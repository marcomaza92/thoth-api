-- Crear la base de datos (si no existe)

DO $$
BEGIN
    -- Verifica si la base de datos existe
    IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = 'mydatabase') THEN
        -- Crea la base de datos
        EXECUTE 'CREATE DATABASE mydatabase';
        
        -- Mensaje en la consola
        RAISE NOTICE 'mydatabase created by Init script';
    ELSE
        RAISE NOTICE 'mydatabase already existed';
    END IF;
END
$$;

-- Conecta a la base de datos
\c mydatabase

DO $$
BEGIN
    -- Verifica si la tabla "users" existe
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'users') THEN
        -- Crea la tabla "users"
        EXECUTE '
        CREATE TABLE IF NOT EXISTS users (
            id SERIAL PRIMARY KEY,
            name VARCHAR(50) NOT NULL,
            age INTEGER NOT NULL
        )';
        
        -- Mensaje en la consola
        RAISE NOTICE 'users table created by Init script';
    ELSE
        RAISE NOTICE 'users table already existed';
    END IF;
END
$$;