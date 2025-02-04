-- USE db_foxsavvy;

-- Consultas desde server

-- -----------------------------------------------------------------------------
-- Verificar emial y password en Log in
-- -----------------------------------------------------------------------------

SELECT email, contraseña
FROM usuarios
WHERE email = emial_log_in
and contraseña = password_log_in;

-- -----------------------------------------------------------------------------
-- Datos de usuario: nombre, apellido, monedas, puntos, amigos, racha_dias
-- -----------------------------------------------------------------------------

SELECT nombre_usuario, SUBSTR(apellido_usuario, 1, 1) AS apellido_usuario, monedas, puntos, amigos, racha_dias
FROM usuarios
WHERE id_usuario = 1;

-- -----------------------------------------------------------------------------
-- Listar y contar (cantidad numerica) logros por usuario
-- -----------------------------------------------------------------------------

-- Listar
SELECT id_logro
FROM logros_usuarios
WHERE id_usuario = 1;

-- Contar
SELECT COUNT(id_logro) AS cantidad_logros
FROM logros_usuarios
WHERE id_usuario = 2;

-- -----------------------------------------------------------------------------
-- Ranking de puntos de usuarios en orden descendiente (mayor a menor)
-- -----------------------------------------------------------------------------

SELECT puntos FROM usuarios
ORDER BY puntos DESC
LIMIT 10;

-- -----------------------------------------------------------------------------
-- Tiempo en horas que pasa el usuario en el servidor diariamente
-- -----------------------------------------------------------------------------

SELECT 
    DAYNAME(fecha) AS dia_semana, 
    SUM(tiempo_total) AS horas_totales_dia
FROM sesiones
WHERE id_usuario = 1
GROUP BY dia_semana 
ORDER BY FIELD(dia_semana, 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo');

-- -----------------------------------------------------------------------------
-- Niveles y mundos completos por un usuario
-- -----------------------------------------------------------------------------

-- niveles
SELECT COUNT(id_nivel) AS niveles_completados
FROM niveles_usuarios
WHERE nivel_completado = TRUE
AND id_usuario = 1;

-- mundos
SELECT COUNT(id_mundo) AS mundos_completados
FROM mundos_usuarios
WHERE mundo_completado = TRUE
AND id_usuario = 1;