-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 12-02-2025 a las 16:20:54
-- Versión del servidor: 8.3.0
-- Versión de PHP: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIfvENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gestion_colegio`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignaturas`
--

DROP TABLE IF EXISTS `asignaturas`;
CREATE TABLE IF NOT EXISTS `asignaturas` (
  `id_asignatura` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id_asignatura`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asignaturas`
--

INSERT INTO `asignaturas` (`id_asignatura`, `nombre`) VALUES
(1, 'Matemáticas'),
(2, 'Ciencias'),
(3, 'Lenguaje');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

DROP TABLE IF EXISTS `asistencia`;
CREATE TABLE IF NOT EXISTS `asistencia` (
  `id_asistencia` int NOT NULL AUTO_INCREMENT,
  `estudiante_id` int NOT NULL,
  `asignatura_id` int NOT NULL,
  `curso_id` int NOT NULL,
  `docente_id` int NOT NULL,
  `fecha` date NOT NULL,
  `estado` enum('Presente','Ausente') NOT NULL,
  `observaciones` text,
  PRIMARY KEY (`id_asistencia`),
  KEY `estudiante_id` (`estudiante_id`),
  KEY `asignatura_id` (`asignatura_id`),
  KEY `curso_id` (`curso_id`),
  KEY `docente_id` (`docente_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asistencia`
--

INSERT INTO `asistencia` (`id_asistencia`, `estudiante_id`, `asignatura_id`, `curso_id`, `docente_id`, `fecha`, `estado`, `observaciones`) VALUES
(1, 4, 1, 1, 2, '2025-02-10', 'Presente', 'Llegó a tiempo'),
(2, 4, 2, 1, 2, '2025-02-11', 'Ausente', 'Enfermedad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

DROP TABLE IF EXISTS `cursos`;
CREATE TABLE IF NOT EXISTS `cursos` (
  `id_curso` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `cupo_maximo` int NOT NULL,
  PRIMARY KEY (`id_curso`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`id_curso`, `nombre`, `cupo_maximo`) VALUES
(1, 'Grado 1', 30),
(2, 'Grado 2', 30);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docente_asignatura`
--

DROP TABLE IF EXISTS `docente_asignatura`;
CREATE TABLE IF NOT EXISTS `docente_asignatura` (
  `id_docente` int NOT NULL,
  `id_asignatura` int NOT NULL,
  `id_curso` int NOT NULL,
  PRIMARY KEY (`id_docente`,`id_asignatura`,`id_curso`),
  KEY `id_asignatura` (`id_asignatura`),
  KEY `id_curso` (`id_curso`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `docente_asignatura`
--

INSERT INTO `docente_asignatura` (`id_docente`, `id_asignatura`, `id_curso`) VALUES
(2, 1, 1),
(2, 2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiantes`
--

DROP TABLE IF EXISTS `estudiantes`;
CREATE TABLE IF NOT EXISTS `estudiantes` (
  `id_estudiante` int NOT NULL,
  `curso_id` int NOT NULL,
  `acudiente_id` int NOT NULL,
  PRIMARY KEY (`id_estudiante`),
  KEY `curso_id` (`curso_id`),
  KEY `acudiente_id` (`acudiente_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estudiantes`
--

INSERT INTO `estudiantes` (`id_estudiante`, `curso_id`, `acudiente_id`) VALUES
(4, 1, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notas`
--

DROP TABLE IF EXISTS `notas`;
CREATE TABLE IF NOT EXISTS `notas` (
  `id_nota` int NOT NULL AUTO_INCREMENT,
  `estudiante_id` int NOT NULL,
  `asignatura_id` int NOT NULL,
  `docente_id` int NOT NULL,
  `calificacion` decimal(5,2) NOT NULL,
  `observaciones` text,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_nota`),
  KEY `estudiante_id` (`estudiante_id`),
  KEY `asignatura_id` (`asignatura_id`),
  KEY `docente_id` (`docente_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `notas`
--

INSERT INTO `notas` (`id_nota`, `estudiante_id`, `asignatura_id`, `docente_id`, `calificacion`, `observaciones`, `fecha_registro`) VALUES
(1, 4, 1, 2, 4.50, 'Buen desempeño', '2025-02-12 02:03:28'),
(2, 4, 2, 2, 3.80, 'Debe mejorar en experimentos', '2025-02-12 02:03:28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `noticias`
--

DROP TABLE IF EXISTS `noticias`;
CREATE TABLE IF NOT EXISTS `noticias` (
  `id_noticia` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `contenido` text NOT NULL,
  `fecha_publicacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_noticia`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `noticias`
--

INSERT INTO `noticias` (`id_noticia`, `titulo`, `contenido`, `fecha_publicacion`) VALUES
(1, 'Inicio de clases', 'Las clases comienzan el 15 de febrero, estén atentos a los horarios.', '2025-02-12 02:03:28'),
(2, 'Día del estudiante', 'Se realizará una jornada especial el próximo viernes.', '2025-02-12 02:03:28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre`) VALUES
(1, 'Administrador'),
(2, 'Docente'),
(3, 'Estudiante'),
(4, 'Acudiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre_completo` varchar(100) NOT NULL,
  `identificacion` varchar(20) NOT NULL,
  `numero_celular` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `contrasena` varchar(255) NOT NULL,
  `rol_id` int NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `identificacion` (`identificacion`),
  UNIQUE KEY `correo` (`correo`),
  KEY `rol_id` (`rol_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre_completo`, `identificacion`, `numero_celular`, `correo`, `contrasena`, `rol_id`) VALUES
(1, 'Carlos López', '100001', '3001234567', 'admin@colegio.com', '$2b$10$AkRzxk..HEQmzOAf8y8zBOo6bT6RVvklX2TxoLf6OLAUq4zb4Cy1m', 1),
(2, 'Laura Martínez', '100002', '3002345678', 'docente1@colegio.com', '$2b$10$AkRzxk..HEQmzOAf8y8zBOo6bT6RVvklX2TxoLf6OLAUq4zb4Cy1m', 2),
(3, 'Juan Pérez', '100003', '3003456789', 'acudiente1@colegio.com', '$2b$10$AkRzxk..HEQmzOAf8y8zBOo6bT6RVvklX2TxoLf6OLAUq4zb4Cy1m', 4),
(4, 'Mariana Ruiz', '100004', '3004567890', 'estudiante1@colegio.com', '$2b$10$AkRzxk..HEQmzOAf8y8zBOo6bT6RVvklX2TxoLf6OLAUq4zb4Cy1m', 3),
(6, 'Daniel', '10697564', '3123561896', 'danielp@example.com', '$2b$10$AkRzxk..HEQmzOAf8y8zBOo6bT6RVvklX2TxoLf6OLAUq4zb4Cy1m', 1);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
