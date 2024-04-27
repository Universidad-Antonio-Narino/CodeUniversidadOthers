CREATE DATABASE BandApp;
USE BandApp;

-- Crear la tabla Integrantes
CREATE TABLE Integrantes (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Instrumento VARCHAR(50) NOT NULL,
    Foto VARCHAR(255) NOT NULL,
    Seguidores INT,
    Conciertos INT,
    Ganancias DECIMAL(10 , 2 ),
    DonaCaridad BOOLEAN,
    GeneroFavorito VARCHAR(20)
);

CREATE TABLE Conciertos (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Ganancia DECIMAL(10 , 2 ) CHECK (Ganancia >= 10000 AND Ganancia <= 100000),
    IntegranteID INT,
    FOREIGN KEY (IntegranteID)
        REFERENCES Integrantes (ID)
);

-- DATOS EJEMPLO
-- Insertar integrantes
INSERT INTO Integrantes (Nombre, Instrumento, Foto, Seguidores, Conciertos, Ganancias, DonaCaridad, GeneroFavorito)
VALUES
    ('Integrante1', 'Guitarra', '/ruta/foto1.jpg', 10000, 5, 50000, TRUE, 'Rock'),
    ('Integrante2', 'Batería', '/ruta/foto2.jpg', 8000, 8, 70000, FALSE, 'Pop'),
    ('Integrante3', 'Bajo', '/ruta/foto3.jpg', 12000, 3, 30000, TRUE, 'Jazz'),
    ('Integrante4', 'Teclado', '/ruta/foto4.jpg', 15000, 6, 60000, FALSE, 'Tropical');

-- Insertar conciertos
INSERT INTO Conciertos (Ganancia, IntegranteID)
VALUES
    (15000, 1),
    (20000, 2),
    (30000, 3),
    (25000, 4);
    