USE master;
GO
IF DB_ID (N'AgenciasViajes') IS NOT NULL
DROP DATABASE AgenciasViajes;
CREATE DATABASE AgenciasViajes
ON
( NAME = AgenciasViajes_dat,
    FILENAME = 'C:\samples\AgenciasViajes.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = AgenciasViajes_log,
    FILENAME = 'C:\samples\AgenciasViajes.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE AgenciasViajes;
GO
CREATE TABLE Hotel
(
idHotel INT NOT NULL,
codigo VARCHAR (10) NOT NULL,
telefono INT NOT NULL,
plazasDisponibles INT NOT NULL,
direccion VARCHAR (50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Sucursal
(
idSucursal INT NOT NULL,
codigo VARCHAR(10) NOT NULL,
direccion VARCHAR (50) NOT NULL,
telefono INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL,
);
GO
CREATE TABLE Turista
(
idTurista INT NOT NULL,
codigo VARCHAR(10) NOT NULL,
nombre VARCHAR(10) NOT NULL,
apellidoPaterno VARCHAR(10) NOT NULL,
apellidoMaterno VARCHAR(10) NOT NULL,
direccion VARCHAR(50) NOT NULL,
telefono INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Viaje
(
idViaje INT NOT NULL,
idSucursal INT NOT NULL,
idTurista INT NOT NULL,
fecha DATETIME NOT NULL,
clase VARCHAR(10) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL,
);
GO
CREATE TABLE Vuelo
(
idVuelo INT NOT NULL,
numero INT NOT NULL,
fecha DATETIME NOT NULL,
origen VARCHAR(10) NOT NULL,
destino VARCHAR(10) NOT NULL,
plazaTuristica VARCHAR(10) NOT NULL,
plazaTotal INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE ViajeVuelo
(
idViajeVuelo INT NOT NULL,
idVuelo INT NOT NULL,
idViaje INT NOT NULL,
clase VARCHAR(10) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE HotelViaje
(
idHotelViaje INT NOT NULL,
idHotel INT NOT NULL,
idViaje INT NOT NULL,
llegada VARCHAR(10) NOT NULL,
salida VARCHAR (10) NOT NULL,
regimen VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO

--Llaves primarias
ALTER TABLE Hotel ADD CONSTRAINT PK_Hotel PRIMARY KEY(idHotel)
ALTER TABLE Sucursal ADD CONSTRAINT PK_Sucursal PRIMARY KEY (idSucursal)
ALTER TABLE Turista ADD CONSTRAINT PK_Turista PRIMARY KEY(idTurista)
ALTER TABLE Viaje ADD CONSTRAINT PK_Viaje PRIMARY KEY(idViaje)
ALTER TABLE Vuelo ADD CONSTRAINT PK_Vuelo PRIMARY KEY(idVuelo)
ALTER TABLE ViajeVuelo ADD CONSTRAINT PK_ViajeVuelo PRIMARY KEY(idViajeVuelo)
ALTER TABLE HotelViaje ADD CONSTRAINT PK_HotelViaje PRIMARY KEY(idHotelViaje)

--Llaves Foraneas
--Viaje
ALTER TABLE Viaje ADD CONSTRAINT FK_ViajeSucursal FOREIGN KEY(idSucursal) REFERENCES Sucursal(idSucursal)
ALTER TABLE viaje ADD CONSTRAINT FK_ViajeTurista FOREIGN KEY (idTurista) REFERENCES Turista(idTurista)

--ViajeVuelo
ALTER TABLE ViajeVuelo ADD CONSTRAINT FK_ViajeVueloViaje FOREIGN KEY(idViaje) REFERENCES Viaje(idViaje)
ALTER TABLE ViajeVuelo ADD CONSTRAINT FK_ViajeVueloVuelo FOREIGN KEY(idVuelo) REFERENCES Vuelo(idVuelo)

--HotelViaje
ALTER TABLE HotelViaje ADD CONSTRAINT FK_HotelViajeHotel FOREIGN KEY(idHotel) REFERENCES Hotel(idHotel)
ALTER TABLE HotelViaje ADD CONSTRAINT FK_HotelViajeViaje FOREIGN KEY(idViaje) REFERENCES Viaje(idViaje)

--Indices
CREATE INDEX TX_Hotel ON HOTEL(idHotel)
CREATE INDEX TX_Sucursal ON Sucursal(idSucursal)
CREATE INDEX TX_Turista ON Turista(idTurista)
CREATE INDEX TX_Viaje ON Viaje(idViaje)
CREATE INDEX TX_Vuelo ON Vuelo(idVuelo)
CREATE INDEX TX_ViajeVuelo ON ViajeVuelo(idViajeVuelo)
CREATE INDEX TX_HotelViaje ON HotelViaje(idHotelViaje)
