-- USE db_foxsavvy;

INSERT INTO usuarios(nombre_usuario, apellido_usuario, email, password_hash, monedas) VALUES
('Pedro', 'Kantor', 'rynn@imperium.com', 'abc', 0),
('Iskandar', 'Khayon', 'prospero@maledictum.com', '123', 11),
('Tarik', 'Torgaddon', 'luna@imperium.com', '123', 33);

-- -----------------------------------------------------------------------------
-- TEST: tienda, compras y usuarios
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

INSERT INTO amigos(id_solicitante, id_receptor) VALUES (2, 3);

SELECT * FROM amigos;
SELECT * FROM usuarios;

-- -----------------------------------------------------------------------------
-- FIN TEST: amigos
-- RESULTADOS: la variable amigos de ambos usuarios aumenta en 1 :)
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- TEST: recompensas por niveles y usuarios
-- al completar un nivel se le asignar las recompensas al usuario
-- -----------------------------------------------------------------------------

INSERT INTO mundos (nombre_mundo) VALUES ('El claro del ahorro');

INSERT INTO niveles (id_mundo) VALUES (1), (1), (1);

INSERT INTO recompensas (tipo_recompensa) VALUES ('monedas'), ('puntos');

INSERT INTO niveles_usuarios (id_nivel, id_usuario) VALUES
(1, 1),
(2, 1),
(3, 1);

INSERT INTO niveles_recompensas (id_nivel, id_recompensa, cantidad) VALUES
(1, 1, 20),
(1, 2, 100),
(2, 1, 60),
(3, 2, 300);

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