GO
IF DB_ID (N'Carreteras') IS NOT NULL
DROP DATABASE Carreteras;
CREATE DATABASE Carreteras
ON
( NAME = Carreteras_dat,
    FILENAME = 'C:\samples\Carreteras.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = Carreteras_log,
    FILENAME = 'C:\samples\Carreteras.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE Carreteras;
GO
CREATE TABLE Carretera
(
idCarretera INT NOT NULL,
nombre VARCHAR (50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Tramo
(
idTramo INT NOT NULL,
idCarretera INT NOT NULL,
numTramos INT NOT NULL,
descripcion VARCHAR (50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Municipio
(
idMunicipio INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE MunicipioTramo
(
idMunicipioTramo INT NOT NULL,
idTramo INT NOT NULL,
idMunicipio INT NOT NULL,
kmentra INT NOT NULL,
kmsale INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO

--Llaves Primarias
ALTER TABLE Carretera ADD CONSTRAINT PK_Carretera PRIMARY KEY (idCarretera)
ALTER TABLE Tramo ADD CONSTRAINT PK_Tramo PRIMARY KEY(idTramo)
ALTER TABLE Municipio ADD CONSTRAINT PK_Municipio PRIMARY KEY(idMunicipio)
ALTER TABLE MunicipioTramo ADD CONSTRAINT PK_MunicipioTramo PRIMARY KEY (idMunicipioTramo)

--Llaves Foraneas

--MunicipioTramo
ALTER TABLE MunicipioTramo ADD CONSTRAINT FK_MunicipioTramoMunicipio FOREIGN KEY(idMunicipio) REFERENCES Municipio(idMunicipio)
ALTER TABLE MunicipioTramo ADD CONSTRAINT FK_MunicipioTramoTramo FOREIGN KEY(idTramo) REFERENCES Tramo(idTramo)

--Tramo
ALTER TABLE Tramo ADD CONSTRAINT FK_TramoCarretera FOREIGN KEY (idCarretera) REFERENCES carretera(idCarretera)
--Indicex
CREATE INDEX TX_Carretera ON Carretera(idCarretera)
CREATE INDEX TX_Tramo ON Tramo(idTramo)
CREATE INDEX TX_Municipio ON Municipio(idMunicipio)
CREATE INDEX TX_MunicipioTramo ON MunicipioTramo(idMunicipioTramo)