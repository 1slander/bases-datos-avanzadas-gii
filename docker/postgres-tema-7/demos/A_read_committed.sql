-- Nivel por defecto
SHOW transaction_isolation;

BEGIN;
SELECT * FROM v_info;

-- 1. Leer saldo de Ana
SELECT saldo FROM cuentas WHERE titular = 'Ana';

-- (No cerrar aún la transacción; espera a que B actualice y haga COMMIT)

-- 3. Volver a leer saldo de Ana (puede cambiar)
SELECT saldo FROM cuentas WHERE titular = 'Ana';

COMMIT;
-- Fin de la transacción