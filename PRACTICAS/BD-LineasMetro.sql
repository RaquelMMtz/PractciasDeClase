USE master;
GO
IF DB_ID (N'LineasMetro') IS NOT NULL
DROP DATABASE LineasMetro;
CREATE DATABASE LineasMetro
ON
( NAME = LineasMetro_dat,
    FILENAME = 'C:\samples\LineasMetro.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = LineasMetro_log,
    FILENAME = 'C:\samples\LineasMetro.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE LineasMetro;
GO
CREATE TABLE Acceso
(
idAcceso INT NOT NULL,
idEstacion INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
numero INT NOT NULL,
direccion VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Cochera
(
idCochera INT NOT NULL,
idEstacion INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
numero INT NOT NULL,
direccion VARCHAR(50)NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Estacion
(
idEstacion INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
direccion VARCHAR(50) NOT NULL,
numero INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Linea
(
idLinea INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
ruta VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Tren
(
idTren INT NOT NULL,
idCochera INT NOT NULL,
idLinea INT NOT NULL,
clave VARCHAR(10) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE EstacionLinea
(
idEstacionLinea INT NOT NULL,
idEstacion INT NOT NULL,
idLinea INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO

--Llaves Primarias
ALTER TABLE Acceso ADD CONSTRAINT PK_Acceso PRIMARY KEY(idAcceso)
ALTER TABLE Cochera ADD CONSTRAINT PK_Cochera PRIMARY KEY(idCochera)
ALTER TABLE Estacion ADD CONSTRAINT PK_Estacion PRIMARY KEY(idEstacion)
ALTER TABLE Linea ADD CONSTRAINT PK_Linea PRIMARY KEY(idLinea)
ALTER TABLE Tren ADD CONSTRAINT PK_Tren PRIMARY KEY(idTren)
ALTER TABLE EstacionLinea ADD CONSTRAINT PK_EstacionLinea PRIMARY KEY(idEstacionLinea)

--Llaves Foraneas
--Acceso
ALTER TABLE Acceso ADD CONSTRAINT FK_AccesoEstacion FOREIGN KEY(idEstacion) REFERENCES Estacion(idEstacion)
--Cochera
ALTER TABLE Cochera ADD CONSTRAINT FK_CocheraEstacion FOREIGN KEY(idEstacion) REFERENCES Estacion(idEstacion)
--Tren
ALTER TABLE Tren ADD CONSTRAINT FK_TrenCochera FOREIGN KEY(idCochera) REFERENCES Cochera(idCochera)
ALTER TABLE Tren ADD CONSTRAINT FK_TrenLinea FOREIGN KEY(idLinea) REFERENCES Linea(idLinea)
--EstacionLinea
ALTER TABLE EstacionLinea ADD CONSTRAINT FK_EstacionLineaEstacion FOREIGN KEY(idEstacion) REFERENCES Estacion(idEstacion)
ALTER TABLE EstacionLinea ADD CONSTRAINT FK_EstacionLineaLinea FOREIGN KEY(idLinea) REFERENCES Linea(idLinea)

--INDICES
CREATE INDEX TX_Acceso ON Acceso(idAcceso)
CREATE INDEX TX_Cochera ON Cochera(idCochera)
CREATE INDEX TX_Estacion ON Estacion(idEstacion)
CREATE INDEX TX_Linea ON Linea(idLinea)
CREATE INDEX TX_Tren ON Tren(idTren)
CREATE INDEX TX_EstacionLinea ON EstacionLinea(idEstacionLinea)