/*
1. Registrar un libro en el catálogo.
2. Eliminar un libro del catálogo.
3. Buscar un libro por título.
4. Buscar un libro por ISBN.
5. Abastecer ejemplares de un libro.
6. Vender ejemplares de un libro.
7. Calcular la cantidad de transacciones de abastecimiento de un libro particular.
8. Buscar el libro más costoso.
9. Buscar el libro menos costoso.
10. Buscar el libro más vendido.
*/

#Procedimiento de insertar libros en el catalgo
delimiter //
create procedure RegistroLibros(IN _isbn varchar(13),in _titulo varchar(45),in _precioCompra int,in _precioVenta int ,in _CantidadActualLibros INT)
begin
    INSERT INTO libro(isbn,titulo,precioCompra,precioVenta,CantidadActualLibros) values (_isbn,_titulo,_precioCompra,_precioVenta,_CantidadActualLibros);
end //
delimiter

#procedimiento de eliminacion de libros catalogo
delimiter //
CREATE PROCEDURE EliminacionLibro(IN _isbn VARCHAR(14))
BEGIN
    DELETE from libro WHERE libro.isbn = _isbn;
end //
delimeter;

#buscar libros por titulo
delimiter //
CREATE PROCEDURE BusquedaLibrosTitulo(IN _titulo VARCHAR(45))
BEGIN
    select * from libro inner join transacion on libro.isbn = transacion.isbn where libro.titulo = _titulo;
end //
delimeter;

#buscar libros por isbn
delimiter //
CREATE PROCEDURE BusquedaLibrosIsbn(IN _isbn VARCHAR(14))
BEGIN
   select * from libro inner join transacion on libro.isbn = transacion.isbn where libro.isbn = _isbn;
end //
delimeter;

#abastecer ejemplares de un libro
delimiter //
CREATE PROCEDURE Abastecer(IN _isbn VARCHAR(13), IN _tipoTransicion varchar(15),in _fechaRealizacion date, in _CantidadEjemplares int)
BEGIN
	#primero inserto en transaciones los libros que se añadiran
    
    INSERT INTO libreriauan.transacion (isbn, tipoTransicion, fechaRealizacion, CantidadEjemplares) 
    VALUES(_isbn,_tipoTransicion,_fechaRealizacion_CantidadEjemplares);
	/*
    Explicacion:
    quiero modificar mi cantidad de libros totales en la tabla libros
    basandome en las transaciones por ende voy a modificar la misma,
    primero uno lo que me de la consulta donde lo que buscara es todas
    las transacciones con el tipo 'Abastecimiento' las suma y luego las 
    añade al total de libros
    */
    UPDATE libro l
	JOIN (
    SELECT isbn, SUM(CantidadEjemplares) AS TotalAbastecido
    FROM transacion
    WHERE tipoTransicion = 'Abastecimiento'
    GROUP BY isbn
	) t ON l.isbn = t.isbn
	SET l.CantidadActualLibros = l.CantidadActualLibros + t.TotalAbastecido;

end //
delimeter;

#vender ejemplares de un libro
delimiter //
CREATE PROCEDURE venderLibros(IN _isbn VARCHAR(13), IN _tipoTransicion varchar(15),in _fechaRealizacion date, in _CantidadEjemplares int)
BEGIN
	INSERT INTO libreriauan.transacion (isbn, tipoTransicion, fechaRealizacion, CantidadEjemplares) 
    VALUES(_isbn,_tipoTransicion,_fechaRealizacion_CantidadEjemplares);

    UPDATE libro l
	JOIN (
    SELECT isbn, SUM(CantidadEjemplares) AS TotalVendido
    FROM transacion
    WHERE tipoTransicion = 'Venta'
    GROUP BY isbn
	) t ON l.isbn = t.isbn
	SET l.CantidadActualLibros = l.CantidadActualLibros - t.TotalVendido;
end //
delimeter;

#Calcular transacciones de abastecimiento de un libro
delimiter //
CREATE PROCEDURE CalculoAbaste()
BEGIN
    SELECT isbn, SUM(CantidadEjemplares) AS AbastecimientoTotalLibros
    FROM transacion
    WHERE tipoTransicion = 'Abastecimiento'
    GROUP BY isbn;
end //
delimeter;

#buscar libro mas costoso
delimiter //
CREATE PROCEDURE libroCaro()
BEGIN
    SELECT titulo, precioVenta FROM libro WHERE precioVenta = (SELECT MAX(precioVenta) FROM libro);
end //
delimeter;

#buscar libro menos costoso
delimiter //
CREATE PROCEDURE LibroBarato()
BEGIN
    SELECT titulo, precioVenta FROM libro WHERE precioVenta = (SELECT min(precioVenta) FROM libro);
end //
delimeter;

#buscar libro mas vendido
#menu
DELIMITER //

-- Eliminar el procedimiento almacenado existente
-- DROP PROCEDURE IF EXISTS BandAppMenu;

-- Crear el nuevo procedimiento almacenado
CREATE PROCEDURE LibraryMenu()
BEGIN
    DECLARE choice INT;
	SET choice =1;
    LibraryMenuLoop: LOOP
        -- Mostrar opciones del menú
        SELECT '1. Registrar un libro en el catálogo' AS MenuOption;
        SELECT '2. Eliminar un libro del catálogo.' AS MenuOption;
        SELECT '3. Buscar un libro por título.' AS MenuOption;
        SELECT '4. Buscar un libro por ISBN.' AS MenuOption;
        SELECT '5. Abastecer ejemplares de un libro.' AS MenuOption;
        SELECT '6. Vender ejemplares de un libro.' AS MenuOption;
        SELECT '7. Calcular la cantidad de transacciones de abastecimiento de un libro particular.' AS MenuOption;
        SELECT '8. Buscar el libro más costoso.' AS MenuOption;
        SELECT '9. Buscar el libro menos costoso.' AS MenuOption;
        SELECT '10. Buscar el libro más vendido.' AS MenuOption;
        SELECT '0. Salir' AS MenuOption;

        -- Pedir al usuario que elija una opción
        SELECT 'Ingrese el número de la opción deseada:' INTO choice;
        SET choice = IFNULL(choice, -1);

        -- Ejecutar la opción seleccionada
        CASE choice
            WHEN 1 THEN
                CALL RegistroLibros('1','Cien años de soledad',2,3,15);
                -- CALL primeraOpcion();
            WHEN 2 THEN
                -- Aquí puedes pedir más información al usuario para modificar un integrante
                CALL EliminacionLibro('978-014243723');
            WHEN 3 THEN
                CALL BusquedaLibrosTitulo('Eloquent JavaScript');
            WHEN 4 THEN
                CALL BusquedaLibrosIsbn('978-014243723');
            WHEN 5 THEN
                CALL Abastecer('978-159327283', 'Abastecimiento', '2024-04-24', 15);
            WHEN 6 THEN
                CALL venderLibros('978-159327283', 'Venta', '2024-04-27', 10);
            WHEN 7 THEN
                CALL CalculoAbaste();
            WHEN 8 THEN
                CALL libroCaro();
            WHEN 9 THEN
                CALL LibroBarato();
            WHEN 10 THEN
                SELECT * from libro;
            WHEN 0 THEN
                LEAVE BandAppMenuLoop;
            ELSE
                SELECT 'Opción no válida. Inténtelo de nuevo.';
        END CASE;
    END LOOP BandAppMenuLoop;
END //

DELIMITER ;


