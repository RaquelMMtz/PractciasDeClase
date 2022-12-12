USE master;
GO
IF DB_ID (N'CINE') IS NOT NULL
DROP DATABASE CINE;
CREATE DATABASE CINE
ON
( NAME = CINE_dat,
    FILENAME = 'C:\samples\CINE.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = CINE_log,
    FILENAME = 'C:\samples\CINE.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE CINE;
GO
CREATE TABLE Actor
(
idActor INT NOT NULL,
nombre VARCHAR NOT NULL,
apellido VARCHAR NOT NULL,
personaje VARCHAR NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Boleto
(
idBoleto INT NOT NULL,
idEmpleado INT NOT NULL,
idCliente INT NOT NULL,
idPelicula INT NOT NULL,
descripcion VARCHAR NOT NULL,
fecha DATETIME NOT NULL,
asiento VARCHAR NOT NULL,
fila VARCHAR NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Cliente
(
idCliente INT NOT NULL,
nombre VARCHAR NOT NULL,
apellido VARCHAR NOT NULL,
telefono VARCHAR NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Director
(
idDirector INT NOT NULL,
nombre VARCHAR NOT NULL,
apellido VARCHAR NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Empleado
(
idEmpleado INT NOT NULL,
idSucursal INT NOT NULL,
idPuesto INT NOT NULL,
apellido VARCHAR NOT NULL,
direccion VARCHAR NOT NULL,
rfc VARCHAR NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Pelicula
(
idPelicula INT NOT NULL,
idDirector INT NOT NULL,
idProductor INT NOT NULL,
titulo VARCHAR NOT NULL,
ano VARCHAR NOT NULL,
duracion VARCHAR NOT NULL,
genero VARCHAR NOT NULL,
clasificacion VARCHAR NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Productor 
(
idProductor INT NOT NULL,
nombre VARCHAR NOT NULL,
apellido VARCHAR NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Puesto
(
idPuesto INT NOT NULL,
nombre VARCHAR NOT NULL,
descripcion VARCHAR NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Sala
(
idSala INT NOT NULL,
idSucursal INT NOT NULL,
idPelicula INT NOT NULL,
aforo VARCHAR NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Sucursal
(
idSucursal INT NOT NULL,
nombre VARCHAR NOT NULL,
direccion VARCHAR NOT NULL,
propietario VARCHAR NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE ActorPelicula
(
idActorPelicula INT NOT NULL,
idActor INT NOT NULL,
idPelicula INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO

--Llaves Primarias
ALTER TABLE Actor ADD CONSTRAINT PK_Actor PRIMARY KEY(idActor)
ALTER TABLE Boleto ADD CONSTRAINT PK_Boleto PRIMARY KEY(idBoleto)
ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY(idCliente)
ALTER TABLE Director ADD CONSTRAINT PK_Director PRIMARY KEY(idDirector)
ALTER TABLE Empleado ADD CONSTRAINT PK_Empleado PRIMARY KEY(idEmpleado)
ALTER TABLE Pelicula ADD CONSTRAINT PK_Pelicula PRIMARY KEY(idPelicula)
ALTER TABLE Productor ADD CONSTRAINT PK_Productor PRIMARY KEY(idProductor)
ALTER TABLE Puesto ADD CONSTRAINT PK_Puesto PRIMARY KEY(idPuesto)
ALTER TABLE Sala ADD CONSTRAINT PK_Sala PRIMARY KEY(idSala)
ALTER TABLE Sucursal ADD CONSTRAINT PK_Sucursal PRIMARY KEY(idSucursal)
ALTER TABLE ActorPelicula ADD CONSTRAINT PK_ActorPelicula PRIMARY KEY(idActorPelicula)

--LlavesForaneas
--Boleto
ALTER TABLE Boleto ADD CONSTRAINT FK_BoletoEmpleado FOREIGN KEY(idEmpleado) REFERENCES Empleado(idEmpleado)
ALTER TABLE Boleto ADD CONSTRAINT FK_BoletoCliente FOREIGN KEY(idCliente) REFERENCES Cliente(idCliente)
ALTER TABLE Boleto ADD CONSTRAINT FK_BoletoPelicula FOREIGN KEY(idPelicula) REFERENCES Pelicula(idPelicula)
--Empleado
ALTER TABLE Empleado ADD CONSTRAINT FK_EmpleadoSucursal FOREIGN KEY(idSucursal) REFERENCES Sucursal(idSucursal)
ALTER TABLE Empleado ADD CONSTRAINT FK_EmpleadoPuesto FOREIGN KEY(idPuesto) REFERENCES Puesto(idPuesto)
--Peliculas
ALTER TABLE Pelicula ADD CONSTRAINT FK_PeliculaDirector FOREIGN KEY(idDirector) REFERENCES Director(idDirector)
ALTER TABLE Pelicula ADD CONSTRAINT FK_PeliculaProductor FOREIGN KEY(idProductor) REFERENCES Productor(idProductor)
--Sala
ALTER TABLE Sala ADD CONSTRAINT FK_SalaPelicula FOREIGN KEY(idPelicula) REFERENCES Pelicula(idPelicula)
ALTER TABLE Sala ADD CONSTRAINT FK_SalaSucursal FOREIGN KEY(idSucursal) REFERENCES Sucursal(idSucursal)

--ActorPelicula
ALTER TABLE ActorPelicula ADD CONSTRAINT FK_ActorPeliculaActor FOREIGN KEY(idActor) REFERENCES Actor(idActor)
ALTER TABLE ActorPelicula ADD CONSTRAINT FK_ActorPeliculaPelicula FOREIGN KEY(idPelicula) REFERENCES Pelicula(idPelicula)

--Indices
CREATE INDEX TX_Actor ON Actor(idActor)
CREATE INDEX TX_Boleto ON Boleto(idBoleto)
CREATE INDEX TX_Cliente ON Cliente(idCliente)
CREATE INDEX TX_Director ON Director(idDirector)
CREATE INDEX TX_Empleado ON Empleado(idEmpleado)
CREATE INDEX TX_Pelicula ON Pelicula(idPelicula)
CREATE INDEX TX_Productor ON Productor(idProductor)
CREATE INDEX TX_Puesto ON Puesto(idPuesto)
CREATE INDEX TX_Sala ON Sala(idSala)
CREATE INDEX TX_Sucursal ON Sucursal(idSucursal)
CREATE INDEX TX_ActorPelicula ON ActorPelicula(idActorPelicula)