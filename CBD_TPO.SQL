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

-- 1. PERSONA
INSERT INTO persona (num_doc, tipo_doc, nombre, apellido, fecha_nac, telefono, correo) VALUES
('12345678', 'DNI', 'Ana', 'González', '2000-05-10', '2994000001', 'ana@email.com'),
('23456789', 'DNI', 'Luis', 'Pérez', '1998-08-25', '2994000002', 'luis@email.com');

-- 2. DOCENTE
INSERT INTO docente (num_doc, tipo_doc, titulo) VALUES
('12345678', 'DNI', 'Lic. en Informática'),
('23456789', 'DNI', 'Ing. en Sistemas');

-- 3. AULA
INSERT INTO aula (id_aula, tipo, cant_asientos) VALUES
(1, 'Aula tradicional', 30),
(2, 'Laboratorio', 25);

-- 4. ASIENTO
INSERT INTO asiento (id_aula, numero_asiento, fila) VALUES
(1, 1, 1),
(1, 2, 1),
(2, 1, 1),
(2, 2, 1);

-- 5. ESTUDIANTE
INSERT INTO estudiante (num_doc, tipo_doc,legajo) VALUES
('87654321', 'DNI',1001),
('98765432', 'DNI',1002);

-- 6. (Estudiantes deben existir en PERSONA también)
INSERT INTO persona (num_doc, tipo_doc, nombre, apellido, fecha_nac, telefono, correo) VALUES
('87654321', 'DNI', 'Carlos', 'Ruiz', '2002-03-15', '2994000003', 'carlos@email.com'),
('98765432', 'DNI', 'Sofía', 'Martínez', '2001-11-30', '2994000004', 'sofia@email.com');

-- 7. TEMA
INSERT INTO tema (nombre_tema, contenido) VALUES
('Base de Datos', 'Conceptos de modelo relacional y SQL'),
('Programación', 'Introducción a la lógica y estructuras de control');

-- 8. CURSO
INSERT INTO curso (id_curso, fecha, hora, id_aula, num_doc, tipo_doc) VALUES
(101, '2024-06-10', '14:00:00', 1, '12345678', 'DNI'),
(102, '2024-06-11', '16:00:00', 2, '23456789', 'DNI');

-- 9. TIENE
INSERT INTO tiene (id_curso, nombre_tema, tipo_tema, cantidad_preferencias) VALUES
(101, 'Base de Datos', 'principal', 15),
(102, 'Programación', 'principal', 12);

-- 10. PREFERENCIA
INSERT INTO preferencia (legajo, nombre_tema, motivo) VALUES
(1001, 'Base de Datos', 'Me interesa aprender SQL'),
(1002, 'Programación', 'Me gusta desarrollar programas');

-- 11. INSCRIPCION
INSERT INTO inscripcion (numero_inscripcion, legajo, id_curso, id_aula, numero_asiento, fecha, calificacion) VALUES
(1, 1001, 101, 1, 1, '2024-05-01', 'APROBADO'),
(2, 1002, 102, 2, 1, '2024-05-02', 'AUSENTE');



-- Este DELETE elimina a Carlos Ruiz (persona y estudiante)
DELETE FROM persona
WHERE num_doc = '87654321' AND tipo_doc = 'DNI';


-- Este DELETE va a FALLAR porque el docente está usando RESTRICT // no falla revisar
DELETE FROM persona
WHERE num_doc = '12345678' AND tipo_doc = 'DNI';
