USE master;
GO
IF DB_ID (N'AgenciaAutos') IS NOT NULL
DROP DATABASE AgenciaAutos;
CREATE DATABASE AgenciaAutos
ON
( NAME = AgenciaAutos_dat,
    FILENAME = 'C:\samples\AgenciaAutos.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = AgenciaViajesII_log,
    FILENAME = 'C:\samples\AgenciaAutos.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE AgenciaAutos;
GO
CREATE TABLE Agencia
(
idAgencia INT NOT NULL,
claveAlfaNumerica INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
apellidoPaterno VARCHAR(50) NOT NULL,
apellidoMaterno VARCHAR(50) NOT NULL,
telefono INT NOT NULL,
direccion VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Cliente
(
idCliente INT NOT NULL,
claveAlfaNumerica INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
apellidoPaterno VARCHAR(50) NOT NULL,
apellidoMaterno VARCHAR(50) NOT NULL,
telefono INT NOT NULL,
direccion VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Coche
(
idCoche INT NOT NULL,
idGarage INT NOT NULL,
claveAlfaNumerica INT NOT NULL,
placa VARCHAR(10)  NOT NULL,
costo VARCHAR(10) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Garage
(
idGarage INT NOT NULL,
claveAlfaNumerica INT NOT NULL,
direccion VARCHAR(50)NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE Reserva
(
idReserva INT NOT NULL,
idAgencia INT NOT NULL,
idCliente INT NOT NULL,
claveAlfaNumerica INT NOT NULL,
fechaComienzo DATETIME NOT NULL,
fechaTermina DATETIME NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO
CREATE TABLE CocheReserva
(
idCocheReserva INT NOT NULL,
idCoche INT NOT NULL,
idReserva INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
)
GO

--LlavesPrimarias
ALTER TABLE Agencia ADD CONSTRAINT PK_Agencia PRIMARY KEY(idAgencia)
ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY(idCliente)
ALTER TABLE Coche ADD CONSTRAINT PK_Coche PRIMARY KEY(idCoche)
ALTER TABLE Garage ADD CONSTRAINT PK_Garage PRIMARY KEY(idGarage)
ALTER TABLE Reserva ADD CONSTRAINT PK_Reserva PRIMARY KEY(idReserva)
ALTER TABLE CocheReserva ADD CONSTRAINT PK_CocheReserva PRIMARY KEY(idCocheReserva)

--LlavesForaneas
--Coche
ALTER TABLE Coche ADD CONSTRAINT FK_CocheGarage FOREIGN KEY(idGarage) REFERENCES Garage(idGarage)
--Reserva
ALTER TABLE Reserva ADD CONSTRAINT FK_ReservaAgencia FOREIGN KEY(idAgencia) REFERENCES Agencia(idAgencia)
ALTER TABLE Reserva ADD CONSTRAINT FK_ReservaCliente FOREIGN KEY(idCliente) REFERENCES Cliente(idCliente)
--CocheReserva
ALTER TABLE CocheReserva ADD CONSTRAINT FK_CocheReservaCoche FOREIGN KEY(idCoche) REFERENCES Coche(idCoche)
ALTER TABLE CocheReserva ADD CONSTRAINT FK_CocheReservaReserva FOREIGN KEY(idReserva) REFERENCES Reserva(idReserva)

--Indices
CREATE INDEX TX_Agencia ON Agencia(idAgencia)
CREATE INDEX TX_Cliente ON Cliente(idCliente)
CREATE INDEX TX_Coche ON Coche(idCoche)
CREATE INDEX TX_Garage ON Garage(idGarage)
CREATE INDEX TX_Reserva ON Reserva(idReserva)
CREATE INDEX TX_CocheReserva ON CocheReserva(idCocheReserva)