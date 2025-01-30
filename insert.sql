INSERT INTO usuarios(nombre_usuario, apellido_usuario, email, password_hash, monedas) VALUES
('Pedro', 'Kantor', 'rynn@imperium.com', 'abc', 0),
('Iskandar', 'Khayon', 'prospero@maledictum.com', '123', 11),
('Tarik', 'Torgaddon', 'luna@imperium.com', '123', 33);

INSERT INTO tienda(nombre_item, descripcion, precio_monedas, tipo_item) VALUES ('eliminar opcion', 'Elimina una opcion incorrecta aleatoria', 10, 'buff');

INSERT INTO compras(id_usuario, id_item) VALUES (2, 1), (3, 1);

INSERT INTO amigos(id_solicitante, id_receptor) VALUES (1, 3);

SELECT * FROM usuarios;
SELECT * FROM compras;
SELECT * FROM amigos;
SELECT * FROM tienda;