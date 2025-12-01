BEGIN;
UPDATE cuentas SET saldo = saldo - 50 WHERE titular = 'Ana';
UPDATE cuentas SET saldo = saldo + 50 WHERE titular = 'Luis';
COMMIT;  -- Puede quedar bloqueado hasta que A haga COMMIT
-- Fin de la transacción