-- USE db_foxsavvy;

-- Datos fijos fundamentales

-- -----------------------------------------------------------------------------
-- Items de la tienda
-- -----------------------------------------------------------------------------

INSERT INTO tienda(nombre_item, descripcion, precio_monedas, tipo_item) VALUES
('eliminar opcion', 'Elimina una opcion incorrecta aleatoria', 10, 'buff');

INSERT INTO tienda (nombre_item, descripcion, precio_monedas, tipo_item) VALUES
('Multiplicador de Monedas x2', 'Duplica las monedas obtenidas en el siguiente minijuego.', 100, 'buff'),
('Multiplicador de Puntos x2', 'Duplica los puntos obtenidos en el siguiente minijuego.', 100, 'buff'),
('Escudo Anti-Gastos', 'Evita perder monedas en el siguiente minijuego.', 150, 'buff'),
('Tiempo Extra', 'Añade 2 minuto extra al tiempo de los minijuegos.', 120, 'buff'),
('Dado Dorado', 'Un casino en la palma de tu mano.', 200, 'gambling'), 
-- -----------------------------------------------------------------------------
-- Logros
-- -----------------------------------------------------------------------------

INSERT INTO logros (nombre_logro, descripcion, imagen_url) VALUES
-- Mundo 1
('Primer Paso', 'Completa el nivel 1 del Mundo 1.', '--'),
('Explorador del Claro del Ahorro', 'Completa todos los niveles del Mundo 1.', '--'),
-- Mundo 2
('Explorador de la Aldea del Presupuesto', 'Completa todos los niveles del Mundo 2.', '--'),
-- Mundo 3
('Explorador de la Montaña de las Inversiones', 'Completa todos los niveles del Mundo 3.', '--'),
-- Todos los mundos
('Maestro del Ahorro', 'Completa todos los mundos.', '--'),
-- Racha sesiones diarias
('Racha de 7 Días', 'Inicia sesión durante 7 días consecutivos.', '--'),
('Racha de 30 Días', 'Inicia sesión durante 30 días consecutivos.', '--'),
-- Ahorrar monedas
('Ahorrador Novato', 'Acumula 100 monedas.', '--'),
('Ahorrador Experto', 'Acumula 500 monedas.', '--'),
('Ahorrador Maestro', 'Acumula 1000 monedas.', '--'),
-- Amigos
('Primer Amigo', 'Agrega a un amigo.', '--'),
('Popularidad en Aumento', 'Agrega a 5 amigos.', '--'),
('Zorro Amistoso', 'Agrega a 10 amigos.', '--'),
-- Ranking
('Cénit financiero', 'Alcanza el primer lugar en el rankig.', '--'),
-- Tienda
('Comprador novicio', 'Compra tu primer objeto en la tienda.', '--'),
('Comprador habitual', 'Compra 10 objetos en la tienda.', '--');

-- -----------------------------------------------------------------------------
-- Recompensas
-- -----------------------------------------------------------------------------

INSERT INTO recompensas (tipo_recompensa) VALUES ('monedas'), ('puntos');

-- -----------------------------------------------------------------------------
-- Mundos
-- -----------------------------------------------------------------------------

INSERT INTO mundos (nombre_mundo) VALUES
('El claro del ahorro'),
('Aldea del Presupuesto'),
('Montaña de las Inversiones');

-- -----------------------------------------------------------------------------
-- Niveles
-- -----------------------------------------------------------------------------

INSERT INTO niveles (id_mundo) VALUES (1), (1), (1);

-- -----------------------------------------------------------------------------
-- Recompensas por nivel
-- -----------------------------------------------------------------------------

INSERT INTO niveles_recompensas (id_nivel, id_recompensa, cantidad) VALUES
(1, 1, 20),
(1, 2, 100),
(2, 1, 60),
(3, 2, 300);
