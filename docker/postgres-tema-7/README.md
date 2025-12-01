# Entorno Docker del Tema 7 — Procesamiento Transaccional

Este entorno Docker está preparado para demostrar de manera práctica cómo funcionan las **transacciones**, los **niveles de aislamiento**, los **bloqueos**, los **problemas de concurrencia** y los **deadlocks** en PostgreSQL.

## 🧰 1. Iniciar los contenedores

1. Inicia los contenedores del Tema 7 desde VSCode o abriendo una terminal.
2. Si abriste una termina, ejecuta el siguiente comando:

    ```bash
    docker compose up -d
    ```

3. Espera unos segundos a que los servicios arranquen.
4. Abre pgAdmin en el navegador: [http://localhost:8080](http://localhost:8080)

    Accede con:

    * **Email:** `admin@example.com`
    * **Password:** `admin`

5. Añade una nueva conexión PostgreSQL:

    * **Name:** `tema7-db`
    * **Host:** `db`
    * **Port:** `5432`
    * **Database:** `demos`
    * **User:** `profesor`
    * **Password:** `postgres`

Ahora ya puedes abrir **dos Query Tool**:

* Sesión **A**
* Sesión **B**

Estas dos sesiones te permitirán ver cómo se afectan entre sí dos transacciones simultáneas.

## 🎬 Demostraciónes guiadas para el tema 7

A continuación tienes todas las demos explicadas y con su código correspondiente.

### DEMO 1 — READ COMMITTED y “Non-repeatable read”

#### 🎯 Objetivo

Mostrar que en el nivel de aislamiento por defecto, una misma lectura dentro de una transacción puede devolver valores diferentes si otra transacción hace `UPDATE` y `COMMIT`.

#### 📌 SESIÓN A — `A_read_committed.sql`

```sql
-- Ver el nivel de aislamiento activo
SHOW transaction_isolation;

BEGIN;

-- Leer saldo de Ana (primera lectura)
SELECT saldo FROM cuentas WHERE titular = 'Ana';

-- No cerrar esta transacción. Espera a que Sesión B haga su update y commit.
-- (Ahora ejecutar Sesión B)

-- Volver a leer saldo de Ana (segunda lectura)
SELECT saldo FROM cuentas WHERE titular = 'Ana';

COMMIT;
```

#### 📌 SESIÓN B — `B_read_committed.sql`

Ejecutar entre las dos lecturas de A:

```sql
BEGIN;

UPDATE cuentas SET saldo = saldo - 100 WHERE titular = 'Ana';
UPDATE cuentas SET saldo = saldo + 100 WHERE titular = 'Luis';

COMMIT;
```

#### 🧠 Qué ocurre

* La primera lectura en A devuelve un valor.
* B modifica el saldo y hace COMMIT.
* La segunda lectura en A devuelve un valor distinto → **non-repeatable read**.

Esto ocurre porque READ COMMITTED permite ver siempre la versión más reciente confirmada.

### DEMO 2 — REPEATABLE READ: evitando lecturas no repetibles

#### 🎯 Objetivo

Mostrar cómo el nivel **REPEATABLE READ** mantiene un *snapshot* constante para toda la transacción, impidiendo que los valores cambien dentro de ella.

#### 📌 SESIÓN A — `A_repeatable_read.sql`

```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN;

SELECT saldo FROM cuentas WHERE titular = 'Ana';

-- Dejar en espera; ejecutar la Sesión B ahora

-- Segunda lectura de saldo
SELECT saldo FROM cuentas WHERE titular = 'Ana';

COMMIT;
```

#### 📌 SESIÓN B — `B_repeatable_read.sql`

```sql
BEGIN;

UPDATE cuentas SET saldo = saldo - 50 WHERE titular = 'Ana';
UPDATE cuentas SET saldo = saldo + 50 WHERE titular = 'Luis';

COMMIT; -- Puede quedar bloqueado hasta que A haga COMMIT
```

#### 🧠 Qué ocurre

* A hace una lectura en REPEATABLE READ.
* B intenta modificar el dato y queda **bloqueada**.
* A vuelve a leer y obtiene el mismo valor.

El bloqueo hace que la consistencia esté garantizada.

### DEMO 3 — Phantom Read (lectura fantasma)

#### 🎯 Objetivo

Mostrar que READ COMMITTED permite que aparezcan nuevas filas que antes no existían dentro de una transacción.

#### 📌 SESIÓN A

```sql
BEGIN;

-- Primera consulta por rango
SELECT count(*) FROM pedidos
WHERE cliente = 'Ana' AND fecha >= now() - interval '2 days';

-- Ejecutar Sesión B ahora

-- Segunda consulta: puede haber más registros
SELECT count(*) FROM pedidos
WHERE cliente = 'Ana' AND fecha >= now() - interval '2 days';

COMMIT;
```

#### 📌 SESIÓN B

```sql
BEGIN;

INSERT INTO pedidos (cliente, importe)
VALUES ('Ana', 35.00);

COMMIT;
```

#### 🧠 Qué ocurre

En READ COMMITTED, La sesión "A" ve más filas en la segunda lectura: aparece un **“fantasma”**, un registro nuevo que cumple el filtro.

> Repetir esta misma demo en REPEATABLE READ muestra que los fantasmas desaparecen.

### DEMO 4 — Deadlocks (interbloqueos)

#### 🎯 Objetivo

Mostrar cómo dos transacciones pueden bloquearse mutuamente hasta que PostgreSQL detecta un deadlock y aborta una de ellas.

#### 📌 SESIÓN A — `locks_deadlock_A.sql`

```sql
BEGIN;

-- A bloquea a Ana
UPDATE cuentas SET saldo = saldo + 10 WHERE titular = 'Ana';

-- Esperar a que B bloquee a Luis

-- A intenta bloquear a Luis (bloqueado por B)
UPDATE cuentas SET saldo = saldo - 10 WHERE titular = 'Luis';
```

#### 📌 SESIÓN B — `locks_deadlock_B.sql`

```sql
BEGIN;

-- B bloquea a Luis
UPDATE cuentas SET saldo = saldo + 5 WHERE titular = 'Luis';

-- Intento sobre Ana: está bloqueada por A
UPDATE cuentas SET saldo = saldo - 5 WHERE titular = 'Ana';
```

#### 🧠 Qué ocurre

* A bloquea Ana.
* B bloquea Luis.
* A quiere Luis → bloqueado.
* B quiere Ana → bloqueado.
* PostgreSQL detecta el deadlock y aborta automáticamente una transacción.

Esto demuestra cómo el motor garantiza **progreso** y evita bloqueo permanente.

### Explicación del script de inicialización `02_helpers.sql`

El archivo `02_helpers.sql` crea la vista `v_info`, cuyo propósito es mostrar información útil sobre la **sesión actual** durante las demos del Tema 7 (transacciones y concurrencia). Esta vista ayuda a identificar rápidamente **qué usuario**, **qué nivel de aislamiento** y **en qué instante** se ejecuta cada operación.

### ✔️ ¿Qué contiene la vista?

```sql
CREATE OR REPLACE VIEW v_info AS
SELECT current_user AS usr,
       current_setting('transaction_isolation') AS iso,
       clock_timestamp() AS now;
```

### ✔️ Qué muestra cada columna

* **usr** → el usuario conectado (ej. `profesor`).
* **iso** → nivel de aislamiento activo (`read committed`, `repeatable read`, etc.).
* **now** → instante exacto de ejecución (a diferencia de `now()`, cambia en cada consulta).

### ✔️ ¿Para qué sirve?

* Comparar el comportamiento de dos sesiones distintas (A y B).
* Ver rápidamente el nivel de aislamiento usado en cada transacción.
* Marcar el momento exacto de cada operación, útil en demos de bloqueos, lecturas repetidas y phantom reads.
* Facilitar el análisis de cómo se comportan las transacciones bajo concurrencia.
