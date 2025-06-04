CREATE TABLE persona(
    num_doc VARCHAR(10),
    tipo_doc VARCHAR(10),
    nombre VARCHAR(15),
    apellido VARCHAR(15),
    fecha_nac DATE,
    telefono VARCHAR(15),
    correo VARCHAR(25),
    PRIMARY KEY(num_doc, tipo_doc)
);

CREATE TABLE estudiante(
    legajo INT(5),
    num_doc VARCHAR(10),
    tipo_doc VARCHAR(10),
    PRIMARY KEY(num_doc, tipo_doc),
    FOREIGN KEY(num_doc, tipo_doc) REFERENCES persona(num_doc, tipo_doc)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE docente(
    titulo VARCHAR(20),
    num_doc VARCHAR(10),
    tipo_doc VARCHAR(10),
    PRIMARY KEY(num_doc, tipo_doc),
    FOREIGN KEY(num_doc, tipo_doc) REFERENCES persona(num_doc, tipo_doc)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

CREATE TABLE tema(
    nombre_tema VARCHAR(20),
    contenido VARCHAR(50),
    PRIMARY KEY(nombre_tema)
);

CREATE TABLE aula(
    id_aula INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(20),
    cant_asientos INT
);

CREATE TABLE asiento(
    id_aula INT,
    numero_asiento INT,
    fila INT,
    PRIMARY KEY(id_aula, numero_asiento),
    FOREIGN KEY(id_aula) REFERENCES aula(id_aula)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE curso(
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE,
    hora TIME,
    id_aula INT,
    num_doc VARCHAR(10),
    tipo_doc VARCHAR(10),
    FOREIGN KEY(num_doc, tipo_doc) REFERENCES docente(num_doc, tipo_doc)
        ON UPDATE CASCADE 
        ON DELETE SET NULL,
    FOREIGN KEY(id_aula) REFERENCES aula(id_aula)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

CREATE TABLE tiene(
    tipo_tema VARCHAR(20),
    cantidad_preferencias INT,
    id_curso INT,
    nombre_tema VARCHAR(20),
    PRIMARY KEY(id_curso, nombre_tema),
    FOREIGN KEY(id_curso) REFERENCES curso(id_curso)
        ON UPDATE RESTRICT
        ON DELETE CASCADE ,
    FOREIGN KEY(nombre_tema) REFERENCES tema(nombre_tema)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

CREATE TABLE preferencia(
    motivo TEXT,
    nombre_tema VARCHAR(20),
    num_doc VARCHAR(10),
    tipo_doc VARCHAR(10),
    PRIMARY KEY (nombre_tema, num_doc, tipo_doc),
    FOREIGN KEY (num_doc, tipo_doc) REFERENCES estudiante(num_doc, tipo_doc)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (nombre_tema) REFERENCES tema(nombre_tema)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

CREATE TABLE inscripcion(
    num_doc VARCHAR(10),
    tipo_doc VARCHAR(10),
    id_curso INT,
    id_aula INT,
    numero_asiento INT,
    numero_inscripcion INT,
    fecha DATE,
    calificacion VARCHAR(50),
    PRIMARY KEY (num_doc, tipo_doc, id_curso, id_aula, numero_asiento, numero_inscripcion),
    FOREIGN KEY (num_doc, tipo_doc) REFERENCES estudiante(num_doc, tipo_doc)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
    FOREIGN KEY (id_aula, numero_asiento) REFERENCES asiento(id_aula, numero_asiento)
        ON UPDATE RESTRICT 
        ON DELETE RESTRICT
);

--inserts

-- 1. PERSONA
INSERT INTO persona (num_doc, tipo_doc, nombre, apellido, fecha_nac, telefono, correo) VALUES
('55555555', 'DNI', 'Julieta', 'Fernández', '2001-04-12', '2995000001', 'julieta@email.com'),
('66666666', 'DNI', 'Tomás', 'Villalba', '1999-10-22', '2995000002', 'tomas@email.com'),
('77777777', 'DNI', 'Martina', 'Ríos', '2003-07-30', '2995000003', 'martina@email.com'),
('88888888', 'DNI', 'Mateo', 'Silva', '2000-12-08', '2995000004', 'mateo@email.com');

-- 2. ESTUDIANTE
INSERT INTO estudiante (legajo, num_doc, tipo_doc) VALUES
(2001, '77777777', 'DNI'),
(2002, '88888888', 'DNI');

-- 3. DOCENTE
INSERT INTO docente (titulo, num_doc, tipo_doc) VALUES
('Tec. en Informática', '55555555', 'DNI'),
('Lic. en Ciencias de Datos', '66666666', 'DNI');

-- 4. TEMA
INSERT INTO tema (nombre_tema, contenido) VALUES
('Redes', 'Protocolos, capas OSI y modelos de comunicación'),
('Ingeniería de Software', 'Metodologías ágiles y documentación');

-- 5. AULA
INSERT INTO aula (tipo, cant_asientos) VALUES
('Auditorio', 40),
('Sala multimedia', 20);

-- 6.
INSERT INTO asiento (id_aula, numero_asiento, fila) VALUES
(3, 1, 1),
(3, 2, 1),
(4, 1, 1),
(4, 2, 1);

-- 7. CURSO
INSERT INTO curso (fecha, hora, id_aula, num_doc, tipo_doc) VALUES
('2024-07-01', '09:00:00', 3, '55555555', 'DNI'),
('2024-07-02', '11:00:00', 4, '66666666', 'DNI');

-- 8. TIENE
INSERT INTO tiene (tipo_tema, cantidad_preferencias, id_curso, nombre_tema) VALUES
('principal', 6, 103, 'Redes'),
('principal', 10, 104, 'Ingeniería de Software');

-- 9. PREFERENCIA
INSERT INTO preferencia (motivo, nombre_tema, num_doc, tipo_doc) VALUES
('Me interesa la configuración de redes locales', 'Redes', '77777777', 'DNI'),
('Quiero trabajar en desarrollo de proyectos', 'Ingeniería de Software', '88888888', 'DNI');

-- 10. INSCRIPCION
INSERT INTO inscripcion (num_doc, tipo_doc, id_curso, id_aula, numero_asiento, numero_inscripcion, fecha, calificacion) VALUES
('77777777', 'DNI', 103, 3, 1, 3, '2024-06-01', 'APROBADO'),
('88888888', 'DNI', 104, 4, 1, 4, '2024-06-02', 'DESAPROBADO');

--deletes

--DELETE CASCADE
DELETE FROM estudiante
WHERE num_doc = '77777777' AND tipo_doc = 'DNI';

--DELETE RESTRICT
DELETE FROM curso WHERE id_curso = 104;