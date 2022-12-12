USE master;
GO
IF DB_ID (N'CtrlHozpitalizacion') IS NOT NULL
DROP DATABASE CtrlHozpitalizacion;
CREATE DATABASE CtrlHozpitalizacion
ON
( NAME = CtrlHozpitalizacion_dat,
    FILENAME = 'C:\samples\CtrlHozpitalizacion.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = CtrlHozpitalizacion_log,
    FILENAME = 'C:\samples\CtrlHozpitalizacion.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE CtrlHozpitalizacion;
GO
CREATE TABLE Diagnostico
(
idDiagnostico INT NOT NULL,
idPaciente INT NOT NULL,
idMedico INT NOT NULL,
codigoDiagnostico VARCHAR (10) NOT NULL,
descripcion VARCHAR(50) NOT NULL,
fecha DATETIME NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Cama
(
idCama INT NOT NULL,
idPlanta INT NOT NULL,
numCama INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Medico
(
idMedico INT NOT NULL,
numFichaMedica INT NOT NULL,
nombre VARCHAR (50) NOT NULL,
apellidoPaterno VARCHAR(50) NOT NULL,
apellidoMaterno VARCHAR(50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Paciente
(
idPaciente INT NOT NULL,
numSeguroSocial INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
apellidoPaterno VARCHAR(50) NOT NULL,
apellidoMaterno VARCHAR (50) NOT NULL,
fechaNacimiento DATETIME NOT NULL,
rfc VARCHAR (50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Planta
(
idPlanta INT NOT NULL,
numPlanta INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
numCama INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE TarjetaVisita
(
idTarjetaVisita INT NOT NULL,
idPaciente INT NOT NULL,
numPase INT NOT NULL,
horaInicio DATETIME NOT NULL,
horaFinal DATETIME NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE VisitaMedica
(
idVisitaMedica INT NOT NULL,
idPaciente INT NOT NULL,
idMedico INT NOT NULL,
fecha DATETIME NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE CamaPaciente
(
idCamaPaciente INT NOT NULL,
idCama INT NOT NULL,
idPaciente INT NOT NULL,
fechaAsignacion DATETIME NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);

--Llaves Primarias 
ALTER TABLE Cama ADD CONSTRAINT PK_Cama PRIMARY KEY(idCama)
ALTER TABLE Diagnostico ADD CONSTRAINT PK_Diagnostico PRIMARY KEY (idDiagnostico)
ALTER TABLE Medico ADD CONSTRAINT PK_Medico PRIMARY KEY(idMedico)
ALTER TABLE Paciente ADD CONSTRAINT PK_Paciente PRIMARY KEY(idPaciente)
ALTER TABLE Planta ADD CONSTRAINT PK_Planta PRIMARY KEY(idPlanta)
ALTER TABLE TarjetaVisita ADD CONSTRAINT PK_TarjetaVisita PRIMARY KEY(idTarjetaVisita)
ALTER TABLE VisitaMedica ADD CONSTRAINT PK_VisitaMedica PRIMARY KEY(idVisitaMedica)
ALTER TABLE CamaPaciente ADD CONSTRAINT PK_CamaPaciente PRIMARY KEY(idCamaPaciente)

--Llaves Foraneas
--Cama
ALTER TABLE Cama ADD CONSTRAINT FK_CamaPlanta FOREIGN KEY (idPlanta) REFERENCES Planta(idPlanta)
--Diagnostico
ALTER TABLE Diagnostico ADD CONSTRAINT FK_DiagnosticoPaciente FOREIGN KEY(idPaciente) REFERENCES Paciente(idPaciente)
ALTER TABLE Diagnostico ADD CONSTRAINT FK_DiagnosticoMedico FOREIGN KEY(idMedico) REFERENCES Medico(idMedico)
--TarjetaVisita
ALTER TABLE TarjetaVisita ADD CONSTRAINT FK_TarjetaVisitaPaciente FOREIGN KEY (idPaciente) REFERENCES Paciente(idPaciente)
--TarjetaMedica
ALTER TABLE VisitaMedica ADD CONSTRAINT FK_VisitaMedicaPaciente FOREIGN KEY (idPaciente) REFERENCES Paciente(idPaciente)
ALTER TABLE VisitaMedica ADD CONSTRAINT FK_VisitaMedicaMedico FOREIGN KEY (idMedico) REFERENCES Medico(idMedico)
--CamaPaciente
ALTER TABLE CamaPaciente ADD CONSTRAINT FK_CamaPacienteCama FOREIGN KEY(idCama) REFERENCES Cama(idCama)
ALTER TABLE CamaPaciente ADD CONSTRAINT FK_CamaPacientePaciente FOREIGN KEY (idPaciente) REFERENCES Paciente(idPaciente)

--Indices
CREATE INDEX TX_Cama ON Cama(idCama)
CREATE INDEX TX_Diagnostico ON Diagnostico(idDiagnostico)
CREATE INDEX TX_Medico ON Medico(idMedico)
CREATE INDEX TX_Paciente ON Paciente(idPaciente)
CREATE INDEX TX_Planta ON Planta(idPlanta)
CREATE INDEX TX_TarjetaVisita ON TarjetaVisita(idTarjetaVisita)
CREATE INDEX TX_VisitaMedica ON VisitaMedica(idVisitaMedica)
CREATE INDEX TX_CamaPaciente ON CamaPaciente(idCamaPaciente)
