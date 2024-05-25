CREATE TABLE Productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    tipo ENUM('papeleria', 'supermercado', 'drogueria') NOT NULL,
    cantidad_actual INT NOT NULL,
    cantidad_minima INT NOT NULL,
    precio_base DECIMAL(10,2) NOT NULL
);

CREATE TABLE Ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES Productos(id)
);

INSERT INTO Productos (nombre, tipo, cantidad_actual, cantidad_minima, precio_base)
VALUES
    ('Lapiz', 'papeleria', 100, 20, 1.50),
    ('Leche', 'supermercado', 50, 10, 2.00),
    ('Aspirina', 'drogueria', 75, 15, 3.00),
    ('Cuaderno', 'papeleria', 80, 25, 4.50);

INSERT INTO Ventas (producto_id, cantidad, fecha)
VALUES
    (1, 5, '2023-04-28'),
    (2, 10, '2023-04-27'),
    (3, 3, '2023-04-28'),
    (4, 8, '2023-04-26');
    
-- 1. Visualizar la información de los productos
CREATE VIEW vista_productos AS
SELECT
    p.id,
    p.nombre,
    p.tipo,
    p.cantidad_actual,
    p.cantidad_minima,
    p.precio_base,
    CASE
        WHEN p.tipo = 'papeleria' THEN p.precio_base * 1.16
        WHEN p.tipo = 'supermercado' THEN p.precio_base * 1.04
        WHEN p.tipo = 'drogueria' THEN p.precio_base * 1.12
    END AS precio_final
FROM
    Productos p;

-- 2. Vender un producto
DELIMITER $$
CREATE PROCEDURE vender_producto(
    producto_id INT,
    cantidad INT
)
BEGIN
    DECLARE precio_final DECIMAL(10,2);
    DECLARE stock_actual INT;

    SELECT cantidad_actual INTO stock_actual
    FROM Productos
    WHERE id = producto_id;

    IF stock_actual >= cantidad THEN
        UPDATE Productos
        SET cantidad_actual = cantidad_actual - cantidad
        WHERE id = producto_id;

        SELECT
            CASE
                WHEN tipo = 'papeleria' THEN precio_base * 1.16
                WHEN tipo = 'supermercado' THEN precio_base * 1.04
                WHEN tipo = 'drogueria' THEN precio_base * 1.12
            END INTO precio_final
        FROM
            Productos
        WHERE
            id = producto_id;

        INSERT INTO Ventas (producto_id, cantidad, fecha)
        VALUES (producto_id, cantidad, CURDATE());

        SELECT CONCAT('Venta realizada. Total: ', precio_final * cantidad) AS Mensaje;
    ELSE
        SELECT 'No hay suficiente stock' AS Mensaje;
    END IF;
END$$
DELIMITER ;

-- 3. Abastecer la tienda con un producto
DELIMITER $$
CREATE PROCEDURE abastecer_producto(
    producto_id INT,
    cantidad INT
)
BEGIN
    UPDATE Productos
    SET cantidad_actual = cantidad_actual + cantidad
    WHERE id = producto_id;

    SELECT CONCAT('Producto abastecido. Cantidad actual: ', cantidad_actual) AS Mensaje
    FROM Productos
    WHERE id = producto_id;
END$$
DELIMITER ;

-- 4. Cambiar un producto
DELIMITER $$
CREATE PROCEDURE cambiar_producto(
    producto_id INT,
    nuevo_nombre VARCHAR(50),
    nuevo_tipo ENUM('papeleria', 'supermercado', 'drogueria'),
    nuevo_precio_base DECIMAL(10,2)
)
BEGIN
    DECLARE existe_nombre BOOLEAN;

    SELECT COUNT(*) > 0 INTO existe_nombre
    FROM Productos
    WHERE nombre = nuevo_nombre AND id <> producto_id;

    IF NOT existe_nombre THEN
        UPDATE Productos
        SET
            nombre = nuevo_nombre,
            tipo = nuevo_tipo,
            precio_base = nuevo_precio_base
        WHERE id = producto_id;

        SELECT 'Producto actualizado' AS Mensaje;
    ELSE
        SELECT 'Ya existe un producto con ese nombre' AS Mensaje;
    END IF;
END$$
DELIMITER ;

-- 5. Calcular estadísticas de ventas
CREATE VIEW vista_estadisticas AS
SELECT
    (SELECT p.nombre
     FROM Productos p
     INNER JOIN Ventas v ON p.id = v.producto_id
     GROUP BY p.id
     ORDER BY SUM(v.cantidad) DESC
     LIMIT 1) AS producto_mas_vendido,
    (SELECT p.nombre
     FROM Productos p
     INNER JOIN Ventas v ON p.id = v.producto_id
     GROUP BY p.id
     ORDER BY SUM(v.cantidad) ASC
     LIMIT 1) AS producto_menos_vendido,
    (SELECT SUM(p.precio_base * v.cantidad *
                CASE
                    WHEN p.tipo = 'papeleria' THEN 1.16
                    WHEN p.tipo = 'supermercado' THEN 1.04
                    WHEN p.tipo = 'drogueria' THEN 1.12
                END)
     FROM Productos p
     INNER JOIN Ventas v ON p.id = v.producto_id) AS total_ventas,
    (SELECT SUM(p.precio_base *
                CASE
                    WHEN p.tipo = 'papeleria' THEN 1.16
                    WHEN p.tipo = 'supermercado' THEN 1.04
                    WHEN p.tipo = 'drogueria' THEN 1.12
                END) / SUM(v.cantidad)
     FROM Productos p
     INNER JOIN Ventas v ON p.id = v.producto_id) AS promedio_ventas;

DELIMITER $$
CREATE PROCEDURE menu()
BEGIN
    DECLARE opcion INT;

    SELECT '
        ====== MENÚ PRINCIPAL ======
        1. Visualizar información de productos
        2. Vender un producto
        3. Abastecer la tienda con un producto
        4. Cambiar un producto
        5. Calcular estadísticas de ventas
        0. Salir' INTO @menu;

    -- Asignar la opción directamente para probar
    SET opcion = 1; -- Cambiar este valor para probar otras opciones
	AppMenuLoop: LOOP
    CASE opcion
        WHEN 1 THEN
            SELECT * FROM vista_productos;
        WHEN 2 THEN
            -- Valores de prueba
            SET @producto_id = 1;
            SET @cantidad = 5;
            CALL vender_producto(@producto_id, @cantidad);
        WHEN 3 THEN
            -- Valores de prueba
            SET @producto_id = 2;
            SET @cantidad = 10;
            CALL abastecer_producto(@producto_id, @cantidad);
        WHEN 4 THEN
            -- Valores de prueba
            SET @producto_id = 3;
            SET @nuevo_nombre = 'Ibuprofeno';
            SET @nuevo_tipo = 'drogueria';
            SET @nuevo_precio_base = 4.50;
            CALL cambiar_producto(@producto_id, @nuevo_nombre, @nuevo_tipo, @nuevo_precio_base);
        WHEN 5 THEN
            SELECT * FROM vista_estadisticas;
            WHEN 0 THEN
                LEAVE AppMenuLoop;
            ELSE
                SELECT 'Opción no válida. Inténtelo de nuevo.';
    END CASE;
    SET opcion = 0;
    END LOOP AppMenuLoop;
END$$
DELIMITER ;

call menu;

