CREATE DATABASE IF NOT EXISTS Champions;
USE Champions;

CREATE TABLE IF NOT EXISTS Equipo (
    codigo INT,
    partido_codigo INT,
    ciudad VARCHAR(45),
    aforo INT,
    estadio VARCHAR(45),
    nombre VARCHAR(45),
    anio YEAR,
    PRIMARY KEY (codigo, partido_codigo)
);

CREATE TABLE IF NOT EXISTS Presidente (
    num_doc INT,
    Equipo_codigo INT,
    Equipo_partido_codigo INT,
    anio_ingreso YEAR,
    nombre VARCHAR(10),
    PRIMARY KEY (num_doc, Equipo_codigo, Equipo_partido_codigo),
    FOREIGN KEY (Equipo_codigo, Equipo_partido_codigo) REFERENCES Equipo(codigo, partido_codigo)
);

CREATE TABLE IF NOT EXISTS Partido (
    codigo INT,
    fecha DATETIME,
    goles_visitante INT,
    goles_local INT,
    PRIMARY KEY (codigo)
);

CREATE TABLE IF NOT EXISTS Gol (
    codigo INT,
    descripcion TEXT,
    min TIME,
    partido_codigo INT,
    PRIMARY KEY (codigo, partido_codigo)
);

CREATE TABLE IF NOT EXISTS Jugador (
    codigo INT,
    equipo_codigo INT,
    equipo_partido_codigo INT,
    nombre VARCHAR(45),
    posicion VARCHAR(45),
    fecha_naci DATETIME,
    PRIMARY KEY (codigo, equipo_codigo, equipo_partido_codigo),
    FOREIGN KEY (equipo_codigo, equipo_partido_codigo) REFERENCES Equipo(codigo, partido_codigo)
);

CREATE TABLE IF NOT EXISTS Equipo_has_Partido (
    Equipo_codigo INT,
    Equipo_partido_codigo INT,
    Partido_codigo INT,
    PRIMARY KEY (Equipo_codigo, Equipo_partido_codigo, Partido_codigo),
    FOREIGN KEY (Equipo_codigo, Equipo_partido_codigo) REFERENCES Equipo(codigo, partido_codigo),
    FOREIGN KEY (Partido_codigo) REFERENCES Partido(codigo)
);

CREATE TABLE IF NOT EXISTS Partido_has_Gol (
    Partido_codigo INT,
    Gol_codigo INT,
    Gol_Partido_Codigo INT,
    PRIMARY KEY (Partido_codigo, Gol_codigo, Gol_Partido_Codigo),
    FOREIGN KEY (Partido_codigo) REFERENCES Partido(codigo),
    FOREIGN KEY (Gol_codigo, Gol_Partido_Codigo) REFERENCES Gol(codigo, partido_codigo)
);

CREATE TABLE IF NOT EXISTS Jugador_has_Gol (
    Jugador_Codigo INT,
    Jugador_Equipo_Codigo INT,
    Jugador_Equipo_Partido_Codigo INT,
    Gol_codigo INT,
    PRIMARY KEY (Jugador_Codigo, Jugador_Equipo_Codigo, Jugador_Equipo_Partido_Codigo, Gol_codigo),
    FOREIGN KEY (Jugador_Codigo, Jugador_Equipo_Codigo, Jugador_Equipo_Partido_Codigo) REFERENCES Jugador(codigo, equipo_codigo, equipo_partido_codigo),
    FOREIGN KEY (Gol_codigo) REFERENCES Gol(codigo)
);
