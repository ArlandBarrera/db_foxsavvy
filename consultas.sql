-- USE db_foxsavvy;

-- consultas desde server
-- |
-- |
-- \/

-- ranking de usuairo de forma descendiente
SELECT puntaje FROM usuarios
ORDER BY puntaje DESC
LIMIT 10;

-- horas del usuario dentro del servidor
SELECT 
    DAYNAME(fecha) AS dia_semana, 
    SUM(tiempo_total) AS horas_totales_dia
FROM sesiones 
GROUP BY dia_semana 
ORDER BY FIELD(dia_semana, 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo');

-- niveles completados por usuario
SELECT id_nivel, id_usuario
FROM niveles_usuarios
WHERE nivel_completado = TRUE;

-- mundos completados por usuario
SELECT id_mundo, id_usuario
FROM mundos_usuarios
WHERE mundo_completado = TRUE;

-- ^
-- |
-- |
-- consultas desde server