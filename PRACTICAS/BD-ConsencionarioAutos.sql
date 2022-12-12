USE master;
GO
IF DB_ID (N'ConcesAutomoviles') IS NOT NULL
DROP DATABASE ConcesAutomoviles;
CREATE DATABASE ConcesAutomoviles
ON
( NAME = ConcesAutomoviles_dat,
    FILENAME = 'C:\samples\ConcesAutomoviles.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = ConcesAutomoviles_log,
    FILENAME = 'C:\samples\ConcesAutomoviles.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE ConcesAutomoviles;
GO
CREATE TABLE Cliente
(
idCliente INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
apellidoPaterno VARCHAR(50) NOT NULL,
apellidoMaterno VARCHAR(50) NOT NULL,
direccion VARCHAR(50) NOT NULL,
telefono INT NOT NULL,
rfc VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Opcion
(
idOpcion INT NOT NULL,
nombre VARCHAR (50) NOT NULL,
descripcion VARCHAR (50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Usado
(
idUsado INT NOT NULL,
idCliente INT NOT NULL,
marca VARCHAR(50) NOT NULL,
modelo VARCHAR(50)NOT NULL,
matricula VARCHAR (50),
precio INT NOT NULL,
fecha DATETIME NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Vehiculo
(
idVehiculo INT NOT NULL,
marca VARCHAR (50) NOT NULL,
modelo VARCHAR (50) NOT NULL,
cilindro INT NOT NULL,
precio INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Vendedor
(
idVendedor INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
apellidoPaterno VARCHAR(50)NOT NULL,
apellidoMaterno VARCHAR(50) NOT NULL,
rfc VARCHAR(50) NOT NULL,
direccion VARCHAR (50) NOT NULL,
telefono INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Venta
(
idVenta INT NOT NULL,
idCliente INT NOT NULL,
idVendedor INT NOT NULL,
idOpcion INT NOT NULL,
fecha DATETIME NOT NULL,
matricula VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE VehiculoOpcion
(
idVehiculoOpcion INT NOT NULL,
idVehiculo INT NOT NULL,
idOpcion INT NOT NULL,
precio VARCHAR (50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE VentaOpcion
(
idVentaOpcion INT NOT NULL,
idVenta INT NOT NULL,
idOpcion INT NOT NULL,
precio VARCHAR (50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO

--LlavesPrimarias
ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY(idCliente)
ALTER TABLE Opcion ADD CONSTRAINT PK_Opcion PRIMARY KEY(idOpcion)
ALTER TABLE Usado ADD CONSTRAINT PK_Usado PRIMARY KEY(idUsado)
ALTER TABLE Vehiculo ADD CONSTRAINT PK_Vehiculo PRIMARY KEY(idVehiculo)
ALTER TABLE Vendedor ADD CONSTRAINT PK_Vendedor PRIMARY KEY(idVendedor)
ALTER TABLE Venta ADD CONSTRAINT PK_Venta PRIMARY KEY(idVenta)
ALTER TABLE VehiculoOpcion ADD CONSTRAINT PK_VehiculoOpcion PRIMARY KEY(idVehiculoOpcion)
ALTER TABLE VentaOpcion ADD CONSTRAINT PK_VentaOpcion PRIMARY KEY(idVentaOpcion)

--LlavesForaneas
--Usado
ALTER TABLE Usado ADD CONSTRAINT FK_UsadoCliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
--Venta
ALTER TABLE Venta ADD CONSTRAINT FK_VentaCliente FOREIGN KEY(idCliente) REFERENCES Cliente(idCliente)
ALTER TABLE Venta ADD CONSTRAINT FK_VentaVendedor FOREIGN KEY(idVendedor) REFERENCES Vendedor(idVendedor)
ALTER TABLE Venta ADD CONSTRAINT FK_VentaOpcion FOREIGN KEY(idOpcion) REFERENCES Opcion(idOpcion)
--VehiculoOpcion
ALTER TABLE VehiculoOpcion ADD CONSTRAINT FK_VehiculoOpcionVehiculo FOREIGN KEY(idVehiculo) REFERENCES Vehiculo(idVehiculo)
ALTER TABLE VehiculoOpcion ADD CONSTRAINT FK_VehiculoOpcionOpcion FOREIGN KEY(idOpcion) REFERENCES Opcion(idOpcion)
--VentaOpcion
ALTER TABLE VentaOpcion ADD CONSTRAINT FK_VentaOpcionVenta FOREIGN KEY(idVenta) REFERENCES Venta(idVenta)
ALTER TABLE VentaOpcion ADD CONSTRAINT FK_VentaOpcionOpcion FOREIGN KEY(idOpcion) REFERENCES Opcion(idOpcion)

--Indices
CREATE INDEX TX_Cliente ON Cliente(idCliente)
CREATE INDEX TX_Opcion ON Opcion(idOpcion)
CREATE INDEX TX_Usado ON Usado(idUsado)
CREATE INDEX TX_Vehiculo ON Vehiculo(idVehiculo)
CREATE INDEX TX_Vendedor ON Vendedor(idVendedor)
CREATE INDEX TX_Venta ON Venta(idVenta)
CREATE INDEX TX_VehiculoOpcion ON VehiculoOpcion(idVehiculoOpcion)
CREATE INDEX TX_VentaOpcion ON VentaOpcion(idVentaOpcion)
