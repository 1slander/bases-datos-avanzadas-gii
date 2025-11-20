CREATE TABLE IF NOT EXISTS estaciones (
    id         SERIAL PRIMARY KEY,
    comunidad  TEXT NOT NULL,
    municipio  TEXT NOT NULL,
    combustible TEXT NOT NULL,
    precio     NUMERIC(5,2) NOT NULL
);

INSERT INTO estaciones (comunidad, municipio, combustible, precio) VALUES
('Cantabria', 'Santander', 'Gasolina 95 E5', 1.60),
('Cantabria', 'Torrelavega', 'Gasóleo A', 1.50),
('Asturias', 'Oviedo', 'Gasolina 95 E5', 1.59),
('Asturias', 'Gijón', 'Gasóleo A', 1.52),
('País Vasco', 'Bilbao', 'Gasolina 95 E5', 1.62),
('País Vasco', 'San Sebastián', 'Gasóleo A', 1.54);
