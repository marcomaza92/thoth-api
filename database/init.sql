-- Crear la base de datos (si no existe)
CREATE DATABASE IF NOT EXISTS mydatabase;

-- Conectarse a la base de datos
\c mydatabase;

-- Crear la tabla de usuarios (si no existe)
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INTEGER NOT NULL
);