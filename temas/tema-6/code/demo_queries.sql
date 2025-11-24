-- CONSULTAS BASE (SIN ÍNDICES SECUNDARIOS)
-- Úsalas para medir con EXPLAIN ANALYZE y luego repítelas tras crear índices.

-- 1) Búsqueda por igualdad (email):
-- Esperable: Seq Scan en clientes, porque no hay índice en email.
EXPLAIN ANALYZE
SELECT id, nombre, email
FROM clientes
WHERE email = 'cliente500@example.com';

-- 2) Rango por fecha (llamadas reciente):
EXPLAIN ANALYZE
SELECT count(*)
FROM llamadas
WHERE fecha_llamada >= NOW() - INTERVAL '7 days';

-- 3) Filtro por estado + cliente (parcialmente selectivo):
EXPLAIN ANALYZE
SELECT cliente_id, count(*) AS total
FROM llamadas
WHERE estado = 'ATENDIDA'
GROUP BY cliente_id
ORDER BY total DESC
LIMIT 10;

-- 4) JOIN clientes + llamadas (por cliente_id)
EXPLAIN ANALYZE
SELECT c.pais, l.estado, avg(l.duracion_seg)::int AS dur_media
FROM llamadas l
JOIN clientes c ON c.id = l.cliente_id
WHERE l.fecha_llamada >= NOW() - INTERVAL '30 days'
GROUP BY c.pais, l.estado
ORDER BY c.pais, l.estado;

-- 5) Búsqueda LIKE por nombre (demostración de trigramas posteriormente)
EXPLAIN ANALYZE
SELECT id, nombre
FROM clientes
WHERE nombre ILIKE '%ente 99%';
