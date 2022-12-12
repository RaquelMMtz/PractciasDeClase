USE master;
GO
IF DB_ID (N'AgenciaViajesII') IS NOT NULL
DROP DATABASE AgenciaViajesII;
CREATE DATABASE AgenciaViajesII
ON
( NAME = AgenciaViajesII_dat,
    FILENAME = 'C:\samples\AgenciaViajesII.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = AgenciaViajesII_log,
    FILENAME = 'C:\samples\AgenciaViajesII.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE AgenciaViajesII;
GO
CREATE TABLE Cliente
(
idCliente INT NOT NULL,
nombre VARCHAR (50) NOT NULL,
apellidoPaterno VARCHAR(50) NOT NULL,
apellidoMaterno VARCHAR(50) NOT NULL,
telefono INT NOT NULL,
direccion VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Hotel
(
idHotel INT NOT NULL,
idPuntoRuta INT NOT NULL,
nombre VARCHAR(50)NOT NULL,
direccion VARCHAR(50) NOT NULL,
telefono INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE PuntoRuta
(
idPuntoRuta INT NOT NULL,
idTipoRuta INT NOT NULL,
descripcion VARCHAR(50) NOT NULL,
tipoEstancia VARCHAR(10) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Tour
(
idTour INT NOT NULL,
idTipoTour INT NOT NULL,
descripcion VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE TipoTour
(
idTipoTour INT NOT NULL,
nombre VARCHAR(50)NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE TipoRuta
(
idTipoRuta INT NOT NULL,
descripcion VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE ClienteTour
(
idClienteTour INT NOT NULL,
idCliente INT NOT NULL,
idTour INT NOT NULL,
fecha DATETIME NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE ClienteHotel
(
idClienteHotel INT NOT NULL,
idCliente INT NOT NULL,
idHotel INT NOT NULL,
fechaHospedaje DATETIME NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE PuntoRutaTour
(
idPuntoRutaTour INT NOT NULL,
idPuntoRuta INT NOT NULL,
idTour INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO

--LlavesPrimarias
ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY (idCliente)
ALTER TABLE Hotel ADD CONSTRAINT PK_Hotel PRIMARY KEY(idHotel)
ALTER TABLE PuntoRuta ADD CONSTRAINT PK_PuntoRuta PRIMARY KEY(idPuntoRuta)
ALTER TABLE Tour ADD CONSTRAINT PK_Tour PRIMARY KEY(idTour)
ALTER TABLE TipoTour ADD CONSTRAINT PK_TipoTour PRIMARY KEY(idTipoTour)
ALTER TABLE TipoRuta ADD CONSTRAINT PK_TipoRuta PRIMARY KEY(idTipoRuta)
ALTER TABLE ClienteHotel ADD CONSTRAINT PK_ClienteHotel PRIMARY KEY(idClienteHotel)
ALTER TABLE PuntoRutaTour ADD CONSTRAINT PK_PuntoRutaTour PRIMARY KEY(idPuntoRutaTour)

--LlavesForaneas
--Hotel
ALTER TABLE Hotel ADD CONSTRAINT FK_HotelPuntoRuta FOREIGN KEY(idPuntoRuta) REFERENCES PuntoRuta(idPuntoRuta)
--PuntaRuta
ALTER TABLE PuntoRuta ADD CONSTRAINT FK_PuntoRutaTipoRuta FOREIGN KEY(idTipoRuta) REFERENCES TipoRuta(idTipoRuta)
--Tour
ALTER TABLE Tour ADD CONSTRAINT FK_TourTipoTour FOREIGN KEY(idTipoTour) REFERENCES TipoTour(idTipoTour)
--ClienteTour
ALTER TABLE ClienteTour ADD CONSTRAINT FK_ClienteTourCliente FOREIGN KEY(idCliente) REFERENCES Cliente(idCliente)
ALTER TABLE ClienteTour ADD CONSTRAINT FK_ClienteTourTour FOREIGN KEY(idTour) REFERENCES Tour(idTour)
--ClienteHotel
ALTER TABLE ClienteHotel ADD CONSTRAINT FK_ClienteHotelCliente FOREIGN KEY(idCliente) REFERENCES Cliente(idCliente)
ALTER TABLE ClienteHotel ADD CONSTRAINT FK_ClienteHotelHotel FOREIGN KEY(idHotel) REFERENCES Hotel(idHotel)
--PuntoRutaTour
ALTER TABLE PuntoRutaTour ADD CONSTRAINT FK_PuntoRutaTourPuntoRuta FOREIGN KEY(idPuntoRuta) REFERENCES PuntoRuta(idPuntoRuta)
ALTER TABLE PuntoRutaTour ADD CONSTRAINT FK_PuntoRutaTourTour FOREIGN KEY(idTour) REFERENCES Tour(idTour)

--Indices
CREATE INDEX TX_Cliente ON Cliente(idCliente)
CREATE INDEX TX_Hotel ON Hotel(idHotel)
CREATE INDEX TX_PuntoRuta ON PuntoRuta(idPuntoRuta)
CREATE INDEX TX_Tour ON Tour(idTour)
CREATE INDEX TX_TipoTour ON TipoTour(idTipoTour)
CREATE INDEX TX_TipoRuta ON TipoRuta(idTipoRuta)
CREATE INDEX TX_ClienteTour ON ClienteTour(idClienteTour)
CREATE INDEX TX_ClienteHotel ON ClienteHotel(idClienteHotel)
CREATE INDEX TX_PuntoRutaTour ON PuntoRutaTour(idPuntoRutaTour)
