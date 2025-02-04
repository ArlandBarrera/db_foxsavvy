-- Insertar logros en la tabla 'logros'
INSERT INTO logros (nombre_logro, descripcion, imagen_url) VALUES
-- Mundo 1
('Primer Paso', 'Completa el nivel 1 del Mundo 1.', '--'),
('Explorador del Claro del Ahorro', 'Completa todos los niveles del Mundo 1.', '--'),
-- Mundo 2
('Nivel Intermedio', 'Completa el nivel 5 de cualquier mundo.', '--'),
('Explorador de la Aldea del Presupuesto', 'Completa todos los niveles del Mundo 2.', '--'),
-- Mundo 3
('Experto en Niveles', 'Completa el último nivel de cualquier mundo.', '--'),
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

-- -------------------------------------------------------------------------------
-- 1. Verificar si el usuario ha completado todos los niveles de un mundo
BEGIN;

-- Variables usadas desde el server
SET @id_usuario = 1;
SET @id_mundo = 1;
SET @niveles_completados = 0;
SET @total_niveles = 0;
SET @id_logro = 1;

SELECT COUNT(*) INTO @niveles_completados
FROM niveles_usuarios
WHERE id_usuario = @id_usuario AND id_nivel IN (
    SELECT id_nivel FROM niveles WHERE id_mundo = @id_mundo
) AND nivel_completado = TRUE;

-- SELECT @niveles_completados;

SELECT COUNT(*) INTO @total_niveles
FROM niveles
WHERE id_mundo = @id_mundo;

-- SELECT @total_niveles;

-- Condicional en el server
IF @niveles_completados = @total_niveles THEN
    INSERT INTO logros_usuarios (id_usuario, id_logro) VALUES (@id_usuario, @id_logro);
END IF;

COMMIT;

-- -------------------------------------------------------------------------------
-- 2. Verificar si el usuario ha completado todos los mundos
BEGIN;

-- Variables usadas desde el server
SET @id_usuario = 1;
SET @mundos_completados = 0;
SET @total_mundos = 0;
SET @id_logro = 1;

SELECT COUNT(DISTINCT id_mundo) INTO @mundos_completados
FROM mundos_usuarios
WHERE id_usuario = @id_usuario AND mundo_completado = TRUE;

SELECT COUNT(*) INTO @total_mundos
FROM mundos;

IF @mundos_completados = @total_mundos THEN
    INSERT INTO logros_usuarios (id_usuario, id_logro) VALUES (@id_usuario, @id_logro);
END IF;

COMMIT;

-- ------------------------------------------------------------------------------
-- 3. Verificar si el usuario completó el primer nivel, nivel 5 o último nivel
BEGIN;

SELECT id_nivel INTO @nivel_completado
FROM niveles_usuarios
WHERE id_usuario = @id_usuario AND nivel_completado = TRUE;

SELECT MIN(id_nivel) INTO @primer_nivel FROM niveles WHERE id_mundo = ?;
SELECT id_nivel INTO @nivel_5 FROM niveles WHERE id_mundo = ? ORDER BY id_nivel LIMIT 1 OFFSET 4;
SELECT MAX(id_nivel) INTO @ultimo_nivel FROM niveles WHERE id_mundo = ?;

IF @nivel_completado = @primer_nivel THEN
    INSERT INTO logros_usuarios (id_usuario, id_logro) VALUES (?, ?);
ELSEIF @nivel_completado = @nivel_5 THEN
    INSERT INTO logros_usuarios (id_usuario, id_logro) VALUES (?, ?);
ELSEIF @nivel_completado = @ultimo_nivel THEN
    INSERT INTO logros_usuarios (id_usuario, id_logro) VALUES (?, ?);
END IF;

COMMIT;

-- -------------------------------------------------------------------------------
-- 4. Verificar racha de días
BEGIN;

-- Variables usadas desde el server
SET @id_usuario = 1;
SET @racha_dias = 0;
SET @id_logro = ?;

SELECT racha_dias INTO @racha_dias
FROM usuarios
WHERE id_usuario = @id_usuario;

IF @racha_dias >= 7 THEN
    INSERT INTO logros_usuarios (id_usuario, id_logro) VALUES (?, ?);
END IF;

IF @racha_dias >= 30 THEN
    INSERT INTO logros_usuarios (id_usuario, id_logro) VALUES (?, ?);
END IF;

COMMIT;

-- ----------------------------------------------------------------------------------
-- 5. Verificar monedas acumuladas
BEGIN;

SET @id_usuario = 1;
SET @monedas = 0;
SET @id_logro = ?;

SELECT monedas INTO @monedas
FROM usuarios
WHERE id_usuario = @id_usuario;

IF @monedas >= 100 THEN
    INSERT INTO logros_usuarios (id_usuario, id_logro) VALUES (?, ?);
END IF;

IF @monedas >= 500 THEN
    INSERT INTO logros_usuarios (id_usuario, id_logro) VALUES (?, ?);
END IF;

IF @monedas >= 1000 THEN
    INSERT INTO logros_usuarios (id_usuario, id_logro) VALUES (?, ?);
END IF;

COMMIT;

-- ----------------------------------------------------------------------------------
-- 6. Verificar cantidad de amigos
BEGIN;

SET @id_usuario = 1;
SET @amigos = 0;
SET @id_logro = ?;

SELECT amigos INTO @amigos
FROM usuarios
WHERE id_usuario = @id_usuario;

IF @amigos >= 1 THEN
    INSERT INTO logros_usuarios (id_usuario, id_logro) VALUES (?, ?);
END IF;

IF @amigos >= 5 THEN
    INSERT INTO logros_usuarios (id_usuario, id_logro) VALUES (?, ?);
END IF;

IF @amigos >= 10 THEN
    INSERT INTO logros_usuarios (id_usuario, id_logro) VALUES (?, ?);
END IF;

COMMIT;
