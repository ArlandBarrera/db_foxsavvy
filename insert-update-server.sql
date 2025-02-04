-- USE db_foxsavvy;

-- Operaciones INSERT y UPDATE pensadas para ser realizadas desde el server

-- -----------------------------------------------------------------------------
-- Insertar nuevo usuario. `?` es un simbolo representativo.
-- -----------------------------------------------------------------------------

INSERT INTO usuarios(nombre_usuario, apellido_usuario, email, contraseña) VALUES
(?, ?, ?, ?);

-- -----------------------------------------------------------------------------
-- Tiempo de Log in y Log out. Calcular tiempo total en el servidor.
-- -----------------------------------------------------------------------------

-- Log in | INSERT inicio de sesion
INSERT INTO sesiones (id_usuario, fecha, tiempo_login)
VALUES (id_usuario_server, CURDATE(), CURTIME())
ON DUPLICATE KEY UPDATE tiempo_total = tiempo_total;

-- Log out | UPDATE fin se sesion
UPDATE sesiones 
SET tiempo_total = tiempo_total + TIMESTAMPDIFF(SECOND,
  STR_TO_DATE(CONCAT(fecha, ' ', hora_login), '%Y-%m-%d %H:%i:%s'),
  NOW()
) / 3600
WHERE id_usuario = id_usuario_server 
AND fecha = CURDATE();

-- -----------------------------------------------------------------------------
-- UPDATE nivel/mundo estado a completado al ser completado por un usuario.
-- -----------------------------------------------------------------------------

-- nivel
UPDATE niveles_usuarios
SET nivel_completado = TRUE
WHERE id_nivel = id_nivel_server
AND id_usuario = id_usuario_server;

-- mundo
UPDATE mundos_usuarios
SET mundo_completado = TRUE
WHERE id_mundo = id_mundo_server
AND id_usuario = id_usuario_server;