USE master;
GO
IF DB_ID (N'GestionExamenes') IS NOT NULL
DROP DATABASE GestionExamenes;
CREATE DATABASE GestionExamenes
ON
( NAME = AgenciasViajes_dat,
    FILENAME = 'C:\samples\GestionExamenes.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = AgenciasViajes_log,
    FILENAME = 'C:\samples\GestionExamenes.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE GestionExamenes;
GO
CREATE TABLE Alumno
(
idAlumno INT NOT NULL,
matricula INT NOT NULL,
nombre VARCHAR (10) NOT NULL,
apellidoPaterno VARCHAR(50) NOT NULL,
apellidoMaterno VARCHAR(50) NOT NULL,
grupo INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Examen
(
idExamen INT NOT NULL,
fechaRealizacion DATETIME NOT NULL,
numeroPreguntas INT NOT NULL,
numeroExamen INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Practica
(
idPractica INT NOT NULL,
codigo VARCHAR(10) NOT NULL,
titulo VARCHAR(10) NOT NULL,
gradoDificultad INT NOT NULL,
tipo INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Profesor
(
idProfesor INT NOT NULL,
nombre VARCHAR (10) NOT NULL,
apellidoPaterno VARCHAR(50) NOT NULL,
apellidoMaterno VARCHAR(50) NOT NULL,
matricula INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE AlumnoExamen
(
idAlumnoExamen INT NOT NULL,
idAlumnoPractica INT NOT NULL,
idAlumno INT NOT NULL,
idExamen INT NOT NULL,
nota INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE AlumnoPractica
(
idAlumnoPractica INT NOT NULL,
idAlumno INT NOT NULL,
idPractica INT NOT NULL,
nota INT NOT NULL,
fecha DATETIME NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE PracticaProfesor
(
idPracticaProfesor INT NOT NULL,
idPractica INT NOT NULL,
idProfesor INT NOT NULL,
fecha DATETIME NOT NULL,
diseno INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO

--Llaves Primarias
ALTER TABLE Alumno ADD CONSTRAINT PK_Alumno PRIMARY KEY(idAlumno)
ALTER TABLE Examen ADD CONSTRAINT PK_Examen PRIMARY KEY(idExamen)
ALTER TABLE Practica ADD CONSTRAINT PK_Practica PRIMARY KEY(idPractica)
ALTER TABLE Profesor ADD CONSTRAINT PK_Profesor PRIMARY KEY(idProfesor)
ALTER TABLE AlumnoExamen ADD CONSTRAINT PK_AlumnoExamen PRIMARY KEY (idAlumnoExamen)
ALTER TABLE AlumnoPractica ADD CONSTRAINT PK_AlumnoPractica PRIMARY KEY(idAlumnoPractica)
ALTER TABLE PracticaProfesor ADD CONSTRAINT PK_PracticaProfesor PRIMARY KEY(idPracticaProfesor)

--Llaves Foraneas
--AlumnoExamen
ALTER TABLE AlumnoExamen ADD CONSTRAINT FK_AlumnoExamenAlumno FOREIGN KEY(idAlumno) REFERENCES Alumno(idAlumno)
ALTER TABLE AlumnoExamen ADD CONSTRAINT FK_AlumnoExamenExamen FOREIGN KEY(idExamen) REFERENCES Examen(idExamen)
--AlumnosPractica
ALTER TABLE AlumnoPractica ADD CONSTRAINT FK_AlumnoPracticaAlumno FOREIGN KEY(idAlumno) REFERENCES Alumno(idAlumno)
ALTER TABLE AlumnoPractica ADD CONSTRAINT FK_AlumnoPracticaPractica FOREIGN KEY(idPractica) REFERENCES Practica(idPractica)
--PracticaProfesor
ALTER TABLE PracticaProfesor ADD CONSTRAINT FK_PracticaProfesorPractica FOREIGN KEY (idPractica) REFERENCES Practica(idPractica)
ALTER TABLE PracticaProfesor ADD CONSTRAINT FK_PracticaPofresorProfesor FOREIGN KEY(idProfesor) REFERENCES Profesor(idProfesor)
--Indices
CREATE INDEX TX_Alumno ON Alumno(idAlumno)
CREATE INDEX TX_Examen ON Examen(idExamen)
CREATE INDEX TX_Practica ON Practica(idPractica)
CREATE INDEX TX_Profesor ON Profesor(idProfesor)
CREATE INDEX TX_AlumnoPractica ON AlumnoPractica(idAlumnoPractica)
CREATE INDEX TX_PracticaProfesor ON PracticaProfesor(idPracticaProfesor) 