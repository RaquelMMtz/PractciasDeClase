USE master;
GO
IF DB_ID (N'Bancos') IS NOT NULL
DROP DATABASE Bancos;
CREATE DATABASE Bancos
ON
( NAME = Bancos_dat,
    FILENAME = 'C:\samples\Bancos.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = Bancos_log,
    FILENAME = 'C:\samples\Bancos.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE Bancos;
GO
CREATE TABLE Cliente
(
idCliente INT NOT NULL,
nombre VARCHAR (50) NOT NULL,
apellidoPaterno VARCHAR(50) NOT NULL,
apellidoMaterno VARCHAR (50) NOT NULL,
direccion VARCHAR(50) NOT NULL,
curp VARCHAR (50) NOT NULL,
rfc VARCHAR (50) NOT NULL,
telefono INT NOT NULL,
correo VARCHAR NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Cuenta
(
idCuenta INT NOT NULL,
idSucursal INT NOT NULL,
numCuenta INT NOT NULL,
saldo INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Domiciliacion
(
idDomiciliacion INT NOT NULL,
concepto VARCHAR(50) NOT NULL,
fecha DATETIME NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Prestamo
(
idPrestamo INT NOT NULL,
idCliente INT NOT NULL,
numFolio VARCHAR(50) NOT NULL,
monto INT NOT NULL,
fecha DATETIME NOT NULL,
plazo DATETIME NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Sucursal
(
idSucursal INT NOT NULL,
nombre VARCHAR (50) NOT NULL,
direccion VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE CuentaDomiciliacion
(
idCuentaDomiciliacion INT NOT NULL,
idCuenta INT NOT NULL,
idDomiciliacion INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE ClienteCuenta
(
idClienteCuenta INT NOT NULL,
idCliente INT NOT NULL,
idCuenta INT NOT NULL,
privilegio VARCHAR (50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
--LlavesPrimarias
ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY(idCliente)
ALTER TABLE Cuenta ADD CONSTRAINT PK_Cuenta PRIMARY KEY(idCuenta)
ALTER TABLE Domiciliacion ADD CONSTRAINT PK_Domiciliacion PRIMARY KEY(idDomiciliacion)
ALTER TABLE Prestamo ADD CONSTRAINT PK_Prestamo PRIMARY KEY(idPrestamo)
ALTER TABLE Sucursal ADD CONSTRAINT PK_Sucursal PRIMARY KEY(idSucursal)
ALTER TABLE CuentaDomiciliacion ADD CONSTRAINT PK_CuentaDomiciliacion PRIMARY KEY(idCuentaDomiciliacion)
ALTER TABLE ClienteCuenta ADD CONSTRAINT PK_ClienteCuenta PRIMARY KEY(idClienteCuenta)

--LlavesForaneas
--Cuenta
ALTER TABLE Cuenta ADD CONSTRAINT FK_CuentaSucursal FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal)
--Prestamo
ALTER TABLE Prestamo ADD CONSTRAINT FK_PrestamoCliente FOREIGN KEY(idCliente) REFERENCES Cliente(idCliente)
--CuentaDomiciliacion
ALTER TABLE CuentaDomiciliacion ADD CONSTRAINT FK_CuentaDomiciliacionCuenta FOREIGN KEY(idCuenta) REFERENCES Cuenta(idCuenta)
ALTER TABLE CuentaDomiciliacion ADD CONSTRAINT FK_CuentaDomiciiacionDomiciliacion FOREIGN KEY(idDomiciliacion)  REFERENCES Domiciliacion(idDomiciliacion)
--ClienteCuenta
ALTER TABLE ClienteCuenta ADD CONSTRAINT FK_ClienteCuentaCuenta FOREIGN KEY(idCuenta) REFERENCES Cuenta(idCuenta)
ALTER TABLE ClienteCuenta ADD CONSTRAINT FK_ClienteCuentaCliente FOREIGN KEY(idCliente) REFERENCES Cliente(idCliente)

--Indices
CREATE INDEX TX_Cliente ON Cliente(idCliente)
CREATE INDEX TX_Cuenta ON Cuenta(idCuenta)
CREATE INDEX TX_Domiciliacion ON Domiciliacion(idDomiciliacion)
CREATE INDEX TX_Prestamo ON Prestamo(idPrestamo)
CREATE INDEX TX_Sucursal ON Sucursal(idSucursal)
CREATE INDEX TX_CuentaDomiciliacion ON CuentaDomiciliacion(idCuentaDomiciliacion)
CREATE INDEX TX_ClienteCuenta ON ClienteCuenta(idClienteCuenta)