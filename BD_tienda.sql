/*CREAR LA TABLA ARTICULOS*/
CREATE TABLE t_articulos (
art_id INT NOT NULL AUTO_INCREMENT,
art_nom VARCHAR (100) NOT NULL,
art_precio DECIMAL(10,2) UNSIGNED,
fab_id INT NOT NULL,
PRIMARY KEY (art_id));

/*CREAR LA TABLA FABRICANTES*/
CREATE TABLE t_fabricantes (
fab_id INT NOT NULL AUTO_INCREMENT,
fab_nombre VARCHAR(50) NOT NULL,
PRIMARY KEY (fab_id));

/*HACER LA RELACION ENTRE ARTICULOS Y FABRICANTES*/
ALTER TABLE t_articulos 
ADD INDEX fk_art_fab (fab_id),
ADD CONSTRAINT fk_art_fab
FOREIGN KEY (fab_id)
REFERENCES t_fabricantes (fab_id);

/*INSERTAR DATOS EN FABRICANTES*/
INSERT INTO t_fabricantes
(fab_nombre)
VALUES
('Sony'),('Acer'),('Toshiba'),('Msi'),
('Asus'),('Lenovo'),('Apple'),('Motorola'),
('Lg'),('Samsung'),('Philips');

/*INSERTAR DATOS EN ARTICULOS*/
INSERT INTO t_articulos
(art_nom, art_precio, fab_id)
VALUES
('Portatail MDS', 998, 1),('Auriculares X90', 34.65, 3),
('Mando PS', 22.15, 1),('Tablet BD45', 102.50, 4),
('Movil SF', 122, 7),('Cadena Musical TS55', 220.48, 11),
('TV HD 4500', 1005.78, 9),('TV HD 5600', 1250.50, 9),
('Portatil FGV2222',745.20,2);

/*SELECCIONAR TODOS LOS ARTICULOS Y SUS PRECIOS*/
SELECT art_nom,art_precio
from t_articulos;

/*ARTICULOS QUE CUESTA MAS DE 200*/
SELECT art_nom,art_precio
FROM t_articulos
WHERE art_precio > 200;

/*ARTICULOS QUE CUESTEN MAS DE 200 Y MENOS DE 1000*/
SELECT * 
FROM t_articulos
WHERE art_precio between 200 AND 1000; 

/*ARTICULOS Y PRECIO EN PTS REDONDEANDO A 2 DECIMALES*/
SELECT art_nom, ROUND(art_precio*1.386,2) AS precio_pts
from t_articulos;

/*MEDIA DE PRECIOS REDONDEADO A 2 DECIMALES*/
SELECT ROUND(AVG(art_precio),2) AS Precio_medio
from t_articulos;

/*MEDIA DE PRECIOS DE LOS ARTICULOS CUYO FABRICANTE SEA UN FABRICANTE CONCRETO*/
SELECT ROUND(AVG(art_precio),2) AS Precio_medio,FAB_NOMBRE
from t_articulos a,t_fabricantes f
WHERE A.FAB_ID=F.FAB_ID AND LOWER(f.fab_nombre)=LOWER('SONY');

/*OBTENER NUMERO DE ARTICULOS CON PRECIO MAYOR O IGUAL A 180*/
SELECT COUNT(art_id)
FROM t_articulos
WHERE art_precio >=80;

/*ORDENAR LA TABLA DE ARTICULOS DESC POR PRECIO Y ASC POR NOMBRE Y CUYO PRECIO SEA MAYOR DE 180*/
SELECT * 
FROM t_articulos
WHERE art_precio > 180
ORDER BY art_precio DESC, art_nom ASC;

/*LISTADO DE ARTICULOS INCLUYENDO POR CADA ARTICULO LOS DATOS DE SU FABRICATE*/
SELECT art_id,art_nom,art_precio,fab_nombre
from t_articulos a,t_fabricantes f
WHERE a.fab_id=f.fab_id;

/*LISTADO DE ARTICULOS CON SUS FABRICANTES CON UN 'INNER JOIN'*/
SELECT art_nom,fab_nombre,art_precio
from t_articulos a
INNER JOIN t_fabricantes f
ON a.fab_id=f.fab_id
ORDER BY f.fab_nombre;

/*OBTNER PRECIO MEDIO DE LOS ARTICULOS DE CADA FABRICANTE,
MOSTRANDO EL ID DEL FABRICANTE*/
SELECT ROUND(AVG(art_precio),2) AS precio_medio, fab_id
FROM t_articulos
GROUP BY fab_id;

/*OBTNER PRECIO MEDIO DE LOS ARTICULOS DE CADA FABRICANTE,
MOSTRANDO LOS FABRICANTES*/
SELECT ROUND(AVG(art_precio),2) AS precio_medio, fab_nombre
FROM t_articulos a,t_fabricantes f
WHERE f.fab_id=a.fab_id
GROUP BY a.fab_id;

/*OBTENER LOS NOMBRES DE LOS FABRICANTE QUE OFREZCAN PRODUCTOS
CUYO PRECIO MEDIO SEA MAYOR O IGUAL A 180*/

SELECT ROUND(AVG(a.art_precio),2) PRECIO_MEDIO,F.FAB_NOMBRE
FROM T_FABRICANTES F
INNER JOIN T_ARTICULOS a
ON A.FAB_ID=F.FAB_ID 
GROUP BY F.FAB_ID
HAVING PRECIO_MEDIO >=180;

/*Obtener el nombre y el precio del artículo más barato*/
SELECT art_precio,art_nom
FROM t_articulos
WHERE art_precio
IN
(select min(art_precio) FROM t_articulos)

;

/*Obtener una lista con el nombre y precio de los artículos más caros de cada proveedor
 (incluyendo el nombre del proveedor)*/
 
SELECT art_nom,art_precio,fab_nombre,f.fab_id 
from t_articulos a
INNER JOIN t_fabricantes f
ON f.fab_id=a.fab_id
WHERE art_precio
IN
(SELECT MAX(art_precio) FROM t_articulos
group by fab_id);

/*Añadir un nuevo producto: altavoces de 70€ del fabricante 2*/
INSERT INTO t_articulos
(art_nom,art_precio,fab_id)
VALUES
('Altavoces TEX33',70,2);

/*Cambiar el nombre del producto 4 a 'Impresora laser':*/
UPDATE t_articulos
SET art_nom='Impresora Laser'
WHERE art_id=4;

/*Aplicar un descuento del 10% a todos los productos*/
UPDATE t_articulos
SET art_precio=art_precio*0.90;

/*Aplicar un descuento del 10% a todos los productos cuyo precio sea mayor o igual a 120€ */
UPDATE t_articulos
SET art_precio=art_precio*0.90
WHERE art_precio >= 120;