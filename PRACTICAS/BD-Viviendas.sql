USE master;
GO
IF DB_ID (N'Viviendas') IS NOT NULL
DROP DATABASE Viviendas;
CREATE DATABASE Viviendas
ON
( NAME = Viviendas_dat,
    FILENAME = 'C:\samples\Viviendas.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = Viviendas_log,
    FILENAME = 'C:\samples\Viviendas.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE Viviendas;
GO
CREATE TABLE Municipio
(
idMunicipio INT NOT NULL,
idVivienda INT NOT NULL,
nombre VARCHAR (50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Persona
(
idPersona INT NOT NULL,
idVivienda INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
apellidoPaterno VARCHAR (50) NOT NULL,
apellidoMaterno VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Vivienda
(
idVivienda INT NOT NULL,
idPersona INT NOT NULL,
direccion VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
--Llaves Primarias
ALTER TABLE Municipio ADD CONSTRAINT PK_Municipio PRIMARY KEY(idMunicipio)
ALTER TABLE Persona ADD CONSTRAINT PK_Persona PRIMARY KEY(idPersona)
ALTER TABLE Vivienda ADD CONSTRAINT PK_Vivienda PRIMARY KEY(idVivienda)
--Llaves Foraneas
--Municipio
ALTER TABLE Municipio ADD CONSTRAINT FK_MunicipioVivienda FOREIGN KEY(idVivienda) REFERENCES Vivienda(idVivienda)
--Persona
ALTER TABLE Persona ADD CONSTRAINT FK_PersonaVivivenda FOREIGN KEY(idVivienda) REFERENCES Vivienda(idVivienda)
--Vivienda
ALTER TABLE Vivienda ADD CONSTRAINT FK_ViviendaPersona FOREIGN KEY(idPersona) REFERENCES Persona(idPersona)

--Indices
CREATE INDEX TX_Municipio ON Municipio(idMunicipio)
CREATE INDEX TX_Vivienda ON Vivienda(idVivienda)
CREATE INDEX TX_Persona ON Persona(idPersona)