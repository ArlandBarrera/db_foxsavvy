-- USE db_foxsavvy;

-- Datos fijos fundamentales!

-- -----------------------------------------------------------------------------
-- Items de la tienda
-- -----------------------------------------------------------------------------

INSERT INTO tienda(nombre_item, descripcion, precio_monedas, tipo_item) VALUES
('Eliminar opcion', 'Elimina una opción incorrecta aleatoria', 10, 'buff'),
('Monedas x2', 'Duplica las monedas obtenidas en un minijuego.', 20, 'buff'),
('Puntos x2', 'Duplica los puntos obtenidos en un minijuego.', 20, 'buff'),
('Escudo Anti-Pérdida', 'Evita perder monedas en un minijuego.', 40, 'buff'),
('Tiempo Extra', 'Añade 2 minutos extra al tiempo de un minijuego.', 60, 'buff'),
('Dado Dorado', 'Una inversión en la palma de tu mano.', 100, 'buff');

-- -----------------------------------------------------------------------------
-- Logros
-- -----------------------------------------------------------------------------

INSERT INTO logros (nombre_logro, descripcion, imagen_url) VALUES
-- Mundo 1
('Primer Paso', 'Completa el nivel 1 del Mundo 1.', '--'),
('Explorador del Claro del Ahorro', 'Completa todos los niveles del Mundo 1.', '--'),
-- Mundo 2
('Visitante de la Aldea del Presupuesto', 'Completa todos los niveles del Mundo 2.', '--'),
-- Mundo 3
('Aventurero de la Montaña de las Inversiones', 'Completa todos los niveles del Mundo 3.', '--'),
-- Todos los mundos
('Maestro del Ahorro', 'Completa todos los mundos.', '--'),
-- Racha sesiones diarias
('Racha de 7 Días', 'Inicia sesión durante 7 días consecutivos.', '--'),
('Racha de 30 Días', 'Inicia sesión durante 30 días consecutivos.', '--'),
-- Ahorrar monedas
('Ahorrador Novato', 'Ahorra 100 monedas.', '--'),
('Ahorrador Experto', 'Ahorra 500 monedas.', '--'),
('Ahorrador Maestro', 'Ahorra 1000 monedas.', '--'),
-- Amigos
('Primer Amigo', 'Agrega a un amigo.', '--'),
('Popularidad en Aumento', 'Agrega a 5 amigos.', '--'),
('Zorro Amistoso', 'Agrega a 10 amigos.', '--'),
-- Ranking
('Cénit financiero', 'Alcanza el primer lugar en el rankig.', '--'),
-- Tienda
('Comprador novicio', 'Compra tu primer objeto en la tienda.', '--'),
('Comprador habitual', 'Compra 10 objetos en la tienda.', '--'),
('Ludópata', 'Compra 50 dados dorados', '--');

-- -----------------------------------------------------------------------------
-- Recompensas
-- -----------------------------------------------------------------------------

INSERT INTO recompensas (tipo_recompensa) VALUES ('monedas'), ('puntos');

-- -----------------------------------------------------------------------------
-- Mundos
-- -----------------------------------------------------------------------------

INSERT INTO mundos (nombre_mundo) VALUES
('Claro del ahorro'),
('Aldea del Presupuesto'),
('Montaña de las Inversiones');

-- -----------------------------------------------------------------------------
-- Niveles
-- -----------------------------------------------------------------------------

INSERT INTO niveles (id_mundo, nombre_nivel) VALUES
(1, 'El secreto de la bellota dorada'),
(1, 'La madríguera del escondite seguro');

-- -----------------------------------------------------------------------------
-- Recompensas por nivel
-- -----------------------------------------------------------------------------

INSERT INTO niveles_recompensas (id_nivel, id_recompensa, cantidad) VALUES
(1, 1, 10),
(1, 2, 20),
(2, 1, 10),
(2, 2, 20);
