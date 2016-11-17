-- crear la tabla
create table T_OFFICES (
	OFFC_ID int NOT NULL, 
	OFFC_COUNTRY varchar(30) NOT NULL, 
	OFFC_DESCRIPTION varchar(90) , 
	OFFC_NAME varchar(30));

/*eliminar la tabla*/
DROP TABLE t_offices;

create table T_OFFICES (
	OFFC_ID int NOT NULL, 
	OFFC_COUNTRY varchar(30) NOT NULL, 
	OFFC_DESCRIPTION varchar(100),
    OFFC_NAME varchar(30)
	);
    
/* modificar datos de una columna*/
ALTER TABLE T_OFFICES
CHANGE COLUMN OFFC_DESCRIPTION
OFFC_DESCRIPTION VARCHAR (100);

/*eliminar una columna*/
ALTER TABLE T_OFFICES
DROP COLUMN OFFC_NAME;

/*añadir una columna*/
alter table t_offices
add column
OFFC_CITY varchar (50) not null
AFTER OFFC_COUNTRY;

/*INSERTAR REGISTROS*/

INSERT INTO T_OFFICES
(OFFC_ID,OFFC_COUNTRY,OFFC_CITY,OFFC_DESCRIPTION)
VALUES
(10,"España","Madrid","Oficina central");

INSERT INTO T_OFFICES
(OFFC_ID,OFFC_COUNTRY,OFFC_CITY)
VALUES
(11,"España","Barcelona");

/*INSERTAR VARIOS REGITROS DE UNA SOLA VEZ*/

INSERT INTO T_OFFICES
(OFFC_ID,OFFC_COUNTRY,OFFC_CITY,OFFC_DESCRIPTION)
VALUES
(20,"Chile","Santiago","Oficina principal  de Chile"),
(30,"Argentina","Buenos aires",null);


/*SELECT CON CONDICION*/

SELECT 
OFFC_ID,
OFFC_COUNTRY,
OFFC_CITY
FROM T_OFFICES
WHERE
OFFC_DESCRIPTION LIKE 'Oficina%';

/*actualizar registro*/

update T_OFFICES
SET
OFFC_CITY = 'Buenos Aires'
where offc_city = 'Buenos aires';

CREATE TABLE `T_KNOWLEDGE_LINES` (
`KNLN_ID` INT(11) NOT NULL,
`KNLN_NAME` VARCHAR(45) NOT NULL,
PRIMARY KEY (`KNLN_ID`)
);

INSERT INTO `T_KNOWLEDGE_LINES` 
(`KNLN_ID`, `KNLN_NAME`)
VALUES (10, 'Java');

INSERT INTO `T_KNOWLEDGE_LINES` 
(`KNLN_ID`, `KNLN_NAME`)
VALUES (20, '.NET');

INSERT INTO `T_KNOWLEDGE_LINES` 
(`KNLN_ID`, `KNLN_NAME`)
VALUES (30, 'Mainframe');

/*PONER COMO CLAVE PRIMARIA UNA COLUMNA*/
ALTER TABLE T_OFFICES
ADD PRIMARY KEY (OFFC_ID);

CREATE TABLE `T_EMPLOYEES` (
`EMPL_ID` INT NOT NULL AUTO_INCREMENT,
`OFFC_ID` INT NOT NULL,
`KNLN_ID` INT,
`EMPL_FORNAME` VARCHAR(50) NOT NULL,
`EMPL_MIDDLE_NAME` VARCHAR(50),
`EMPL_SURNAME` VARCHAR(50) NOT NULL,
`EMPL_NUMBER` INT NOT NULL,
`EMPL_HIRE_DATE` DATETIME NOT NULL,
`EMPL_MENTOR_ID` INT,
PRIMARY KEY (`EMPL_ID`));


INSERT INTO T_EMPLOYEES (
OFFC_ID, KNLN_ID, EMPL_FORNAME, EMPL_SURNAME, 
EMPL_NUMBER,EMPL_HIRE_DATE)
VALUES (
10, 10, "Luis", "Pérez", 150, "2015-05-30");

INSERT INTO T_EMPLOYEES (
OFFC_ID, KNLN_ID, EMPL_FORNAME, EMPL_SURNAME, 
EMPL_NUMBER,EMPL_HIRE_DATE)
VALUES (
20, 30, "Juan", "Dominguez", 150, "2014-05-30");


INSERT INTO T_employees (
offc_id, knln_id, empl_forname, empl_surname,
empl_number, empl_hire_date, empl_mentor_id)
VALUES (
11,20, "Luis", "Gonzalez", 160, "2006-05-18", 1);

INSERT INTO T_employees (
offc_id,  empl_forname, empl_surname,
empl_number, empl_hire_date)
VALUES (
20, "Pedro", "Garcia", 180, "2006-05-18");

CREATE TABLE `T_PROJECTS` (
`PRJT_ID` INT NOT NULL AUTO_INCREMENT,
`PRJT_CODE` VARCHAR(16) NOT NULL,
`PRJT_NAME` VARCHAR(50) NOT NULL,
PRIMARY KEY (`PRJT_ID`));

INSERT INTO t_projects (
prjt_code,prjt_name)
VALUES 
("EXT-3016", "SGLU"),
("INT-0100", "UCO"),
("MKT-0200", "Prop SC");


CREATE TABLE `T_PROJECTS_EMPLOYEES` (
`PRJT_ID` INT NOT NULL,
`EMPL_ID` INT NOT NULL,
PRIMARY KEY (PRJT_ID,EMPL_ID));

INSERT INTO t_projects_employees
(prjt_id,empl_id)
values
(1,3),(2,4),(2,5),(3,1),(3,4);

INSERT INTO t_projects (
prjt_code,prjt_name)
VALUES
("EXT-001000-01234","Gestion de usuarios"),
("INT-001000-03200","Cursos de formacion");

INSERT INTO t_projects_employees
(prjt_id, empl_id)
VALUES
(1,1),(1,2),(6,1);

/*PONER COMO CLAVE PRIMARIA UN CAMPO*/
alter table t_offices
add primary key (offc_id);

/*CREAR CLAVE FORANEA*/

ALTER TABLE t_employees
ADD INDEX FK_EMPL_OFFC (offc_id),
ADD CONSTRAINT FK_EMPL_OFFC
FOREIGN KEY (offc_id)
REFERENCES t_offices (offc_id);

/*OTRA CLAVE FORANEA*/

ALTER TABLE T_EMPLOYEES
ADD INDEX FK_EMPL_KNLN (KNLN_ID),
ADD CONSTRAINT FK_EMPL_KNLN
FOREIGN KEY (KNLN_ID)
REFERENCES T_KNOWLEDGE_LINES (KNLN_ID);

ALTER TABLE t_projects_employees
ADD INDEX fk_prem_prjt (prjt_id),
ADD CONSTRAINT fk_prem_prjt
FOREIGN KEY (prjt_id)
REFERENCES t_projects (prjt_id);

ALTER TABLE t_projects_employees
ADD INDEX fk_prem_empl (empl_id),
ADD CONSTRAINT fk_prem_empl
FOREIGN KEY (empl_id)
REFERENCES t_employees (empl_id);`PRIMARY`

alter table t_employees
add index fk_empl_mentor (empl_mentor_id),
add constraint fk_empl_mentor
foreign key (empl_mentor_id)
references t_employees (empl_id);

/*SELECT CON LEFT OUTER JOIN MULTIPLE*/
select e.empl_forname, e.empl_surname, o.offc_city, k.knln_name
from t_employees e 
left outer join t_offices o on e.offc_id=o.offc_id
left outer join t_knowledge_lines k on e.knln_id= k.knln_id
where o.offc_country IN ("España","Chile") and e.empl_mentor_id is null;

/*SELECT CON INNER JOIN*/
SELECT p.prjt_code, p.prjt_name, e.empl_number, e.empl_surname
from t_projects p,t_employees e, t_projects_employees pe
WHERE p.prjt_id=pe.prjt_id and e.empl_id=pe.empl_id and e.empl_forname="Luis";

/*CREAR UNA VISTA*/
CREATE VIEW v_projects_employees
(prjt_code, prjt_name, empl_number, empl_forname, empl_surname)
AS 
SELECT p.prjt_code, p.prjt_name, e.empl_number, e.empl_forname, e.empl_surname
from t_projects p,t_employees e, t_projects_employees pe
WHERE p.prjt_id=pe.prjt_id and e.empl_id=pe.empl_id;

/*SELECT DE LA VISA CREADA ANTERIORMENTE*/
SELECT * FROM v_projects_employees v
WHERE v.prjt_code like ("EXT%");

/*COUNT Y GROUP BY*/
SELECT COUNT(offc_id) AS CNT_offc, offc_country
FROM t_offices 
GROUP BY offc_country;

CREATE TABLE `T_DOCUMENTS` (
`DOCS_ID` INT NOT NULL AUTO_INCREMENT,
`EMPL_ID` INT NOT NULL,
`DOCS_NAME` VARCHAR(100) NOT NULL,
`DOCS_TYPE` enum ('PDF', 'DOC', 'XLS') NOT NULL,
PRIMARY KEY (`DOCS_ID`));

ALTER TABLE T_DOCUMENTS ADD INDEX FK_DOCS_EMPL (EMPL_ID),
ADD CONSTRAINT FK_DOCS_EMPL
FOREIGN KEY (EMPL_ID) REFERENCES T_EMPLOYEES (EMPL_ID);

INSERT INTO `T_DOCUMENTS`
(`EMPL_ID`, `DOCS_NAME`, `DOCS_TYPE`)
VALUES
(1, 'Titulo', 'PDF'),
(1, 'Curriculum', 'DOC'),
(1, 'Certificado OCP', 'PDF'),
(1, 'Matriz conocimientos', 'XLS'),
(2, 'Grado', 'PDF'),
(2, 'Curriculum', 'DOC'),
(2, 'Certificado MS', 'PDF'),
(3, 'Titulo', 'PDF');

/*CONCAT COUNT ORDER BY ASC y LIMIT*/
SELECT CONCAT(e.empl_forname, ' ', e.empl_surname) AS FULL_NAME,
COUNT(docs_id) Num_docs
FROM t_documents d,t_employees e
where d.empl_id=e.empl_id
GROUP BY e.empl_id
order by num_docs ASC LIMIT 1,2;

/*CONCAT COUNT GROUP BY LEFT OUTER JOIN*/
SELECT CONCAT(e.empl_forname, ' ', e.empl_surname) AS FULL_NAME,
COUNT(docs_id) Num_docs
FROM t_employees e
LEFT OUTER JOIN t_documents d
ON d.empl_id=e.empl_id
GROUP BY e.empl_id
order by num_docs ASC
limit 1,3;
