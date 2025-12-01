BEGIN;
UPDATE cuentas SET saldo = saldo + 5 WHERE titular = 'Luis';  -- Bloquea fila de Luis
-- ahora intenta tocar 'Ana' (bloqueada por A)
UPDATE cuentas SET saldo = saldo - 5 WHERE titular = 'Ana';
-- PostgreSQL detectará el interbloqueo y ABORTARÁ una transacción
