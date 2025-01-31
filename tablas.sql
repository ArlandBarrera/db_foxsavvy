-- USE db_foxsavvy

-- TODO:
-- Los niveles tienes puntuacion, es la puntuacion un campo
-- Al terminar un nuvel se asigna la recompensa, en que taba se registran las recompensas

-- 1. Tabla usuarios
-- Esta tabla almacenar la información de los usuarios registrados en la plataforma.
DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL,
    apellido_usuario VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    racha_dias INT DEFAULT 0,
    monedas INT DEFAULT 0,
    amigos INT DEFAULT 0,
    puntaje INT DEFAULT 0
);

-- 2. Tabla temario
-- Esta tabla almacena los diferentes temas o lecciones que los usuarios pueden desbloquear.
DROP TABLE IF EXISTS temario;
CREATE TABLE temario (
    id_tema INT AUTO_INCREMENT PRIMARY KEY,
    nombre_tema VARCHAR(100) UNIQUE NOT NULL,
    descripcion TEXT,
    animacion_url VARCHAR(255),
    duracion_estimada INT, -- DuraciÃ³n en minutos
    monedas_recompensa INT DEFAULT 0
);

-- 3. Tabla progresos
-- Esta tabla registrará el progreso de cada usuario en los diferentes temas.
DROP TABLE IF EXISTS progresos;
CREATE TABLE progresos (
    id_progreso INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_tema INT,
    completado BOOLEAN DEFAULT FALSE,
    fecha_completado DATETIME,
    puntaje INT DEFAULT 0,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_tema) REFERENCES temario(id_tema)
);

-- 4. Tabla recompensas
-- Esta tabla almacena las recompensas que los usuarios pueden obtener al completar temas o mantener rachas.
-- TODO: revisar logica de recompensas.
DROP TABLE IF EXISTS recompensas;
CREATE TABLE recompensas (
    id_recompensa INT AUTO_INCREMENT PRIMARY KEY,
   
    tipo_recompensa ENUM('monedas', 'bonus_juego', 'medalla') NOT NULL,
    cantidad INT,
    fecha_obtencion DATETIME DEFAULT CURRENT_TIMESTAMP,
   
);

-- 5. Tabla logros
-- Esta tabla almacenará los logros o medallas que los usuarios pueden obtener.
DROP TABLE IF EXISTS logros;
CREATE TABLE logros (
    id_logro INT AUTO_INCREMENT PRIMARY KEY,
    nombre_logro VARCHAR(100) NOT NULL,
    descripcion TEXT,
    imagen_url VARCHAR(255)
);

-- 6. Tabla logros_usuarios
-- Esta tabla relaciona los logros con los usuarios que los han obtenido.
DROP TABLE IF EXISTS logros_usuarios;
CREATE TABLE logros_usuarios (
    id_usuario INT,
    id_logro INT,
    fecha_obtencion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_logro) REFERENCES logros(id_logro),
    PRIMARY KEY (id_usuario, id_logro)
);

-- 7. Tabla ranking
-- Esta tabla almacena el ranking de los usuarios basado en su puntaje en lecciones y juegos.
DROP TABLE IF EXISTS ranking;
CREATE TABLE ranking (
    id_ranking INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    puntaje_total INT DEFAULT 0,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- 8. Tabla amigos
-- Esta tabla manejará las relaciones de amistad entre los usuarios.
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

-- 9. Tabla tienda
-- Esta tabla almacena los ítems que los usuarios pueden comprar con sus monedas.
DROP TABLE IF EXISTS tienda;
CREATE TABLE tienda (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    nombre_item VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio_monedas INT NOT NULL,
    tipo_item ENUM('minijuego', 'buff', 'decoracion') NOT NULL
);

-- 10. Tabla compras
-- Esta tabla registra las compras realizadas por los usuarios en la tienda.
DROP TABLE IF EXISTS compras;
CREATE TABLE compras (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_item INT,
    fecha_compra DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_item) REFERENCES tienda(id_item)
);

-- 11. Tabla sesiones
-- Esta tabla registra el tiempo de sesión de los usuarios.
DROP TABLE IF EXISTS sesiones;
CREATE TABLE sesiones (
    id_sesion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    inicio_sesion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fin_sesion DATETIME,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- 12.Tabla de Mundo
-- Esta tabla almacenara el progreso de los mundos del usuario.
DROP TABLE IF EXISTS mundos;
CREATE TABLE mundos (
    id_mundo INT AUTO_INCREMENT PRIMARY KEY,
    mundo_completado BOOLEAN DEFAULT FALSE
);

-- 13. Tabla de Niveles
-- Esta tabla almacenara el progreso de los niveles del usuario.
DROP TABLE IF EXISTS niveles;
CREATE TABLE niveles (
    id_nivel INT AUTO_INCREMENT PRIMARY KEY,
    id_mundo INT,
    nivel_completado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_mundo) REFERENCES mundos(id_mundo)
);

DROP TABLE IF EXISTS mundos_recompensas;
CREATE TABLE mundos_recompensas (
    id_mundo INT,
    id_recompensa INT,
    FOREIGN KEY (id_mundo) REFERENCES mundos(id_mundo)
    FOREIGN KEY (id_recompensa) REFERENCES recompensas(id_recompensa)
    PRIMARY KEY (id_mundo, id_recompensa)
);

DROP TABLE IF EXISTS niveles_recompensas;
CREATE TABLE niveles_recompensas (
    id_nivel INT,
    id_recompensa INT,
    FOREIGN KEY (id_nivel) REFERENCES niveles(id_nivel)
    FOREIGN KEY (id_recompensa) REFERENCES recompensas(id_recompensa)
    PRIMARY KEY (id_nivel, id_recompensa)
);

DROP TABLE IF EXISTS usuario_mundo;
CREATE TABLE usuario_mundo (
    id_usuario INT,
    id_mundo INT,
    FORIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
    FOREIGN KEY (id_mundo) REFERENCES mundos(id_mundo)
    PRIMARY KEY (id_mundo, id_usuario)
);
