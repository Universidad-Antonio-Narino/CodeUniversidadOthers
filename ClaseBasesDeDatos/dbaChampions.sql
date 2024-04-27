create schema if not exists champions;
use champions;

### creacion de tablas
create table if not exists presidente(
	num_doc int not null primary key,
    anio_ingreso year,
    nombre varchar(35),
    fecha_nac date
);

create table if not exists equipo(
	codigo int auto_increment primary key,
    nombre varchar(32),
    ciudad varchar(35),
    aforo int,
    estadio varchar(35),
    anio year,
    presidente_num_doc int,
    foreign key(presidente_num_doc) references champions.presidente(num_doc)
);

create table if not exists juagdor(
	codigo int auto_increment primary key,
    nombre varchar(25),
    fecha_nac date,
    equipo_codigo int,
    equipo_presidente_num_doc int,
    foreign key(equipo_codigo) references champions.equipo(codigo),
    foreign key(equipo_presidente_num_doc) references champions.presidente(num_doc)
);

create table if not exists partido(
	codigo int auto_increment primary key,
    fecha datetime,
    goles_visitante int,
    goles_local int,
    equipo_codigo int,
    equipo_presidente_num_doc int,
    foreign key (equipo_codigo) references champions.equipo(codigo),
    foreign key (equipo_presidente_num_doc) references champions.equipo(presidente_num_doc)
);

CREATE TABLE IF NOT EXISTS gol (
    codigo INT AUTO_INCREMENT PRIMARY KEY,
    descripcion TEXT,
    minutes TIME,
    partido_codigo INT,
    jugador_codigo INT,
    jugador_equipo_codigo INT,
    jugador_equipo_presidente_num_doc INT,
   foreign key(partido_codigo) references champions.partido(codigo),
   foreign key(jugador_codigo) references champions.juagdor(codigo),
   foreign key(jugador_equipo_codigo) references champions.juagdor(equipo_codigo),
   foreign key(jugador_equipo_presidente_num_doc) references champions.juagdor(equipo_presidente_num_doc)
);



