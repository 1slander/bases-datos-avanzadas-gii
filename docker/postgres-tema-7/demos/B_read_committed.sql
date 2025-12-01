BEGIN;
UPDATE cuentas SET saldo = saldo - 100 WHERE titular = 'Ana';
-- Simula ingreso en otra cuenta para mantener consistencia del escenario
UPDATE cuentas SET saldo = saldo + 100 WHERE titular = 'Luis';
COMMIT;
-- Fin de la transacción