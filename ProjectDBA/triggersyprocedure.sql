use world;
#creacion de procedimientos almacenados para dba world
#creacion de triggers para dba world
/*
Como se compone el menu:
1- Insercion de datos
2- Eliminacion de registros
3- actualizacion de registros
4- otras operaciones


*/
#registro datos 5 tablas

delimiter //
/*
Tabla city
ID int AI PK 
Name char(35) 
CountryCode char(3) 
District char(20) 
Population int
*/
create procedure RegistroCity(in name VARCHAR(35),in countrycode VARCHAR(3),in District VARCHAR(20),in Population int)
BEGIN
    INSERT INTO city(name,countrycode,District,Population) VALUES(_name,_countrycode,_district,_population);
END //
delimiter;

delimiter //
/*
Tabla citygetlanguage
name char(35) 
countrycode char(3) 
language char(30)
*/
create procedure RegistroCitygetlanguage(in name VARCHAR(35),in countrycode VARCHAR(3),in LANGUAGE VARCHAR(30))
BEGIN
    INSERT INTO citygetlanguage(name,countrycode,LANGUAGE) VALUES(_name,_countrycode,_LANGUAGE);
END //
delimiter;

delimiter //
/*
Tabla country
Code char(3) PK 
Name char(52) 
Continent enum('Asia','Europe','North America','Africa','Oceania','Antarctica','South America') 
Region char(26) 
SurfaceArea float(10,2) 
IndepYear smallint 
Population int 
LifeExpectancy float(3,1) 
GNP float(10,2) 
GNPOld float(10,2) 
LocalName char(45) 
GovernmentForm char(45) 
HeadOfState char(60) 
Capital int 
Code2 char(2)
*/
create procedure RegistroCountry(in code VARCHAR(3),in name VARCHAR(52),in Continent enum('Asia','Europe','North America','Africa','Oceania','Antarctica','South America'),in Region VARCHAR(26),in SurfaceArea FLOAT(3,1), in GNP FLOAT(10,2),in GNPOld FLOAT(10,2),in LocalName VARCHAR(45),in GovernmentForm VARCHAR(45),in HeadOfState VARCHAR(60),in Capital int,in Code2 VARCHAR(2))
BEGIN
    INSERT INTO city(code,name,Continent,Region,SurfaceArea,GNP, GNPOld, LocalName,GovernmentForm,HeadOfState,Capital,Code2) VALUES(_code,_name,_Continent,_Region,_SurfaceArea,_GNP,_GNPOld,_LocalName,_GovernmentForm,_HeadOfState,_Capital,_Code2);
END //
delimiter;


DELIMITER //
/*
Tabla CountryLanguagecountry
CountryCode char(3) PK 
Language char(30) PK 
IsOfficial enum('T','F') 
Percentage float(4,1)
*/

create procedure RegistroCountryLanguagecountry(in countrycode VARCHAR(3),in Language VARCHAR(30),in IsOfficial enum('T','F'),in Percentage float(4,1))
BEGIN
    INSERT INTO city(countrycode,Language,IsOfficial,Percentage) VALUES(_countrycode,_Language,_IsOfficial,_Percentage);
END //
delimiter;




DELIMITER //

-- Eliminar el procedimiento almacenado existente
-- DROP PROCEDURE IF EXISTS BandAppMenu;

-- Crear el nuevo procedimiento almacenado
CREATE PROCEDURE LibraryMenu()
BEGIN
    DECLARE opcion INT;
    SELECT '
        ====== MENÚ PRINCIPAL ======
        1. Registrar una ciudad
        2. Registrar una citygetlanguage
        3. Registrar un country
        4. Registrar un CountryLanguagecountry
        5. Calcular estadísticas de ventas
        0. Salir' INTO @menu;
    SET opcion = 1;
    AppMenuLoop: LOOP
    CASE opcion
        WHEN 1 THEN
            call RegistroCity();
        WHEN 2 THEN
            -- Valores de prueba
            
            --SET @producto_id = 1;
            --SET @cantidad = 5;
            CALL RegistroCitygetlanguage();
        WHEN 3 THEN
            -- Valores de prueba
            CALL RegistroCountry();
        WHEN 4 THEN
            CALL RegistroCountryLanguagecountry();
        WHEN 5 THEN
            SELECT * FROM vista_estadisticas;
            WHEN 0 THEN
                LEAVE AppMenuLoop;
            ELSE
                SELECT 'Opción no válida. Inténtelo de nuevo.';
    END CASE;
    SET opcion = 0;
    END LOOP AppMenuLoop;
END //

DELIMITER ;
