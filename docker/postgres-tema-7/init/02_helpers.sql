-- Mostrar nivel por defecto y timestamp útil para trazas
CREATE OR REPLACE VIEW v_info AS
SELECT current_user AS usr,
       current_setting('transaction_isolation') AS iso,
       clock_timestamp() AS now;
