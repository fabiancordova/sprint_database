/*crear base de datos*/
CREATE DATABASE IF NOT EXISTS telovendo;
USE telovendo;

/*crear usuario administrador para que pueda conectarse localmente a la base datos multitienda
y tenga todos los permisos sobre la base de datos*/
DROP USER `administrador`@`localhost`;
CREATE USER `administrador`@`localhost` IDENTIFIED BY '123';
GRANT ALL ON telovendo.* TO `administrador`@`localhost`;

CREATE TABLE IF NOT EXISTS proveedor (
  id_proveedor int NOT NULL AUTO_INCREMENT,
  representante_legal varchar(30) DEFAULT NULL,
  nombre_proveedor varchar(30) DEFAULT NULL,
  telefono_1 int NOT NULL,
  telefono_2 int NOT NULL,
  categoria_producto varchar(100) DEFAULT NULL,
  email varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (id_proveedor)
);

INSERT INTO proveedor VALUES
  (1,'Alejandro Fridman','ripley',982675900, 982675910,'computación','ventas@ripley.com'),
  (2,'Jaime Ramirez','falabella',982675800, 982675810,'computación','ventas@falabella.com'),
  (3,'José Couso','paris',982675700, 982675710,'computación','ventas@paris.com'),
  (4,'Herman Osses','hites',982675600, 982675610,'computación','ventas@hites.com'),
  (5,'Manuel Larraín','la polar',982675500, 982675510,'electro hogar','ventas@lapolar.com'),
  (6,'Rodrigo Matta','lider',982675400, 982675410,'electro hogar','ventas@lider.com'),
  (7,'Rodrigo Libano','abcdin',982675300, 982675310,'electro hogar','ventas@abcdin.com'),
  (8,'Ricardo Gonzalez','jumbo',982675258, 982675350,'deportes','servicio.ventas@jumbo.com');

SELECT * FROM proveedor;

CREATE TABLE IF NOT EXISTS cliente (
  id_cliente int NOT NULL AUTO_INCREMENT,
  nombre varchar(30) DEFAULT NULL,
  apellido varchar(30) DEFAULT NULL,
  dirección varchar(100) DEFAULT NULL,
  PRIMARY KEY (id_cliente)
);

INSERT INTO cliente VALUES 
  (1, 'juan', 'perez', 'los aromos 751'), 
  (2, 'pedro', 'tapia', 'los sauces 761'),
  (3, 'alex', 'solar', 'colon 751'), 
  (4, 'ignacio', 'garrido', 'valencia 551'),
  (5, 'pablo', 'martinez', 'octava 751'), 
  (6, 'maria', 'perez', 'los aromos 751'), 
  (7, 'luisa', 'tapia', 'los sauces 761'),
  (8, 'ana', 'rojas', 'los almendros 751');
  
  SELECT * FROM cliente;
  
  CREATE TABLE IF NOT EXISTS producto (
  id_producto int NOT NULL AUTO_INCREMENT,
  nombre varchar(30) DEFAULT NULL,
  precio int NOT NULL,
  categoria_producto varchar(100) DEFAULT NULL,
  nombre_proveedor varchar(100) DEFAULT NULL,
  color varchar(30) DEFAULT NULL,
  stock int NOT NULL,
  id_proveedor int NOT NULL,
  PRIMARY KEY (id_producto),
  FOREIGN KEY (id_proveedor) REFERENCES proveedor (id_proveedor) on delete cascade on update cascade
);
  
  INSERT INTO producto VALUES
  (1,'notebook Apple',900000,'computación', 'ripley','blanco',100, 1),
  (2,'notebook Dell',730000,'computación', 'falabella','negro',120, 2),
  (3,'notebook Dell',700000,'computación', 'paris','negro',110, 3),
  (4,'notebook HP',690000,'computación', 'hites','negro',130, 4),
  (5,'refrigerador Samsung',350000,'electro hogar', 'la polar','gris',50, 5),
  (6,'refrigerador LG',400000,'electro hogar', 'lider','blanco',40, 6),
  (7,'cocina Bosch',150000,'electro hogar', 'abcdin','blanco',35, 7),
  (8,'mountain bike',120000,'deportes', 'jumbo','rojo',80,8);

  SELECT * FROM producto;

/*consultar la categoría de productos que más se repite.*/
SELECT producto.categoria_producto, COUNT( categoria_producto ) AS total
FROM  producto
GROUP BY categoria_producto
ORDER BY total DESC;

/*consultar la cantidad de marcas de productos de mayor a menor.*/
SELECT producto.nombre AS marcas, COUNT( stock ) AS total
FROM  producto
GROUP BY nombre
ORDER BY total DESC; 

/*consultar la cantidad de productos con mayor stock.*/
SELECT producto.nombre AS nombre_producto,SUM(stock) AS total FROM producto GROUP BY nombre ORDER BY total DESC;
/*consultar el color de producto es más común.*/
SELECT producto.color AS color_del_producto,SUM(stock) AS total FROM producto GROUP BY color ORDER BY total DESC;
/*consultar los proveedores con menor stock de productos.*/
select proveedor.nombre_proveedor, producto.stock AS total_productos from proveedor inner join producto on proveedor.id_proveedor=producto.id_proveedor ORDER BY total_productos ASC; 
/*Cambiar la categoría de productos más popular por ‘Electrónica y computación’.*/
UPDATE proveedor, producto SET proveedor.categoria_producto='Electrónica_y_computación', producto.categoria_producto='Electrónica_y_computación' 
WHERE proveedor.categoria_producto='computación' AND producto.categoria_producto='computación';