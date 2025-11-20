CREATE TABLE IF NOT EXISTS estaciones (
    id         SERIAL PRIMARY KEY,
    comunidad  TEXT NOT NULL,
    municipio  TEXT NOT NULL,
    combustible TEXT NOT NULL,
    precio     NUMERIC(5,2) NOT NULL
);

INSERT INTO estaciones (comunidad, municipio, combustible, precio) VALUES
('Comunidad de Madrid', 'Madrid', 'Gasolina 95 E5', 1.58),
('Comunidad de Madrid', 'Alcalá de Henares', 'Gasolina 95 E5', 1.55),
('Comunidad de Madrid', 'Getafe', 'Gasóleo A', 1.49),
('Castilla-La Mancha', 'Toledo', 'Gasolina 95 E5', 1.53),
('Castilla-La Mancha', 'Albacete', 'Gasóleo A', 1.47),
('Castilla y León', 'Valladolid', 'Gasolina 95 E5', 1.56),
('Castilla y León', 'Segovia', 'Gasóleo A', 1.48);
