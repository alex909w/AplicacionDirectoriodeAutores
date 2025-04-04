-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS Authors;
USE Authors;

-- Crear tabla de géneros literarios
CREATE TABLE IF NOT EXISTS literary_genre (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Crear tabla de autores
CREATE TABLE IF NOT EXISTS author (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(10),
    birth_date DATE,
    genre_id BIGINT NOT NULL,
    FOREIGN KEY (genre_id) REFERENCES literary_genre(id)
);

-- Insertar géneros literarios de ejemplo
INSERT INTO literary_genre (name) VALUES 
('Novela'),
('Poesía'),
('Ensayo'),
('Ciencia Ficción'),
('Fantasía'),
('Drama'),
('Terror'),
('Biografía'),
('Historia'),
('Aventura');

-- Insertar autores de ejemplo
INSERT INTO author (name, phone, birth_date, genre_id) VALUES 
('Gabriel García Márquez', '2222-1111', '1927-03-06', 1),
('Jorge Luis Borges', '2222-2222', '1899-08-24', 2),
('Isabel Allende', '2222-3333', '1942-08-02', 1),
('Julio Cortázar', '2222-4444', '1914-08-26', 1),
('Pablo Neruda', '2222-5555', '1904-07-12', 2),
('Mario Vargas Llosa', '2222-6666', '1936-03-28', 3),
('Octavio Paz', '2222-7777', '1914-03-31', 2),
('Carlos Fuentes', '2222-8888', '1928-11-11', 1),
('Gabriela Mistral', '2222-9999', '1889-04-07', 2),
('Rubén Darío', '7777-1111', '1867-01-18', 2);

