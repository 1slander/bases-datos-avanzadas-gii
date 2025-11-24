-- Semillas: 1.000 clientes y ~50.000 llamadas.
-- Generadas con funciones aleatorias de PostgreSQL.

-- 1) Clientes
INSERT INTO clientes (nombre, email, pais, fecha_alta)
SELECT
  'Cliente ' || g,
  'cliente' || g || '@example.com',
  (ARRAY['ES','PT','FR','DE','IT','MX','AR','CO','CL','PE'])[ (random()*9)::int + 1 ],
  (CURRENT_DATE - (random()*365)::int)
FROM generate_series(1, 1000) g;

-- 2) Llamadas
-- Generamos números destino pseudoaleatorios y distribución de estados.
INSERT INTO llamadas (cliente_id, numero_destino, fecha_llamada, duracion_seg, estado, costo_eur)
SELECT
  (random()*999)::int + 1,                                   -- cliente_id [1..1000]
  '+34' || lpad(((random()*899999999)::int + 100000000)::text, 9, '0'),
  NOW() - (((random()*60)::int || ' days')::interval)        -- últimas ~8 semanas
    - (((random()*24)::int || ' hours')::interval)
    - (((random()*59)::int || ' minutes')::interval),
  (random()*600)::int,                                       -- 0..600 seg
  (ARRAY['ATENDIDA','PERDIDA','OCUPADO'])[ (random()*2)::int + 1 ],
  round((random()*1.50 + 0.05)::numeric, 2)                  -- 0.05..1.55 €
FROM generate_series(1, 50000);

ANALYZE clientes;
ANALYZE llamadas;
