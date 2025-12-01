SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN;
SELECT * FROM v_info;

-- 1. Leer saldo de Ana
SELECT saldo FROM cuentas WHERE titular = 'Ana';

-- (espera a que B intente actualizar y confirmar)

-- 3. Releer saldo de Ana (debe ser el MISMO para A)
SELECT saldo FROM cuentas WHERE titular = 'Ana';

COMMIT;
-- Fin de la transacción