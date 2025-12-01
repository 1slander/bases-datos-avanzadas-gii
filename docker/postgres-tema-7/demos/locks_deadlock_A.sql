BEGIN;
UPDATE cuentas SET saldo = saldo + 10 WHERE titular = 'Ana';  -- Bloquea fila de Ana
-- espera a que B bloquee a 'Luis', luego intenta:
UPDATE cuentas SET saldo = saldo - 10 WHERE titular = 'Luis';
-- (Esta línea puede quedar bloqueada)
