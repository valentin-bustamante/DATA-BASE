CREATE TABLE persona(
    num_doc VARCHAR(10),
    tipo_doc VARCHAR(10),
    nombre VARCHAR(15),
    apellido VARCHAR(15),
    fecha_nac DATE,
    telefono VARCHAR(15),
    correo VARCHAR(25),
    PRIMARY KEY(num_doc, tipo_doc),
);

CREATE TABLE estudiante(
    legajo INT(5),
    num_doc VARCHAR(10),
    tipo_doc VARCHAR(10),
    PRIMARY KEY(num_doc, tipo_doc),
    FOREIGN KEY(num_doc, tipo_doc) REFERENCES persona(num_doc, tipo_doc),
    ON UPDATE CASCADE,
    ON DELETE CASCADE,
);

CREATE TABLE docente(
    titulo VARCHAR(20);
    num_doc VARCHAR(10),
    tipo_doc VARCHAR(10),
    PRIMARY KEY(num_doc, tipo_doc),
    FOREIGN KEY(num_doc, tipo_doc) REFERENCES persona(num_doc, tipo_doc),
    ON UPDATE CASCADE,
    ON DELETE RESTRICT
);

CREATE TABLE tema(
    nombre_tema VARCHAR(20),
    contenido VARCHAR(50),
    PRIMARY KEY(nombre_tema),
);

CREATE TABLE aula(
    id_aula INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(20),
    cant_asientos INT,
);

CREATE TABLE asiento(
    id_aula INT,
    numero_asiento INT,
    fila INT,
    PRIMARY KEY(id_aula, numero_asiento),
    FOREIGN KEY(id_aula) REFERENCES aula(id_aula),
    ON UPDATE CASCADE, 
    ON DELETE CASCADE
);

CREATE TABLE curso(
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE,
    hora TIME, 
    id_aula INT,
    num_doc VARCHAR(10),
    tipo_doc VARCHAR(10),
    FOREIGN KEY(num_doc, tipo_doc) REFERENCES docente(num_doc, tipo_doc),
        ON UPDATE CASCADE 
        ON DELETE SET NULL
    FOREIGN KEY(id_aula) REFERENCES aula(id_aula),
        ON UPDATE RESTRICT, 
        ON DELETE RESTRICT
);

CREATE TABLE tiene(
    tipo_tema VARCHAR(20),
    cantidad_preferencias INT,
    id_curso INT,
    nombre_tema VARCHAR(20),
    PRIMARY KEY(id_curso, nombre_tema),
    FOREIGN KEY(id_curso) REFERENCES curso(id_curso),
        ON UPDATE RESTRICT,
        ON DELETE CASCADE 
    FOREIGN KEY(nombre_tema) REFERENCES tema(nombre_tema),
        ON UPDATE RESTRICT,
        ON DELETE RESTRICT
);

CREATE TABLE preferencia(
    motivo TEXT,
    nombre_tema VARCHAR(20),
    num_doc VARCHAR(10),
    tipo_doc VARCHAR(10),
    PRIMARY KEY (nombre_tema, num_doc, tipo_doc),
    FOREIGN KEY (num_doc, tipo_doc) REFERENCES estudiante(num_doc, tipo_doc),
        ON UPDATE CASCADE, 
        ON DELETE CASCADE
    FOREIGN KEY (nombre_tema) REFERENCES tema(nombre_tema),
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
    FOREIGN KEY (num_doc, tipo_doc) REFERENCES estudiante(num_doc, tipo_doc),
        ON UPDATE CASCADE, 
        ON DELETE CASCADE
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
    FOREIGN KEY (id_aula, numero_asiento) REFERENCES asiento(id_aula, numero_asiento),
        ON UPDATE RESTRICT 
        ON DELETE RESTRICT
);

