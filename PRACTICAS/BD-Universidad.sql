USE master;
GO
IF DB_ID (N'Universidad') IS NOT NULL
DROP DATABASE Universidad;
CREATE DATABASE Universidad
ON
( NAME = Universidad_dat,
    FILENAME = 'C:\samples\Universidad.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = Universidad_log,
    FILENAME = 'C:\samples\Universidad.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE Universidad;
GO
CREATE TABLE Area
(
idArea INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Catedra
(
idCatedra INT NOT NULL,
idDepartamento INT NOT NULL,
idFacultad INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Departamento
(
idDepartamento INT NOT NULL,
idArea INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Facultad
(
idFacultad INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
direccion VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO 
CREATE TABLE Profesor
(
idProfesor INT NOT NULL,
idDepartamento INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
apellidoPaterno VARCHAR(50) NOT NULL,
apellidoMaterno VARCHAR(50) NOT NULL,
matricula VARCHAR(50) NOT NULL,
direccion VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE DepartamentoFacultad
(
idDepartamentoFacultad INT NOT NULL,
idFacultad INT NOT NULL,
idDepartamento INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE CatedraProfesor
(
idCatedraProfesor INT NOT NULL,
idCatedra INT NOT NULL,
idProfesor INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO

--Llaves Primarias
ALTER TABLE Area ADD CONSTRAINT PK_Area PRIMARY KEY(idArea)
ALTER TABLE Catedra ADD CONSTRAINT PK_Catedra PRIMARY KEY(idCatedra)
ALTER TABLE Departamento ADD CONSTRAINT PK_Departamento PRIMARY KEY(idDepartamento)
ALTER TABLE Facultad ADD CONSTRAINT PK_Facultad PRIMARY KEY(idFacultad)
ALTER TABLE Profesor ADD CONSTRAINT PK_Profesor PRIMARY KEY(idProfesor)
ALTER TABLE DepartamentoFacultad ADD CONSTRAINT PK_DepartamentoFacultad PRIMARY KEY(idDepartamentoFacultad)
ALTER TABLE CatedraProfesor ADD CONSTRAINT PK_CatedraProfesor PRIMARY KEY(idCatedraProfesor)

--LlavesForaneas
--Catedra
ALTER TABLE Catedra ADD CONSTRAINT FK_CatedraDepartamento FOREIGN KEY(idDepartamento) REFERENCES Departamento(idDepartamento)
ALTER TABLE Catedra ADD CONSTRAINT FK_CatedraFacultad FOREIGN KEY(idFacultad) REFERENCES Facultad(idFacultad)
--Departamento
ALTER TABLE Departamento ADD CONSTRAINT FK_DepartamentoArea FOREIGN KEY(idArea) REFERENCES Area(idArea)
--Profesor
ALTER TABLE Profesor ADD CONSTRAINT FK_ProfesorDepartamento FOREIGN KEY(idDepartamento) REFERENCES Departamento(idDepartamento)
--DepartamentoFacultad
ALTER TABLE DepartamentoFacultad ADD CONSTRAINT FK_DepartamentoFacultadFacultad FOREIGN KEY(idFacultad) REFERENCES Facultad(idFacultad)
ALTER TABLE DepartamentoFacultad ADD CONSTRAINT FK_DepartamentoFacultadDepertamento FOREIGN KEY(idDepartamento) REFERENCES Departamento(idDepartamento)
--CatedraProfesor
ALTER TABLE CatedraProfesor ADD CONSTRAINT FK_CatedraProfesorCatedra FOREIGN KEY(idCatedra) REFERENCES Catedra(idCatedra)
ALTER TABLE CatedraProfesor ADD CONSTRAINT FK_CatedraProfesorProfesor FOREIGN KEY(idProfesor) REFERENCES Profesor(idProfesor)

--Indices
CREATE INDEX TX_Area ON Area(idArea)
CREATE INDEX TX_Catedra ON Catedra(idCatedra)
CREATE INDEX TX_Departamento ON Departamento(idDepartamento)
CREATE INDEX TX_Facultad ON Facultad(idFacultad)
CREATE INDEX TX_Profesor ON Profesor(idProfesor)
CREATE INDEX TX_DepartamentoFacultad ON DepartamentoFacultad(idDepartamentoFacultad)
CREATE INDEX TX_CatedraProfesor ON CatedraProfesor(idCatedraProfesor)
