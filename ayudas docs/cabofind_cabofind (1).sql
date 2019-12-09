-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 25-05-2019 a las 15:17:06
-- Versión del servidor: 5.6.39-83.1
-- Versión de PHP: 7.2.7

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

CREATE TABLE `caracteristicas` (
  `ID_CARACTERISTICAS` int(11) NOT NULL,
  `CAR_NOMBRE` varchar(45) DEFAULT NULL,
  `CAR_NOMBRE_ENG` varchar(45) DEFAULT NULL,
  `CAR_ESTATUS` varchar(45) DEFAULT NULL,
  `CAR_FECHA` timestamp NULL DEFAULT NULL,
  `negocios_ID_NEGOCIO` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

CREATE TABLE `categorias` (
  `ID_CATEGORIA` int(11) NOT NULL,
  `CAT_NOMBRE` varchar(30) DEFAULT NULL,
  `CAT_ESTATUS` varchar(2) DEFAULT NULL,
  `CAT_URL` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`ID_CATEGORIA`, `CAT_NOMBRE`, `CAT_ESTATUS`, `CAT_URL`) VALUES
(59, 'Servicios', 'A', 'categoria.php'),
(60, 'Restaurantes', 'A', 'restaurantes.php'),
(61, 'Compras', 'A', 'compras.php'),
(62, 'Vida nocturna', 'A', 'vida_nocturna_php'),
(63, 'Descubre', 'A', 'descubre.php');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exposicion`
--

CREATE TABLE `exposicion` (
  `ID_EXPOSICION` int(11) NOT NULL,
  `EXP_NIVEL` varchar(25) NOT NULL,
  `EXP_FECHA_ALTA` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `EXP_FECHA_CADUCIDAD` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `exposicion`
--

INSERT INTO `exposicion` (`ID_EXPOSICION`, `EXP_NIVEL`, `EXP_FECHA_ALTA`, `EXP_FECHA_CADUCIDAD`) VALUES
(7, 'Baja', '2019-05-24 13:02:01', ''),
(8, 'Media', '2019-05-24 13:02:01', ''),
(9, 'Alta', '2019-05-24 13:02:07', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `galeria`
--

CREATE TABLE `galeria` (
  `ID_GALERIA` int(11) NOT NULL,
  `GAL_FOTO` varchar(255) DEFAULT NULL,
  `GAL_TIPO` varchar(255) DEFAULT NULL,
  `GAL_ESTATUS` varchar(2) DEFAULT NULL,
  `ID_NEGOCIO` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `galeria`
--

INSERT INTO `galeria` (`ID_GALERIA`, `GAL_FOTO`, `GAL_TIPO`, `GAL_ESTATUS`, `ID_NEGOCIO`) VALUES
(21, 'https://cdn.pixabay.com/photo/2016/03/09/16/50/city-street-1246870_960_720.jpg', 'Publicacion', 'A', 22),
(22, 'https://images.pexels.com/photos/556416/pexels-photo-556416.jpeg', 'Logo', 'A', 22),
(23, 'https://images.pexels.com/photos/449627/pexels-photo-449627.jpeg', 'Galeria', 'A', 22),
(24, 'https://cdn.pixabay.com/photo/2016/03/09/16/50/city-street-1246870_960_720.jpg', 'Banner', 'A', 22),
(25, 'https://scontent-dfw5-2.xx.fbcdn.net/v/t1.0-9/59565711_812470582485062_3520869496107565056_n.png?_nc_cat=109&_nc_ht=scontent-dfw5-2.xx&oh=3847a25d8f8a2ed4ce843d30f0aab5c8&oe=5D54AAD7', 'Logo', 'A', 24),
(26, 'https://scontent-dfw5-2.xx.fbcdn.net/v/t1.0-9/11813421_10153390625562211_7426069060619207316_n.jpg?_nc_cat=107&_nc_ht=scontent-dfw5-2.xx&oh=b026650712bc6fb692f2490b2f0ccfc8&oe=5D6248DB', 'Logo', 'A', 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `negocios`
--

CREATE TABLE `negocios` (
  `ID_NEGOCIO` int(11) NOT NULL,
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
  `exposicion_ID_EXPOSICION` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `negocios`
--

INSERT INTO `negocios` (`ID_NEGOCIO`, `NEG_NOMBRE`, `NEG_CORREO`, `NEG_TEL`, `NEG_DIRECCION`, `NEG_DESCRIPCION`, `NEG_DESCRIPCION_ENG`, `NEG_RESPONSABLE`, `NEG_ESTATUS`, `NEG_ETIQUETAS`, `NEG_ETIQUETAS_ING`, `NEG_FECHA`, `NEG_MAP`, `ID_SUBCATEGORIA`, `exposicion_ID_EXPOSICION`) VALUES
(22, 'Cabocantina', 'cabo@gmail.com', 624, 'Centro', 'Enrique segoviano', 'Enrique segoviano en ingles', 'Pedro', 'A', 'restaurante', 'restaurant', '2019-05-24 13:03:35', 'https://goo.gl/maps/PUnGD2L2PMJ3acEf8', 27, 8),
(23, 'Pan di bacco', 'bacco@', 624, 'Centro', 'asdasdasdasdasd ', 'asdasdasdasdasd ingles', 'Franchesco', 'A', 'restaurante,italiano', 'restaurant,italian', '2019-05-24 13:16:51', NULL, 26, 9),
(24, 'Cabo build pc', 'build@gmail.com', 624, 'na', 'Con mas de 15 años en el mercado, somos tu mejor opcion, contamos con garantias de hasta 6 meses en nuestros trabajos, somos tu mejor opcion c: pvto', 'des ing', 'Carlos', 'A', 'Soporte, Computadoras, mantenimiento', 'pc ing', '2019-05-25 14:25:30', 'https://goo.gl/maps/uqTcoBuB66VDfP5y8', 39, 9),
(25, 'Squid Roe', 'squid@.com', 624, 'na', 'des', 'des ing', 'Squid', 'A', 'Antro', 'Antro ing', '2019-05-25 14:27:52', 'https://goo.gl/maps/CRkaJLZN1UAAv8Fx7', 41, 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `publicacion`
--

CREATE TABLE `publicacion` (
  `ID_PUBLICACION` int(11) NOT NULL,
  `PUB_TITULO` varchar(45) DEFAULT NULL,
  `PUB_TITULO_ING` varchar(45) NOT NULL,
  `PUB_DETALLE` varchar(45) DEFAULT NULL,
  `PUB_DETALLE_ING` varchar(45) NOT NULL,
  `PUB_FECHA` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `PUB_VIDEO` varchar(100) DEFAULT NULL,
  `negocios_ID_NEGOCIO` int(11) NOT NULL,
  `galeria_ID_GALERIA` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `publicacion`
--

INSERT INTO `publicacion` (`ID_PUBLICACION`, `PUB_TITULO`, `PUB_TITULO_ING`, `PUB_DETALLE`, `PUB_DETALLE_ING`, `PUB_FECHA`, `PUB_VIDEO`, `negocios_ID_NEGOCIO`, `galeria_ID_GALERIA`) VALUES
(44, 'Nuevo area', 'New area', 'asdasasdasdasd', 'asdasdasdasdasd ingles', '2019-05-24 13:10:48', NULL, 22, 21);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subcategoria`
--

CREATE TABLE `subcategoria` (
  `ID_SUBCATEGORIA` int(11) NOT NULL,
  `SUB_NOMBRE` varchar(30) DEFAULT NULL,
  `SUB_ESTATUS` varchar(2) DEFAULT NULL,
  `ID_CATEGORIA` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `subcategoria`
--

INSERT INTO `subcategoria` (`ID_SUBCATEGORIA`, `SUB_NOMBRE`, `SUB_ESTATUS`, `ID_CATEGORIA`) VALUES
(24, 'Medicos', 'A', 59),
(25, 'Transporte', 'A', 59),
(26, 'Italianos', 'A', 60),
(27, 'Mexicanos', 'A', 60),
(28, 'Chinos', 'A', 60),
(29, 'Japonese', 'A', 60),
(30, 'Taquerías', 'A', 60),
(31, 'Cafeterías', 'A', 60),
(32, 'Snacks', 'A', 60),
(33, 'Ropa', 'A', 61),
(34, 'Regalos', 'A', 61),
(35, 'Tiendas', 'A', 61),
(36, 'Artesanias', 'A', 61),
(37, 'Farmacias', 'A', 61),
(38, 'Financieros', 'A', 59),
(39, 'Tecnicos', 'A', 59),
(40, 'Bares', 'A', 62),
(41, 'Antros', 'A', 62),
(42, 'Sportbar', 'A', 62),
(43, 'Rockbar', 'A', 62),
(44, 'Terraza', 'A', 62),
(45, 'Actividades acuaticas', 'A', 63),
(46, 'Actividades terrestres', 'A', 63),
(47, 'Actividades aereas', 'A', 63),
(48, 'Cultura', 'A', 63),
(49, 'Eventos', 'A', 63);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `caracteristicas`
--
ALTER TABLE `caracteristicas`
  ADD PRIMARY KEY (`ID_CARACTERISTICAS`),
  ADD KEY `fk_caracteristicas_negocios1_idx` (`negocios_ID_NEGOCIO`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`ID_CATEGORIA`);

--
-- Indices de la tabla `exposicion`
--
ALTER TABLE `exposicion`
  ADD PRIMARY KEY (`ID_EXPOSICION`);

--
-- Indices de la tabla `galeria`
--
ALTER TABLE `galeria`
  ADD PRIMARY KEY (`ID_GALERIA`),
  ADD KEY `ID_NEGOCIO_idx` (`ID_NEGOCIO`);

--
-- Indices de la tabla `negocios`
--
ALTER TABLE `negocios`
  ADD PRIMARY KEY (`ID_NEGOCIO`),
  ADD KEY `ID_SUBCATEGORIA_idx` (`ID_SUBCATEGORIA`),
  ADD KEY `fk_negocios_exposicion1_idx` (`exposicion_ID_EXPOSICION`);

--
-- Indices de la tabla `publicacion`
--
ALTER TABLE `publicacion`
  ADD PRIMARY KEY (`ID_PUBLICACION`),
  ADD KEY `fk_PUBLICACION_negocios1_idx` (`negocios_ID_NEGOCIO`),
  ADD KEY `fk_publicacion_galeria1_idx` (`galeria_ID_GALERIA`);

--
-- Indices de la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  ADD PRIMARY KEY (`ID_SUBCATEGORIA`),
  ADD KEY `ID_CATEGORIA_idx` (`ID_CATEGORIA`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `caracteristicas`
--
ALTER TABLE `caracteristicas`
  MODIFY `ID_CARACTERISTICAS` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `ID_CATEGORIA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT de la tabla `exposicion`
--
ALTER TABLE `exposicion`
  MODIFY `ID_EXPOSICION` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `galeria`
--
ALTER TABLE `galeria`
  MODIFY `ID_GALERIA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `negocios`
--
ALTER TABLE `negocios`
  MODIFY `ID_NEGOCIO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `publicacion`
--
ALTER TABLE `publicacion`
  MODIFY `ID_PUBLICACION` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  MODIFY `ID_SUBCATEGORIA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

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
