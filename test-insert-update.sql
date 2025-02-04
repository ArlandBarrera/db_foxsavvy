-- USE db_foxsavvy;

SELECT * FROM usuarios;
SELECT * FROM tienda;
SELECT * FROM compras;
SELECT * FROM mundos;
SELECT * FROM niveles;
SELECT * FROM recompensas;
SELECT * FROM niveles_usuarios;
SELECT * FROM niveles_recompensas;

INSERT INTO usuarios(nombre_usuario, apellido_usuario, email, contraseña, monedas) VALUES
('Pedro', 'Kantor', 'rynn@imperium.com', 'abc', 0),
('Iskandar', 'Khayon', 'prospero@maledictum.com', '123', 11),
('Tarik', 'Torgaddon', 'luna@imperium.com', '123', 33);

-- -----------------------------------------------------------------------------
-- TEST: tienda, compras y usuarios. import('insert-datos-vitales.tienda')
-- restar monedas de un usuario al realizar una compra en la tienda
-- -----------------------------------------------------------------------------

INSERT INTO tienda(nombre_item, descripcion, precio_monedas, tipo_item) VALUES
('eliminar opcion', 'Elimina una opcion incorrecta aleatoria', 10, 'buff');

INSERT INTO compras(id_usuario, id_item) VALUES (2, 1), (3, 1);

SELECT * FROM tienda;
SELECT * FROM compras;
SELECT * FROM usuarios;

-- -----------------------------------------------------------------------------
-- FIN TEST: tienda, compras y usuarios
-- RESULTADOS: al usuario con id(?) se le restan las monedas :)
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- TEST: amigos
-- asignar a cada usuario su amigo correspondiente (solicitante, receptor)
-- -----------------------------------------------------------------------------

INSERT INTO amigos(id_solicitante, id_receptor) VALUES (1, 2);

SELECT * FROM amigos;
SELECT * FROM usuarios;

-- -----------------------------------------------------------------------------
-- FIN TEST: amigos
-- RESULTADOS: la variable amigos de ambos usuarios aumenta en 1 :)
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- TEST: recompensas por niveles y usuarios. import('insert-datos-vitales.*')
-- al completar un nivel se le asignar las recompensas al usuario
-- -----------------------------------------------------------------------------

INSERT INTO mundos (nombre_mundo) VALUES ('El claro del ahorro');

INSERT INTO niveles (id_mundo) VALUES (1), (1), (1);

INSERT INTO recompensas (tipo_recompensa) VALUES ('monedas'), ('puntos');

INSERT INTO niveles_usuarios (id_nivel, id_usuario) VALUES
(1, 1),
(2, 1),
(3, 1),
(3, 3);

INSERT INTO niveles_recompensas (id_nivel, id_recompensa, cantidad) VALUES
(1, 1, 20),
(1, 2, 100),
(2, 1, 60);

UPDATE niveles_usuarios
SET nivel_completado = TRUE
WHERE id_nivel = 1
AND id_usuario = 1;

SELECT * FROM mundos;
SELECT * FROM niveles;
SELECT * FROM recompensas;
SELECT * FROM niveles_usuarios;
SELECT * FROM niveles_recompensas;
SELECT * FROM usuarios;

-- -----------------------------------------------------------------------------
-- FIN TEST: recompensas por niveles y usuarios
-- RESULTADOS: al usuario con id(?) se le asignan las recompensas :)
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- TEST: logros y usuarios. import('logros.logros')
-- insertar y verificar los logros de un usuario
-- -----------------------------------------------------------------------------

INSERT INTO logros (nombre_logro, descripcion, imagen_url) VALUES
('Primer Paso', 'Completa el nivel 1 del Mundo 1.', '--'),
('Explorador del Claro del Ahorro', 'Completa todos los niveles del Mundo 1.', '--');

INSERT INTO logros_usuarios (id_logro, id_usuario) VALUES
(1, 1),
(2, 1),
(1, 2);

SELECT * FROM logros;
SELECT * FROM logros_usuarios;

-- Listar logros
SELECT id_logro, id_usuario
FROM logros_usuarios
WHERE id_usuario = 1;

-- Contar logros
SELECT COUNT(id_logro) AS cantidad_logros
FROM logros_usuarios
WHERE id_usuario = 2;

-- -----------------------------------------------------------------------------
-- FIN TEST: logros y usuarios.
-- RESULTADOS: al usuario con id(?) se le asignan las logros :)
-- -----------------------------------------------------------------------------