-- CREATE DATABASE db_foxsavvy;
-- USE db_foxsavvy;

-- Tabla para la información de los usuarios registrados en la plataforma.
DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL,
    apellido_usuario VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    monedas INT DEFAULT 0,
    puntos INT DEFAULT 0,
    amigos INT DEFAULT 0,
    racha_dias INT DEFAULT 0
);

-- Tabla para las recompensas que los usuarios pueden obtener al completar mundos o niveles.
-- TODO: revisar logica de recompensas.
DROP TABLE IF EXISTS recompensas;
CREATE TABLE recompensas (
    id_recompensa INT AUTO_INCREMENT PRIMARY KEY,
    tipo_recompensa ENUM('monedas', 'puntos') NOT NULL
);

-- Tabla para los logros que los usuarios pueden obtener.
DROP TABLE IF EXISTS logros;
CREATE TABLE logros (
    id_logro INT AUTO_INCREMENT PRIMARY KEY,
    nombre_logro VARCHAR(100) NOT NULL,
    descripcion TEXT,
    imagen_url VARCHAR(255)
);

-- Tabla para los logros que los usuarios  han obtenido.
DROP TABLE IF EXISTS logros_usuarios;
CREATE TABLE logros_usuarios (
    id_usuario INT,
    id_logro INT,
    fecha_obtencion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_logro) REFERENCES logros(id_logro),
    PRIMARY KEY (id_usuario, id_logro)
);

-- Tabla para las relaciones de amistad entre los usuarios.
DROP TABLE IF EXISTS amigos;
CREATE TABLE amigos (
    id_solicitante INT,
    id_receptor INT,
    fecha_amistad DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_solicitante) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_receptor) REFERENCES usuarios(id_usuario),
    PRIMARY KEY (id_solicitante, id_receptor),
    CONSTRAINT check_amigo_id CHECK (id_solicitante <> id_receptor)
);

-- Tabla para los ítems que los usuarios pueden comprar con sus monedas.
DROP TABLE IF EXISTS tienda;
CREATE TABLE tienda (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    nombre_item VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio_monedas INT NOT NULL,
    tipo_item ENUM('minijuego', 'buff', 'decoracion') NOT NULL
);

-- Tabla para las compras realizadas por los usuarios en la tienda.
DROP TABLE IF EXISTS compras;
CREATE TABLE compras (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_item INT,
    fecha_compra DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_item) REFERENCES tienda(id_item)
);

-- Tabla para el tiempo de sesión de los usuarios.
DROP TABLE IF EXISTS sesiones;
CREATE TABLE sesiones (
    id_usuario INT,
    fecha DATE NOT NULL,
    tiempo_login TIME NOT NULL,
    tiempo_total FLOAT DEFAULT 0, -- Tiempo en horas
    PRIMARY KEY (id_usuario, fecha),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla para el progreso de los mundos del usuario.
DROP TABLE IF EXISTS mundos;
CREATE TABLE mundos (
    id_mundo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_mundo TEXT NOT NULL
);

-- Tabla para el progreso de los niveles del usuario.
DROP TABLE IF EXISTS niveles;
CREATE TABLE niveles (
    id_nivel INT AUTO_INCREMENT PRIMARY KEY,
    id_mundo INT,
    FOREIGN KEY (id_mundo) REFERENCES mundos(id_mundo)
);

-- Tabla intermedia para mundos y recompensas.
DROP TABLE IF EXISTS mundos_recompensas;
CREATE TABLE mundos_recompensas (
    id_mundo INT,
    id_recompensa INT,
    cantidad INT,
    FOREIGN KEY (id_mundo) REFERENCES mundos(id_mundo),
    FOREIGN KEY (id_recompensa) REFERENCES recompensas(id_recompensa),
    PRIMARY KEY (id_mundo, id_recompensa)
);

-- Tabla intermedia para niveles y recompensas.
DROP TABLE IF EXISTS niveles_recompensas;
CREATE TABLE niveles_recompensas (
    id_nivel INT,
    id_recompensa INT,
    cantidad INT,
    FOREIGN KEY (id_nivel) REFERENCES niveles(id_nivel),
    FOREIGN KEY (id_recompensa) REFERENCES recompensas(id_recompensa),
    PRIMARY KEY (id_nivel, id_recompensa)
);

-- Tabla intermedia para usuarios y mundos.
DROP TABLE IF EXISTS mundos_usuarios;
CREATE TABLE mundos_usuarios (
    id_mundo INT,
    id_usuario INT,
    mundo_completado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_mundo) REFERENCES mundos(id_mundo),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    PRIMARY KEY (id_mundo, id_usuario)
);

-- Tabla intermedia para usuarios y niveles.
DROP TABLE IF EXISTS niveles_usuarios;
CREATE TABLE niveles_usuarios (
    id_nivel INT,
    id_usuario INT,
    nivel_completado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_nivel) REFERENCES niveles(id_nivel),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    PRIMARY KEY (id_nivel, id_usuario)
);