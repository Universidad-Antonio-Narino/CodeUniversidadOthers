/*
PROBLEM
De cada libro se conoce:
- ISBN. Identificador del libro. No pueden existir dos libros en la tienda con el mismo ISBN.
- Título. El nombre del libro.
- Precio de compra: Valor pagado por la compra de cada ejemplar en la tienda.
- Precio de venta: Valor por el cual se vende cada ejemplar del libro.
- Cantidad actual. Cantidad actual de ejemplares que tiene la tienda. Solo puede ser modificada mediante
la venta o abastecimiento.
Adicionalmente, de cada libro se conoce todas las transacciones que se han realizado sobre él. De cada
transacción se conoce:
- El tipo de transacción. Puede ser venta o abastecimiento.
- La fecha de realización.
- La cantidad de ejemplares incluidos en la transacción.
El abastecimiento de libros permite aumentar la cantidad actual de ejemplares del libro y registrar una
transacción de tipo abastecimiento.
La venta de libros permite disminuir la cantidad actual de ejemplares del libro y registrar una transacción
de venta. Esta transacción solo se podrá realizar si la cantidad actual de ejemplares es mayor a la cantidad
que se quiere vender.

*/


CREATE DATABASE IF NOT EXISTS libreriaUan;

use libreriaUan;

CREATE TABLE IF NOT EXISTS libro (
    isbn VARCHAR(14) UNIQUE NOT NULL,
    titulo VARCHAR(45) NOT NULL,
    precioCompra INT NOT NULL,
    precioVenta INT NOT NULL,
    CantidadActualLibros INT NOT NULL,
    PRIMARY KEY (isbn)
);

CREATE TABLE IF NOT EXISTS transacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(14)  NOT NULL,
    tipoTransicion VARCHAR(15) NOT NULL,
    fechaRealizacion DATE NOT NULL,
    CantidadEjemplares INT NOT NULL,
    FOREIGN KEY (isbn) REFERENCES libro(isbn)
);

INSERT INTO libro(isbn, titulo, precioCompra, precioVenta, CantidadActualLibros) VALUES 
('978-014243723', 'Moby Dick', 10, 15, 50),
('978-159327283', 'Eloquent JavaScript', 20, 30, 40),
('978-144933181', 'Learning Python', 15, 25, 60),
('978-059600712', 'Head First Design Patterns', 25, 35, 30);

INSERT INTO libreriauan.transacion (isbn, tipoTransicion, fechaRealizacion, CantidadEjemplares) VALUES 
('978-014243723', 'Abastecimiento', '2024-04-25', 20),
('978-014243723', 'Venta', '2024-04-26', 5),
('978-159327283', 'Abastecimiento', '2024-04-24', 15),
('978-159327283', 'Venta', '2024-04-27', 10),
('978-144933181', 'Abastecimiento', '2024-04-22', 30),
('978-144933181', 'Venta', '2024-04-25', 20),
('978-059600712', 'Abastecimiento', '2024-04-23', 25),
('978-059600712', 'Venta', '2024-04-26', 15);


