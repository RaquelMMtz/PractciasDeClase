--SQL
USE master;
GO
IF DB_ID (N'ServicioMilitar') IS NOT NULL
DROP DATABASE ServicioMilitar
GO
CREATE DATABASE ServicioMilitar
ON
( NAME = ServicioMilitar_dat,
    FILENAME = 'C:\samples\ServicioMilitar.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = ServicioMilitar_log,
    FILENAME = 'C:\samples\ServicioMilitar.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE ServicioMilitar;
GO
CREATE TABLE Usuario
(
 idUsuario INT NOT NULL,
 nombre VARCHAR (50) NOT NULL,
 apellidoPaterno VARCHAR (50) NOT NULL,
 apellidoMaterno VARCHAR (50) NOT NULL,
 correo VARCHAR (50) NOT NULL,
 clave INT NOT NULL,
 estatus BIT DEFAULT 1 NOT NULL,
  idUsuarioCrea INT NOT NULL,
  fechacrea DATETIME NOT NULL,
  idUsuarioModifica int NOT NULL,
  fechaModifica int NOT NULL
);

GO
CREATE TABLE Compania
(
  idCompania INT NOT NULL,
  actividad VARCHAR (50) NOT NULL,
  estatus BIT DEFAULT 1 NOT NULL,
  numero INT NOT NULL,
  idUsuarioCrea INT NOT NULL,
  fechacrea DATETIME NOT NULL,
  idUsuarioModifica int NOT NULL,
  fechaModifica int NOT NULL
  );
  GO
  CREATE TABLE Cuartel
(
  idCuartel INT NOT NULL,
  nombre VARCHAR (20) NOT NULL,
  codigoCuartel VARCHAR (10) NOT NULL,
  direccion VARCHAR (50)NOT NULL,
  estatus BIT DEFAULT 1 NOT NULL,
  idUsuarioCrea INT NOT NULL,
  fechacrea DATETIME NOT NULL,
  idUsuarioModifica int NOT NULL,
  fechaModifica int NOT NULL
  );
  GO
  CREATE TABLE Cuerpo
  ( idCuerpo INT NOT NULL,
    denominacion VARCHAR (10) NOT NULL,
	numero int NOT NULL,
	estatus BIT DEFAULT 1 NOT NULL,
  idUsuarioCrea INT NOT NULL,
  fechacrea DATETIME NOT NULL,
  idUsuarioModifica int NOT NULL,
  fechaModifica int NOT NULL
	);
 GO
 CREATE TABLE Servicio
 (idServicio INT NOT NULL,
 codigo VARCHAR (10) NOT NULL,
 descripcion VARCHAR (10) NOT NULL,
 estatus BIT DEFAULT 1 NOT NULL,
 idUsuarioCrea INT NOT NULL,
  fechacrea DATETIME NOT NULL,
  idUsuarioModifica int NOT NULL,
  fechaModifica int NOT NULL
 );
 GO
 CREATE TABLE Soldado
 (idSoldado INT NOT NULL,
 nombre VARCHAR (50) NOT NULL,
 apellidoPaterno VARCHAR (50) NOT NULL,
 apellidoMaterno VARCHAR (50) NOT NULL,
 codigo INT NOT NULL,
 graduacion VARCHAR (50) NOT NULL,
 idCuerpo INT NOT NULL,
 idCompania INT NOT NULL,
 idCuartel INT NOT NULL,
 estatus BIT DEFAULT 1 NOT NULL,
 idUsuarioCrea INT NOT NULL,
  fechacrea DATETIME NOT NULL,
  idUsuarioModifica int NOT NULL,
  fechaModifica int NOT NULL
 );
 GO
 CREATE TABLE CompaniaCuartel
 (idCompaniaCuartel INT NOT NULL,
  idCompania INT NOT NULL,
  idCuartel INT NOT NULL,
  estatus BIT DEFAULT 1 NOT NULL,
 idUsuarioCrea INT NOT NULL,
  fechacrea DATETIME NOT NULL,
  idUsuarioModifica int NOT NULL,
  fechaModifica int NOT NULL
 );
 GO
 CREATE TABLE SoldadoServicio
 (idSoldadoServicio INT NOT NULL,
  idServicio INT NOT NULL,
  idSoldado INT NOT NULL,
  fecha DATETIME NOT NULL,
  estatus BIT DEFAULT 1 NOT NULL,
 idUsuarioCrea INT NOT NULL,
  fechacrea DATETIME NOT NULL,
  idUsuarioModifica int NOT NULL,
  fechaModifica int NOT NULL
  );
 --Llaves Primarias
 ALTER TABLE Usuario ADD CONSTRAINT PK_Usuario PRIMARY KEY (idUsuario)
  ALTER TABLE Compania ADD CONSTRAINT PK_Compania PRIMARY KEY (idCompania)
  ALTER TABLE Cuartel ADD CONSTRAINT PK_Cuartel PRIMARY KEY (idCuartel)
  ALTER TABLE Cuerpo ADD CONSTRAINT PK_Cuerpo PRIMARY KEY (idCuerpo)
  ALTER TABLE Servicio ADD CONSTRAINT PK_Servicio PRIMARY KEY (idServicio)
  ALTER TABLE Soldado ADD CONSTRAINT PK_Soldado PRIMARY KEY (idSoldado)
  ALTER TABLE CompaniaCuartel ADD CONSTRAINT PK_CompaniaCuartel PRIMARY KEY (idCompaniaCuartel)
  ALTER TABLE SoldadoServicio ADD CONSTRAINT PK_SoldadoServicio PRIMARY KEY (idSoldadoServicio)

  --Llaves Foraneas
  --SOLDADO
  ALTER TABLE Soldado ADD CONSTRAINT FK_SoldadoCompania FOREIGN KEY (idCompania) REFERENCES Compania (idCompania)
  ALTER TABLE Soldado ADD CONSTRAINT FK_SoldadoCuartel FOREIGN KEY (idCuartel) REFERENCES Cuartel (idCuartel)
  ALTER TABLE Soldado ADD CONSTRAINT FK_SoldadoCuerpo FOREIGN KEY (idCuerpo) REFERENCES Cuerpo (idCuerpo)
  --CompaniaCuartel
  ALTER TABLE CompaniaCuartel ADD CONSTRAINT FK_CompaniaCuartelCompania FOREIGN KEY (idCompania) REFERENCES Compania (idCompania)
  ALTER TABLE CompaniaCuartel ADD CONSTRAINT FK_CompaniaCuartelCuartel FOREIGN KEY (idCuartel) REFERENCES Cuartel (idCuartel)
  --SoldadoServicio
  ALTER TABLE SoldadoServicio ADD CONSTRAINT FK_SoldadoServicioSoldado FOREIGN KEY (idSoldado) REFERENCES Soldado (idSoldado)
   ALTER TABLE SoldadoServicio ADD CONSTRAINT FK_SoldadoServicioServicio FOREIGN KEY (idServicio) REFERENCES Servicio (idServicio)

  --iNDICES
  CREATE INDEX IX_Usuario ON Usuario (idUsuario)
  CREATE INDEX IX_Compania ON Compania (idCompania)
  CREATE INDEX IX_Cuartel ON Cuartel (idCuartel)
  CREATE INDEX IX_Cuerpo ON Cuerpo (idCuerpo)
  CREATE INDEX IX_Servicio ON Servicio (idServicio)
  CREATE INDEX IX_Soldado ON Soldado (idSoldado)
  CREATE INDEX IX_CompaniaCuartel ON CompaniaCuartel (idCompaniaCuartel)
  CREATE INDEX IX_SoldadoServicio ON SoldadoServicio (idSoldadoServicio)