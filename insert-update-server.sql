-- USE db_foxsavvy;

-- Operaciones INSERT y UPDATE pensadas para ser realizadas desde el server

-- INSERT/UPDATE desde servidor
-- |
-- |
-- \/

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

-- UPDATE nivel_completado al terminar un nivel
UPDATE niveles_usuarios
SET nivel_completado = TRUE
WHERE id_nivel = id_nivel_server
AND id_usuario = id_usuario_server;

-- UPDATE mundo_completado al terminar un mundo
UPDATE mundos_usuarios
SET mundo_completado = TRUE
WHERE id_mundo = id_mundo_server
AND id_usuario = id_usuario_server;

-- ^
-- |
-- |
-- FIN INSERT/UPDATE desde server