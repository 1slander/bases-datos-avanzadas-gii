# Tema 7 — Introducción al procesamiento transaccional

El objetivo del tema es comprender cómo los sistemas gestores de bases de datos (SGBD) garantizan la **integridad**, **seguridad** y **consistencia** de los datos mediante el uso de **transacciones**. Se presentan las propiedades **ACID**, los estados de una transacción, los mecanismos de recuperación y cómo se controla la ejecución concurrente.

## 🖥️ Contenedor Docker para este tema

La descripción del contenedor Docker para poner en práctica los conceptos de este tema se encuentra disponible en el directorio [docker/postgres-tema-7](../../docker/postgres-tema-7/README.md)

## 1. ¿Qué es una transacción?

Según la definición del tema :

Una **transacción** es una **unidad lógica de trabajo**, compuesta por una serie de operaciones que deben ejecutarse **todas** o **ninguna**.

Internamente, aunque un usuario haga una acción sencilla, el SGBD ejecuta múltiples suboperaciones que deben tratarse como un único bloque.

Las transacciones se delimitan con:

```sql
BEGIN TRANSACTION;
-- operaciones...
END TRANSACTION;
```

## 2. Propiedades ACID

El tema destaca cuatro propiedades fundamentales que debe cumplir toda transacción :

### ✔️ **Atomicidad**

Se ejecutan **todas** las operaciones o **ninguna**.
Si ocurre un error, el sistema debe **deshacer** todos los cambios.

### ✔️ **Consistencia**

Tras ejecutarse la transacción, la base de datos debe pasar de un estado **válido** a otro estado **válido**.

### ✔️ **Aislamiento**

Una transacción no debe ver efectos de otras transacciones concurrentes.

### ✔️ **Durabilidad**

Una vez confirmada, los cambios **no pueden perderse**, incluso ante fallos.

## 3. Estados de una transacción

El material de estudio define los siguientes estados :

1. **Activa** → fase inicial mientras ejecuta instrucciones.
2. **Parcialmente comprometida** → tras la última instrucción antes del commit.
3. **Fallida** → error que impide continuar.
4. **Abortada** → tras hacer rollback y restaurar el estado inicial.
   * Puede reiniciarse o cancelarse.
5. **Comprometida** → finaliza correctamente.
6. **Terminada** → comprometida o abortada.

## 4. Implementación de atomicidad y durabilidad

Otro punto importante es el papel del **gestor de recuperaciones** del SGBD, encargado de garantizar atomicidad/durabilidad. Uno de los mecanismos descritos son las **copias en la sombra** (shadow paging) :

### ✔️ Copias en la sombra

* Se crea una copia de la BD antes de ejecutar una transacción.
* La transacción opera sobre la copia.
* Si finaliza bien → la copia sustituye al original.
* Si falla → se descarta la copia.

## 5. Secuencialidad y concurrencia

La ejecución concurrente de transacciones puede provocar **inconsistencias**. Por ello, los SGBD deben planificar correctamente la ejecución de las operaciones.

El tema explica la **secuencialidad en cuanto a conflictos**, donde se analiza el orden de las operaciones de lectura/escritura para determinar si una planificación es válida .

### Tipos de pares de operaciones

* **Lectura – Lectura** → sin conflicto
* **Lectura – Escritura** → conflicto
* **Escritura – Lectura** → conflicto
* **Escritura – Escritura** → afecta a lecturas posteriores

Dos instrucciones están en **conflicto** si pertenecen a transacciones distintas y al menos una es de escritura.

Una planificación es **secueciable en cuanto a conflictos** si es equivalente (en cuanto al resultado) a una planificación secuencial sin conflictos.

## 6. Recuperabilidad

Durante ejecución concurrente, si una transacción falla, es necesario garantizar que otras transacciones que **dependían de sus datos** también se gestionen correctamente.

El tema introduce las **planificaciones recuperables** :

* Una planificación es recuperable si, cuando una transacción *T₂* lee datos escritos por *T₁*, entonces *T₁* **se compromete antes** de que *T₂* se comprometa.

* Esto evita situaciones en las que *T₂* dependa de datos que deben deshacerse.

## 7. Implementación del aislamiento

Para asegurar el aislamiento, se utilizan técnicas de **bloqueo de datos** (locking) y control de concurrencia :

### Niveles de bloqueo

* Base de datos
* Archivo
* Tabla
* Bloque/página
* **Fila (más común)**
* Columna (menos habitual)

Un bloqueo impide que otros procesos actualicen un dato mientras está siendo modificado, garantizando la integridad en entornos concurrentes.
