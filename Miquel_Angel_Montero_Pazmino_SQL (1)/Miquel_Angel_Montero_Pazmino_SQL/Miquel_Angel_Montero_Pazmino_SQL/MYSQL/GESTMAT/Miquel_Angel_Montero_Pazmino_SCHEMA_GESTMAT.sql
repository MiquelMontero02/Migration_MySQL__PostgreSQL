CREATE TABLESPACE PANDORA ADD DATAFILE 'pandora.ibd' ENGINE=INNODB;

CREATE DATABASE GESTMAT
CHARACTER SET='utf8';

CREATE USER IF NOT EXISTS TRANSFORMADOR_1 IDENTIFIED BY '1234';
GRANT CREATE,INSERT,SELECT,REFERENCES,CREATE VIEW ON GESTMAT.* TO 'TRANSFORMADOR_1'@'%';
GRANT SELECT ON RAW_IMPORT.* TO 'TRANSFORMADOR_1'@'%';
FLUSH PRIVILEGES;

USE GESTMAT;

CREATE TABLE CORR_ELECT(
    ID INT PRIMARY KEY AUTO_INCREMENT,
    CORR_ELECT VARCHAR(512)
);

CREATE TABLE CURS(
    ID INT PRIMARY KEY
);

CREATE TABLE ASSIGNATURA(
    NOM VARCHAR (128) PRIMARY KEY
    
);

CREATE TABLE DENOM_GEN(
    NOM VARCHAR(16) PRIMARY KEY 
);

CREATE TABLE COM_AUT(
    NOM VARCHAR(32) PRIMARY KEY    
);

CREATE TABLE TIPO_ENSNY(
    NOM VARCHAR(8) PRIMARY KEY 
);

CREATE TABLE DISTRIT(
    ID INT PRIMARY KEY
);


CREATE TABLE MODALITAT(
    NOM VARCHAR(32) PRIMARY KEY  
);

CREATE TABLE GRUP(
    ID CHAR PRIMARY KEY
);

CREATE TABLE TITULAR(
    NIF VARCHAR(16) PRIMARY KEY,
    NOM VARCHAR(128) NOT NULL
);

CREATE TABLE LOCALITAT(
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NOM VARCHAR(64) NOT NULL
);

CREATE TABLE ILLA (
    NOM VARCHAR(32) PRIMARY KEY,
    COM_AUT VARCHAR(32),
    FOREIGN KEY (COM_AUT) REFERENCES COM_AUT(NOM)  
);

CREATE TABLE MUNICIPI(
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NOM VARCHAR(64) NOT NULL,
    COM_AUT VARCHAR(32) NOT NULL,
    FOREIGN KEY (COM_AUT) REFERENCES COM_AUT(NOM)
);

CREATE TABLE CODI_POSTAL (
    CP VARCHAR(8) PRIMARY KEY,
    MUNICIPI INT NOT NULL,
    FOREIGN KEY (MUNICIPI) REFERENCES MUNICIPI(ID)
);

CREATE TABLE ESTUDIANT(
    DNI VARCHAR(16) PRIMARY KEY,
    NOM VARCHAR (64) NOT NULL,
    EMAIL VARCHAR(64) NOT NULL,
    COGNOM VARCHAR(64) NOT NULL,
    COGNOM_AD VARCHAR(64) NULL,
    MUNICIPI INT NOT NULL,
    FOREIGN KEY (MUNICIPI) REFERENCES MUNICIPI(ID)
);

CREATE TABLE CENTRE(
    ID INT PRIMARY KEY,
    NOM_CENTRE VARCHAR(256) NOT NULL,
    TELEFON INT NOT NULL,
    WEB VARCHAR(128) NOT NULL,
    TITULAR VARCHAR(16) NOT NULL,
    CP VARCHAR(8) NOT NULL,
    FOREIGN KEY (TITULAR) REFERENCES TITULAR(NIF),
    FOREIGN KEY (CP) REFERENCES CODI_POSTAL(CP)
);

CREATE TABLE ADRECA(
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NOM VARCHAR(128) NOT NULL,
    LOCALITAT INT NOT NULL,
    CENTRE INT,
    FOREIGN KEY (LOCALITAT) REFERENCES LOCALITAT(ID),
    FOREIGN KEY (CENTRE) REFERENCES CENTRE(ID)  
);

CREATE TABLE MATRICULA(
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ESTUDIANT VARCHAR(16) NOT NULL,
    TIPO_ENSNY VARCHAR(8) NOT NULL,
    CENTRE INT NOT NULL,
    CURS INT NOT NULL,
    ASSIGNATURA VARCHAR (128) NOT NULL,
    MODALITAT VARCHAR (32) NOT NULL,
    GRUP CHAR NOT NULL,
    FOREIGN KEY (ESTUDIANT) REFERENCES ESTUDIANT(DNI),
    FOREIGN KEY (TIPO_ENSNY) REFERENCES TIPO_ENSNY(NOM),
    FOREIGN KEY (CENTRE) REFERENCES CENTRE(ID),
    FOREIGN KEY (CURS) REFERENCES CURS(ID),
    FOREIGN KEY (ASSIGNATURA) REFERENCES ASSIGNATURA(NOM),
    FOREIGN KEY (MODALITAT) REFERENCES MODALITAT(NOM),
    FOREIGN KEY (GRUP) REFERENCES GRUP(ID)
);

CREATE TABLE R_CENTRE_CORREU(
    CENTRE INT NOT NULL,
    CORREU INT NOT NULL,
    FOREIGN KEY (CENTRE) REFERENCES CENTRE(ID),
    FOREIGN KEY (CORREU) REFERENCES CORR_ELECT(ID),
    CONSTRAINT ID PRIMARY KEY (CENTRE,CORREU)
);


CREATE TABLE R_MUNICIPI_DISTRIT(
    MUNICIPI INT NOT NULL,
    DISTRIT INT NOT NULL,
    FOREIGN KEY (MUNICIPI) REFERENCES MUNICIPI(ID),
    FOREIGN KEY(DISTRIT) REFERENCES DISTRIT(ID),
    CONSTRAINT ID PRIMARY KEY(MUNICIPI, DISTRIT)
);

CREATE TABLE R_MUNICIPI_LOCALITAT(
    MUNICIPI INT NOT NULL,
    LOCALITAT INT NOT NULL,
    FOREIGN KEY (MUNICIPI) REFERENCES MUNICIPI(ID),
    FOREIGN KEY (LOCALITAT) REFERENCES LOCALITAT(ID),
    CONSTRAINT ID PRIMARY KEY(MUNICIPI, LOCALITAT)
);


