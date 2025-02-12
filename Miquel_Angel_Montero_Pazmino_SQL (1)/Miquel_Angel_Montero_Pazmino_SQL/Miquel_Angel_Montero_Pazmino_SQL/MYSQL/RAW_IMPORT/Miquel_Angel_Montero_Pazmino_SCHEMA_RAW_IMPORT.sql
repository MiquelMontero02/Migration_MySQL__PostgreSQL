/*
Estrucutura de la base de datos que almacenara el volcado de los datos de los
archivos:
    -   "estudiants.csv"
    -   "matriculas.csv"
    -   "Llistat_CENTRES.xls"
*/
CREATE TABLESPACE DADE_TEMPORALS ADD DATAFILE 'dades_temporals.idb' ENGINE=INNODB;

CREATE DATABASE RAW_IMPORT
    CHARACTER SET='utf8';
    
USE RAW_IMPORT;

CREATE TABLE CENTRE(
    CODI INT PRIMARY KEY,
    DENOM_GEN VARCHAR(16) NOT NULL,
    NOM VARCHAR (128) NOT NULL,
    EMAIL VARCHAR(128) NOT NULL,
    EMAIL_LIST VARCHAR(256) NULL,
    WEB VARCHAR (128) NULL,
    TITULAR VARCHAR (128) NOT NULL,
    NIF VARCHAR (16) NULL,
    LOCALITAT VARCHAR (64) NOT NULL,
    MUNICIPI VARCHAR (32) NOT NULL,
    ADREC VARCHAR (128) NOT NULL,
    CP INT NOT NULL,
    ILLA VARCHAR(16) NOT NULL,
    TELEFON VARCHAR(16) NULL
)TABLESPACE DADE_TEMPORALS ENGINE=InnoDB;

CREATE TABLE ESTUDIANT(
    DNI VARCHAR (16) PRIMARY KEY,
    NOM VARCHAR (64) NOT NULL,
    COGNOM_1 VARCHAR (32) NOT NULL,
    COGNOM_2 VARCHAR (32) NULL,
    EMAIL VARCHAR (64) NOT NULL,
    CP_DISTR VARCHAR(16) NOT NULL,
    COM_AUT VARCHAR(16) NOT NULL,
    MUNICIPI VARCHAR (32) NOT NULL
)TABLESPACE DADE_TEMPORALS ENGINE=InnoDB;

CREATE TABLE MATRICULA(
    ID INT NOT NULL AUTO_INCREMENT ,
    DNI VARCHAR (16) NOT NULL,
    TIPO_ENSNY VARCHAR (8) NOT NULL,
    MODALITAT VARCHAR (16) NOT NULL,
    CURS INT NOT NULL,
    ASSIGNATURA VARCHAR (128) NOT NULL,
    GRUP CHAR NOT NULL,
    CODI_CENTRE INT NOT NULL,
    PRIMARY KEY(ID)
)TABLESPACE DADE_TEMPORALS ENGINE=InnoDB;

