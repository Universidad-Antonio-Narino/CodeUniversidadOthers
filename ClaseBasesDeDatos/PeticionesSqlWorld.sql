use champions;
select nombre from champions.presidente where num_doc = (select presidente_num_doc from champions.equipo where nombre = 'tigres');
select * from juagdor;
select * from presidente;
select * from equipo;
select * from partido;
show tables like 'juagdor';

###insercion de datos 
insert into champions.presidente(num_doc,anio_ingreso,nombre,fecha_nac) values
(1001346,2012,'fede','1980-03-02'),
(1003306,2015,'asrco','1981-03-02'),
(10121346,2012,'row','1978-03-02');

insert into champions.equipo(nombre,ciudad,aforo,estadio,anio,presidente_num_doc) values
('tigres','bogota',300000,'campin',1969,1001346),
('millonarios','bogota',12000,'techo',1980,1003306),
('leones','bogota',130000,'louis capital',1992,10121346);

insert into champions.juagdor(nombre,fecha_nac,equipo_codigo,equipo_presidente_num_doc) values
    ('John Smith', '1990-01-01', 1, 1001346),
    ('Jane Doe', '1991-02-02', 1, 1001346),
    ('Michael Johnson', '1992-03-03', 1, 1001346),
    ('Emily Williams', '1993-04-04', 1, 1001346),
    ('Daniel Brown', '1994-05-05', 1, 1001346),
    ('Sarah Jones', '1995-06-06', 1, 1001346),
    ('Christopher Davis', '1996-07-07', 1, 1001346),
    ('Jessica Miller', '1997-08-08', 1, 1001346),
    ('Matthew Wilson', '1998-09-09', 1, 1001346),
    ('Amanda Moore', '1999-10-10', 1, 1001346),
    ('Kevin Taylor', '2000-11-11', 1, 1001346),
    ('David Johnson', '1990-01-01', 2, 1003306),
    ('Laura Anderson', '1991-02-02', 2, 1003306),
    ('Robert Martinez', '1992-03-03', 2, 1003306),
    ('Jennifer Thompson', '1993-04-04', 2, 1003306),
    ('Christopher White', '1994-05-05', 2, 1003306),
    ('Stephanie Clark', '1995-06-06', 2, 1003306),
    ('Daniel Rodriguez', '1996-07-07', 2, 1003306),
    ('Megan Lewis', '1997-08-08', 2, 1003306),
    ('Joshua Hall', '1998-09-09', 2, 1003306),
    ('Ashley Young', '1999-10-10', 2, 1003306),
    ('Ryan King', '2000-11-11', 2, 1003306),
    ('Andrew Wilson', '1990-01-01', 3, 10121346),
    ('Emily Thompson', '1991-02-02', 3, 10121346),
    ('Jacob Harris', '1992-03-03', 3, 10121346),
    ('Olivia Martin', '1993-04-04', 3, 10121346),
    ('William Garcia', '1994-05-05', 3, 10121346),
    ('Sophia Martinez', '1995-06-06', 3, 10121346),
    ('Ethan Jackson', '1996-07-07', 3, 10121346),
    ('Isabella Davis', '1997-08-08', 3, 10121346),
    ('Michael Rodriguez', '1998-09-09', 3, 10121346),
    ('Ava Hernandez', '1999-10-10', 3, 10121346),
    ('Alexander Lopez', '2000-11-11', 3, 10121346);

insert into champions.partido(fecha,goles_visitante,goles_local,equipo_codigo,equipo_presidente_num_doc) values
('2024-04-13 15:00:00', 1, 2,1,1001346),
('2024-04-14 14:30:00', 0, 3,2,1003306);

