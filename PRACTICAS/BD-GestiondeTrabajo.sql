USE master;
GO
IF DB_ID (N'GestionTrabajoFinCarrera') IS NOT NULL
DROP DATABASE GestionTrabajoFinCarrera;
CREATE DATABASE GestionTrabajoFinCarrera
ON
( NAME = GestionTrabajoFinCarrera_dat,
    FILENAME = 'C:\samples\GestionTrabajoFinCarrera.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = GestionTrabajoFinCarrera_log,
    FILENAME = 'C:\samples\GestionTrabajoFinCarrera.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE GestionTrabajoFinCarrera;
GO
CREATE TABLE Alumno
(
idAlumno INT NOT NULL,
idGrupo INT NOT NULL,
idProfesor INT NOT NULL,
nombre VARCHAR(10) NOT NULL,
apellidoPaterno VARCHAR(10) NOT NULL,
apellidoMaterno VARCHAR (10) NOT NULL,
matricula VARCHAR(50) NOT NULL,
rfc VARCHAR(50) NOT NULL,
fechaIncorporacion DATETIME NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Grupo
(
idGrupo INT NOT NULL,
numeroGrupo INT NOT NULL,
numeroComponentes INT NOT NULL,
nombre VARCHAR (10) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Profesor
(
idProfesor INT NOT NULL,
nombre VARCHAR (10) NOT NULL,
apellidoPaterno VARCHAR(10) NOT NULL,
apellidoMaterno VARCHAR(10) NOT NULL,
direccion VARCHAR (50) NOT NULL,
rfc VARCHAR (50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Tfc
(
idTfc INT NOT NULL,
idTribunal INT NOT NULL,
idAlumno INT NOT NULL,
tema VARCHAR (50) NOT NULL,
numeroOrden INT NOT NULL,
fechaComienzo DATETIME NOT NULL,
fechaDefinido INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Tribunal
(
idTribunal INT NOT NULL,
direccion VARCHAR (50) NOT NULL,
numeroOrden INT NOT NULL,
numeroComponentes INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE AlumnoProfesor
(
idAlumnoProfesor INT NOT NULL,
idAlumno INT NOT NULL,
idProfesor INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE ProfesorTribunal
(
idProfesorTribunal INT NOT NULL,
idProfesor INT NOT NULL,
idTribunal INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
--Llaves Primarias
ALTER TABLE Alumno ADD CONSTRAINT PK_Alumno PRIMARY KEY(idAlumno)
ALTER TABLE Grupo ADD CONSTRAINT PK_Grupo PRIMARY KEY(idGrupo)
ALTER TABLE Profesor ADD CONSTRAINT PK_Profesor PRIMARY KEY(idProfesor)
ALTER TABLE Tfc ADD CONSTRAINT PK_Tfc PRIMARY KEY(idTfc)
ALTER TABLE Tribunal ADD CONSTRAINT PK_Tribunal PRIMARY KEY(idTribunal)
ALTER TABLE AlumnoProfesor ADD CONSTRAINT PK_AlumnoProfesor PRIMARY KEY(idAlumnoProfesor)
ALTER TABLE ProfesorTribunal ADD CONSTRAINT PK_ProfesorTribunal PRIMARY KEY(idProfesorTribunal)

--Llaves Foraneas
--Alumno
ALTER TABLE Alumno ADD CONSTRAINT FK_AlumnoGrupo FOREIGN KEY(idGrupo) REFERENCES Grupo(idGrupo)
ALTER TABLE Alumno ADD CONSTRAINT FK_AlumnoProfesor FOREIGN KEY(idProfesor) REFERENCES Profesor(idProfesor)

--TFC
ALTER TABLE Tfc ADD CONSTRAINT FK_TfcTribunal FOREIGN KEY(idTribunal) REFERENCES Tribunal(idTribunal)
ALTER TABLE Tfc ADD CONSTRAINT FK_TfcAlumno FOREIGN KEY (idAlumno) REFERENCES Alumno(idAlumno)

--AlumnoProfesor
ALTER TABLE AlumnoProfesor ADD CONSTRAINT FK_AlumnoProfesorAlumno FOREIGN KEY (idAlumno) REFERENCES Alumno(idAlumno)
ALTER TABLE AlumnoProfesor ADD CONSTRAINT FK_AlumnoProfesorProfesor FOREIGN KEY (idProfesor) REFERENCES Profesor(idProfesor)

--ProfesorTribunal
ALTER TABLE ProfesorTribunal ADD CONSTRAINT FK_ProfesorTribunalProfesor FOREIGN KEY(idProfesor) REFERENCES Profesor(idProfesor)
ALTER TABLE ProfesorTribunal ADD CONSTRAINT FK_ProfesorTribunalTribunal FOREIGN KEY(idTribunal) REFERENCES Tribunal(idTribunal)

--Indices
CREATE INDEX TX_Alumno ON Alumno(idAlumno)
CREATE INDEX TX_Grupo ON Grupo(idGrupo)
CREATE INDEX TX_Profesor ON Profesor(idProfesor)
CREATE INDEX TX_Tfc ON Tfc(idTfc)
CREATE INDEX TX_Tribunal ON Tribunal(idTribunal)
CREATE INDEX TX_AlumnoProfesor ON AlumnoProfesor(idAlumnoProfesor)
CREATE INDEX TX_ProfesorTribunal ON ProfesorTribunal(idProfesorTribunal)
