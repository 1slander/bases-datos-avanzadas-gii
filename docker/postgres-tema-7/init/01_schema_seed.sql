-- Esquema mínimo para demos de transacciones, aislamientos y bloqueos
CREATE TABLE cuentas (
  id BIGSERIAL PRIMARY KEY,
  titular TEXT NOT NULL,
  saldo NUMERIC(12,2) NOT NULL CHECK (saldo >= 0)
);

CREATE TABLE pedidos (
  id BIGSERIAL PRIMARY KEY,
  cliente TEXT NOT NULL,
  importe NUMERIC(12,2) NOT NULL,
  fecha TIMESTAMP NOT NULL DEFAULT now()
);

-- Datos iniciales
INSERT INTO cuentas (titular, saldo) VALUES
('Ana', 1000.00),
('Luis',  500.00);

INSERT INTO pedidos (cliente, importe, fecha) VALUES
('Ana', 120.00, now() - interval '2 day'),
('Ana',  80.00, now() - interval '1 day'),
('Luis', 60.00, now() - interval '1 day');
