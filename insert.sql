-- inserciones desde servidor
-- |
-- |
-- \/

-- TODO:
-- Al terminar un nivel se asigna la recompensa (monedas, puntos)

-- Log in
INSERT INTO sesiones (id_usuario, fecha, tiempo_login)
VALUES (id_usuario_server, CURDATE(), CURTIME())
ON DUPLICATE KEY UPDATE tiempo_total = tiempo_total;

-- Log out
UPDATE sesiones 
SET tiempo_total = tiempo_total + TIMESTAMPDIFF(SECOND,
  STR_TO_DATE(CONCAT(fecha, ' ', hora_login), '%Y-%m-%d %H:%i:%s'),
  NOW()
) / 3600
WHERE id_usuario = id_usuario_server 
AND fecha = CURDATE();

-- ^
-- |
-- |
-- fin de inserciones desde server

INSERT INTO usuarios(nombre_usuario, apellido_usuario, email, password_hash, monedas) VALUES
('Pedro', 'Kantor', 'rynn@imperium.com', 'abc', 0),
('Iskandar', 'Khayon', 'prospero@maledictum.com', '123', 11),
('Tarik', 'Torgaddon', 'luna@imperium.com', '123', 33);

INSERT INTO tienda(nombre_item, descripcion, precio_monedas, tipo_item) VALUES ('eliminar opcion', 'Elimina una opcion incorrecta aleatoria', 10, 'buff');

INSERT INTO compras(id_usuario, id_item) VALUES (2, 1), (3, 1);

INSERT INTO amigos(id_solicitante, id_receptor) VALUES (2, 3);

SELECT * FROM usuarios;
SELECT * FROM compras;
SELECT * FROM amigos;
SELECT * FROM tienda;