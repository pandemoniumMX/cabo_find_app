-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 26-05-2019 a las 03:32:08
-- Versión del servidor: 5.7.24
-- Versión de PHP: 7.0.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cabofind_cabofind`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caracteristicas`
--

DROP TABLE IF EXISTS `caracteristicas`;
CREATE TABLE IF NOT EXISTS `caracteristicas` (
  `ID_CARACTERISTICAS` int(11) NOT NULL AUTO_INCREMENT,
  `CAR_NOMBRE` varchar(45) DEFAULT NULL,
  `CAR_NOMBRE_ENG` varchar(45) DEFAULT NULL,
  `CAR_ESTATUS` varchar(45) DEFAULT NULL,
  `CAR_FECHA` timestamp NULL DEFAULT NULL,
  `negocios_ID_NEGOCIO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_CARACTERISTICAS`),
  KEY `fk_caracteristicas_negocios1_idx` (`negocios_ID_NEGOCIO`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `caracteristicas`
--

INSERT INTO `caracteristicas` (`ID_CARACTERISTICAS`, `CAR_NOMBRE`, `CAR_NOMBRE_ENG`, `CAR_ESTATUS`, `CAR_FECHA`, `negocios_ID_NEGOCIO`) VALUES
(1, 'Area fumadores', 'Smoking area', 'A', NULL, 22),
(2, 'Parking', 'Parking', 'A', NULL, 23),
(3, 'Area de niños', 'Children area', 'A', NULL, 23);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

DROP TABLE IF EXISTS `categorias`;
CREATE TABLE IF NOT EXISTS `categorias` (
  `ID_CATEGORIA` int(11) NOT NULL AUTO_INCREMENT,
  `CAT_NOMBRE` varchar(30) DEFAULT NULL,
  `CAT_NOMBRE_ING` varchar(50) DEFAULT NULL,
  `CAT_ESTATUS` varchar(2) DEFAULT NULL,
  `CAT_URL` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_CATEGORIA`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`ID_CATEGORIA`, `CAT_NOMBRE`, `CAT_NOMBRE_ING`, `CAT_ESTATUS`, `CAT_URL`) VALUES
(59, 'Servicios', 'Services', 'A', 'categoria.php'),
(60, 'Restaurantes', 'Restaurants', 'A', 'restaurantes.php'),
(61, 'Compras', 'Shopping', 'A', 'compras.php'),
(62, 'Vida nocturna', 'Night life', 'A', 'vida_nocturna_php'),
(63, 'Descubre', 'Discover', 'A', 'descubre.php');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exposicion`
--

DROP TABLE IF EXISTS `exposicion`;
CREATE TABLE IF NOT EXISTS `exposicion` (
  `ID_EXPOSICION` int(11) NOT NULL AUTO_INCREMENT,
  `EXP_NIVEL` varchar(25) NOT NULL,
  `EXP_FECHA_ALTA` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `EXP_FECHA_CADUCIDAD` varchar(25) NOT NULL,
  PRIMARY KEY (`ID_EXPOSICION`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `exposicion`
--

INSERT INTO `exposicion` (`ID_EXPOSICION`, `EXP_NIVEL`, `EXP_FECHA_ALTA`, `EXP_FECHA_CADUCIDAD`) VALUES
(1, 'Baja', '2019-05-24 13:02:01', ''),
(2, 'Media', '2019-05-24 13:02:01', ''),
(3, 'Alta', '2019-05-24 13:02:07', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `galeria`
--

DROP TABLE IF EXISTS `galeria`;
CREATE TABLE IF NOT EXISTS `galeria` (
  `ID_GALERIA` int(11) NOT NULL AUTO_INCREMENT,
  `GAL_FOTO` varchar(255) DEFAULT NULL,
  `GAL_TIPO` varchar(255) DEFAULT NULL,
  `GAL_ESTATUS` varchar(2) DEFAULT NULL,
  `ID_NEGOCIO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_GALERIA`),
  KEY `ID_NEGOCIO_idx` (`ID_NEGOCIO`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `galeria`
--

INSERT INTO `galeria` (`ID_GALERIA`, `GAL_FOTO`, `GAL_TIPO`, `GAL_ESTATUS`, `ID_NEGOCIO`) VALUES
(21, 'https://cdn.pixabay.com/photo/2016/03/09/16/50/city-street-1246870_960_720.jpg', 'Publicacion', 'A', 22),
(22, 'https://images.pexels.com/photos/556416/pexels-photo-556416.jpeg', 'Logo', 'A', 22),
(23, 'https://images.pexels.com/photos/449627/pexels-photo-449627.jpeg', 'Publicacion', 'A', 22),
(24, 'https://cdn.pixabay.com/photo/2016/03/09/16/50/city-street-1246870_960_720.jpg', 'Galeria', 'A', 22),
(25, 'https://scontent-dfw5-2.xx.fbcdn.net/v/t1.0-9/59565711_812470582485062_3520869496107565056_n.png?_nc_cat=109&_nc_ht=scontent-dfw5-2.xx&oh=3847a25d8f8a2ed4ce843d30f0aab5c8&oe=5D54AAD7', 'Logo', 'A', 24),
(26, 'https://scontent-dfw5-2.xx.fbcdn.net/v/t1.0-9/11813421_10153390625562211_7426069060619207316_n.jpg?_nc_cat=107&_nc_ht=scontent-dfw5-2.xx&oh=b026650712bc6fb692f2490b2f0ccfc8&oe=5D6248DB', 'Logo', 'A', 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `negocios`
--

DROP TABLE IF EXISTS `negocios`;
CREATE TABLE IF NOT EXISTS `negocios` (
  `ID_NEGOCIO` int(11) NOT NULL AUTO_INCREMENT,
  `NEG_NOMBRE` varchar(50) DEFAULT NULL,
  `NEG_CORREO` varchar(45) DEFAULT NULL,
  `NEG_TEL` int(10) DEFAULT NULL,
  `NEG_DIRECCION` varchar(80) DEFAULT NULL,
  `NEG_DESCRIPCION` varchar(255) DEFAULT NULL,
  `NEG_DESCRIPCION_ENG` varchar(255) DEFAULT NULL,
  `NEG_RESPONSABLE` varchar(45) DEFAULT NULL,
  `NEG_ESTATUS` varchar(2) DEFAULT NULL,
  `NEG_ETIQUETAS` varchar(500) DEFAULT NULL,
  `NEG_ETIQUETAS_ING` varchar(500) DEFAULT NULL,
  `NEG_FECHA` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `NEG_MAP` varchar(1000) DEFAULT NULL,
  `ID_SUBCATEGORIA` int(11) DEFAULT NULL,
  `exposicion_ID_EXPOSICION` int(11) NOT NULL,
  PRIMARY KEY (`ID_NEGOCIO`),
  KEY `ID_SUBCATEGORIA_idx` (`ID_SUBCATEGORIA`),
  KEY `fk_negocios_exposicion1_idx` (`exposicion_ID_EXPOSICION`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `negocios`
--

INSERT INTO `negocios` (`ID_NEGOCIO`, `NEG_NOMBRE`, `NEG_CORREO`, `NEG_TEL`, `NEG_DIRECCION`, `NEG_DESCRIPCION`, `NEG_DESCRIPCION_ENG`, `NEG_RESPONSABLE`, `NEG_ESTATUS`, `NEG_ETIQUETAS`, `NEG_ETIQUETAS_ING`, `NEG_FECHA`, `NEG_MAP`, `ID_SUBCATEGORIA`, `exposicion_ID_EXPOSICION`) VALUES
(22, 'Cabocantina', 'cabo@gmail.com', 624, 'Centro', 'Enrique segoviano', 'Enrique segoviano en ingles', 'Pedro', 'A', 'restaurante', 'restauran', '2019-05-24 13:03:35', 'https://goo.gl/maps/PUnGD2L2PMJ3acEf8', 27, 1),
(23, 'Pan di bacco', 'bacco@', 624, 'Centro', 'asdasdasdasdasd ', 'asdasdasdasdasd ingles', 'Franchesco', 'A', 'restaurante,italiano', 'restaurant,italian', '2019-05-24 13:16:51', NULL, 26, 3),
(24, 'Cabo build pc', 'build@gmail.com', 624, 'na', 'Con mas de 15 años en el mercado, somos tu mejor opcion, contamos con garantias de hasta 6 meses en nuestros trabajos, somos tu mejor opcion c: pvto', 'des ing', 'Carlos', 'A', 'Soporte, Computadoras, mantenimiento', 'pc ing', '2019-05-25 14:25:30', 'https://goo.gl/maps/uqTcoBuB66VDfP5y8', 39, 2),
(25, 'Squid Roe', 'squid@.com', 624, 'na', 'des', 'des ing', 'Squid', 'A', 'Antro', 'Antro ing', '2019-05-25 14:27:52', 'https://goo.gl/maps/CRkaJLZN1UAAv8Fx7', 41, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `publicacion`
--

DROP TABLE IF EXISTS `publicacion`;
CREATE TABLE IF NOT EXISTS `publicacion` (
  `ID_PUBLICACION` int(11) NOT NULL AUTO_INCREMENT,
  `PUB_TITULO` varchar(45) DEFAULT NULL,
  `PUB_TITULO_ING` varchar(45) NOT NULL,
  `PUB_DETALLE` varchar(45) DEFAULT NULL,
  `PUB_DETALLE_ING` varchar(45) NOT NULL,
  `PUB_FECHA` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `PUB_VIDEO` varchar(100) DEFAULT NULL,
  `negocios_ID_NEGOCIO` int(11) NOT NULL,
  `galeria_ID_GALERIA` int(11) NOT NULL,
  PRIMARY KEY (`ID_PUBLICACION`),
  KEY `fk_PUBLICACION_negocios1_idx` (`negocios_ID_NEGOCIO`),
  KEY `fk_publicacion_galeria1_idx` (`galeria_ID_GALERIA`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `publicacion`
--

INSERT INTO `publicacion` (`ID_PUBLICACION`, `PUB_TITULO`, `PUB_TITULO_ING`, `PUB_DETALLE`, `PUB_DETALLE_ING`, `PUB_FECHA`, `PUB_VIDEO`, `negocios_ID_NEGOCIO`, `galeria_ID_GALERIA`) VALUES
(44, 'Nuevo area', 'New area', 'asdasasdasdasd', 'asdasdasdasdasd ingles', '2019-05-24 13:10:48', NULL, 22, 21),
(45, 'Promociones 2x1', 'Promocionts 2x1', 'En platos mayores a $500', 'En platos mayores a $500 ingles', '2019-05-25 23:26:10', NULL, 22, 23),
(46, 'Publicacion media', 'Media', 'media', 'media', '2019-05-26 00:53:49', NULL, 25, 26);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subcategoria`
--

DROP TABLE IF EXISTS `subcategoria`;
CREATE TABLE IF NOT EXISTS `subcategoria` (
  `ID_SUBCATEGORIA` int(11) NOT NULL AUTO_INCREMENT,
  `SUB_NOMBRE` varchar(30) DEFAULT NULL,
  `SUB_NOMBRE_ING` varchar(50) NOT NULL,
  `SUB_ESTATUS` varchar(2) DEFAULT NULL,
  `ID_CATEGORIA` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_SUBCATEGORIA`),
  KEY `ID_CATEGORIA_idx` (`ID_CATEGORIA`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `subcategoria`
--

INSERT INTO `subcategoria` (`ID_SUBCATEGORIA`, `SUB_NOMBRE`, `SUB_NOMBRE_ING`, `SUB_ESTATUS`, `ID_CATEGORIA`) VALUES
(24, 'Medicos', 'Medics', 'A', 59),
(25, 'Transporte', 'Transport', 'A', 59),
(26, 'Italianos', 'Italians', 'A', 60),
(27, 'Mexicanos', 'Mexicans', 'A', 60),
(28, 'Chinos', 'Chinese', 'A', 60),
(29, 'Japonese', 'Japanese', 'A', 60),
(30, 'Taquerías', 'Tacos', 'A', 60),
(31, 'Cafeterías', 'Coffe', 'A', 60),
(32, 'Snacks', 'Snacks', 'A', 60),
(33, 'Ropa', 'Clothes', 'A', 61),
(34, 'Regalos', 'Gifs', 'A', 61),
(35, 'Tiendas', 'Stores', 'A', 61),
(36, 'Artesanias', 'Artesanies', 'A', 61),
(37, 'Farmacias', 'Pharmacies', 'A', 61),
(38, 'Financieros', 'Finances', 'A', 59),
(39, 'Tecnicos', 'Technicals', 'A', 59),
(40, 'Bares', 'Bars', 'A', 62),
(41, 'Antros', 'NightClub', 'A', 62),
(42, 'Sportbar', 'Sportbar', 'A', 62),
(43, 'Rockbar', 'Rockbar', 'A', 62),
(44, 'Terraza', 'Roof sky', 'A', 62),
(45, 'Actividades acuaticas', 'Water activities', 'A', 63),
(46, 'Actividades terrestres', 'Ground activities', 'A', 63),
(47, 'Actividades aereas', '', 'A', 63),
(48, 'Cultura', 'Culture', 'A', 63),
(49, 'Eventos', 'Events', 'A', 63);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `caracteristicas`
--
ALTER TABLE `caracteristicas`
  ADD CONSTRAINT `fk_caracteristicas_negocios1` FOREIGN KEY (`negocios_ID_NEGOCIO`) REFERENCES `negocios` (`ID_NEGOCIO`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `galeria`
--
ALTER TABLE `galeria`
  ADD CONSTRAINT `ID_NEGOCIO` FOREIGN KEY (`ID_NEGOCIO`) REFERENCES `negocios` (`ID_NEGOCIO`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `negocios`
--
ALTER TABLE `negocios`
  ADD CONSTRAINT `ID_SUBCATEGORIA` FOREIGN KEY (`ID_SUBCATEGORIA`) REFERENCES `subcategoria` (`ID_SUBCATEGORIA`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_negocios_exposicion1` FOREIGN KEY (`exposicion_ID_EXPOSICION`) REFERENCES `exposicion` (`ID_EXPOSICION`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `publicacion`
--
ALTER TABLE `publicacion`
  ADD CONSTRAINT `fk_PUBLICACION_negocios1` FOREIGN KEY (`negocios_ID_NEGOCIO`) REFERENCES `negocios` (`ID_NEGOCIO`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_publicacion_galeria1` FOREIGN KEY (`galeria_ID_GALERIA`) REFERENCES `galeria` (`ID_GALERIA`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  ADD CONSTRAINT `ID_CATEGORIA` FOREIGN KEY (`ID_CATEGORIA`) REFERENCES `categorias` (`ID_CATEGORIA`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
