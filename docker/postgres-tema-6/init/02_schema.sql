-- Esquema básico (sin índices secundarios) para comparar antes/después
CREATE TABLE IF NOT EXISTS clientes (
  id           BIGSERIAL PRIMARY KEY,
  nombre       TEXT NOT NULL,
  email        TEXT NOT NULL,
  pais         TEXT NOT NULL,
  fecha_alta   DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE IF NOT EXISTS llamadas (
  id             BIGSERIAL PRIMARY KEY,
  cliente_id     BIGINT NOT NULL REFERENCES clientes(id),
  numero_destino TEXT NOT NULL,
  fecha_llamada  TIMESTAMP NOT NULL,
  duracion_seg   INTEGER NOT NULL,
  estado         TEXT NOT NULL CHECK (estado IN ('ATENDIDA','PERDIDA','OCUPADO')),
  costo_eur      NUMERIC(6,2) NOT NULL
);

-- Índices mínimos obligatorios sólo por PK/FK (los crea el motor automáticamente).
-- Nada más aquí: queremos medir primero sin índices secundarios.
-- Los índices secundarios los añadiremos después en otro script.