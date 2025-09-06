-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-09-2025 a las 05:53:29
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `farmacia_db`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_medicamentos_por_especialidad` (IN `nombre_espec` VARCHAR(50))   BEGIN
    SELECT m.cod_medicamento, m.descripcion, m.marca, m.stock
    FROM medicamento m
    INNER JOIN especialidad e ON m.cod_espec = e.cod_espec
    WHERE e.nombre = nombre_espec;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_medicamentos_por_tipo_nombre` (IN `nombre_tipo` VARCHAR(100))   BEGIN
    SELECT m.cod_medicamento, m.descripcion, m.marca, m.stock
    FROM medicamento m
    INNER JOIN tipo_medic t ON m.cod_tipo_med = t.cod_tipo_med
    WHERE t.descripcion = nombre_tipo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_medicamentos_stock_bajo` (IN `p_min_stock` INT)   BEGIN
    SELECT m.cod_medicamento, m.descripcion, m.marca, m.presentacion,
           m.stock, m.precio_venta_uni
    FROM medicamento m
    WHERE m.stock < p_min_stock;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_orden_compra`
--

CREATE TABLE `detalle_orden_compra` (
  `nro_orden_c` int(10) UNSIGNED NOT NULL,
  `cod_medicamento` int(10) UNSIGNED NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(12,2) NOT NULL,
  `montouni` decimal(12,2) GENERATED ALWAYS AS (`precio`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_orden_compra`
--

INSERT INTO `detalle_orden_compra` (`nro_orden_c`, `cod_medicamento`, `descripcion`, `cantidad`, `precio`) VALUES
(1, 1, 'Aspirina 500mg', 100, 0.40),
(1, 2, 'Jarabe Pediátrico Antigripal', 50, 4.50),
(2, 3, 'Crema Antialérgica', 80, 7.50),
(2, 4, 'Paracetamol 500mg', 120, 0.35);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_orden_vta`
--

CREATE TABLE `detalle_orden_vta` (
  `nro_orden_vta` int(10) UNSIGNED NOT NULL,
  `cod_medicamento` int(10) UNSIGNED NOT NULL,
  `descripcion_med` varchar(255) DEFAULT NULL,
  `cantidad_requerida` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_orden_vta`
--

INSERT INTO `detalle_orden_vta` (`nro_orden_vta`, `cod_medicamento`, `descripcion_med`, `cantidad_requerida`) VALUES
(1, 1, 'Aspirina 500mg', 20),
(1, 6, 'Ibuprofeno 400mg', 10),
(2, 2, 'Jarabe Pediátrico Antigripal', 5),
(2, 3, 'Crema Antialérgica', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidad`
--

CREATE TABLE `especialidad` (
  `cod_espec` int(10) UNSIGNED NOT NULL,
  `descripcion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `especialidad`
--

INSERT INTO `especialidad` (`cod_espec`, `descripcion`) VALUES
(1, 'Cardiología'),
(2, 'Pediatría'),
(3, 'Dermatología'),
(4, 'Neurología');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `laboratorio`
--

CREATE TABLE `laboratorio` (
  `cod_lab` int(10) UNSIGNED NOT NULL,
  `razon_social` varchar(255) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `contacto` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `laboratorio`
--

INSERT INTO `laboratorio` (`cod_lab`, `razon_social`, `direccion`, `telefono`, `email`, `contacto`) VALUES
(1, 'Lab Farma SA', 'Av. Principal 123', '987654321', 'contacto@labfarma.com', 'Juan Pérez'),
(2, 'BioSalud SAC', 'Jr. Salud 456', '912345678', 'info@biosalud.com', 'María Gómez'),
(3, 'PharmaPlus', 'Calle Comercio 789', '976543210', 'ventas@pharmaplus.com', 'Carlos Ruiz');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicamento`
--

CREATE TABLE `medicamento` (
  `cod_medicamento` int(10) UNSIGNED NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `fecha_fabricacion` date DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `presentacion` varchar(255) DEFAULT NULL,
  `stock` int(10) UNSIGNED DEFAULT 0,
  `precio_venta_uni` decimal(12,2) DEFAULT 0.00,
  `precio_venta_pres` decimal(12,2) DEFAULT 0.00,
  `cod_tipo_med` int(10) UNSIGNED DEFAULT NULL,
  `marca` varchar(100) DEFAULT NULL,
  `cod_espec` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `medicamento`
--

INSERT INTO `medicamento` (`cod_medicamento`, `descripcion`, `fecha_fabricacion`, `fecha_vencimiento`, `presentacion`, `stock`, `precio_venta_uni`, `precio_venta_pres`, `cod_tipo_med`, `marca`, `cod_espec`) VALUES
(1, 'Aspirina 500mg', '2023-01-15', '2026-01-15', 'Caja 20 tabletas', 200, 0.50, 8.00, 1, 'Bayer', 1),
(2, 'Jarabe Pediátrico Antigripal', '2023-03-10', '2025-03-10', 'Frasco 120ml', 150, 5.00, 0.00, 2, 'MediKids', 2),
(3, 'Crema Antialérgica', '2023-05-20', '2025-05-20', 'Tubo 50g', 100, 8.00, 0.00, 3, 'SkinCare', 3),
(4, 'Paracetamol 500mg', '2023-07-01', '2026-07-01', 'Caja 10 cápsulas', 300, 0.40, 6.00, 4, 'Genéricos Perú', 2),
(5, 'Vitamina B12 Inyectable', '2023-08-01', '2027-08-01', 'Ampolla 1ml', 120, 2.50, 0.00, 3, 'NutriPlus', 4),
(6, 'Ibuprofeno 400mg', '2023-04-12', '2026-04-12', 'Caja 20 tabletas', 180, 0.70, 12.00, 1, 'MK', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden_compra`
--

CREATE TABLE `orden_compra` (
  `nro_orden_c` int(10) UNSIGNED NOT NULL,
  `fecha_emision` date NOT NULL,
  `situacion` varchar(50) DEFAULT NULL,
  `total` decimal(12,2) DEFAULT 0.00,
  `cod_lab` int(10) UNSIGNED DEFAULT NULL,
  `nro_factura_prov` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `orden_compra`
--

INSERT INTO `orden_compra` (`nro_orden_c`, `fecha_emision`, `situacion`, `total`, `cod_lab`, `nro_factura_prov`) VALUES
(1, '2024-01-15', 'Pendiente', 500.00, 1, 'FAC-001'),
(2, '2024-02-20', 'Completada', 800.00, 2, 'FAC-002');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden_venta`
--

CREATE TABLE `orden_venta` (
  `nro_orden_vta` int(10) UNSIGNED NOT NULL,
  `fecha_emision` date NOT NULL,
  `motivo` varchar(255) DEFAULT NULL,
  `situacion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `orden_venta`
--

INSERT INTO `orden_venta` (`nro_orden_vta`, `fecha_emision`, `motivo`, `situacion`) VALUES
(1, '2024-03-10', 'Venta mostrador', 'Completada'),
(2, '2024-04-05', 'Pedido en línea', 'Pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_medic`
--

CREATE TABLE `tipo_medic` (
  `cod_tipo_med` int(10) UNSIGNED NOT NULL,
  `descripcion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_medic`
--

INSERT INTO `tipo_medic` (`cod_tipo_med`, `descripcion`) VALUES
(1, 'Tableta'),
(2, 'Jarabe'),
(3, 'Inyectable'),
(4, 'Cápsula');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `detalle_orden_compra`
--
ALTER TABLE `detalle_orden_compra`
  ADD PRIMARY KEY (`nro_orden_c`,`cod_medicamento`),
  ADD KEY `fk_detalle_compra_medicamento` (`cod_medicamento`);

--
-- Indices de la tabla `detalle_orden_vta`
--
ALTER TABLE `detalle_orden_vta`
  ADD PRIMARY KEY (`nro_orden_vta`,`cod_medicamento`),
  ADD KEY `fk_detalle_vta_medicamento` (`cod_medicamento`);

--
-- Indices de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  ADD PRIMARY KEY (`cod_espec`);

--
-- Indices de la tabla `laboratorio`
--
ALTER TABLE `laboratorio`
  ADD PRIMARY KEY (`cod_lab`);

--
-- Indices de la tabla `medicamento`
--
ALTER TABLE `medicamento`
  ADD PRIMARY KEY (`cod_medicamento`),
  ADD KEY `fk_medicamento_tipo_med` (`cod_tipo_med`),
  ADD KEY `fk_medicamento_espec` (`cod_espec`);

--
-- Indices de la tabla `orden_compra`
--
ALTER TABLE `orden_compra`
  ADD PRIMARY KEY (`nro_orden_c`),
  ADD KEY `fk_ordencompra_lab` (`cod_lab`);

--
-- Indices de la tabla `orden_venta`
--
ALTER TABLE `orden_venta`
  ADD PRIMARY KEY (`nro_orden_vta`);

--
-- Indices de la tabla `tipo_medic`
--
ALTER TABLE `tipo_medic`
  ADD PRIMARY KEY (`cod_tipo_med`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  MODIFY `cod_espec` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `laboratorio`
--
ALTER TABLE `laboratorio`
  MODIFY `cod_lab` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `medicamento`
--
ALTER TABLE `medicamento`
  MODIFY `cod_medicamento` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `orden_compra`
--
ALTER TABLE `orden_compra`
  MODIFY `nro_orden_c` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `orden_venta`
--
ALTER TABLE `orden_venta`
  MODIFY `nro_orden_vta` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo_medic`
--
ALTER TABLE `tipo_medic`
  MODIFY `cod_tipo_med` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_orden_compra`
--
ALTER TABLE `detalle_orden_compra`
  ADD CONSTRAINT `fk_detalle_compra_medicamento` FOREIGN KEY (`cod_medicamento`) REFERENCES `medicamento` (`cod_medicamento`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_detalle_compra_orden` FOREIGN KEY (`nro_orden_c`) REFERENCES `orden_compra` (`nro_orden_c`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_orden_vta`
--
ALTER TABLE `detalle_orden_vta`
  ADD CONSTRAINT `fk_detalle_vta_medicamento` FOREIGN KEY (`cod_medicamento`) REFERENCES `medicamento` (`cod_medicamento`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_detalle_vta_orden` FOREIGN KEY (`nro_orden_vta`) REFERENCES `orden_venta` (`nro_orden_vta`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `medicamento`
--
ALTER TABLE `medicamento`
  ADD CONSTRAINT `fk_medicamento_espec` FOREIGN KEY (`cod_espec`) REFERENCES `especialidad` (`cod_espec`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_medicamento_tipo_med` FOREIGN KEY (`cod_tipo_med`) REFERENCES `tipo_medic` (`cod_tipo_med`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `orden_compra`
--
ALTER TABLE `orden_compra`
  ADD CONSTRAINT `fk_ordencompra_lab` FOREIGN KEY (`cod_lab`) REFERENCES `laboratorio` (`cod_lab`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
