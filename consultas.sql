-- consultas desde server
-- |
-- |
-- \/

-- TODO:
-- niveles completados por usuario
-- mundos completados por usuario

-- ranking de usuairo de forma descendiente
SELECT puntaje FROM usuarios
ORDER BY puntaje DESC
LIMIT 10;

-- horas del usuario dentro del servidor
SELECT
    id_usuario,
    DAYNAME(fecha) AS dia_semana,
    SUM(tiempo_total) AS horas_totales_dia
FROM sesiones
GROUP BY id_usuario, fecha
ORDER BY fecha DESC, id_usuario;

-- ^
-- |
-- |
-- consultas desde server