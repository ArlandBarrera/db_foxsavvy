-- USE db_foxsavvy;

-- TODO:
-- Aumentar la racha de dias al entrar a la cuenta por dia.
-- Aumentar las monedas del usuario tras recibir recompensa
-- Aumentar los puntos del usuario tras recibir recompensa

-- Trigger para comprobar las monedas del usuario al momento de comprar
DROP TRIGGER IF EXISTS check_monedas_compra;
DELIMITER //

CREATE TRIGGER check_monedas_compra
BEFORE INSERT ON compras
FOR EACH ROW
BEGIN
  IF (SELECT monedas FROM usuarios WHERE id_usuario = NEW.id_usuario) < 
      (SELECT precio_monedas FROM tienda WHERE id_item = NEW.id_item) THEN
       SIGNAL SQLSTATE '45000' 
       SET MESSAGE_TEXT = 'monedas insuficientes para realizar la compra';
  END IF;
END //

DELIMITER ;

-- Trigger para decrementar la cantidad de monedas de un usuario tras realizar un compra
DROP TRIGGER IF EXISTS dec_monedas_usuario_compra;
DELIMITER //

CREATE TRIGGER dec_monedas_usuario_compra
AFTER INSERT ON compras
FOR EACH ROW
BEGIN
  UPDATE usuarios
  SET monedas = monedas - (SELECT precio_monedas FROM tienda WHERE id_item = NEW.id_item)
  WHERE id_usuario = NEW.id_usuario;
END //

DELIMITER ;

-- Trigger para aumentar la cantidad de amigos de un usuario receptor de una solicitud
DROP TRIGGER IF EXISTS inc_amigos_usuario_receptor;
DELIMITER //

CREATE TRIGGER inc_amigos_usuario_receptor
AFTER INSERT ON amigos
FOR EACH ROW
BEGIN
  UPDATE usuarios
  SET amigos = amigos + 1
  WHERE id_usuario = NEW.id_receptor;
END //

DELIMITER ;

-- Trigger para aumentar la cantidad de amigos de un usuario receptor de una solicitud
DROP TRIGGER IF EXISTS inc_amigos_usuario_solicitante;
DELIMITER //

CREATE TRIGGER inc_amigos_usuario_solicitante
AFTER INSERT ON amigos
FOR EACH ROW
BEGIN
  UPDATE usuarios
  SET amigos = amigos + 1
  WHERE id_usuario = NEW.id_solicitante;
END //

DELIMITER ;

-- Trigger para asignar monedas a usuario por nivel completado
DROP TRIGGER IF EXISTS recompensas_monedas_usuario_nivel;
DELIMITER //

CREATE TRIGGER recompensas_monedas_usuario_nivel
AFTER UPDATE ON niveles_usuarios
FOR EACH ROW
BEGIN
  IF ((OLD.nivel_completado = FALSE) AND (NEW.nivel_completado = TRUE)) THEN
    IF (SELECT cantidad FROM niveles_recompensas WHERE id_nivel = NEW.id_nivel AND id_recompensa = 1) THEN
        UPDATE usuarios
        SET
          monedas = monedas + (SELECT cantidad FROM niveles_recompensas WHERE id_nivel = NEW.id_nivel AND id_recompensa = 1)
        WHERE id_usuario = NEW.id_usuario;
    END IF;
  END IF;
END //

DELIMITER ;

-- Trigger para asignar puntos a usuario por nivel completado
DROP TRIGGER IF EXISTS recompensas_puntos_usuario_nivel;
DELIMITER //

CREATE TRIGGER recompensas_puntos_usuario_nivel
AFTER UPDATE ON niveles_usuarios
FOR EACH ROW
BEGIN
  IF ((OLD.nivel_completado = FALSE) AND (NEW.nivel_completado = TRUE)) THEN
    IF (SELECT cantidad FROM niveles_recompensas WHERE id_nivel = NEW.id_nivel AND id_recompensa = 2) THEN
        UPDATE usuarios
        SET
          puntos = puntos + (SELECT cantidad FROM niveles_recompensas WHERE id_nivel = NEW.id_nivel AND id_recompensa = 2)
        WHERE id_usuario = NEW.id_usuario;
    END IF;
  END IF;
END //

DELIMITER ;