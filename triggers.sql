-- USE db_foxsavvy;

-- Trigger para aumentar las monedas de los usuarios
-- DROP TRIGGER IF EXISTS aumentar_monedas_usuario;
-- DELIMITER //

-- CREATE TRIGGER aumentar_monedas_usuario
-- AFTER INSERT ON usuario
-- FOR EACH ROW
-- BEGIN
-- 	UPDATE usuario
--     SET monedas_usuario = monedas_usuario + 1
--     WHERE id_usuario = NEW.id_usuario;
-- END // 

-- DELIMITER ;

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