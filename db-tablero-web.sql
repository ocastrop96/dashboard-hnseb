-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 24-04-2022 a las 18:40:28
-- Versión del servidor: 5.7.33
-- Versión de PHP: 7.4.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db-tablero-web`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `DESBLOQUEAR_USUARIO` (IN `_idUsuario` INT(11))   UPDATE tabcont_usuarios SET intentosUsuario = 0 WHERE idUsuario = _idUsuario

-- tabcont_$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EDITAR_USUARIO` (IN `_idUsuario` INT(11), IN `_idPerfil` INT(11), IN `_dniUsuario` VARCHAR(20), IN `_apellidosUsuario` VARCHAR(50), IN `_nombresUsuario` VARCHAR(50), IN `_cuentaUsuario` VARCHAR(50), IN `_correoUsuario` VARCHAR(50), IN `_claveUsuario` VARCHAR(100))   UPDATE tabcont_usuarios 
SET idPerfil = _idPerfil,
dniUsuario = _dniUsuario,
apellidosUsuario = _apellidosUsuario,
nombresUsuario = _nombresUsuario,
cuentaUsuario = _cuentaUsuario,
correoUsuario = _correoUsuario,
claveUsuario = _claveUsuario 
WHERE
	idUsuario = _idUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ELIMINAR_USUARIO` (IN `_idUsuario` INT(11))   DELETE FROM tabcont_usuarios WHERE idUsuario = _idUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `HABILITAR_USUARIO` (IN `_idUsuario` INT(11), IN `_idEstado` INT(11))   UPDATE tabcont_usuarios SET idEstado = _idEstado WHERE idUsuario = _idUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_PERFILES_USUARIO` ()   SELECT
	psyem_perfiles.idPerfil, 
	psyem_perfiles.detallePerfil
FROM
	psyem_perfiles$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_USUARIOS` ()   SELECT
	psyem_usuarios.idUsuario, 
	psyem_usuarios.dniUsuario, 
	psyem_usuarios.apellidosUsuario, 
	psyem_usuarios.nombresUsuario, 
	psyem_usuarios.cuentaUsuario, 
	psyem_usuarios.correoUsuario, 
	psyem_usuarios.claveUsuario, 
	psyem_usuarios.intentosUsuario,
	date_format(psyem_usuarios.fechaAlta,'%d/%m/%Y') as fechaAlta, 
	psyem_usuarios.profileUsuario, 
	psyem_usuarios.idPerfil, 
	psyem_perfiles.detallePerfil, 
	psyem_usuarios.idEstado, 
	psyem_estadosu.detalleEstadoU,
	psyem_profesionales.idProfesional, 
	psyem_profesionales.nombresProfesional, 
	psyem_profesionales.apellidosProfesional
FROM
	psyem_usuarios
	INNER JOIN
	psyem_perfiles
	ON 
		psyem_usuarios.idPerfil = psyem_perfiles.idPerfil
	INNER JOIN
	psyem_estadosu
	ON 
		psyem_usuarios.idEstado = psyem_estadosu.idEstado
	LEFT JOIN
	psyem_profesionales
	ON 
		psyem_usuarios.dniUsuario = psyem_profesionales.dniProfesional 
	ORDER BY psyem_usuarios.idPerfil ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LOGIN_USUARIO` (IN `_cuentaUsuario` VARCHAR(50))   SELECT
	psyem_usuarios.idUsuario, 
	psyem_usuarios.dniUsuario, 
	psyem_usuarios.apellidosUsuario, 
	psyem_usuarios.nombresUsuario, 
	psyem_usuarios.cuentaUsuario, 
	psyem_usuarios.correoUsuario, 
	psyem_usuarios.claveUsuario, 
	psyem_usuarios.intentosUsuario, 
	psyem_usuarios.fechaAlta, 
	psyem_usuarios.profileUsuario, 
	psyem_usuarios.idPerfil, 
	psyem_perfiles.detallePerfil, 
	psyem_usuarios.idEstado, 
	psyem_estadosu.detalleEstadoU,
		psyem_profesionales.idProfesional,
		CONCAT(psyem_profesionales.nombresProfesional,' ',psyem_profesionales.apellidosProfesional) AS profesional
FROM
	psyem_usuarios
	INNER JOIN
	psyem_perfiles
	ON 
		psyem_usuarios.idPerfil = psyem_perfiles.idPerfil
	INNER JOIN
	psyem_estadosu
	ON 
		psyem_usuarios.idEstado = psyem_estadosu.idEstado
	LEFT JOIN
	psyem_profesionales
	ON 
		psyem_usuarios.dniUsuario = psyem_profesionales.dniProfesional 
WHERE psyem_usuarios.cuentaUsuario = _cuentaUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTRAR_USUARIO` (IN `_idPerfil` INT(11), IN `_dniUsuario` VARCHAR(20), IN `_apellidosUsuario` VARCHAR(50), IN `_nombresUsuario` VARCHAR(50), IN `_cuentaUsuario` VARCHAR(50), IN `_correoUsuario` VARCHAR(50), IN `_claveUsuario` VARCHAR(100))   INSERT INTO psyem_usuarios ( idPerfil, dniUsuario, apellidosUsuario, nombresUsuario, cuentaUsuario, correoUsuario, claveUsuario )
VALUES
	( _idPerfil, _dniUsuario, _apellidosUsuario, _nombresUsuario, _cuentaUsuario, _correoUsuario, _claveUsuario )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTRO_INTENTOS` (IN `_idUsuario` INT(11))   BEGIN
UPDATE psyem_usuarios SET intentosUsuario = intentosUsuario + 1 WHERE idUsuario = _idUsuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VERIFICA_ESTADO_LOG` (IN `_USUARIO` INT(11))   SELECT
	psyem_usuarios.idUsuario, 
	psyem_usuarios.idEstado
FROM
	psyem_usuarios
WHERE idUsuario = _USUARIO$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `MES_SPANISH` (`_d` DATE, `_locale` VARCHAR(5)) RETURNS VARCHAR(22) CHARSET utf8  BEGIN
     SET @@lc_time_names = _locale;
     RETURN UPPER(DATE_FORMAT(_d, '%M'));
 END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tabcont_estadosu`
--

CREATE TABLE `tabcont_estadosu` (
  `idEstado` int(11) NOT NULL,
  `detalleEstadoU` varchar(50) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `tabcont_estadosu`
--

INSERT INTO `tabcont_estadosu` (`idEstado`, `detalleEstadoU`) VALUES
(1, 'HABILITADO'),
(2, 'INHABILITADO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tabcont_perfiles`
--

CREATE TABLE `tabcont_perfiles` (
  `idPerfil` int(11) NOT NULL,
  `detallePerfil` varchar(50) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `tabcont_perfiles`
--

INSERT INTO `tabcont_perfiles` (`idPerfil`, `detallePerfil`) VALUES
(1, 'ADMINISTRADOR'),
(2, 'JEFE'),
(3, 'PSICOLOGO'),
(4, 'MONITOREO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tabcont_usuarios`
--

CREATE TABLE `tabcont_usuarios` (
  `idUsuario` int(11) NOT NULL,
  `idPerfil` int(11) NOT NULL,
  `idEstado` int(11) NOT NULL DEFAULT '2',
  `dniUsuario` varchar(20) COLLATE utf8_bin NOT NULL,
  `apellidosUsuario` varchar(50) COLLATE utf8_bin NOT NULL,
  `nombresUsuario` varchar(50) COLLATE utf8_bin NOT NULL,
  `cuentaUsuario` varchar(50) COLLATE utf8_bin NOT NULL,
  `correoUsuario` varchar(50) COLLATE utf8_bin NOT NULL,
  `claveUsuario` varchar(100) COLLATE utf8_bin NOT NULL,
  `intentosUsuario` int(11) DEFAULT '0',
  `fechaAlta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `profileUsuario` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `tabcont_usuarios`
--

INSERT INTO `tabcont_usuarios` (`idUsuario`, `idPerfil`, `idEstado`, `dniUsuario`, `apellidosUsuario`, `nombresUsuario`, `cuentaUsuario`, `correoUsuario`, `claveUsuario`, `intentosUsuario`, `fechaAlta`, `profileUsuario`) VALUES
(1, 1, 1, '77478995', 'CASTRO PALACIOS', 'OLGER IVAN', 'ocastrop', 'ocastrop@hnseb.gob.pe', '$2a$07$usesomesillystringforeM8r9BbmlBZ9ovuveDN0W0YiCUcwiGOm', 2, '2021-06-01 15:34:46', ''),
(2, 1, 1, '40195996', 'ROSAS SANCHEZ', 'MONICA NOHEMI', 'rosasmn', 'rosasmn@hnseb.gob.pe', '$2a$07$usesomesillystringforeoRNSqF5ebwOJ.HFIcVhNJ65bww3hpNi', 0, '2021-06-01 17:24:22', NULL),
(3, 3, 1, '06958470', 'CORDOVA CACHAY', 'MATILDE', 'mcordovac', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforehgypeI5DRix.IHkznBBhY252VmxlIWG', 0, '2021-06-01 17:24:53', NULL),
(4, 3, 1, '09851044', 'FLORES CASTILLO', 'IRMA', 'ifloresc', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforeBMhRE0LIoruOmyFsWj3UQXjUsLK9jbW', 0, '2021-06-01 17:25:46', NULL),
(5, 2, 1, '09512967', 'MORI ZUBIATE', 'ZONIA EMPERATRIZ', 'zmoriz', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringfore5.XZEFBrtJ9.qXuqzFwfY43rZRYXidu', 1, '2021-06-01 17:26:04', NULL),
(6, 3, 1, '09479664', 'PABLO JARAMILLO', 'NORMA BEATRIZ', 'npabloj', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforejafDnGpmQvC62Zn3P5JoKKyWKV4zarq', 0, '2021-06-01 17:26:33', NULL),
(7, 3, 2, '10725238', 'RAPRI SOLANO', 'EDSON', 'erapris', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforelIPayZrI4jRNiLPXnEEGudMyDr2fDY2', 0, '2021-06-01 17:26:54', NULL),
(8, 3, 1, '06781469', 'SALDAÑA CHAVEZ', 'KELLY', 'ksaldañac', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforeZpoQa.04HI7d0l.s3qvV9RXq.FhroYq', 0, '2021-06-01 17:27:17', NULL),
(9, 3, 1, '06123251', 'SANCHEZ AQUINO', 'NORMA NELIDA', 'nsancheza', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforeYSJzm0jn4URCyGiJ4fg.5wGT.VCsJVa', 0, '2021-06-01 17:27:36', NULL),
(10, 3, 1, '10288615', 'TRUJILLO CASTILLO', 'MIRIAM ROCIO', 'mtrujilloc', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforet.nDPdp7Y6XclmteD.MneoaNId0Wvje', 1, '2021-06-01 17:28:01', NULL),
(11, 3, 1, '07178930', 'VELASQUEZ REYES', 'MARIA ANGELA', 'mvelasquezr', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforedE1OzELbl6PFujI.BSco1Er6IX.Uv6C', 0, '2021-06-01 17:28:22', NULL),
(12, 3, 1, '46624029', 'ZAVALETA LOPEZ', 'DARNELLY JAHAIRA', 'dzavaletal', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforeBQPDD/GSseqnB6cro9X9nOHtqDKTXLS', 0, '2021-06-01 17:29:00', NULL),
(13, 1, 1, '09966920', 'SERNAQUE QUINTANA', 'JAVIER OCTAVIO', 'jsernaque', 'jsernaque@hnseb.gob.pe', '$2a$07$usesomesillystringforeAR0AYDLcMUwZJGc02Ta3T98Pn6LH7pi', 0, '2021-07-06 19:35:33', NULL),
(14, 4, 1, '41768412', 'FERRARI SANTANDER', 'ALEXIS ALBERTO', 'aferraris', 'dr.alex.ferrari.s@gmail.com', '$2a$07$usesomesillystringforeSXtcfjIjdiDI0eqt9OsmF.T.sEtEwhy', 1, '2021-08-23 19:46:27', NULL),
(15, 4, 1, '06790718', 'CASTILLO USCAMAYTA DE USCAMAYTA', 'JANET MICHELL', 'jcastillou', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringfore4RW/Ia3rLfbPLbdjrPhqpsjfJ65iXpa', 0, '2021-09-15 17:50:26', NULL),
(16, 3, 1, '45833915', 'SALAS ATENCIO', 'INDIRA MARGARETH', 'isalasa', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforeSJCI5jxBOnt6PgFlYouo/P95cCeFkFu', 2, '2022-01-19 14:01:35', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tabcont_estadosu`
--
ALTER TABLE `tabcont_estadosu`
  ADD PRIMARY KEY (`idEstado`);

--
-- Indices de la tabla `tabcont_perfiles`
--
ALTER TABLE `tabcont_perfiles`
  ADD PRIMARY KEY (`idPerfil`);

--
-- Indices de la tabla `tabcont_usuarios`
--
ALTER TABLE `tabcont_usuarios`
  ADD PRIMARY KEY (`idUsuario`),
  ADD KEY `fk_perfil` (`idPerfil`),
  ADD KEY `fk_estadoUsuario` (`idEstado`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tabcont_estadosu`
--
ALTER TABLE `tabcont_estadosu`
  MODIFY `idEstado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tabcont_perfiles`
--
ALTER TABLE `tabcont_perfiles`
  MODIFY `idPerfil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tabcont_usuarios`
--
ALTER TABLE `tabcont_usuarios`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tabcont_usuarios`
--
ALTER TABLE `tabcont_usuarios`
  ADD CONSTRAINT `fk_estadoUsuario` FOREIGN KEY (`idEstado`) REFERENCES `tabcont_estadosu` (`idEstado`),
  ADD CONSTRAINT `fk_perfil` FOREIGN KEY (`idPerfil`) REFERENCES `tabcont_perfiles` (`idPerfil`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
