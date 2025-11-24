-- ÍNDICES PARA ACELERAR LAS CONSULTAS DEMO

-- A) Igualdad por email (búsqueda exacta):
CREATE INDEX idx_clientes_email ON clientes (email);

-- B) Rango por fecha_llamada:
CREATE INDEX idx_llamadas_fecha ON llamadas (fecha_llamada);

-- C) Compuesto para JOIN + filtro por fecha en llamadas:
CREATE INDEX idx_llamadas_cliente_fecha ON llamadas (cliente_id, fecha_llamada);

-- D) Parcial por estado (cuando 'ATENDIDA' es frecuente en consultas):
CREATE INDEX idx_llamadas_atendidas ON llamadas (cliente_id)
WHERE estado = 'ATENDIDA';

-- E) Funcional para email case-insensitive (demostración):
--    Usarías WHERE lower(email) = '...' → requiere index funcional:
CREATE INDEX idx_clientes_lower_email ON clientes ((lower(email)));

-- F) Trigramas para LIKE en nombre (ILIKE '%texto%'):
CREATE INDEX idx_clientes_nombre_trgm ON clientes USING gin (nombre gin_trgm_ops);
