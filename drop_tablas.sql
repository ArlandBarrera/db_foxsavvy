-- USE db_foxsavvy;

-- Realizar DROP en este orden!

-- Tablas intermedias
DROP TABLE IF EXISTS compras;
DROP TABLE IF EXISTS logros_usuarios;
DROP TABLE IF EXISTS mundos_recompensas;
DROP TABLE IF EXISTS niveles_recompensas;
DROP TABLE IF EXISTS mundos_usuarios;
DROP TABLE IF EXISTS niveles_usuarios;
-- Tablas con llave foranea
DROP TABLE IF EXISTS amigos;
DROP TABLE IF EXISTS sesiones;
DROP TABLE IF EXISTS niveles;
-- Tablas sin llave foranea
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS logros;
DROP TABLE IF EXISTS tienda;
DROP TABLE IF EXISTS recompensas;
DROP TABLE IF EXISTS mundos;