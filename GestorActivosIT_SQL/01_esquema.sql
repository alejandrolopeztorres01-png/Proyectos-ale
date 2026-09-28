-- =========================================================================
-- PROYECTO: Sistema de Gestión de Activos IT y Licencias
-- AUTOR: Alejandro López Torres
-- DESCRIPCIÓN: Creación del esquema relacional y restricciones de integridad.
-- =========================================================================

CREATE DATABASE SiGestActivosIT;
USE SiGestActivosIT;

-- Creo la tabla de Departamentos para normalizar la información de los empleados
CREATE TABLE Departamentos (
    id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nombre_departamento VARCHAR(50) NOT NULL UNIQUE
);

-- Tabla de Empleados con su relación (Foreign Key) al departamento
CREATE TABLE Empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    id_departamento INT,
    fecha_alta DATE DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_empleado_dpto FOREIGN KEY (id_departamento) 
        REFERENCES Departamentos(id_departamento) ON DELETE SET NULL
);

-- Tabla principal de Hardware (Equipos físicos)
CREATE TABLE Equipos_Hardware (
    num_serie VARCHAR(50) PRIMARY KEY, -- Uso el número de serie como PK ya que es único por dispositivo
    tipo_equipo VARCHAR(30) NOT NULL, -- Ej: Laptop, Monitor, Servidor
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    estado VARCHAR(20) DEFAULT 'ACTIVO',
    -- Aplico un CHECK constraint para asegurar que solo entren estados válidos
    CONSTRAINT chk_estado CHECK (estado IN ('ACTIVO', 'MANTENIMIENTO', 'BAJA'))
);

-- Tabla para gestionar las asignaciones de hardware a empleados (Relación N:M resuelta)
CREATE TABLE Asignaciones_Hardware (
    id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT NOT NULL,
    num_serie VARCHAR(50) NOT NULL,
    fecha_asignacion DATE NOT NULL,
    fecha_devolucion DATE NULL, -- Es NULL si el equipo sigue asignado
    notas TEXT,
    CONSTRAINT fk_asig_empleado FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado) ON DELETE CASCADE,
    CONSTRAINT fk_asig_equipo FOREIGN KEY (num_serie) REFERENCES Equipos_Hardware(num_serie) ON DELETE CASCADE
);