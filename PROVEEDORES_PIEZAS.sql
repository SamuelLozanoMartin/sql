CREATE TABLE PROVEEDORES(
	PROV_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
	PROV_NOM VARCHAR(50) NOT NULL,
	PRIMARY KEY (PROV_ID)
);

CREATE TABLE PIEZAS(
	PIEZ_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
	PIEZ_NOM VARCHAR(100) NOT NULL,
	PRIMARY KEY (PIEZ_ID)
);

CREATE TABLE PRECIOS(
	PREC_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
	PROV_ID INT UNSIGNED NOT NULL,
	PIEZ_ID INT UNSIGNED NOT NULL,
	PRECIO DECIMAL(10,2) UNSIGNED DEFAULT NULL,
	PRIMARY KEY (PREC_ID)
);
 
	id_tareas int not null auto_increment,
    tarea varchar(20) not null,
    descripcion varchar(150) not null,
    cobrado decimal(10,2) not null,
    gastado decimal(10,2) not null,
    pagado boolean not null,
    id_clientes int not null,
    primary key (id_tareas)
);



INSERT INTO PROVEEDORES(
		PROV_NOM
)
VALUES
('Bultaco'),
('Yamaha'),
('Honda'),
('Kawasaki'),
('BMW');

INSERT INTO PIEZAS(
	PIEZ_NOM
)
VALUES
('Carburador'),
('Bujia'),
('Chicle'),
('Rueda'),
('Cable acelerador');


ALTER TABLE PRECIOS     
ADD INDEX FK_PROV (PROV_ID),    
 ADD CONSTRAINT FK_PROV        
  FOREIGN KEY (PROV_ID)         
  REFERENCES PROVEEDORES (PROV_ID);


ALTER TABLE PRECIOS     
ADD INDEX FK_PIEZ (PIEZ_ID),    
 ADD CONSTRAINT FK_PIEZ        
  FOREIGN KEY (PIEZ_ID)         
  REFERENCES PIEZAS (PIEZ_ID);

ALTER TABLE PRECIOS 
ADD CONSTRAINT CT_UQ_PROV_PIEZ_ID UNIQUE(PROV_ID, PIEZ_ID);

INSERT INTO precios
(prov_id,piez_id,precio)
VALUES
(1,2,50.5),
(1,3,22),
(2,1,256.20),
(2,4,188.54),
(3,3,18.50),
(3,5,12),
(4,2,8),
(4,1,355.20),
(4,5,10.80),
(5,4,122.30),
(5,1,395.20);

 /*Obtener los nombres de todas las PIEZAS*/
 SELECT piez_nom FROM piezas;
 
 /*Obtener todos los datos de los PROVEEDORES*/
 SELECT * FROM proveedores;
 
 /*Precio medio de todas las piezas*/
 SELECT ROUND(AVG(precio),2)
 FROM precios;
 
 /*Obtener el precio medio por pieza al que nos suministran las piezas*/
 SELECT piez_nom,ROUND(AVG(precio),2)
 FROM precios pr
 INNER JOIN piezas pi
 ON pi.piez_id=pr.piez_id
 GROUP BY piez_nom;
 
 /*Obtener nombre PROVEEDOR y el precio medio por proveedor al que nos suministran las piezas*/
 SELECT prov_nom,ROUND(AVG(precio),2)
 FROM precios pre
 INNER JOIN proveedores pro
 ON pro.prov_id=pre.prov_id
 GROUP BY prov_nom;
 
 /*Obtener los nombres de los proveedores que distribuyen la pieza 1*/
 SELECT prov_nom
 FROM proveedores pro
 INNER JOIN precios pre
 ON pre.prov_id=pro.prov_id
 WHERE pre.piez_id=1;
 
 /*Nombres de las piezas suministradas por el proveedor cuyo código es 1*/
 SELECT piez_nom
 from piezas pi
 INNER JOIN precios pre
 ON pre.piez_id=pi.piez_id
 WHERE pre.prov_id=1;
 
 /*Nombres de las piezas suministradas por el proveedor cuyo nombre es Honda*/
 SELECT piez_nom
 from piezas pi
 INNER JOIN precios pre
 ON pre.piez_id=pi.piez_id
 INNER JOIN proveedores pro
 ON pro.prov_id=pre.prov_id
 WHERE LOWER(PRO.prov_NOM)=LOWER('HONDA');
 
 

/*Obtener un listado de los nombres de las piezas y los proveedores que suministran esas piezas más caras, 
 indicando el nombre de la pieza y el precio al que la suministran*/
SELECT pz.PIEZ_NOM, po.PROV_NOM, PRECIO
FROM PIEZAS pz
INNER JOIN 
PRECIOS pr
ON pz.PIEZ_ID = pr.PIEZ_ID
INNER JOIN PROVEEDORES po ON pr.PROV_ID = po.PROV_ID
WHERE PRECIO
IN (
SELECT MAX( PRECIO ) 
FROM PRECIOS pr2
GROUP BY pr2.PIEZ_ID
HAVING pr2.PIEZ_ID = pz.PIEZ_ID
);

