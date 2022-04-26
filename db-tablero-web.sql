-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 26-04-2022 a las 20:16:15
-- Versión del servidor: 10.1.48-MariaDB
-- Versión de PHP: 7.4.7

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
CREATE DEFINER=`root`@`localhost` PROCEDURE `DESBLOQUEAR_USUARIO` (IN `_idUsuario` INT(11))   UPDATE tabcont_usuarios SET intentosUsuario = 0 WHERE idUsuario = _idUsuario$$

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
	tabcont_perfiles.idPerfil, 
	tabcont_perfiles.detallePerfil
FROM
	tabcont_perfiles$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_USUARIOS` ()   SELECT
	tabcont_usuarios.idUsuario, 
	tabcont_usuarios.dniUsuario, 
	tabcont_usuarios.apellidosUsuario, 
	tabcont_usuarios.nombresUsuario, 
	tabcont_usuarios.cuentaUsuario, 
	tabcont_usuarios.correoUsuario, 
	tabcont_usuarios.claveUsuario, 
	tabcont_usuarios.intentosUsuario,
	date_format(tabcont_usuarios.fechaAlta,'%d/%m/%Y') as fechaAlta, 
	tabcont_usuarios.profileUsuario, 
	tabcont_usuarios.idPerfil, 
	tabcont_perfiles.detallePerfil, 
	tabcont_usuarios.idEstado, 
	tabcont_estadosu.detalleEstadoU
FROM
	tabcont_usuarios
	INNER JOIN
	tabcont_perfiles
	ON 
		tabcont_usuarios.idPerfil = tabcont_perfiles.idPerfil
	INNER JOIN
	tabcont_estadosu
	ON 
		tabcont_usuarios.idEstado = tabcont_estadosu.idEstado
	ORDER BY tabcont_usuarios.idPerfil ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LOGIN_USUARIO` (IN `_cuentaUsuario` VARCHAR(50))   SELECT
	tabcont_usuarios.idUsuario, 
	tabcont_usuarios.dniUsuario, 
	tabcont_usuarios.apellidosUsuario, 
	tabcont_usuarios.nombresUsuario, 
	tabcont_usuarios.cuentaUsuario, 
	tabcont_usuarios.correoUsuario, 
	tabcont_usuarios.claveUsuario, 
	tabcont_usuarios.intentosUsuario, 
	tabcont_usuarios.fechaAlta, 
	tabcont_usuarios.profileUsuario, 
	tabcont_usuarios.idPerfil, 
	tabcont_perfiles.detallePerfil, 
	tabcont_usuarios.idEstado, 
	tabcont_estadosu.detalleEstadoU
FROM
	tabcont_usuarios
	INNER JOIN
	tabcont_perfiles
	ON 
		tabcont_usuarios.idPerfil = tabcont_perfiles.idPerfil
	INNER JOIN
	tabcont_estadosu
	ON 
		tabcont_usuarios.idEstado = tabcont_estadosu.idEstado
WHERE tabcont_usuarios.cuentaUsuario = _cuentaUsuario$$

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
(2, 'DIRECCION'),
(3, 'JEFATURAS');

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
(1, 1, 1, '77478995', 'CASTRO PALACIOS', 'OLGER IVAN', 'ocastrop', 'ocastrop@hnseb.gob.pe', '$2a$07$usesomesillystringforeVF6hLwtgsUBAmUN4cGEd8tYF74gSHRW', 0, '2021-06-01 15:34:46', ''),
(13, 1, 1, '09966920', 'SERNAQUE QUINTANA', 'JAVIER OCTAVIO', 'jsernaque', 'jsernaque@hnseb.gob.pe', '$2a$07$usesomesillystringforeAR0AYDLcMUwZJGc02Ta3T98Pn6LH7pi', 0, '2021-07-06 19:35:33', NULL),
(14, 1, 1, '18089753', 'HERRERA MORALES', 'SANTIAGO ANTONIO', 'sherrera', 'direccion@hnseb.gob.pe', '$2a$07$usesomesillystringfore0eTaEYwOJS8QjbSY..tC576juGmGm0q', 0, '2021-07-06 19:35:33', NULL),
(15, 1, 1, '08344235', 'HERRERA ALANIA', 'ORLANDO FORTUNATO', 'oherrera', 'direccion@hnseb.gob.pe', '$2a$07$usesomesillystringfore6TJegGsuXnXa.YGd7h82Za.x2TsErla', 0, '2021-07-06 19:35:33', NULL),
(16, 1, 1, '46238818', 'VELAZCO YACHACHIN', 'KERLY NANETTE', 'kvelazco', 'estadistica@hnseb.gob.pe', '$2a$07$usesomesillystringforeoRfMfYHVaaM/GopGD/znINTjbdAkVVa', 0, '2021-07-06 19:35:33', NULL);

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
