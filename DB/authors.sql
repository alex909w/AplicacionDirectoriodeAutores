-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 04-04-2025 a las 22:35:21
-- Versión del servidor: 8.3.0
-- Versión de PHP: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `app_sms`
--
DROP DATABASE IF EXISTS `app_sms`;
CREATE DATABASE IF NOT EXISTS `app_sms` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `app_sms`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion_sistema`
--

DROP TABLE IF EXISTS `configuracion_sistema`;
CREATE TABLE IF NOT EXISTS `configuracion_sistema` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave_configuracion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `valor_configuracion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `encriptado` tinyint(1) DEFAULT '0',
  `actualizado_por` int DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clave_configuracion` (`clave_configuracion`),
  KEY `actualizado_por` (`actualizado_por`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracion_sistema`
--

INSERT INTO `configuracion_sistema` (`id`, `clave_configuracion`, `valor_configuracion`, `descripcion`, `encriptado`, `actualizado_por`, `fecha_actualizacion`) VALUES
(1, 'limite_diario_sms', '1000', 'Límite diario de SMS que se pueden enviar', 0, NULL, '2025-03-29 14:51:10'),
(2, 'proveedor_sms_predeterminado', '1', 'ID del proveedor de SMS predeterminado', 0, NULL, '2025-03-29 14:51:10'),
(3, 'correo_notificacion', 'alertas@example.com', 'Email para notificaciones del sistema', 0, NULL, '2025-03-29 14:51:10'),
(4, 'costo_mensaje', '0.032', NULL, 0, NULL, '2025-03-31 04:10:39'),
(5, 'moneda', '$', NULL, 0, NULL, '2025-03-31 04:10:39');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contactos`
--

DROP TABLE IF EXISTS `contactos`;
CREATE TABLE IF NOT EXISTS `contactos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `telefono` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apellido` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `datos_adicionales` json DEFAULT NULL,
  `creado_por` int DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `creado_por` (`creado_por`),
  KEY `idx_contactos_telefono` (`telefono`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contactos`
--

INSERT INTO `contactos` (`id`, `telefono`, `nombre`, `apellido`, `correo`, `datos_adicionales`, `creado_por`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(2, '+50378573605', 'Aristides Alexander Hernandez Valdez', 'Valdez', 'alex909w@hotmail.com', NULL, NULL, '2025-03-30 02:57:49', '2025-03-31 05:11:33'),
(3, '+50378573605', 'Aristides Alexander ', 'Valdez', 'alex909w@hotmail.com', NULL, NULL, '2025-03-31 02:10:57', '2025-03-31 02:10:57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupos_contacto`
--

DROP TABLE IF EXISTS `grupos_contacto`;
CREATE TABLE IF NOT EXISTS `grupos_contacto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creado_por` int DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `creado_por` (`creado_por`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `grupos_contacto`
--

INSERT INTO `grupos_contacto` (`id`, `nombre`, `descripcion`, `creado_por`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(1, 'Varios', 'VIP', NULL, '2025-03-31 02:35:42', '2025-03-31 02:35:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes_enviados`
--

DROP TABLE IF EXISTS `mensajes_enviados`;
CREATE TABLE IF NOT EXISTS `mensajes_enviados` (
  `id` int NOT NULL AUTO_INCREMENT,
  `telefono` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contenido_mensaje` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `plantilla_id` int DEFAULT NULL,
  `variables_usadas` json DEFAULT NULL,
  `estado` enum('pendiente','enviado','fallido','entregado') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'pendiente',
  `mensaje_error` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enviado_por` int DEFAULT NULL,
  `fecha_envio` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_entrega` timestamp NULL DEFAULT NULL,
  `proveedor` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_mensaje_proveedor` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plantilla_id` (`plantilla_id`),
  KEY `enviado_por` (`enviado_por`),
  KEY `idx_mensajes_enviados_estado` (`estado`,`fecha_envio`),
  KEY `idx_mensajes_estado` (`estado`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `mensajes_enviados`
--

INSERT INTO `mensajes_enviados` (`id`, `telefono`, `contenido_mensaje`, `plantilla_id`, `variables_usadas`, `estado`, `mensaje_error`, `enviado_por`, `fecha_envio`, `fecha_entrega`, `proveedor`, `id_mensaje_proveedor`) VALUES
(1, '+50378573605', 'Hola Alexander, bienvenido a nuestro servicio. Estamos encantados de tenerte con nosotros.', 1, '{\"nombre\": \"Alexander\"}', 'enviado', NULL, NULL, '2025-03-31 02:35:13', NULL, NULL, NULL),
(2, '+50378573605', 'Hola Clientes, tenemos una promoción especial del 20% en tu tarjeta terminada en 123468. Válida hasta 30/03.', 2, '{\"fecha\": \"30/03\", \"nombre\": \"Clientes\", \"digitos_tc\": \"123468\"}', 'enviado', NULL, NULL, '2025-03-31 02:37:25', NULL, NULL, NULL),
(3, '+50378573605', 'Hola Clientes, tenemos una promoción especial del 20% en tu tarjeta terminada en 123468. Válida hasta 30/03.', 2, '{\"fecha\": \"30/03\", \"nombre\": \"Clientes\", \"digitos_tc\": \"123468\"}', 'enviado', NULL, NULL, '2025-03-31 02:37:25', NULL, NULL, NULL),
(4, '+50378573605', 'Hola Clientes, tenemos una promoción especial del 20% en tu tarjeta terminada en 123468. Válida hasta 30/03.', 2, '{\"fecha\": \"30/03\", \"nombre\": \"Clientes\", \"digitos_tc\": \"123468\"}', 'enviado', NULL, NULL, '2025-03-31 02:37:30', NULL, NULL, NULL),
(5, '+50378573605', 'Hola Clientes, tenemos una promoción especial del 20% en tu tarjeta terminada en 123468. Válida hasta 30/03.', 2, '{\"fecha\": \"30/03\", \"nombre\": \"Clientes\", \"digitos_tc\": \"123468\"}', 'enviado', NULL, NULL, '2025-03-31 02:37:30', NULL, NULL, NULL),
(6, '+50378573605', 'Hola Alex, tenemos una promoción especial del 20% en tu tarjeta terminada en 653201.2. Válida hasta 29/03.', 2, '{\"fecha\": \"29/03\", \"nombre\": \"Alex\", \"digitos_tc\": \"653201.2\"}', 'entregado', NULL, NULL, '2025-03-31 02:56:29', NULL, NULL, NULL),
(7, '+50378573605', 'Tu código de verificación es 1234568. No lo compartas con nadie.', 3, '{\"codigo\": \"1234568\"}', 'fallido', NULL, NULL, '2025-03-31 02:56:50', NULL, NULL, NULL),
(8, '+50378573605', 'Hola , tenemos una promoción especial del 20% en tu tarjeta terminada en . Válida hasta .', 2, '{\"fecha\": \"\", \"nombre\": \"\", \"digitos_tc\": \"\"}', 'entregado', NULL, NULL, '2025-03-31 03:04:57', NULL, NULL, NULL),
(9, '+50378573605', 'Hola , bienvenido a nuestro servicio. Estamos encantados de tenerte con nosotros.', 1, '{\"nombre\": \"\"}', 'enviado', NULL, NULL, '2025-03-31 03:43:17', NULL, NULL, NULL),
(10, '+50378573605', 'Hola , bienvenido a nuestro servicio. Estamos encantados de tenerte con nosotros.', 1, '{\"nombre\": \"\"}', 'enviado', NULL, NULL, '2025-03-31 03:43:18', NULL, NULL, NULL),
(11, '+50378573605', 'Hola , bienvenido a nuestro servicio. Estamos encantados de tenerte con nosotros. <apellido> <digitos_tc> <Cuenta>', 1, '{\"nombre\": \"\"}', 'enviado', NULL, NULL, '2025-03-31 03:44:01', NULL, NULL, NULL),
(12, '+50378573605', 'Hola , bienvenido a nuestro servicio. Estamos encantados de tenerte con nosotros. <apellido> <digitos_tc> <Cuenta>', 1, '{\"nombre\": \"\"}', 'enviado', NULL, NULL, '2025-03-31 03:44:01', NULL, NULL, NULL),
(13, '+50378573605', 'Hola , bienvenido a nuestro servicio. Estamos encantados de tenerte con nosotros.', 1, '{\"nombre\": \"\"}', 'enviado', NULL, NULL, '2025-03-31 04:14:30', NULL, NULL, NULL),
(14, '+50378573605', 'Hola , bienvenido a nuestro servicio. Estamos encantados de tenerte con nosotros.', 1, '{\"nombre\": \"\"}', 'enviado', NULL, NULL, '2025-03-31 04:14:30', NULL, NULL, NULL),
(15, '+50378573605', 'Hola , bienvenido a nuestro servicio. Estamos encantados de tenerte con nosotros.', 1, '{\"nombre\": \"\"}', 'entregado', NULL, NULL, '2025-03-31 14:09:47', NULL, NULL, NULL),
(16, '+50378573605', 'Hola , bienvenido a nuestro servicio. Estamos encantados de tenerte con nosotros.', 1, '{\"nombre\": \"\"}', 'enviado', NULL, NULL, '2025-03-31 14:10:16', NULL, NULL, NULL),
(17, '+50378573605', 'Hola , bienvenido a nuestro servicio. Estamos encantados de tenerte con nosotros.', 1, '{\"nombre\": \"\"}', 'enviado', NULL, NULL, '2025-03-31 16:20:51', NULL, NULL, NULL),
(18, '+50378573605', 'Hola , tenemos una promoción especial del 20% en tu tarjeta terminada en . Válida hasta .', 2, '{\"fecha\": \"\", \"nombre\": \"\", \"digitos_tc\": \"\"}', 'enviado', NULL, NULL, '2025-04-01 02:13:22', NULL, NULL, NULL),
(19, '+50378573605', 'Hola , tenemos una promoción especial del 20% en tu tarjeta terminada en . Válida hasta .', 2, '{\"fecha\": \"\", \"nombre\": \"\", \"digitos_tc\": \"\"}', 'fallido', NULL, NULL, '2025-04-01 02:13:49', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `miembros_grupo`
--

DROP TABLE IF EXISTS `miembros_grupo`;
CREATE TABLE IF NOT EXISTS `miembros_grupo` (
  `contacto_id` int NOT NULL,
  `grupo_id` int NOT NULL,
  `fecha_agregado` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`contacto_id`,`grupo_id`),
  KEY `grupo_id` (`grupo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `miembros_grupo`
--

INSERT INTO `miembros_grupo` (`contacto_id`, `grupo_id`, `fecha_agregado`) VALUES
(2, 1, '2025-03-31 02:35:57'),
(3, 1, '2025-03-31 02:35:57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plantillas_mensaje`
--

DROP TABLE IF EXISTS `plantillas_mensaje`;
CREATE TABLE IF NOT EXISTS `plantillas_mensaje` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contenido` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `creado_por` int DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `creado_por` (`creado_por`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `plantillas_mensaje`
--

INSERT INTO `plantillas_mensaje` (`id`, `nombre`, `contenido`, `descripcion`, `activo`, `creado_por`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(1, 'Bienvenida', 'Hola <nombre>, bienvenido a nuestro servicio. Estamos encantados de tenerte con nosotros.', 'Mensaje de bienvenida para nuevos usuarios', 1, NULL, '2025-03-29 14:51:10', '2025-03-29 14:51:10'),
(2, 'Promoción', 'Hola <nombre>, tenemos una promoción especial del 20% en tu tarjeta terminada en <digitos_tc>. Válida hasta <fecha>.', 'Mensaje promocional con descuento', 1, NULL, '2025-03-29 14:51:10', '2025-03-29 14:51:10'),
(3, 'Verificación', 'Tu código de verificación es <codigo>. No lo compartas con nadie.', 'Mensaje para verificación de identidad', 1, NULL, '2025-03-29 14:51:10', '2025-03-29 14:51:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores_sms`
--

DROP TABLE IF EXISTS `proveedores_sms`;
CREATE TABLE IF NOT EXISTS `proveedores_sms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `api_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url_base` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `configuracion` json DEFAULT NULL,
  `creado_por` int DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `creado_por` (`creado_por`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `proveedores_sms`
--

INSERT INTO `proveedores_sms` (`id`, `nombre`, `api_key`, `api_secret`, `url_base`, `activo`, `configuracion`, `creado_por`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(1, 'Twilio', 'tu_api_key_aqui', 'tu_api_secret_aqui', 'https://api.twilio.com', 1, '{\"account_sid\": \"tu_account_sid\", \"from_number\": \"+1234567890\"}', NULL, '2025-03-29 14:51:10', '2025-03-29 14:51:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registros_actividad`
--

DROP TABLE IF EXISTS `registros_actividad`;
CREATE TABLE IF NOT EXISTS `registros_actividad` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int DEFAULT NULL,
  `accion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_entidad` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entidad_id` int DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `direccion_ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `agente_usuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_registros_actividad_usuario` (`usuario_id`,`fecha_creacion`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `registros_actividad`
--

INSERT INTO `registros_actividad` (`id`, `usuario_id`, `accion`, `tipo_entidad`, `entidad_id`, `descripcion`, `direccion_ip`, `agente_usuario`, `fecha_creacion`) VALUES
(1, NULL, 'create_template', NULL, NULL, 'Plantilla creada: Alex', '::1', NULL, '2025-03-29 15:17:39'),
(2, NULL, 'create_template', NULL, NULL, 'Plantilla creada: 123', '::1', NULL, '2025-03-29 15:21:24'),
(3, NULL, 'delete_template', NULL, NULL, 'Plantilla eliminada: ID 5', '::1', NULL, '2025-03-29 15:39:27'),
(4, NULL, 'update_variable', NULL, NULL, 'Variable actualizada: nombre', '::1', NULL, '2025-03-29 15:49:37'),
(5, NULL, 'create_contact', NULL, NULL, 'Contacto creado: Aristides Alexander Hernandez Valdez Valdez (+50378573605)', '::1', NULL, '2025-03-29 15:50:17'),
(6, NULL, 'update_template', NULL, NULL, 'Plantilla actualizada: Alex', '::1', NULL, '2025-03-30 02:53:49'),
(7, NULL, 'update_variable', NULL, NULL, 'Variable actualizada: nombre', '::1', NULL, '2025-03-30 02:57:08'),
(8, NULL, 'update_template', NULL, NULL, 'Plantilla actualizada: Alex', '::1', NULL, '2025-03-30 02:57:14'),
(9, NULL, 'delete_contact', NULL, NULL, 'Contacto eliminado: ID 1', '::1', NULL, '2025-03-30 02:57:30'),
(10, NULL, 'create_contact', NULL, NULL, 'Contacto creado: Aristides Alexander Hernandez Valdez Valdez (+50378573605)', '::1', NULL, '2025-03-30 02:57:49'),
(11, NULL, 'update_template', NULL, NULL, 'Plantilla actualizada: Alex', '::1', NULL, '2025-03-31 01:53:22'),
(12, NULL, 'delete_template', NULL, NULL, 'Plantilla eliminada: ID 4', '::1', NULL, '2025-03-31 01:53:27'),
(13, NULL, 'create_variable', NULL, NULL, 'Variable creada: Cuenta', '::1', NULL, '2025-03-31 01:53:58'),
(14, NULL, 'update_contact', NULL, NULL, 'Contacto actualizado: Aristides Alexander Hernandez Valdez Valdez (+50378573605)', '::1', NULL, '2025-03-31 02:05:41'),
(15, NULL, 'update_contact', NULL, NULL, 'Contacto actualizado: Aristides Alexander Hernandez Valdez Valdez (+50378573605)', '::1', NULL, '2025-03-31 02:10:37'),
(16, NULL, 'create_contact', NULL, NULL, 'Contacto creado: Aristides Alexander  Valdez (+50378573605)', '::1', NULL, '2025-03-31 02:10:57'),
(17, NULL, 'send_sms', NULL, NULL, 'Mensaje enviado a +50378573605 usando plantilla ID 1', '::1', NULL, '2025-03-31 02:35:13'),
(18, NULL, 'create_group', NULL, NULL, 'Grupo creado: Varios', '::1', NULL, '2025-03-31 02:35:42'),
(19, NULL, 'add_contacts_to_group', NULL, NULL, 'Se añadieron 2 contactos al grupo 1', '::1', NULL, '2025-03-31 02:35:57'),
(20, NULL, 'send_bulk_sms', NULL, NULL, 'Envío masivo a grupo 1: 2 enviados, 0 fallidos', '::1', NULL, '2025-03-31 02:37:25'),
(21, NULL, 'send_bulk_sms', NULL, NULL, 'Envío masivo a grupo 1: 2 enviados, 0 fallidos', '::1', NULL, '2025-03-31 02:37:30'),
(22, NULL, 'create_group', NULL, NULL, 'Grupo creado: Prueba2', '::1', NULL, '2025-03-31 02:38:50'),
(23, NULL, 'delete_group', NULL, NULL, 'Se eliminó el grupo 2', '::1', NULL, '2025-03-31 02:39:06'),
(24, NULL, 'create_group', NULL, NULL, 'Grupo creado: Prueba 2', '::1', NULL, '2025-03-31 02:43:41'),
(25, NULL, 'update_group', NULL, NULL, 'Se actualizó el grupo 3', '::1', NULL, '2025-03-31 02:43:48'),
(26, NULL, 'add_contacts_to_group', NULL, NULL, 'Se añadieron 2 contactos al grupo 3', '::1', NULL, '2025-03-31 02:43:58'),
(27, NULL, 'delete_group', NULL, NULL, 'Se eliminó el grupo 3', '::1', NULL, '2025-03-31 02:44:10'),
(28, NULL, 'send_sms', NULL, NULL, 'Mensaje enviado a +50378573605 usando plantilla ID 2', '::1', NULL, '2025-03-31 02:56:29'),
(29, NULL, 'send_sms', NULL, NULL, 'Mensaje enviado a +50378573605 usando plantilla ID 3', '::1', NULL, '2025-03-31 02:56:50'),
(30, NULL, 'send_bulk_sms', NULL, NULL, 'Envío masivo a grupo 1: 1 enviados, 1 fallidos', '::1', NULL, '2025-03-31 03:04:57'),
(31, NULL, 'create_variable', NULL, NULL, 'Variable creada: scZSC', '::1', NULL, '2025-03-31 03:17:34'),
(32, NULL, 'update_variable', NULL, NULL, 'Variable actualizada: scZSC', '::1', NULL, '2025-03-31 03:17:43'),
(33, NULL, 'delete_variable', NULL, NULL, 'Variable eliminada: ID 8', '::1', NULL, '2025-03-31 03:17:48'),
(34, NULL, 'create_template', NULL, NULL, 'Plantilla creada: xvxcvx', '::1', NULL, '2025-03-31 03:22:37'),
(35, NULL, 'update_variable', NULL, NULL, 'Variable actualizada: nombre', '::1', NULL, '2025-03-31 03:27:57'),
(36, NULL, 'update_template', NULL, NULL, 'Plantilla actualizada: xvxcvx', '::1', NULL, '2025-03-31 03:28:03'),
(37, NULL, 'update_template', NULL, NULL, 'Plantilla actualizada: xvxcvx', '::1', NULL, '2025-03-31 03:28:13'),
(38, NULL, 'create_template', NULL, NULL, 'Plantilla creada: zcvbcxvb', '::1', NULL, '2025-03-31 03:28:19'),
(39, NULL, 'delete_template', NULL, NULL, 'Plantilla eliminada: ID 7', '::1', NULL, '2025-03-31 03:28:23'),
(40, NULL, 'update_template', NULL, NULL, 'Plantilla actualizada: xvxcvx', '::1', NULL, '2025-03-31 03:28:26'),
(41, NULL, 'delete_template', NULL, NULL, 'Plantilla eliminada: ID 6', '::1', NULL, '2025-03-31 03:28:28'),
(42, NULL, 'update_variable', NULL, NULL, 'Variable actualizada: nombre', '::1', NULL, '2025-03-31 03:28:35'),
(43, NULL, 'create_variable', NULL, NULL, 'Variable creada: zxvcxzcvxzcv', '::1', NULL, '2025-03-31 03:28:44'),
(44, NULL, 'update_variable', NULL, NULL, 'Variable actualizada: zxvcxzcvxzcv', '::1', NULL, '2025-03-31 03:28:49'),
(45, NULL, 'delete_variable', NULL, NULL, 'Variable eliminada: ID 9', '::1', NULL, '2025-03-31 03:28:53'),
(46, NULL, 'create_contact', NULL, NULL, 'Contacto creado: Aristides Alexander Hernandez Valdezxzcvxcv Valdezxzcvzxcvxzcvxzcvx (+50378573605)', '::1', NULL, '2025-03-31 03:29:10'),
(47, NULL, 'update_contact', NULL, NULL, 'Contacto actualizado: Aristides Alexander Hernandez Valdezxzcvxcv fgxh (+50378573605)', '::1', NULL, '2025-03-31 03:29:22'),
(48, NULL, 'delete_contact', NULL, NULL, 'Contacto eliminado: ID 4', '::1', NULL, '2025-03-31 03:29:24'),
(49, NULL, 'create_variable', NULL, NULL, 'Variable creada: asasd', '::1', NULL, '2025-03-31 03:41:58'),
(50, NULL, 'delete_variable', NULL, NULL, 'Variable eliminada: ID 13', '::1', NULL, '2025-03-31 03:42:05'),
(51, NULL, 'create_variable', NULL, NULL, 'Variable creada: nombre1', '::1', NULL, '2025-03-31 03:42:56'),
(52, NULL, 'delete_variable', NULL, NULL, 'Variable eliminada: ID 15', '::1', NULL, '2025-03-31 03:42:59'),
(53, NULL, 'send_bulk_sms', NULL, NULL, 'Envío masivo a grupo 1: 2 enviados, 0 fallidos', '::1', NULL, '2025-03-31 03:43:18'),
(54, NULL, 'send_bulk_sms', NULL, NULL, 'Envío masivo a grupo 1: 2 enviados, 0 fallidos', '::1', NULL, '2025-03-31 03:44:01'),
(55, NULL, 'send_bulk_sms', NULL, NULL, 'Envío masivo a grupo 1: 2 enviados, 0 fallidos', '::1', NULL, '2025-03-31 04:14:30'),
(56, NULL, 'update_contact', NULL, NULL, 'Contacto actualizado: Aristides Alexander Hernandez Valdez Valdez (+50378573605)', '::1', NULL, '2025-03-31 05:11:33'),
(57, NULL, 'send_sms', NULL, NULL, 'Mensaje enviado a +50378573605 usando plantilla ID 1', '::1', NULL, '2025-03-31 14:09:47'),
(58, NULL, 'send_sms', NULL, NULL, 'Mensaje enviado a +50378573605 usando plantilla ID 1', '::1', NULL, '2025-03-31 14:10:16'),
(59, NULL, 'send_sms', NULL, NULL, 'Mensaje enviado a +50378573605 usando plantilla ID 1', '::1', NULL, '2025-03-31 16:20:51'),
(60, NULL, 'update_variable', NULL, NULL, 'Variable actualizada: nombre', '::1', NULL, '2025-03-31 22:07:55'),
(61, NULL, 'send_bulk_sms', NULL, NULL, 'Envío masivo a grupo 1: 1 enviados, 1 fallidos', '::1', NULL, '2025-04-01 02:13:22'),
(62, NULL, 'send_sms', NULL, NULL, 'Mensaje enviado a +50378573605 usando plantilla ID 2', '::1', NULL, '2025-04-01 02:13:49'),
(63, NULL, 'create_template', NULL, NULL, 'Plantilla creada: fgjghj', '::1', NULL, '2025-04-01 16:41:52'),
(64, NULL, 'delete_template', NULL, NULL, 'Plantilla eliminada: ID 8', '::1', NULL, '2025-04-01 16:41:57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contrasena` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apellido` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `rol` enum('admin','usuario') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'usuario',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `correo_electronico` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `proveedor_auth` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_proveedor` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  UNIQUE KEY `correo` (`correo`),
  UNIQUE KEY `idx_correo_electronico` (`correo_electronico`),
  KEY `idx_usuarios_nombre_correo` (`nombre_usuario`,`correo`),
  KEY `idx_usuarios_correo` (`correo`),
  KEY `idx_usuarios_nombre_usuario` (`nombre_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre_usuario`, `contrasena`, `correo`, `nombre`, `apellido`, `activo`, `rol`, `fecha_creacion`, `fecha_actualizacion`, `correo_electronico`, `proveedor_auth`, `id_proveedor`) VALUES
(4, 'admin', 'Admin2025', 'admin@appsms.com', 'Administrador', 'Sistema', 1, 'admin', '2025-03-31 14:36:14', '2025-03-31 15:39:51', NULL, NULL, NULL),
(15, 'Alex Valdez', '', '', NULL, NULL, 1, 'usuario', '2025-03-31 22:44:07', '2025-03-31 22:44:07', 'alex909w@gmail.com', 'google', '109470194202344299224');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `variables`
--

DROP TABLE IF EXISTS `variables`;
CREATE TABLE IF NOT EXISTS `variables` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ejemplo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creado_por` int DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `creado_por` (`creado_por`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `variables`
--

INSERT INTO `variables` (`id`, `nombre`, `descripcion`, `ejemplo`, `creado_por`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(1, 'nombre', 'Nombre del destinatario', 'Juan Antonio', NULL, '2025-03-29 14:51:10', '2025-03-31 22:07:55'),
(2, 'apellido', 'Apellido del destinatario', 'Pérez', NULL, '2025-03-29 14:51:10', '2025-03-29 14:51:10'),
(3, 'digitos_tc', 'Últimos 4 dígitos de la tarjeta de crédito', '1234', NULL, '2025-03-29 14:51:10', '2025-03-29 14:51:10'),
(4, 'fecha', 'Fecha actual en formato DD/MM/YYYY', '01/01/2023', NULL, '2025-03-29 14:51:10', '2025-03-29 14:51:10'),
(5, 'monto', 'Monto de la transacción', '100.00', NULL, '2025-03-29 14:51:10', '2025-03-29 14:51:10'),
(6, 'codigo', 'Código de verificación o promocional', 'ABC123', NULL, '2025-03-29 14:51:10', '2025-03-29 14:51:10'),
(7, 'Cuenta', 'Cuenta banacaria', '0125423', NULL, '2025-03-31 01:53:58', '2025-03-31 01:53:58');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `configuracion_sistema`
--
ALTER TABLE `configuracion_sistema`
  ADD CONSTRAINT `configuracion_sistema_ibfk_1` FOREIGN KEY (`actualizado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `contactos`
--
ALTER TABLE `contactos`
  ADD CONSTRAINT `contactos_ibfk_1` FOREIGN KEY (`creado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `grupos_contacto`
--
ALTER TABLE `grupos_contacto`
  ADD CONSTRAINT `grupos_contacto_ibfk_1` FOREIGN KEY (`creado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `mensajes_enviados`
--
ALTER TABLE `mensajes_enviados`
  ADD CONSTRAINT `mensajes_enviados_ibfk_1` FOREIGN KEY (`plantilla_id`) REFERENCES `plantillas_mensaje` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `mensajes_enviados_ibfk_2` FOREIGN KEY (`enviado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `miembros_grupo`
--
ALTER TABLE `miembros_grupo`
  ADD CONSTRAINT `miembros_grupo_ibfk_1` FOREIGN KEY (`contacto_id`) REFERENCES `contactos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `miembros_grupo_ibfk_2` FOREIGN KEY (`grupo_id`) REFERENCES `grupos_contacto` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `plantillas_mensaje`
--
ALTER TABLE `plantillas_mensaje`
  ADD CONSTRAINT `plantillas_mensaje_ibfk_1` FOREIGN KEY (`creado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `proveedores_sms`
--
ALTER TABLE `proveedores_sms`
  ADD CONSTRAINT `proveedores_sms_ibfk_1` FOREIGN KEY (`creado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `registros_actividad`
--
ALTER TABLE `registros_actividad`
  ADD CONSTRAINT `registros_actividad_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `variables`
--
ALTER TABLE `variables`
  ADD CONSTRAINT `variables_ibfk_1` FOREIGN KEY (`creado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;
--
-- Base de datos: `authors`
--
DROP DATABASE IF EXISTS `authors`;
CREATE DATABASE IF NOT EXISTS `authors` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `authors`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `author`
--

DROP TABLE IF EXISTS `author`;
CREATE TABLE IF NOT EXISTS `author` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `genre_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `genre_id` (`genre_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `author`
--

INSERT INTO `author` (`id`, `name`, `phone`, `birth_date`, `genre_id`) VALUES
(1, 'Gabriel García Márquez', '2222-1111', '1927-03-06', 1),
(2, 'Jorge Luis Borges', '2222-2222', '1899-08-24', 2),
(3, 'Isabel Allende', '2222-3333', '1942-08-02', 1),
(4, 'Julio Cortázar', '2222-4444', '1914-08-26', 1),
(5, 'Pablo Neruda', '2222-5555', '1904-07-12', 2),
(6, 'Mario Vargas Llosa', '2222-6666', '1936-03-28', 3),
(7, 'Octavio Paz', '2222-7777', '1914-03-31', 2),
(8, 'Carlos Fuentes', '2222-8888', '1928-11-11', 1),
(9, 'Gabriela Mistral', '2222-9999', '1889-04-07', 2),
(10, 'Rubén Darío', '7777-1111', '1867-01-18', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autor`
--

DROP TABLE IF EXISTS `autor`;
CREATE TABLE IF NOT EXISTS `autor` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(10) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `genero_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `genero_id` (`genero_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `autor`
--

INSERT INTO `autor` (`id`, `nombre`, `telefono`, `fecha_nacimiento`, `genero_id`) VALUES
(1, 'Gabriel García Márquez', '2222-1111', '1927-03-06', 1),
(2, 'Jorge Luis Borges', '2222-2222', '1899-08-24', 2),
(3, 'Isabel Allende', '2222-3333', '1942-08-02', 1),
(4, 'Julio Cortázar', '2222-4444', '1914-08-26', 1),
(5, 'Pablo Neruda', '2222-5555', '1904-07-12', 2),
(6, 'Mario Vargas Llosa', '2222-6666', '1936-03-28', 3),
(7, 'Octavio Paz', '2222-7777', '1914-03-31', 2),
(8, 'Carlos Fuentes', '2222-8888', '1928-11-11', 1),
(9, 'Gabriela Mistral', '2222-9999', '1889-04-07', 2),
(10, 'Rubén Darío', '7777-1111', '1867-01-18', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genero_literario`
--

DROP TABLE IF EXISTS `genero_literario`;
CREATE TABLE IF NOT EXISTS `genero_literario` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `genero_literario`
--

INSERT INTO `genero_literario` (`id`, `nombre`) VALUES
(1, 'Novela'),
(2, 'Poesía'),
(3, 'Ensayo'),
(4, 'Ciencia Ficción'),
(5, 'Fantasía'),
(6, 'Drama'),
(7, 'Terror'),
(8, 'Biografía'),
(9, 'Historia'),
(10, 'Aventura');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `literary_genre`
--

DROP TABLE IF EXISTS `literary_genre`;
CREATE TABLE IF NOT EXISTS `literary_genre` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `literary_genre`
--

INSERT INTO `literary_genre` (`id`, `name`) VALUES
(1, 'Novela'),
(2, 'Poesía'),
(3, 'Ensayo'),
(4, 'Ciencia Ficción'),
(5, 'Fantasía'),
(6, 'Drama'),
(7, 'Terror'),
(8, 'Biografía'),
(9, 'Historia'),
(10, 'Aventura');
--
-- Base de datos: `fundacion_pablo_tesak`
--
DROP DATABASE IF EXISTS `fundacion_pablo_tesak`;
CREATE DATABASE IF NOT EXISTS `fundacion_pablo_tesak` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;
USE `fundacion_pablo_tesak`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia_beneficiarios`
--

DROP TABLE IF EXISTS `asistencia_beneficiarios`;
CREATE TABLE IF NOT EXISTS `asistencia_beneficiarios` (
  `ID_Beneficiario` int NOT NULL AUTO_INCREMENT,
  `Nombre_Completo` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `Genero` enum('Masculino','Femenino') CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `Edad` int NOT NULL,
  `ID_Institucion` int NOT NULL,
  `Grado` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `Seccion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `ID_Eje` int NOT NULL,
  PRIMARY KEY (`ID_Beneficiario`),
  KEY `ID_Institucion` (`ID_Institucion`),
  KEY `ID_Eje` (`ID_Eje`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `asistencia_beneficiarios`
--

INSERT INTO `asistencia_beneficiarios` (`ID_Beneficiario`, `Nombre_Completo`, `Genero`, `Edad`, `ID_Institucion`, `Grado`, `Seccion`, `ID_Eje`) VALUES
(1, 'erick alexander aguilar beltrán', 'Masculino', 13, 1, '7', '', 14),
(2, 'jeremy alexander díaz avelar', 'Masculino', 13, 1, '7', '', 14),
(3, 'ernesto antonio hernández chica', 'Masculino', 13, 1, '7', '', 14),
(4, 'enrique eliel sandoval lopez', 'Masculino', 13, 1, '7', '', 14),
(5, 'joshua steven aguilar cerna', 'Masculino', 13, 1, '7', '', 14),
(6, 'luis enrique panameño duarte', 'Masculino', 13, 1, '7', '', 14);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia_ejes`
--

DROP TABLE IF EXISTS `asistencia_ejes`;
CREATE TABLE IF NOT EXISTS `asistencia_ejes` (
  `ID_Eje` int NOT NULL AUTO_INCREMENT,
  `ID_Programa` int NOT NULL,
  `Nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `Descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci,
  `Fecha_Creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Eje`),
  KEY `ID_Programa` (`ID_Programa`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `asistencia_ejes`
--

INSERT INTO `asistencia_ejes` (`ID_Eje`, `ID_Programa`, `Nombre`, `Descripcion`, `Fecha_Creacion`) VALUES
(4, 17, 'Artes Visuales', 'Los estudiantes se expresan a través de las artes plásticas y sus manifestaciones: el dibujo, los titeres, la arqueología y el modelado en arcilla.', '2025-02-11 19:46:45'),
(5, 17, 'Escritura Creativa', 'es un espacio que estimula en los estudiantes su capacidad de comunicar y crear.', '2025-02-11 19:48:19'),
(6, 17, 'Música Creativa', 'los participantes, pueden estimular su creatividad, autoestima, desarrollo psicomotriz, audición, ciudado vocal, DICCIÓN, así como la conservación de la cultura musical salvadoreña y el desarrollo de sus habilidades musicales.', '2025-02-11 19:52:11'),
(7, 16, 'Mundo Mesoamericano', 'es un espacio con las condiciones pedagógicas necesarias para consolidar una identidad cultural colectiva basada en la riqueza heredada de los pueblos originarios de mesoamérica.', '2025-02-11 19:56:02'),
(8, 16, 'Imaginarium', 'generamos experiencias que integran los elementos pedagógicos teóricos y prácticos necesarios para el foemnto de la creatividad e imaginación a través DE CREACIÓN y manipulación de lo títeres.', '2025-02-11 20:16:44'),
(12, 16, 'Centro Geografico', 'promovemos la respomsabilidad con el medio ambiente.', '2025-02-11 20:45:16'),
(13, 18, 'Matinée', '', '2025-02-11 20:48:01'),
(14, 18, 'Sociodramas', '', '2025-02-11 20:48:12'),
(15, 18, 'Teatro Para Mi Escuela', '', '2025-02-11 20:48:25'),
(16, 18, 'Grupos Invitados', '', '2025-02-11 20:48:37'),
(17, 18, 'Batucada', '', '2025-02-11 20:48:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia_instituciones`
--

DROP TABLE IF EXISTS `asistencia_instituciones`;
CREATE TABLE IF NOT EXISTS `asistencia_instituciones` (
  `ID_Institucion` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `Distrito` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `Departamento` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `Año` year NOT NULL,
  `Docente` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `Tel_Celular` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `Tel_Fijo` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `Direccion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `Grado` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `Tipo` enum('Escuela','ONG','Colegio','Grupo de Trabajo','Otro') CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `Descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci,
  `Fecha_Registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Institucion`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `asistencia_instituciones`
--

INSERT INTO `asistencia_instituciones` (`ID_Institucion`, `Nombre`, `Distrito`, `Departamento`, `Año`, `Docente`, `Tel_Celular`, `Tel_Fijo`, `Direccion`, `Grado`, `Tipo`, `Descripcion`, `Fecha_Registro`) VALUES
(1, 'Centro Escolar Esteban Aliet', '', '', '0000', '', NULL, NULL, '', '', 'Escuela', NULL, '2025-02-11 22:48:21'),
(3, 'asdasd', 'asd', 'asd', '2025', 'asd', 'asd', 'asd', 'asd', 'asd', 'Escuela', 'asd', '2025-02-12 17:28:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia_programas`
--

DROP TABLE IF EXISTS `asistencia_programas`;
CREATE TABLE IF NOT EXISTS `asistencia_programas` (
  `ID_Programa` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `Descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci,
  `Fecha_Creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Programa`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `asistencia_programas`
--

INSERT INTO `asistencia_programas` (`ID_Programa`, `Nombre`, `Descripcion`, `Fecha_Creacion`) VALUES
(16, 'Componente Cultural', 'Espacio para la promoción y preservación de la cultura en la comunidad', '2025-02-11 17:59:40'),
(17, 'Escuela De Creatividad', 'Espacio de aprendizaje creativo', '2025-02-11 18:00:39'),
(18, 'Artes Escénicas', 'Programa dedicado al desarrollo de las artes escénicas en la Fundación Pablo Tesak', '2025-02-11 18:01:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia_registro`
--

DROP TABLE IF EXISTS `asistencia_registro`;
CREATE TABLE IF NOT EXISTS `asistencia_registro` (
  `ID_Registro` int NOT NULL AUTO_INCREMENT,
  `ID_Visita` int NOT NULL,
  `ID_Beneficiario` int NOT NULL,
  `Asistio` enum('Si','No') CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `Observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci,
  PRIMARY KEY (`ID_Registro`),
  KEY `ID_Visita` (`ID_Visita`),
  KEY `ID_Beneficiario` (`ID_Beneficiario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia_reportes`
--

DROP TABLE IF EXISTS `asistencia_reportes`;
CREATE TABLE IF NOT EXISTS `asistencia_reportes` (
  `ID_Reporte` int NOT NULL AUTO_INCREMENT,
  `ID_Programa` int NOT NULL,
  `ID_Eje` int DEFAULT NULL,
  `ID_Tema` int DEFAULT NULL,
  `ID_Visita` int DEFAULT NULL,
  `Fecha_Generacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `Descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci,
  PRIMARY KEY (`ID_Reporte`),
  KEY `ID_Programa` (`ID_Programa`),
  KEY `ID_Eje` (`ID_Eje`),
  KEY `ID_Tema` (`ID_Tema`),
  KEY `ID_Visita` (`ID_Visita`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia_temas`
--

DROP TABLE IF EXISTS `asistencia_temas`;
CREATE TABLE IF NOT EXISTS `asistencia_temas` (
  `ID_Tema` int NOT NULL AUTO_INCREMENT,
  `ID_Eje` int NOT NULL,
  `Nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `Descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci,
  `Fecha_Creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Tema`),
  KEY `ID_Eje` (`ID_Eje`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `asistencia_temas`
--

INSERT INTO `asistencia_temas` (`ID_Tema`, `ID_Eje`, `Nombre`, `Descripcion`, `Fecha_Creacion`) VALUES
(8, 4, 'Tema 1', '', '2025-02-11 16:09:15'),
(9, 4, 'Tema 2', '', '2025-02-11 16:09:26'),
(10, 5, 'Tema 1.1', '', '2025-02-11 16:09:53'),
(11, 5, 'Tema 2.2', '', '2025-02-11 16:10:17'),
(12, 14, 'Tema 1 Hagamos Teatro', '', '2025-02-11 16:18:20'),
(13, 14, 'Tema 2 Escribamos Teatro', '', '2025-02-11 16:18:38'),
(14, 14, 'Tema 3 Ensayamos Teatro', '', '2025-02-11 16:18:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia_visitas`
--

DROP TABLE IF EXISTS `asistencia_visitas`;
CREATE TABLE IF NOT EXISTS `asistencia_visitas` (
  `ID_Visita` int NOT NULL AUTO_INCREMENT,
  `ID_Tema` int NOT NULL,
  `ID_Institucion` int NOT NULL,
  `Fecha_Visita` date NOT NULL,
  `Descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci,
  PRIMARY KEY (`ID_Visita`),
  KEY `ID_Tema` (`ID_Tema`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `asistencia_visitas`
--

INSERT INTO `asistencia_visitas` (`ID_Visita`, `ID_Tema`, `ID_Institucion`, `Fecha_Visita`, `Descripcion`) VALUES
(1, 12, 1, '2025-02-12', ''),
(2, 12, 1, '2025-02-13', ''),
(3, 13, 3, '2025-02-01', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia_visitas_beneficiarios`
--

DROP TABLE IF EXISTS `asistencia_visitas_beneficiarios`;
CREATE TABLE IF NOT EXISTS `asistencia_visitas_beneficiarios` (
  `ID_Visita_Beneficiario` int NOT NULL AUTO_INCREMENT,
  `ID_Visita` int NOT NULL,
  `ID_Beneficiario` int NOT NULL,
  PRIMARY KEY (`ID_Visita_Beneficiario`),
  KEY `ID_Visita` (`ID_Visita`),
  KEY `ID_Beneficiario` (`ID_Beneficiario`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `asistencia_visitas_beneficiarios`
--

INSERT INTO `asistencia_visitas_beneficiarios` (`ID_Visita_Beneficiario`, `ID_Visita`, `ID_Beneficiario`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 2, 1),
(8, 2, 2),
(9, 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bajas_equipos`
--

DROP TABLE IF EXISTS `bajas_equipos`;
CREATE TABLE IF NOT EXISTS `bajas_equipos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `marca` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `tamano` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `ubicacion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `imagenes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci,
  `motivo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `estado` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `disposicion` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecha_baja` datetime DEFAULT CURRENT_TIMESTAMP,
  `codigo_equipo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `bajas_equipos`
--

INSERT INTO `bajas_equipos` (`id`, `codigo`, `descripcion`, `marca`, `tamano`, `ubicacion`, `imagenes`, `motivo`, `estado`, `disposicion`, `fecha_baja`, `codigo_equipo`) VALUES
(1, 'BJA11042008001', 'MONITOR LED MODELO AOC', 'AOC', '19\"', 'ESCUELA DE CREATIVIDAD', '[\"AKYG21A001657_Monitos_de_Escritorio_0.jpeg\",\"AKYG21A001657_Monitos_de_Escritorio_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-02 21:10:35', 'AKYG21A001657'),
(2, 'BJA11042008002', 'MONITOR LCD MODELO DELL E1910F', 'DELL', '19\" ', 'OFICINA DE MUNDO MESOAMERICANO', '[\"CN-0T437R-72872-082-CGJS_MITOR_DE_ESCRITORIO_0.jpeg\",\"CN-0T437R-72872-082-CGJS_MITOR_DE_ESCRITORIO_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-02 21:10:35', 'CN-0T437R-72872-082-CGJS'),
(3, 'BJA11042008003', 'MONITOR MODELO DELL 1707FP', 'DELL', '17\"', 'ESCUELA DE CREATIVIDAD', '[\"CN-0CC280-71618-695-CNDT_MONITOR_DE_ESCRITORIO_0.jpeg\",\"CN-0CC280-71618-695-CNDT_MONITOR_DE_ESCRITORIO_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-02 21:17:04', 'CN-0CC280-71618-695-CNDT'),
(4, 'BJA11042008004', ' MONITOR MODELO DELL E2011HC', 'DELL', '19\" ', 'ESCUELA DE CREATIVIDAD', '[\"CN-02H2VM-64180-23U-3GEU_MONITOR_DE_ESCRITORIO_0.jpeg\",\"CN-02H2VM-64180-23U-3GEU_MONITOR_DE_ESCRITORIO_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-02 21:20:09', 'CN-02H2VM-64180-23U-3GEU'),
(5, 'BJA11042008005', 'MONITOR MODELO L705', 'HIUNDAI', '20\"', 'ESCUELA DE CREATIVIDAD', '[\"L17A0D080_MONITOR_DE_ESCRITORIO_0.jpeg\",\"L17A0D080_MONITOR_DE_ESCRITORIO_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-02 00:00:00', 'L17A0D080'),
(6, 'BJA11042008006', ' MONITOR DELL', 'DELL', '18\"', 'ESCUELA DE CREATIVIDAD', '[\"CN-0KU311-64180-78L-05CM__MONITOR_NEC_MULTISYNC_MODELO_LCD1850E_0.jpeg\",\"CN-0KU311-64180-78L-05CM__MONITOR_NEC_MULTISYNC_MODELO_LCD1850E_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-02 00:00:00', 'CN-0KU311-64180-78L-05CM'),
(7, 'BJA11042008007', 'MONITOR HYUNDAI MODELO L90D+', 'HYUNDAI', '19', 'IMAGINARIUM', '[\"Q19GSASG5A917204_MONITOR_HYUNDAI_MODELO_L90D__0.jpeg\",\"Q19GSASG5A917204_MONITOR_HYUNDAI_MODELO_L90D__1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-02 22:00:10', 'Q19GSASG5A917204'),
(10, 'BJA11042008008', 'MONITOR NEC', 'NEC', '22\"', 'TEATRO YULKUIKAT', '[\"NO_APLICA_MONITOR_DELL_MODELO_E228WFPC_0.jpeg\",\"NO_APLICA_MONITOR_DELL_MODELO_E228WFPC_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-02 00:00:00', 'LCD1850E'),
(11, 'BJA11042008009', ' MONITOR DELL', 'DELL', '22\"', 'ESCUELA DE CREATIVIDAD', '[\"CN-0G433H-74445-97H-BBHL_MONITOR_HYUNDAI_IMAGEQUEST_MODELO_L70S_0.jpeg\",\"CN-0G433H-74445-97H-BBHL_MONITOR_HYUNDAI_IMAGEQUEST_MODELO_L70S_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-02 00:00:00', 'CN-0G433H-74445-97H-BBHL'),
(12, 'BJA11042008010', 'SISTEMA DE ALMACENAMIENTO PROMISE PEGASUS R4 CON MULTIBAHÍAS', 'PROMISE TECHNOLOGY INC.', '4 BAHÍAS', 'COMUNICACIONES', '[\"M74H11A1940067_SISTEMA_DE_ALMACENAMIENTO_PROMISE_PEGASUS_R4_CON_MULTIBAH__AS_0.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 14:05:40', 'M74H11A1940067'),
(13, 'BJA11042008011', 'FUENTE DE PODER GIGABYTE GP-P750GM (80 PLUS GOLD)', 'GIGABYTE', '750W', 'COMUNICACIONES', '[\"SN2023G010883_FUENTE_DE_PODER_GIGABYTE_GP-P750GM__80_PLUS_GOLD__0.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 14:07:00', 'SN2023G010883'),
(14, 'BJA11042008012', 'PUNTO DE ACCESO WI-FI  WI-FI DAP-2330A1', 'D-LINK', 'DIMENSIONES APROXIMADAS DE UN PUNTO DE ACCESO ESTÁNDAR', 'IMAGINARIUM', '[\"RU7F17F00080_PUNTO_DE_ACCESO_WI-FI_0.jpeg\",\"RU7F17F00080_PUNTO_DE_ACCESO_WI-FI_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 00:00:00', 'RZJF1F7000080'),
(15, 'BJA11042008013', 'BATERÍA DE LITIO PARA PORTÁTIL', 'HP', 'CAPACIDAD 3470MAH, 11.55VDC', 'GESTION Y COOPERACION', '[\"ZT5GTA4C2F8048K_BATER__A_DE_LITIO_PARA_PORT__TIL_0.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 14:14:22', 'ZT5GTA4C2F8048K'),
(16, 'BJA11042008014', 'CONVERTIDOR/ADAPTADOR DE SEÑAL VIDEO/HDMI', 'BLACKMAGIC', 'APROXIMADO A 15X10 CM', 'COMUNICACIONES', '[\"SIN_SERIE_CONVERTIDOR_ADAPTADOR_DE_SE__AL_VIDEO_HDMI_0.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 14:15:52', 'SIN SERIE'),
(17, 'BJA11042008015', 'BATERÍAS DE PLOMO-ÁCIDO SELLADAS PARA USO GENERAL', 'LEOCH Y FORZA', 'DIMENSIONES ESTÁNDAR 12V 7.0AH Y 9.0AH', 'UPS DE ÁREAS', '[\"SIN_SERIE_BATERIAS_BATER__AS_DE_PLOMO-__CIDO_SELLADAS_PARA_USO_GENERAL_0.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 14:23:48', 'SIN SERIE BATERIAS'),
(18, 'BJA11042008016', 'LAMINADORA PERSONAL HEATSEAL H425', 'ACCO BRANDS', 'COMPACTO', 'ESCUELA DE CREATIVIDAD', '[\"XI13992X_LAMINADORA_PERSONAL_HEATSEAL_H425_0.jpeg\",\"XI13992X_LAMINADORA_PERSONAL_HEATSEAL_H425_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 14:25:46', 'XI13992X'),
(19, 'BJA11042008017', 'CALCULADORA ELECTRÓNICA QS-2760H', 'SHARP', 'MEDIANO', 'ADMINISTRACIÓN', '[\"5D015754_CALCULADORA_ELECTR__NICA_QS-2760H_0.jpeg\",\"5D015754_CALCULADORA_ELECTR__NICA_QS-2760H_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 14:27:28', '5D015754'),
(20, 'BJA11042008018', 'CÁMARA CANON EOS REBEL XS', 'CANON', 'COMPACTA', 'COMUNICACIONES', '[\"DS12691_C__MARA_CANON_EOS_REBEL_XS_0.jpeg\",\"DS12691_C__MARA_CANON_EOS_REBEL_XS_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 14:32:28', 'DS12691'),
(21, 'BJA11042008019', 'CÁMARA CANON EOS REBEL XS', 'CANON', 'COMPACTA', 'COMUNICACIONES', '[\"DS126291-2_C__MARA_CANON_EOS_REBEL_XS_0.jpeg\",\"DS126291-2_C__MARA_CANON_EOS_REBEL_XS_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 14:41:46', 'DS126291-2'),
(22, 'BJA11042008020', 'REPRODUCTOR DE DVD/CD MOD DVP-N5725P', 'SONY', 'ESTÁNDAR DE EQUIPO DE MESA', 'TEATRO YULKUIKAT', '[\"2564201_REPRODUCTOR_DE_DVD_CD_0.jpeg\",\"2564201_REPRODUCTOR_DE_DVD_CD_1.jpeg\"]', 'OBSOLESCENCIA', 'FUERA_DE_USO', 'ELIMINACION', '2024-12-03 00:00:00', '2564201'),
(23, 'BJA11042008021', 'IMPRESORA MULTIFUNCIÓN PIXMA G2100', 'CANON', 'MULTIFUNCIÓN', 'MUNDO MESOAMERICANO OFICINA', '[\"SIN_SERIE_CANON_IMPRESORA_MULTIFUNCI__N_PIXMA_0.jpeg\",\"SIN_SERIE_CANON_IMPRESORA_MULTIFUNCI__N_PIXMA_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 00:00:00', 'KKRN97434'),
(24, 'BJA11042008022', 'MPRESORA DE TINTA CONTINUA HP315', 'HP', 'ESTÁNDAR', 'TEATRO YULKUIKAT', '[\"CN0776M300_MPRESORA_DE_TINTA_CONTINUA_0.jpeg\",\"CN0776M300_MPRESORA_DE_TINTA_CONTINUA_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 15:22:00', 'CN0776M300'),
(25, 'BJA11042008023', 'IMPRESORA MULTIFUNCIÓN L575', 'EPSON', 'ESTÁNDAR', 'ESCUELA DE CREATIVIDAD', '[\"W98Y084087_IMPRESORA_MULTIFUNCI__N_0.jpeg\",\"W98Y084087_IMPRESORA_MULTIFUNCI__N_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 15:23:07', 'W98Y084087'),
(26, 'BJA11042008024', 'IMPRESORA MULTIFUNCIÓN L210', 'EPSON', 'ESTÁNDAR', 'CENTRO DE CAPACITACIONES', '[\"S25K698327_IMPRESORA_MULTIFUNCI__N_0.jpeg\",\"S25K698327_IMPRESORA_MULTIFUNCI__N_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 15:24:05', 'S25K698327'),
(27, 'BJA11042008025', 'CANON MULTIFUNCIÓN G4110', 'CANON', 'ESTÁNDAR PARA OFICINA', 'ADMINISTRACIÓN', '[\"K10472_CANON_MULTIFUNCI__N_G4100_0.jpeg\",\"K10472_CANON_MULTIFUNCI__N_G4100_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 15:29:35', 'KLMV03310'),
(28, 'BJA11042008026', 'BROTHER MFC-9970CDW', 'BROTHER', 'ESTÁNDAR PARA OFICINA', 'DIRECCIÓN EJECUTIVA', '[\"U62513J2J356758_BROTHER_MFC-9970CDW_0.jpeg\",\"U62513J2J356758_BROTHER_MFC-9970CDW_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 15:31:12', 'U62513J2J356758'),
(29, 'BJA11042008027', 'IMAC MODELO A1419', 'APPLE', '21.5 \"', 'COMUNICACIONES', '[\"BHPV014845-13_IMAC_MODELO_A1311_0.jpeg\",\"BHPV014845-13_IMAC_MODELO_A1311_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 15:45:59', 'CO2K3ATVDNMP'),
(30, 'BJA11042008028', 'IMAC MODELO A1418', 'APPLE', '21.5\"', 'COMUNICACIONES', '[\"A1418_IMAC_MODELO_A1418_0.jpeg\",\"A1418_IMAC_MODELO_A1418_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 16:08:01', 'D25K526ADNML'),
(31, 'BJA11042008029', 'IMAC MODELO A1311', 'APPLE', '21.5\"', 'COMUNICACIONES', '[\"A1418-2_IMAC_MODELO_A1418_0.jpeg\",\"A1418-2_IMAC_MODELO_A1418_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 16:08:55', 'W80285K9DAS'),
(32, 'BJA11042008030', 'PROYECTOR LCD EPSON H546A', 'EPSON', 'ESTÁNDAR', 'TEATRO YULKUIKAT', '[\"TMF4306155L_PROYECTOR_LCD_EPSON_0.jpeg\",\"TMF4306155L_PROYECTOR_LCD_EPSON_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 16:17:18', 'TM4F3601554'),
(33, 'BJA11042008031', 'PROYECTOR LCD EPSON H355A', 'EPSON', 'ESTÁNDAR', 'COMUNICACIONES', '[\"MTF030261L_PROYECTOR_LCD_EPSON_H355A_0.jpeg\",\"MTF030261L_PROYECTOR_LCD_EPSON_H355A_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 16:18:49', 'MTEFOZ030261L'),
(34, 'BJA11042008032', 'PROYECTOR MULTIMEDIA  M322W', 'NEC', 'ESTÁNDAR', 'COMUNICACIONES', '[\"NP-M322W_PROYECTOR_MULTIMEDIA__M322W_0.jpeg\",\"NP-M322W_PROYECTOR_MULTIMEDIA__M322W_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 16:20:06', 'NP-M322W'),
(35, 'BJA11042008033', 'TERMÓMETROS DE TEMPERATURA DIGITAL', 'VARIAS', 'ESTÁNDAR', 'USOS VARIOS', '[\"VARIOS-3_TERM__METROS_DE_TEMPERATURA_DIGITAL_0.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 17:10:54', 'VARIOS-3'),
(36, 'BJA11042008034', 'MOUSE PARA DESKTOP', 'VARIAS', 'ESTÁNDAR', 'VARIAS AREAS', '[\"VARIOS-6_MOUSE_PARA_DESKTOP_0.jpeg\",\"VARIOS-6_MOUSE_PARA_DESKTOP_1.jpeg\",\"VARIOS-6_MOUSE_PARA_DESKTOP_2.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 17:12:16', 'VARIOS-6'),
(37, 'BJA11042008035', 'DISCOS DURO MECANICOS', 'VARIAS', '3.5\"', 'VARIAS AREAS', '[\"VARIOS-9_DISCOS_DURO_MECANICOS_0.jpeg\",\"VARIOS-9_DISCOS_DURO_MECANICOS_1.jpeg\",\"VARIOS-9_DISCOS_DURO_MECANICOS_2.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 17:13:21', 'VARIOS-9'),
(38, 'BJA11042008036', 'CARGADOR DE BATERIA DE CAMARA', 'CANON', '8.3V 0.58 A', 'COMUNICACIONES', '[\"LC-E10_CARGADOR_DE_BATERIA_DE_CAMARA_0.jpeg\",\"LC-E10_CARGADOR_DE_BATERIA_DE_CAMARA_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 17:15:36', 'LC-E10'),
(39, 'BJA11042008037', 'MICROPROCESADORES, RAM ADAPTADORES SD Y GRÁFICAS.', 'VARIAS', 'ESTÁNDAR', 'VARIAS AREAS', '[\"VARIOS-33_MICROPROCESADORES__RAM_ADAPTADORES_SD_Y_GR__FICAS._0.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 17:17:10', 'VARIOS-33'),
(40, 'BJA11042008038', 'UPS NT751', 'FORZA', 'ESTÁNDAR', 'UPS DE ÁREAS', '[\"190422500287_UPS_NT751_0.jpeg\",\"190422500287_UPS_NT751_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 17:58:04', '190422500287'),
(41, 'BJA11042008039', 'UPS CDP', 'CDP', 'ESTÁNDAR', 'ESCUELA DE CREATIVIDAD', '[\"CDP_UPS_CDP_0.jpeg\",\"CDP_UPS_CDP_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 18:50:42', 'CDP'),
(42, 'BJA11042008040', 'UPS NT-511', 'APC', 'ESTÁNDAR', 'ESCUELA DE CREATIVIDAD', '[\"180112500151_UPS_APC_0.jpeg\",\"180112500151_UPS_APC_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 18:53:13', '180112500151'),
(43, 'BJA11042008041', 'UPS 800', 'FORZA', 'ESTÁNDAR', 'COMUNICACIONES', '[\"9B2105A12755_UPS_FORZA_0.jpeg\",\"9B2105A12755_UPS_FORZA_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 18:55:33', '9B2105A12755'),
(45, 'BJA11042008042', 'PANTALLA LCD', 'SAMASUN', '50\"', 'CENTRO DE CAPACITACIONES', '[\"UN50AU8000_PANTALLA_LCD_0.jpeg\",\"UN50AU8000_PANTALLA_LCD_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 19:03:57', 'UN50AU8000'),
(46, 'BJA11042008043', 'PANTALLA LCD', 'AOC', '32\"', 'ESCUELA DE CREATIVIDAD', '[\"LE32S5970_PANTALLA_LCD_0.jpeg\",\"LE32S5970_PANTALLA_LCD_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 19:07:35', 'LE32S5970'),
(47, 'BJA11042008044', 'RADIOS', 'MOTOROLA', 'ESTÁNDAR', 'VIGILANCIA', '[\"SIN_SERIE-4_RADIOS_0.jpeg\",\"SIN_SERIE-4_RADIOS_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 19:10:01', 'SIN SERIE-4'),
(48, 'BJA11042008045', 'RADIO Y CARGADOR', 'MOTOROLA', 'ESTÁNDAR', 'TEATRO YULKUIKAT', '[\"PR015182_RADIO_Y_CARGADOR_0.jpeg\",\"PR015182_RADIO_Y_CARGADOR_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 19:11:26', 'PR015182'),
(49, 'BJA11042008046', '(DOCK STATIONS) PARA LAPTOPS', 'DELL', 'ESTÁNDAR', 'ESCUELA DE CREATIVIDAD', '[\"246812240097__DOCK_STATIONS__PARA_LAPTOPS_0.jpeg\",\"246812240097__DOCK_STATIONS__PARA_LAPTOPS_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 19:14:31', '246812240097'),
(50, 'BJA11042008047', 'CARGADORES PARA LAPTOPS DELL', 'DELL', 'ESTÁNDAR', 'ESCUELA DE CREATIVIDAD', '[\"S_N-1_CARGADORES_PARA_LAPTOPS_DELL_0.jpeg\",\"S_N-1_CARGADORES_PARA_LAPTOPS_DELL_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 19:16:26', 'S/N-1'),
(51, 'BJA11042008048', 'TECLADO', 'LOGI', 'ESTÁNDAR', 'ADMINISTRACIÓN', '[\"S_N-2_TECLADO_0.jpeg\",\"S_N-2_TECLADO_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 19:17:33', 'S/N-2'),
(52, 'BJA11042008049', 'TECLADOS DE MAN', 'APPLE', 'ESTÁNDAR', 'COMUNICACIONES', '[\"S_N-3_TECLADOS_DE_MAN_0.jpeg\",\"S_N-3_TECLADOS_DE_MAN_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 19:18:26', 'S/N-3'),
(53, 'BJA11042008050', 'TECLADOS DE ESCRITORIO', 'RLIP', 'ESTÁNDAR', 'ESCUELA DE CREATIVIDAD', '[\"SN-123_TECLADOS_DE_ESCRITORIO_0.jpeg\",\"SN-123_TECLADOS_DE_ESCRITORIO_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 19:20:37', 'SN-123'),
(54, 'BJA11042008051', 'TECLA DE ESCRITORIO', 'RLIP', 'ESTÁNDAR', 'ESCUELA DE CREATIVIDAD', '[\"S_N-1234_TECLA_DE_ESCRITORIO_0.jpeg\",\"S_N-1234_TECLA_DE_ESCRITORIO_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 19:22:24', 'S/N-1234'),
(55, 'BJA11042008052', 'TECLADOS DE ESCRITORIO', 'TOUCH', 'ESTÁNDAR', 'ADMINISTRACIÓN', '[\"WKM3153KB_TECLADOS_DE_ESCRITORIO_0.jpeg\",\"WKM3153KB_TECLADOS_DE_ESCRITORIO_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 19:23:57', 'WKM3153KB'),
(56, 'BJA11042008053', 'TECLADOS DE ESCRITORIO', 'INLAND', 'ESTÁNDAR', 'COMUNICACIONES', '[\"0602543_TECLADOS_DE_ESCRITORIO_0.jpeg\",\"0602543_TECLADOS_DE_ESCRITORIO_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 19:25:02', '0602543'),
(57, 'BJA11042008054', 'TECLADOS DE ESCRITORIO', 'DELL', 'ESTÁNDAR', 'COMUNICACIONES', '[\"0W7658-37172-65H-0BDS_TECLADOS_DE_ESCRITORIO_0.jpeg\",\"0W7658-37172-65H-0BDS_TECLADOS_DE_ESCRITORIO_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 19:26:13', '0W7658-37172-65H-0BDS'),
(58, 'BJA11042008055', 'TECLADO DE ESCRITORIO INALAMBRICO 2.4G', 'RLIP', 'ESTÁNDAR', 'ADMINISTRACIÓN', '[\"170647_TECLADO_DE_ESCRITORIO_INALAMBRICO_2.4G_0.jpeg\",\"170647_TECLADO_DE_ESCRITORIO_INALAMBRICO_2.4G_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 19:27:23', '170647'),
(59, 'BJA11042008056', 'TECLA DE ESCRITORIO', 'HP', 'ESTÁNDAR', 'TEATRO YULKUIKAT', '[\"435382-001_TECLA_DE_ESCRITORIO_0.jpeg\",\"435382-001_TECLA_DE_ESCRITORIO_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 19:28:32', '435382-001'),
(60, 'BJA11042008057', 'LAPTOP', 'DELL', 'ESTÁNDAR', 'ESCUELA DE CREATIVIDAD', '[\"32776114177_LAPTOP_0.jpeg\",\"32776114177_LAPTOP_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 19:29:33', '32776114177'),
(61, 'BJA11042008058', 'UPS NT-511', 'FORZA', 'ESTANDAR', 'TEATRO', '[\"67bf538ee18cc-WhatsApp Image 2025-02-26 at 11.28.21 AM.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2025-02-25 00:00:00', '191112505430'),
(62, 'BJA11042008059', 'COMPUTADORA LAPTOP', 'DELL', 'ESTÁNDAR', 'ESCUELA DE CREATIVIDAD', '[\"33119121421_COMPUTADORA_LAPTOP_0.jpeg\",\"33119121421_COMPUTADORA_LAPTOP_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 00:00:00', '33119121421'),
(63, 'BJA11042008060', 'COMPUTADORA LAPTOP', 'DELL', 'ESTÁNDAR', 'ESCUELA DE CREATIVIDAD', '[\"3143436045_COMPUTADORA_LAPTOP_0.jpeg\",\"3143436045_COMPUTADORA_LAPTOP_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 19:33:48', '5149036045'),
(64, 'BJA11042008061', 'COMPUTADORA LAPTOP', 'HP', 'ESTÁNDAR', 'IMAGINARIUM', '[\"SN_102_COMPUTADORA_LAPTOP_0.jpeg\",\"SN_102_COMPUTADORA_LAPTOP_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 19:34:40', '5CD7303856'),
(65, 'BJA11042008062', 'COMPUTADORA LAPTOP', 'HP', 'ESTÁNDAR', 'IMAGINARIUM', '[\"SIN_SERIE1234_COMPUTADORA_LAPTOP_0.jpeg\",\"SIN_SERIE1234_COMPUTADORA_LAPTOP_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-03 19:35:18', '5CD730386M'),
(66, 'BJA11042008063', 'DESKTOP', 'DELL', 'ESTÁNDAR', 'ESCUELA DE CREATIVIDAD', '[\"SIN_SERIEX1_DESKTOP_0.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-05 20:07:33', 'J4KVS81'),
(67, 'BJA11042008064', 'DESKTOP', 'DELL', 'ESTÁNDAR', 'ESCUELA DE CREATIVIDAD', '[\"SIN_SERIEX2_DESKTOP_0.jpeg\",\"SIN_SERIEX2_DESKTOP_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-05 20:08:21', 'GFGXTL1'),
(68, 'BJA11042008065', 'DESKTOP', 'DELL', 'ESTÁNDAR', 'ESCUELA DE CREATIVIDAD', '[\"SIN_SERIEX3_DESKTOP_0.jpeg\",\"SIN_SERIEX3_DESKTOP_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-05 20:11:22', '3TVS201'),
(69, 'BJA11042008066', 'DESKTOP', 'DELL', 'ESTÁNDAR', 'TEATRO YULKUIKAT', '[\"SIN_SERIEX4_DESKTOP_0.jpeg\",\"SIN_SERIEX4_DESKTOP_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-05 20:12:12', 'I3VLZD1'),
(70, 'BJA11042008067', 'DESKTOP', 'DELL', 'ESTÁNDAR', 'TEATRO YULKUIKAT', '[\"SIN_SERIEX2_DESKTOP_0.jpeg\\\",\\\"SIN_SERIEX2_DESKTOP_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-05 20:12:54', '2UA3191LJR'),
(71, 'BJA11042008068', 'DESKTOP', 'LENOVO', 'ESTÁNDAR', 'TEATRO YULKUIKAT', '[\"SIN_SERIEX6_DESKTOP_0.jpeg\",\"SIN_SERIEX6_DESKTOP_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-05 20:13:29', '3159H2U'),
(72, 'BJA11042008069', 'DESKTOP', 'DELL', 'ESTÁNDAR', 'IMAGINARIUM', '[\"SIN_SERIEX7_DESKTOP_0.jpeg\",\"SIN_SERIEX7_DESKTOP_1.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2024-12-05 20:14:48', 'FZX6BK1'),
(74, 'BJA11042008070', 'UPS NT-511', 'FORZA', 'ESTÁNDAR', 'Escuela de creatividad', '[\"67bf53b3077ba-WhatsApp Image 2025-02-26 at 11.28.21 AM (1).jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2025-02-25 00:00:00', 'BJA11042008070'),
(102, 'BJA11042008071', 'REPRODUCTOR DE DVD/CD MOD DVL-919', 'PIONEER', 'ESTÁNDAR', 'Escuela de creatividad', '[\"67bf53cb1b2b2-WhatsApp Image 2025-02-26 at 11.28.21 AM (2).jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2025-02-25 00:00:00', 'UGFM005883CC'),
(103, 'BJA11042008072', 'REPRODUCTOR DE DISCO LASER LD-V8000', 'PIONEER', 'ESTÁNDAR', 'Escuela de creatividad', '[\"67bf53df17f38-072.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2025-02-25 00:00:00', 'NB3917200'),
(104, 'BJA11042008073', 'PROYECTOR XG-E3000U', 'SHARP', 'ESTÁNDAR', 'Escuela de creatividad', '[\"67bf53f332572-073.jpeg\"]', 'DAÑO', 'DAÑADO', 'ELIMINACION', '2025-02-25 00:00:00', '805314170');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cajas_chicas`
--

DROP TABLE IF EXISTS `cajas_chicas`;
CREATE TABLE IF NOT EXISTS `cajas_chicas` (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `nombre_caja` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `saldo_inicial` decimal(10,2) NOT NULL,
  `saldo_actual` decimal(10,2) NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `cajas_chicas`
--

INSERT INTO `cajas_chicas` (`id`, `nombre_caja`, `saldo_inicial`, `saldo_actual`, `fecha_creacion`) VALUES
('Caja001', 'Enero del 1 al 15', 2000.00, 0.00, '2025-01-07 16:01:05'),
('Caja002', 'Enero 16 al 31', 2000.00, 0.00, '2025-01-07 16:05:36'),
('Caja003', 'Cajas 1', 2000.00, 1820.00, '2025-01-08 13:48:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

DROP TABLE IF EXISTS `categoria`;
CREATE TABLE IF NOT EXISTS `categoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id`, `nombre`) VALUES
(2, 'Mobiliario y Equipo'),
(3, 'Multimedia'),
(4, 'Informática'),
(5, 'Herramientas'),
(6, 'Otros'),
(9, 'Electrónica');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

DROP TABLE IF EXISTS `inventario`;
CREATE TABLE IF NOT EXISTS `inventario` (
  `ID_Codigo` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `Nombre_Producto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `Cantidad` int NOT NULL,
  `Estado` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `Fecha_Ingreso` date NOT NULL,
  `Tipo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `Encargado` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `Instalacion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `Ubicacion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`ID_Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`ID_Codigo`, `Nombre_Producto`, `Cantidad`, `Estado`, `Fecha_Ingreso`, `Tipo`, `Encargado`, `Instalacion`, `Ubicacion`) VALUES
('FPT110420080001', 'MONITOR LCD', 1, 'Funcional', '2015-01-02', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080002', 'CASE i7 6th GEN 12 RAM', 1, 'Funcional', '2015-01-02', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080003', 'TECLADO MECANICO', 1, 'Funcional', '2018-05-30', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080004', 'MOUSE ', 1, 'Funcional', '2015-01-02', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080005', 'MONITOR LCD', 1, 'Funcional', '2015-01-02', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080006', 'CASE i5 4th 4590 16 RAM', 1, 'Funcional', '2015-01-02', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080007', 'TECLADO MECANICO', 1, 'Funcional', '2015-01-02', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080008', 'MOUSE', 1, 'Funcional', '2015-01-02', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080009', 'LAPTOP i710th GEN. 10750H 24 RAM', 1, 'Funcional', '2021-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'OFICINA DE TEATRO'),
('FPT110420080010', 'MOUSE USB', 1, 'Funcional', '2021-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'OFICINA DE TEATRO'),
('FPT110420080011', 'CARGADOR DE LAPTOP DE 150W', 1, 'Funcional', '2015-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'OFICINA DE TEATRO'),
('FPT110420080012', 'LAPTOP i3 10th GEN. 1005G1 12 RAM', 1, 'Funcional', '2023-01-01', 'INFORMATICA', 'NOHEMY DURAN', 'TEATRO YULKUIKAT', 'OFICINA DE TEATRO'),
('FPT110420080013', 'CARGADOR DE LAPTOP DE 45W', 1, 'Funcional', '2023-01-01', 'INFORMATICA', 'NOEMY DURAM', 'TEATRO YULKUIKAT', 'OFICINA DE TEATRO '),
('FPT110420080014', 'LAPTOP i5 10th GEN. 1035G1 16 RAM', 1, 'Funcional', '2023-01-01', 'INFORMATICA', 'JOSE CALLEJAS', 'TEATRO YULKUIKAT', 'OFICINA DE TEATRO'),
('FPT110420080015', 'CARGADOR DE LAPTOP DE 65W', 1, 'Funcional', '2023-01-01', 'INFORMATICA', 'JOSE CALLEJAS', 'TEATRO YULKUIKAT', 'OFICINA DE TEATRO'),
('FPT110420080016', 'IMPRESORA MULTI.DE COLORES L575 Y CABLE DE ALIMENTACION', 1, 'Funcional', '2015-01-02', 'INFORMATICA', 'JOSE CALLEJAS', 'TEATRO YULKUIKAT', 'OFICINA DE TEATRO'),
('FPT110420080017', 'IMPRESORA MFC-8910DW Y CABLE DE ALIMENTACION', 1, 'Funcional', '2015-01-02', 'INFORMATICA', 'JOSE CALLEJAS', 'TEATRO YULKUIKAT', 'OFICINA DE TEATRO'),
('FPT110420080018', 'LAPTOP i5 10th GEN. 1035G1 16 RAM ', 1, 'Funcional', '2023-01-01', 'INFORMATICA', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'OFICINA ESCUELA DE CREATIVIDAD'),
('FPT110420080019', 'CARGADOR DE LAPTOP 65W', 1, 'Funcional', '2023-01-01', 'INFORMATICA', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'OFICINA ESCUELA DE CREATIVIDAD'),
('FPT110420080020', 'MOUSE INALAMBRICO', 1, 'Funcional', '2023-01-01', 'INFORMATICA', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'OFICINA ESCUELA DE CREATIVIDAD'),
('FPT110420080021', 'IMPRESORA G2100 MULTI. DE COLORES Y CABLE DE ALIMENTACION', 1, 'Funcional', '2022-01-01', 'INFORMATICA', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'OFICINA ESCUELA DE CREATIVIDAD'),
('FPT110420080022', 'MONITOR 23.8\" 29200/00309314', 1, 'Funcional', '2023-01-01', 'INFORMATICA', 'DIMAS RIVAS', 'COMPONENTE CULTURAL', 'OFICINA MUME'),
('FPT110420080023', 'CASE i5 8th GEN. 8400', 1, 'Funcional', '2022-01-01', 'INFORMATICA', 'DIMAS RIVAS', 'COMPONENTE CULTURAL', 'OFICINA MUME'),
('FPT110420080024', 'MOUSE ', 1, 'Funcional', '2022-01-01', 'INFORMATICA', 'DIMAS RIVAS', 'COMPONENTE CULTURAL', 'OFICINA MUME'),
('FPT110420080025', 'TECLADO', 1, 'Funcional', '2022-01-01', 'INFORMATICA', 'DIMAS RIVAS', 'COMPONENTE CULTURAL', 'OFICINA MUME'),
('FPT110420080026', 'IMPRESORA MULTI, INK TANK 315 Y CABLE DE ALIMENTACION', 1, 'Funcional', '2019-01-01', 'INFORMATICA', 'DIMAS RIVAS', 'COMPONENTE CULTURAL', 'OFICINA MUME'),
('FPT110420080027', 'LAPTOP i3 6th GEN. 6006U 12 RAM', 1, 'Funcional', '2018-01-01', 'INFORMATICA', 'DIMAS RIVAS', 'COMPONENTE CULTURAL', 'OFICINA MUME'),
('FPT110420080028', 'CARGADOR DE LAPTOP 51.672 WH', 1, 'Funcional', '2018-01-01', 'INFORMATICA', 'DIMAS RIVAS', 'COMPONENTE CULTURAL', 'OFICINA MUME'),
('FPT110420080029', 'CASE i7 4th GEN. 16 RAM', 1, 'Funcional', '2017-01-01', 'INFORMATICA', 'NOE BARRERA', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080030', 'MONITOR', 1, 'Funcional', '2017-01-01', 'INFORMATICA', 'NOE BARRERA', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080031', 'TECLADO', 1, 'Funcional', '2017-01-01', 'INFORMATICA', 'NOE BARRERA', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080032', 'CASE i5 10th GEN. 16 RAM', 1, 'Funcional', '2023-01-01', 'INFORMATICA', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080033', 'TECLADO', 1, 'Funcional', '2023-01-01', 'INFORMATICA', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080034', 'MOUSE', 1, 'Funcional', '2022-01-01', 'INFORMATICA', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080035', 'PROYECTOR ', 1, 'Funcional', '2019-01-01', 'MULTIMEDIA', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080036', 'LAPTOP N3060 4 RAM', 1, 'Funcional', '2019-01-01', 'INFORMATICA', 'INGRID CERNA', 'COMPONENTE CULTURAL', 'IMAGINARIUM'),
('FPT110420080037', 'CARADOR DE LAPTOP', 1, 'Funcional', '2019-01-01', 'INFORMATICA', 'INGRID CERNA', 'COMPONENTE CULTURAL', 'IMAGINARIUM'),
('FPT110420080038', 'CASE i5 3th GEN 8 RAM', 1, 'Funcional', '2018-01-01', 'INFORMATICA', 'ANTONIO LEMUS', 'COMPONENTE CULTURAL', 'IMAGINARIUM'),
('FPT110420080039', 'MOUSE', 1, 'Funcional', '2018-01-01', 'INFORMATICA', 'ANTONIO LEMUS', 'COMPONENTE CULTURAL', 'IMAGINARIUM'),
('FPT110420080040', 'TECLADO', 1, 'Funcional', '2018-01-01', 'INFORMATICA', 'ANTONIO LEMUS', 'COMPONENTE CULTURAL', 'IMAGINARIUM'),
('FPT110420080041', 'MONITOR', 1, 'Funcional', '2018-01-01', 'INFORMATICA', 'ANTONIO LEMUS', 'COMPONENTE CULTURAL', 'IMAGINARIUM'),
('FPT110420080042', 'CASE i5 10th GEN. 16 RAM', 1, 'Funcional', '2023-01-01', 'INFORMATICA', 'MARIA COLORADO', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 1'),
('FPT110420080043', 'TECLADO', 1, 'Funcional', '2019-01-01', 'INFORMATICA', 'MARIA COLORADO', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 1'),
('FPT110420080044', 'MOUSE', 1, 'Funcional', '2019-01-01', 'INFORMATICA', 'MARIA COLORADO', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 1'),
('FPT110420080045', 'MONITOR 23.84\"', 1, 'Funcional', '2023-01-01', 'INFORMATICA', 'MARIA COLORADO', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 1'),
('FPT110420080046', 'LAPTOP HP RYZEN 5 2500u RADEO VEGA 12 RAM', 1, 'Funcional', '2019-01-01', 'INFORMATICA', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'OFICINA OPERACIONES'),
('FPT110420080047', 'MOUSE INALAMBRICO', 1, 'Funcional', '2019-01-01', 'INFORMATICA', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'OFICINA OPERACIONES'),
('FPT110420080048', 'CARGADOR', 1, 'Funcional', '2019-01-01', 'INFORMATICA', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'OFICINA OPERACIONES'),
('FPT110420080049', 'IMPRESORA L3150 MULTIFUNCIONAL', 1, 'Funcional', '2023-01-01', 'INFORMATICA', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'OFICINA OPERACIONES'),
('FPT110420080050', 'LAPTOP AMD RYZEN 7 4700U 16 RAM', 1, 'Funcional', '2023-01-01', 'INFORMATICA', 'MELISSA DE MELGAR', 'OPERACIONES Y MANTENIMIENTO', 'OFICINA OPERACIONES'),
('FPT110420080051', 'CARGADOR 45W', 1, 'Funcional', '2023-01-01', 'INFORMATICA', 'MELISSA DE MELGAR', 'OPERACIONES Y MANTENIMIENTO', 'OFICINA OPERACIONES'),
('FPT110420080052', 'MOUSE INALAMBRICO', 1, 'Funcional', '2023-01-01', 'INFORMATICA', 'MELISSA DE MELGAR', 'OPERACIONES Y MANTENIMIENTO', 'OFICINA OPERACIONES'),
('FPT110420080053', 'CASE AMD RYZEM 5 3600 16 RAM', 1, 'Funcional', '2021-01-01', 'INFORMATICA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080054', 'MONITOR MSI', 1, 'Funcional', '2021-01-01', 'INFORMATICA', 'OSCAR ALFARO', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080055', 'TECLADO', 1, 'Funcional', '2021-01-01', 'INFORMATICA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080056', 'MOUSE', 1, 'Funcional', '2021-01-01', 'INFORMATICA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080057', 'CASE i5 10th GEN. 16 RAM', 1, 'Funcional', '2022-09-16', 'INFORMATICA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080058', 'MONITOR', 1, 'Funcional', '2022-09-16', 'INFORMATICA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080059', 'TECLADO', 1, 'Funcional', '2022-09-16', 'INFORMATICA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080060', 'IMPRESORA MULTIFUNCIONAL', 1, 'Funcional', '2022-01-17', 'INFORMATICA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080061', 'CONSOLA DIGITAL', 1, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080062', 'CONSOLA DMX 512 LP 1548', 1, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080063', 'INTERFACE DMX', 1, 'Funcional', '2016-01-01', 'MOBILIARIO Y EQUIPO', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080064', 'MONITORES DE AUDIO ERIS E5', 2, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080065', 'AUDIFONOS SRH 750DJ', 1, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080066', 'MICROFONO TRASMISOR INALAMBRICO DE DIADEMA BLX-1', 6, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080067', 'RECEPTOR DE SEÑAL MIC. INALAMBRICO PG4', 1, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080068', 'RECEPTOR DE SEÑAL DE MIC. INALAMBRICO SVX4', 1, 'Funcional', '2016-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080069', 'RECEPTOR DE MICROFONO BLX-4', 8, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080070', 'RECEPTOR DE SEÑAL DE MICROFONO EW 100', 2, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080071', 'MICROFONO CON TRANSMISOR SK-100', 1, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080072', 'MICROFONO DE SOLAPA SIN TRANSMISOR', 1, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080073', 'MICROFONO DE MANO  PG58', 3, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080074', 'MICROFONO ALAMBRICO PG58', 2, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080075', 'MICROFONO ALAMBRICO', 2, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080076', 'MICROFONO ALAMBRICO SV100', 1, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080077', 'MICRONO ALAMBRICO PGA48', 1, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080078', 'MICROFONO ALAMBRICO MB 1K', 2, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080079', 'MICROFONO ALAMBRICO RTA1', 1, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080080', 'RADIO TRANSMISOR', 5, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080081', 'CARGADOR DE RADIO TRANSMISOR', 5, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080082', 'PROCESADORES DE AUDIO DIGITAL', 2, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080083', 'CARGADOR DE BATERIAS CHB-2', 2, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080084', 'CARGADOR DE  BATERIAS  PS133', 1, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080085', 'CARGADOR DE  BATERIAS PS134', 2, 'Funcional', '2014-10-02', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080086', 'CARGADOR DE BATERIA', 1, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080087', 'CAJA DIRECTA IMP2', 3, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080088', 'CAJA DIRECTA DI402', 2, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080089', 'EXTENSOR XLR DE 24 CANALES', 1, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080090', 'SEGUIDORAS LED DMX FOLLOWSPOT 75ST', 2, 'Funcional', '2014-10-01', 'MOBILIARIO Y EQUIPO', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080091', 'LECO 750W ANALOGICO', 12, 'Funcional', '2014-10-01', 'MOBILIARIO Y EQUIPO', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080092', 'FRESNEL 750W ANALOGICO', 12, 'Funcional', '2014-10-01', 'MOBILIARIO Y EQUIPO', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080093', 'PAR 64 750 ANALOGICO', 12, 'Funcional', '2014-10-01', 'MOBILIARIO Y EQUIPO', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080094', 'PAR 36 ANALOGICO', 12, 'Funcional', '2014-10-01', 'MOBILIARIO Y EQUIPO', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080095', 'PAR 64 LED DMX  RGBWA 7*15', 2, 'Funcional', '2014-10-01', 'MOBILIARIO Y EQUIPO', 'ARITIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080096', 'BAJOS LINE ARRAY AUTOAMPLIFICADOS VARIANT 18A', 3, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080097', 'MEDIOS Y ALTOS ARRAY AUTOAMPLIFICADOS VARIANT 25A', 9, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080098', 'MONITOR DE AUDIO AMPLIFICADO AVANT 12A', 2, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080099', 'MAQUINA DE HUMO Z1300', 1, 'Funcional', '2014-10-01', 'MOBILIARIO Y EQUIPO', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080100', 'RACK DE DIMMER DRD 120', 2, 'Funcional', '2014-10-01', 'MOBILIARIO Y EQUIPO', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080101', 'MODULOS PARA DIMMER D20', 18, 'Funcional', '2014-10-01', 'MOBILIARIO Y EQUIPO', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080102', 'PROYECTOR  G5910', 1, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080103', 'PROYECTOR PRO G6150', 1, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080104', 'PANTALLA DE PROYECCION CON ESTRUCTURA', 1, 'Funcional', '2014-10-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080105', 'SPLITER', 1, 'Funcional', '2014-10-01', 'MOBILIARIO Y EQUIPO', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080106', 'CABLES DE ACERO PARA SEGURIDAD', 9, 'Funcional', '2014-10-01', 'MOBILIARIO Y EQUIPO', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080107', 'WINCHER', 1, 'Funcional', '2014-10-01', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080108', 'PAR 64 RGBWA', 8, 'Funcional', '2014-10-01', 'MOBILIARIO Y EQUIPO', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080109', 'MARTILLO DE HIERRO 16 OZ', 1, 'Funcional', '2022-01-01', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080110', 'MARTILLO HIERRO CUERPO DE PLASTICO', 1, 'Funcional', '2014-10-01', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080111', 'LLAVE FRANCESA 300mm', 1, 'Funcional', '2017-01-01', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080112', 'LLAVE FRANCESA 250mm', 1, 'Funcional', '2017-01-01', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080113', 'LLAVE FRANCESA 200mm', 2, 'Funcional', '2017-01-01', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080114', 'LLAVE FRANCESA 150mm', 1, 'Funcional', '2017-01-01', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080115', 'LLAVE CONBINADA 1/4', 1, 'Funcional', '2017-01-01', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080116', 'LLAVE CONBINADA 3/8', 1, 'Funcional', '2017-01-02', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080117', 'LLAVE CONBINADA  5/16', 1, 'Funcional', '2017-01-03', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080118', 'LLAVE CONBINADA 1/2', 1, 'Funcional', '2017-01-04', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080119', 'LLAVE CONBINADA 9/16', 1, 'Funcional', '2017-01-05', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080120', 'LLAVE CONBINADA  5/8', 1, 'Funcional', '2017-01-06', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080121', 'LLAVE CONBINADA 11/16', 1, 'Funcional', '2017-01-07', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080122', 'LLAVE CONBINADA 3/4', 1, 'Funcional', '2017-01-08', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080123', 'GRAPA PARA CABLE UTP 100 UNIDADES DE 0.5mm', 1, 'Funcional', '2022-01-01', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080124', 'TENAZA DE ELECTRICISTA', 1, 'Funcional', '2017-01-01', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080125', 'TENAZA DE PRESION 10\"', 1, 'Funcional', '2017-01-01', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080126', 'SUCCIONADOR DE ESTAÑO', 1, 'Funcional', '2017-01-01', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080127', 'DESTORNILLADOR EN CRUZ', 1, 'Funcional', '2018-01-01', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080128', 'DESTORNILLADOR EN CRUZ PH 69-148', 1, 'Funcional', '2018-01-01', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080129', 'DESTORNILLADOR EN CRUZ 2X1-1/2\"', 1, 'Funcional', '2018-01-01', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080130', 'DESTORNILLADORES 1X4\" ', 1, 'Funcional', '2018-01-01', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080131', 'DESTORNILLADORES 1X6\" ', 1, 'Funcional', '2018-01-02', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080132', 'DESTORNILLADORES 2X4\" ', 1, 'Funcional', '2018-01-03', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080133', 'DESTORNILLADORES 2X8\" ', 1, 'Funcional', '2018-01-04', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080134', 'DESTORNILLADOR PLANO 119', 1, 'Funcional', '2018-01-01', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080135', 'DESTORNILLADOR PLANO 3/16\"x4\"', 1, 'Funcional', '2018-01-02', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080136', 'DESTORNILLADOR PLANO 1/4\"x6\"', 1, 'Funcional', '2018-01-03', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080137', 'DESTORNILLADOR PLANO 1/4\"x1-1/2\"', 1, 'Funcional', '2018-01-04', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080138', 'DESTORNILLADOR PLANO 3/16\"x3\"', 1, 'Funcional', '2018-01-05', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080139', 'DESTORNILLADOR PLANO 3/16\"x6\"', 1, 'Funcional', '2018-01-06', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080140', 'HALOGENAS PARA GRADAS DE TEATRO 100W', 24, 'Funcional', '2022-01-01', 'MOBILIARIO Y EQUIPO', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080141', 'HALOGENO 750W', 1, 'Funcional', '2019-01-01', 'MOBILIARIO Y EQUIPO', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080142', 'SIERRA CIRCULAR 8.1/4 MOD DW384', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080143', 'SIERRA CIRCULAR 7.1/4 MOD GKS150', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080144', 'LIJADORA ORBITAL 4\" ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080145', 'ROUTER MOD RF1100', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080146', 'TALADRO 3/8 MOD. DND014', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080147', 'TALADRO 1/2\" MOD. M8100', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080148', 'TALADRO INALAMBRICO ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080149', 'CARGADOR DE TALADRO DC18RC', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080150', 'CARGADOR DE TALADRO DCB112', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080151', 'SIERRA SABLE DWE305 (SOSO)', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080152', 'LIJADORA DE BANDA M9400', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080153', 'CEPILLO ELECTRICO D26676', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080154', 'ESMERILADORA 9\" MOD. DWE4559', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080155', 'ESMERILADORA 9\" D234076', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080156', 'ESMERILADORA 9 ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080157', 'TALADRO 1/2\" MOD. DW505', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080158', 'TALADRO INALAMBRICO DHP484', 1, 'Funcional', '2022-05-03', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080159', 'ATORNILLADOR INALAMBRICO DTD153', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080160', 'SIERRA CALADORA DW317', 2, 'Funcional', '2023-03-10', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080161', 'SIERRA CALADORA 4329', 1, 'Funcional', '2022-08-18', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080162', 'ESMERILADORA 4.1/2\" ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080163', 'ESMERILADORA 4.1/2 CA4550', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080164', 'DEMOLEDOR D25722-B3', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080165', 'SIERRA INGLETE ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080166', 'ESMERILADORA 4.1/2\" VAG10108-3', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'TOMAS CRUZ', 'OPERACIONES Y MANTENIMIENTO', 'TALLER DE MANTENIMIENTO'),
('FPT110420080167', 'TRONZADORA DE METAL D28720-B3', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'TOMAS CRUZ', 'OPERACIONES Y MANTENIMIENTO', 'TALLER DE MANTENIMIENTO'),
('FPT110420080168', 'TALADRO ROTOMARTILLO ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080169', 'ESMERILADORA 9\" ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080170', 'CARETA ELECTRONICA', 2, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080171', 'ESMERIL DE 6\" ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'TOMAS CRUZ', 'OPERACIONES Y MANTENIMIENTO', 'TALLER DE MANTENIMIENTO'),
('FPT110420080172', 'APARATO DE SOLDAR 220A', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080173', 'TALADRO DE BANCO BT1200-B3', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'TOMAS CRUZ', 'OPERACIONES Y MANTENIMIENTO', 'TALLER DE MANTENIMIENTO'),
('FPT110420080174', 'APARATO PARA SOLDAR 110V', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080175', 'APARATO DE SOLDAR 110V', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'TOMAS CRUZ', 'OPERACIONES Y MANTENIMIENTO', 'TALLER DE MANTENIMIENTO'),
('FPT110420080176', 'PULIDORA PARA CARRO STGP1318-B3', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080177', 'CARETA PARA SOLDAR ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'TOMAS CRUZ', 'OPERACIONES Y MANTENIMIENTO', 'TALLER DE MANTENIMIENTO'),
('FPT110420080178', 'SIERRA INGLETEADORA 12\" 6955-20', 1, 'Funcional', '2023-04-25', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL '),
('FPT110420080179', 'SIERA DE MESA 10\" MLT100', 1, 'Funcional', '2022-04-20', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL'),
('FPT110420080180', 'SOPLADORA DE HOJAS MM4 EB7660TH', 1, 'Funcional', '2022-03-21', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL'),
('FPT110420080181', 'SOPLADORA DE HOJAS BR420 ', 1, 'Funcional', '2022-11-16', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL'),
('FPT110420080182', 'COMPRESOR DE AIRE 80L 155PSI', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL'),
('FPT110420080183', 'COMPRESOR DE AIRE 120L', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL '),
('FPT110420080184', 'AORILLADORA TRIMMER FS90R', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL '),
('FPT110420080185', 'AORILLADORA TRIMMER FS280', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL '),
('FPT110420080186', 'AORILLADORA TRIMMER FS55', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL '),
('FPT110420080187', 'HIDROLAVADORA 3300PSI 9L/MIN', 2, 'Funcional', '2023-05-15', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL '),
('FPT110420080188', 'MARTILLO DE OREJA', 8, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080189', 'JUEGO DE CUBOS CON RATCH 1/2\" 10-24MM', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080190', 'ARNES PARA GUADAÑA ', 3, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL'),
('FPT110420080191', 'ESCUADRA 12\" ', 3, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080192', 'CARTABON ', 2, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080193', 'JUEGO DE CUBOS DE IMPACTO 11 PZAS 10-24MM', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080194', 'ESPATULA 1.1/2', 12, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080195', 'ESPATULA 2\"', 3, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080196', 'LLAVE CANGREJA 6\" ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080197', 'LLAVE CANGREJA 4\" ', 2, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080198', 'LLAVE CANGREJA 8\" ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080199', 'LLAVE CANGREJA 12\"', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080200', 'TIJERA MANUAL PARA PODAR ', 2, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080201', 'TIJERA PARA PODAR 20\"', 2, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080202', 'JUEGO DE DESARMADORES', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080203', 'TENAZA PARA ARMADOR (ALICATE)', 4, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080204', 'TENAZA PARA ELECTRICISTA 8\"', 3, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080205', 'FORMON PARA MADERA 1.1/2\"', 4, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080206', 'FORMON PARA MADERA 1\"', 4, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080207', 'FORMON PARA MADERA 3/4\"', 2, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080208', 'FORMON PARA MADERA 1/2\"', 3, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080209', 'DECAMETRO 50MTS ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080210', 'DESARMADOR PHILLIPS (VARIEDAD)', 5, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080211', 'DESARMADOR PLANO (VARIEDAD)', 5, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080212', 'CINTA METRICA 8MTS', 3, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080213', 'JUEGO DE CUBOS 5-13MM', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080214', 'MARCO PARA SIERRA ', 3, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080215', 'TIJERA PARA LAMINA DERECHA', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080216', 'TIJERA PARA LAMINA RECTA', 2, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080217', 'TENAZA AJUSTABLE PERICA', 2, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080218', 'TENAZA DE PRESIÓN 8\"', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080219', 'TENAZA DE PRESION TIPO C', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080220', 'REMACHADORA POP', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080221', 'PINZA 8\" (TENAZA DE PUNTA)', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080222', 'LLAVE STILLSON 2\" ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080223', 'LLAVE STILLSON 3\"', 2, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080224', 'CORTA TUBO PARA METAL 2\"', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080225', 'SARGENTO DE 6\"', 3, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080226', 'PISTOLA PARA SILICON (CALEFATEO)', 5, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080227', 'ENGRAPADORA PARA TAPICERIA ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080228', 'TESTER ELECTRONICO ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080229', 'CUMA DERECHA ', 6, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080230', 'MACHETE (CORVO) 20\"', 5, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080231', 'SERRUCHO 20\"', 3, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080232', 'SERRUCHO 24\"', 4, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080233', 'SERRUCHO DE COSTILLA 12\"', 2, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080234', 'ALMADANA 2LB', 4, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080235', 'ALMADANA 4LBS', 4, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080236', 'ALMADANA 12LBS', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080237', 'BARRA DE UÑA ', 6, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080238', 'GRIFA 1/4\"', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080239', 'GRIFA 3/8\"', 3, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080240', 'CORTA FRIO 1/4\"', 2, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080241', 'CORTA FRIO 3/8\"', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080242', 'CORTAFRIO 1/2\"', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080243', 'MANGUERA PARA NIVEL ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080244', 'NIVEL DE CAJA (GRANDE)', 2, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080245', 'NIVEL DE CAJA (PEQUEÑO)', 3, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080246', 'CUCHARA PARA ALBAÑIL', 3, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080247', 'CINCEL ', 2, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080248', 'PUNTA PARA CINCELEAR', 8, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080249', 'LLANA LISA', 4, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080250', 'LLANA DENTADA', 8, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080251', 'PLANCHA DE MADERA ALBAÑIL', 6, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080252', 'PLANCHA DE HULE ALBAÑIL', 2, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080253', 'ESPATULA 8\"', 2, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080254', 'PALA CUADRADA P/ALBAÑIL', 21, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL'),
('FPT110420080255', 'PALA DUPLEX', 4, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL'),
('FPT110420080256', 'CHUZO', 3, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL'),
('FPT110420080257', 'BARRA LINEAL', 3, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL'),
('FPT110420080258', 'PIOCHA ', 13, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL'),
('FPT110420080259', 'AZADON', 5, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL'),
('FPT110420080260', 'ZUACHO', 3, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL'),
('FPT110420080261', 'RASTRILLO DE METAL', 4, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL'),
('FPT110420080262', 'HACHA ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL '),
('FPT110420080263', 'SPOT LAMPARA DE ESTUDIO ', 2, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080264', 'CAMARA FOTOGRAFICA AOS T8', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080265', 'LENTE 10-18MM', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080266', 'LENTE 50MM', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080267', 'LENTE 18-135MM', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080268', 'LENTE 55-250MM', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080269', 'LENTE 18-55MM', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080270', 'LENTE 75-300MM', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080271', 'BATERIA RECARGABLE LP-E10', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080272', 'BATERIA RECARGABLE LP-E17', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080273', 'CAMARA FOTOGRAFICA AOS T6', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080274', 'CABLE HDMI 3MTS', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080275', 'CABLE HDMI 4MTS', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080276', 'CARGADOR LC-E10', 2, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080277', 'CARGADOR LC-E17', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080278', 'AUDIFONOS SHURE SRH840', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080279', 'SWITCH NERD 16 ENTRADAS', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080280', 'ACCESS POINT (ROUTER)', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080281', 'PANTALLA TV 43\" ', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080282', 'DISCO EXTERNO 4 TERA', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080283', 'CARGADOR DE BATERIAS AA Y AAA', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080284', 'MICROFONO PARA TELEFONO ', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080285', 'EXPANSOR USB 4 SALIDAS', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080286', 'ADAPTADOR PARA USB Y MICRO SD', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080287', 'BOCINA PARA COMPUTADORA', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ISRAEL VASQUEZ', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080288', 'IMPRESORA MULTIFUNCIONAL MFC5900', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'OFICINA OPERACIONES'),
('FPT110420080289', 'ROUTER PARA WIFI 3 ANTENAS ', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'OFICINA OPERACIONES'),
('FPT110420080290', 'SILLA EJECUTIVA NEGRA', 2, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'OFICINA OPERACIONES'),
('FPT110420080291', 'PROYECTOR H843A POWER LITE X41+', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'OFICINA OPERACIONES'),
('FPT110420080292', 'PROYECTOR SP-LSP3BLA', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'OFICINA OPERACIONES'),
('FPT110420080293', 'SWITCH POE 4 ENTRADAS', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'COMPONENTE CULTURAL', 'OFICINA MUME'),
('FPT110420080294', 'ACCESS POINT (ROUTER)', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'COMPONENTE CULTURAL', 'OFICINA MUME'),
('FPT110420080295', 'SWITCH AIRLINE 24 SALIDAS', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'COMPONENTE CULTURAL', 'OFICINA MUME'),
('FPT110420080296', 'UPS 1000', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ANGEL LOPEZ', 'COMPONENTE CULTURAL', 'OFICINA MUME'),
('FPT110420080297', 'DISCO DURO DE 2 TERAS', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'OFICINA ESCUELA DE CREATIVIDAD'),
('FPT110420080298', 'BOCINA PARA COMPUTADORA', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'DIMAS RIVAS', 'COMPONENTE CULTURAL', 'OFICINA MUME'),
('FPT110420080299', 'LAMINADORA STLM320', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'OFICINA ESCUELA DE CREATIVIDAD'),
('FPT110420080300', 'PANTALLA TV 43\" ', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'DIMAS RIVAS', 'COMPONENTE CULTURAL', 'OFICINA MUME'),
('FPT110420080301', 'PANTALLA TV 32\" ', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'DIMAS RIVAS', 'COMPONENTE CULTURAL', 'OFICINA MUME'),
('FPT110420080302', 'SONIDO DE 2 BOCINAS ', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'DIMAS RIVAS', 'COMPONENTE CULTURAL', 'PLANETARIO'),
('FPT110420080303', 'PROYECTOR PRO CINEMA 6010', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'DIMAS RIVAS', 'COMPONENTE CULTURAL', 'PLANETARIO'),
('FPT110420080304', 'PASACABLE ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080305', 'GUITARRA ELECTRICA CON ESTUCHE', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080306', 'MONITOR BEHRINGER K8', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080307', 'PROCESADOR DE AUDIO USB96', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080308', 'POWER PLAY PRO 8 CANALES', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080309', 'DRUM KIT 5 SHUER ', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080310', 'CASE GENERICO I7-7700 16RAM', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080311', 'PANTALLA AOC 32\"', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080312', 'MICROFONO DE CONSENSADOR ', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080313', 'AMPLIFICADOR DE BAJO ', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080314', 'TIMBALES', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080315', 'BATERIA MUSICAL ', 2, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080316', 'TECLADO MK935', 4, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080317', 'GUITARRA ELECTROACUSTICA ', 5, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080318', 'GUITARRA ELECTRICA ', 6, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080319', 'CHARANGO ELECTROACUSTICO', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080320', 'CHARANGO DE CUSUCO', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080321', 'UPS ', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080322', 'IMPRESORA MATRICIAL LX-350', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'MANUEL HERNANDEZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080323', 'CASE GENERICO I7-6700 ', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'MANUEL HERNANDEZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080324', 'MONITOR ', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'MANUEL HERNANDEZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA');
INSERT INTO `inventario` (`ID_Codigo`, `Nombre_Producto`, `Cantidad`, `Estado`, `Fecha_Ingreso`, `Tipo`, `Encargado`, `Instalacion`, `Ubicacion`) VALUES
('FPT110420080325', 'TECLADO', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'MANUEL HERNANDEZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080326', 'MOUSE G600', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'MANUEL HERNANDEZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080327', 'MONITOR MI', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ISRAEL VASQUEZ', 'COMUNICACIONES', 'OFICINA DE COMUNICACIONES'),
('FPT110420080328', 'CASE I5 10400 GENERICO', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'OSCAR ALFARO', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080329', 'MOUSE INALAMBRICO', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'OSCAR ALFARO', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080330', 'TECLADO INALAMBRICO', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'OSCAR ALFARO', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080331', 'LAPTOP X360', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'OSCAR ALFARO', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080332', 'BOCINA PARA COMPUTADORA', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'OSCAR ALFARO', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080333', 'MONITOR VIEW SONIC', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'SAMUEL JUAREZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080334', 'CASE I5 3330 GENERICO', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'SAMUEL JUAREZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080335', 'MOUSE ', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'SAMUEL JUAREZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080336', 'TECLADO', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'SAMUEL JUAREZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080337', 'IMPRESORA MULTIFUNCIONAL L-3250', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'MANUEL HERNANDEZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080338', 'IMPRESORA MULTIFUNCIONAL L-6750DW', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'MANUEL HERNANDEZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080339', 'DESTRUCTORA DE PAPEL SX20-08', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'MANUEL HERNANDEZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080340', 'ACCESS POINT (ROUTER)', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080341', 'SWITCH 23 CONECTORES', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080342', 'PACT COR CAT 5 24 CANALES ICC', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080343', 'UPS', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080344', 'CAJA FUERTE ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'OSCAR ALFARO', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080345', 'BOCINA PARA COMPUTADORA', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'MARIA COLORADO', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 1'),
('FPT110420080346', 'SONIDO RLIP', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'NOE BARRERA', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 2'),
('FPT110420080347', 'TRIPODE', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'NOE BARRERA', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 2'),
('FPT110420080348', 'CAMARA NXCAM', 2, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'NOE BARRERA', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 2'),
('FPT110420080349', 'CABLE HDMI', 2, 'Funcional', '1900-01-01', 'INFORMATICA', 'NOE BARRERA', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 2'),
('FPT110420080350', 'MICROFONO INALAMBRICO', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'NOE BARRERA', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 2'),
('FPT110420080351', 'PROYECTOR KR85', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'NOE BARRERA', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 2'),
('FPT110420080352', 'CONSOLA XR8300', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080353', 'BOCINA PP5', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080354', 'PEDESTAL PARA MICROFONO', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080355', 'MICROFONO INALAMBRICO', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080356', 'CARGADOR DE BATERIAS AA Y AAA', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080357', 'SAXOFON ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080358', 'TROMPETA', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080359', 'PIANO TECLADO MK935', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080360', 'ACCESS POINT (ROUTER)', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080361', 'UPS ', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080362', 'ACCESS POINT (ROUTER)', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'COMPONENTE CULTURAL', 'IMAGINARIUM'),
('FPT110420080363', 'SWITCH 16 CANALES', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'COMPONENTE CULTURAL', 'IMAGINARIUM'),
('FPT110420080364', 'BARRA DE SONIDO AIWA 3 CANALES ', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'COMPONENTE CULTURAL', 'IMAGINARIUM'),
('FPT110420080365', 'SWITCH 24 CANALES', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'COMPONENTE CULTURAL', 'IMAGINARIUM'),
('FPT110420080366', 'ACCESS POINT (ROUTER)', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'PRESIDENCIA'),
('FPT110420080367', 'PANTALLA TV 75\"', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'PRESIDENCIA'),
('FPT110420080368', 'UPS', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'PRESIDENCIA'),
('FPT110420080369', 'LAPTOP HP BEIGE', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'PRESIDENCIA'),
('FPT110420080370', 'PANTALLA TV 48\" ', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'GIMNASIO'),
('FPT110420080371', 'TECLADO', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'GIMNASIO'),
('FPT110420080372', 'MOUSE', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'GIMNASIO'),
('FPT110420080373', 'ACCESS POINT (ROUTER)', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'GIMNASIO'),
('FPT110420080374', 'EXPANSOR USB 4 SALIDAS', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'GIMNASIO'),
('FPT110420080375', 'ACCESS POINT (ROUTER)', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'SALA DE CAPACITACIONES'),
('FPT110420080376', 'PANTALLA DE PROYECCIÓN', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'SALA DE CAPACITACIONES'),
('FPT110420080377', 'ROUTER PARA INTERNET', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'SALA DE CAPACITACIONES'),
('FPT110420080378', 'BARRA DE SONIDO AIWA 3 CANALES ', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'BIBLIOTECA'),
('FPT110420080379', 'PANTALLA TV 43\" ', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'DIRECTOR EJECUTIVO', 'DIRECCION EJECUTIVA', 'OFICINA EJECUTIVA'),
('FPT110420080380', 'LAPTOP I5 NEGRO GRIS', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'DIRECTOR EJECUTIVO', 'DIRECCION EJECUTIVA', 'OFICINA EJECUTIVA'),
('FPT110420080381', 'DESKTOP I7 8GB RAM', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'DIRECTOR EJECUTIVO', 'DIRECCION EJECUTIVA', 'OFICINA EJECUTIVA'),
('FPT110420080382', 'ACCESS POINT (ROUTER)', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'DIRECCION EJECUTIVA', 'OFICINA EJECUTIVA'),
('FPT110420080383', 'IMPRESORA HP 9020', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'DIRECTOR EJECUTIVO', 'DIRECCION EJECUTIVA', 'OFICINA EJECUTIVA'),
('FPT110420080384', 'TABLET AKG X7', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'DIRECTOR EJECUTIVO', 'DIRECCION EJECUTIVA', 'OFICINA EJECUTIVA'),
('FPT110420080385', 'REFRIGERADORA MABE ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'DIRECTOR EJECUTIVO', 'DIRECCION EJECUTIVA', 'OFICINA EJECUTIVA'),
('FPT110420080386', 'CAJA FUERTE ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'DIRECTOR EJECUTIVO', 'DIRECCION EJECUTIVA', 'OFICINA EJECUTIVA'),
('FPT110420080387', 'SWITCH 24 CANALES', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'EX CASA INSTITUCIONAL'),
('FPT110420080388', 'PACT COR CAT 5 26 CANALES ICC', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'EX CASA INSTITUCIONAL'),
('FPT110420080389', 'ACCESS POINT (ROUTER)', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'EX CASA INSTITUCIONAL'),
('FPT110420080390', 'GABINETE', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'EX CASA INSTITUCIONAL'),
('FPT110420080391', 'MONITOR Y MOUSE (PARA CAMARAS)', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'OPERACIONES Y MANTENIMIENTO', 'EX CASA INSTITUCIONAL'),
('FPT110420080392', 'AIRE ACONDICIONADO 60000 BTU ', 7, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'COMPONENTE CULTURAL', 'IMAGINARIUM'),
('FPT110420080393', 'AIRE ACONDICIONADO 60000 BTU ', 2, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080394', 'AIRE ACONDICIONADO 60000 BTU ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'ESCUELA DE CREATIVIDAD', 'ESTUDIO DE GRABACION'),
('FPT110420080395', 'AIRE ACONDICIONADO 60000 BTU ', 2, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'OPERACIONES Y MANTENIMIENTO', 'SALA DE CAPACITACIONES'),
('FPT110420080396', 'AIRE ACONDICIONADO 12000 BTU ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080397', 'AIRE ACONDICIONADO 12000 BTU ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080398', 'AIRE ACONDICIONADO 60000 BTU ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'TEATRO YULKUIKAT', 'OFICINA DE TEATRO'),
('FPT110420080399', 'AIRE ACONDICIONADO 60000 BTU ', 6, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080400', 'AIRE ACONDICIONADO 24000 BTU ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'DIRECCION EJECUTIVA', 'OFICINA EJECUTIVA'),
('FPT110420080401', 'AIRE ACONDICIONADO 60000 BTU ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'DIRECCION EJECUTIVA', 'CASA INSTITUCIONAL'),
('FPT110420080402', 'AIRE ACONDICIONADO 48000 BTU ', 2, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'OPERACIONES Y MANTENIMIENTO', 'PRESIDENCIA'),
('FPT110420080403', 'AIRE ACONDICIONADO 36000 BTU ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'OPERACIONES Y MANTENIMIENTO', 'BIBLIOTECA'),
('FPT110420080404', 'AIRE ACONDICIONADO 36000 BTU ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080405', 'AIRE ACONDICIONADO 36000 BTU ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'COMPONENTE CULTURAL', 'PLANETARIO'),
('FPT110420080406', 'AIRE ACONDICIONADO 24000 BTU ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'OPERACIONES Y MANTENIMIENTO', 'DOMOS EX-COMUNICACIONES'),
('FPT110420080407', 'AIRE ACONDICIONADO 24000 BTU ', 2, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080408', 'AIRE ACONDICIONADO 24000 BTU ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'DIRECCION EJECUTIVA', 'CASA INSTITUCIONAL'),
('FPT110420080409', 'AIRE ACONDICIONADO 24000 BTU ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'OPERACIONES Y MANTENIMIENTO', 'OFICINA OPERACIONES'),
('FPT110420080410', 'AIRE ACONDICIONADO 24000 BTU ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'COMUNICACIONES ', 'OFICINA DE COMUNICACIONES'),
('FPT110420080411', 'AIRE ACONDICIONADO 12000 BTU ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'OPERACIONES Y MANTENIMIENTO', 'EX CASA INSTITUCIONAL'),
('FPT110420080412', 'AIRE ACONDICIONADO 24000 BTU ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'OPERACIONES Y MANTENIMIENTO', 'EX CASA INSTITUCIONAL'),
('FPT110420080413', 'AIRE ACONDICIONADO 12000 BTU ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080414', 'AIRE ACONDICIONADO 36000 BTU ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080415', 'AIRE ACONDICIONADO 60000 BTU ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'ECOVENTURA', 'AULA DE BIENVENIDA'),
('FPT110420080416', 'AIRE ACONDICIONADO 60000 BTU ', 15, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'COMPONENTE CULTURAL', 'OFICINA MUME'),
('FPT110420080417', 'EXTINTOR DE FUEGO 20LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL'),
('FPT110420080418', 'EXTINTOR DE FUEGO 20LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'TOMAS CRUZ', 'OPERACIONES Y MANTENIMIENTO', 'TALLER DE MANTENIMIENTO'),
('FPT110420080419', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'ADMINISTRACION', 'CAFETERIA CC'),
('FPT110420080420', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'ADMINISTRACION', 'CAFETERIA CC'),
('FPT110420080421', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 1'),
('FPT110420080422', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 2'),
('FPT110420080423', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'SALON PERCUSION'),
('FPT110420080424', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080425', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 3 VOCES Y VIENTOS'),
('FPT110420080426', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'OPERACIONES Y MANTENIMIENTO', 'GIMNASIO'),
('FPT110420080427', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'DIMAS RIVAS', 'COMPONENTE CULTURAL', 'PLANETARIO'),
('FPT110420080428', 'EXTINTOR DE FUEGO 10LBS', 4, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'DIMAS RIVAS', 'COMPONENTE CULTURAL', 'OFICINA MUME'),
('FPT110420080429', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'OPERACIONES Y MANTENIMIENTO', 'PRESIDENCIA'),
('FPT110420080430', 'EXTINTOR DE FUEGO 10LBS', 6, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ANTONIO LEMUS', 'COMPONENTE CULTURAL', 'IMAGINARIUM'),
('FPT110420080431', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS RAMOS', 'ADMINISTRACION', 'VIGILANCIA'),
('FPT110420080432', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'DIMAS RIVAS', 'COMPONENTE CULTURAL', 'PLANETARIO'),
('FPT110420080433', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'DIRECCION EJECUTIVA', 'OFICINA EJECUTIVA'),
('FPT110420080434', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ISRAEL VASQUEZ', 'COMUNICACIONES', 'OFICINA DE COMUNICACIONES'),
('FPT110420080435', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'OPERACIONES Y MANTENIMIENTO', 'SALA DE CAPACITACIONES'),
('FPT110420080436', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'OPERACIONES Y MANTENIMIENTO', 'DOMOS EX-COMUNICACIONES'),
('FPT110420080437', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'OPERACIONES Y MANTENIMIENTO', 'BIBLIOTECA'),
('FPT110420080438', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'OPERACIONES Y MANTENIMIENTO', 'OFICINA OPERACIONES'),
('FPT110420080439', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'MANUEL HERNANDEZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080440', 'EXTINTOR DE FUEGO 10LBS', 9, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE CALLEJAS', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080441', 'EXTINTOR DE FUEGO 20LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE CALLEJAS', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080442', 'EXTINTOR DE FUEGO 10LBS', 5, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080443', 'EXTINTOR DE FUEGO 20LBS', 2, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080444', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'TOMAS CRUZ', 'OPERACIONES Y MANTENIMIENTO', 'TRANSPORTE'),
('FPT110420080445', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'TOMAS CRUZ', 'OPERACIONES Y MANTENIMIENTO', 'TRANSPORTE'),
('FPT110420080446', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'TOMAS CRUZ', 'OPERACIONES Y MANTENIMIENTO', 'TRANSPORTE'),
('FPT110420080447', 'EXTINTOR DE FUEGO 10LBS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'TOMAS CRUZ', 'OPERACIONES Y MANTENIMIENTO', 'TRANSPORTE'),
('FPT110420080448', 'MOTO COMPRESOR JET MASTER 1/3HP 127V', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080449', 'CIRCUITO CERRADO DE VIDEO VIGILANCIA 5 CAMARAS', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'DIRECTOR EJECUTIVO', 'OPERACIONES Y MANTENIMIENTO', 'EX CASA INSTITUCIONAL'),
('FPT110420080450', 'COCINA DE 4 QUEMADORES ', 3, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'VIGILANCIA', 'ADMINISTRACION', 'VIGILANCIA'),
('FPT110420080451', 'COCINA CON HORNO 4 QUEMADORES', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'DIRECTOR EJECUTIVO', 'DIRECCION EJECUTIVA', 'CASA INSTITUCIONAL'),
('FPT110420080452', 'REFRIGERADORA ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'DIRECTOR EJECUTIVO', 'DIRECCION EJECUTIVA', 'CASA INSTITUCIONAL'),
('FPT110420080453', 'COCINA CON HORNO 6 QUEMADORES', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'ADMINISTRACION', 'CAFETERIA CC'),
('FPT110420080454', 'PLANCHA PARA PUPUSAS 2Q', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'ADMINISTRACION', 'CAFETERIA CC'),
('FPT110420080455', 'FREIDOR INDUSTRIAL CON VALVULA Y MANGUERA', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL'),
('FPT110420080456', 'HIDROLAVADORA 3000PSI', 2, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL'),
('FPT110420080457', 'INVERSOR DE CORRIENTE 1500W', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'JOSE CALLEJAS', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080458', 'LAVADORA DE ROPA ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'DIRECTOR EJECUTIVO', 'DIRECCION EJECUTIVA', 'CASA INSTITUCIONAL'),
('FPT110420080459', 'SECADORA DE ROPA', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'DIRECTOR EJECUTIVO', 'DIRECCION EJECUTIVA', 'CASA INSTITUCIONAL'),
('FPT110420080460', 'LICUADORA DE 2V ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'ADMINISTRACION', 'CAFETERIA CC'),
('FPT110420080461', 'MESA PLEGABLE DE 6 PIES', 10, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'COCINA ECOVENTURA'),
('FPT110420080462', 'MICROONDAS 0.7 PIES', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE CALLEJAS', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080463', 'MICROONDAS 0.7 PIES', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080464', 'MICROONDAS 0.9 PIES', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'MANUEL HERNANDEZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080465', 'REFRIGERADORA 2 PUERTAS ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'ADMINISTRACION', 'CAFETERIA CC'),
('FPT110420080466', 'MICROONDAS ', 2, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JEFE DE OPERACIONES', 'ADMINISTRACION', 'CAFETERIA CC'),
('FPT110420080467', 'MOTOSIERRA 14\"', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080468', 'MOTOSIERRA 20\"', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA 01'),
('FPT110420080469', 'PLANCHA TRANSFER 16X16 SERIGRAFIA', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ANGEL LOPEZ', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL'),
('FPT110420080470', 'SILLA EJECUTIVA NEGRA', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'MANUEL HERNANDEZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080471', 'SILLA EJECUTIVA GERENCIAL', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'OSCAR ALFARO', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080472', 'SILLA EJECUTIVA GERENCIAL', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'DIRECTOR EJECUTIVO', 'DIRECCION EJECUTIVA', 'OFICINA EJECUTIVA'),
('FPT110420080473', 'SILLA EJECUTIVA NEGRA', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ISRAEL VASQUEZ', 'COMUNICACIONES', 'OFICINA DE COMUNICACIONES'),
('FPT110420080474', 'VENTILADOR DE TECHO ', 3, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'ANGEL LOPEZ', 'ESCUELA DE CREATIVIDAD', 'SALON AÑO 1'),
('FPT110420080475', 'DESKTOP CLON CORE I5 7MA GENERACIÓN', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080476', 'LAPTOP I5 ASUS', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080477', 'LAPTOP CORE I5', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080478', 'IMPRESORA MULTI FUNCIONAL L3250', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080479', 'SONIDO ESTACIONARIO DE DOS PARLANTES ', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'AULA DE BIENVENIDA'),
('FPT110420080480', 'ACCESS POINT (ROUTER)', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'ARISTIDES HERNANDEZ', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080481', 'DESKTOP MAC 1 CORE I5', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080482', 'LAPTOP HP AMD RYZEN 7 DE 4TA GENERACIÓN', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'CARLOS URBINA', 'OPERACIONES Y MANTENIMIENTO', 'BODEGA GENERAL'),
('FPT110420080483', 'LAPTOP HP AMD RYZEN 7 DE 4TA GENERACIÓN', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'RICARDO RIVAS', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080484', 'MICROBUS HIACE 16 ASIENTOS 2016', 1, 'Funcional', '1900-01-01', 'VEHICULOS', 'JEFE DE TRANSPORTE', 'OPERACIONES Y MANTENIMIENTO', 'TRANSPORTE'),
('FPT110420080485', 'MOTOCICLETA YTZ 125E 2019', 1, 'Funcional', '1900-01-01', 'VEHICULOS', 'JEFE DE TRANSPORTE', 'OPERACIONES Y MANTENIMIENTO', 'TRANSPORTE'),
('FPT110420080486', 'MOTOCICLETA YBR 125ED 2022', 1, 'Funcional', '1900-01-01', 'VEHICULOS', 'JEFE DE TRANSPORTE', 'OPERACIONES Y MANTENIMIENTO', 'TRANSPORTE'),
('FPT110420080487', 'PICK UP HILUX SER 2023', 1, 'Funcional', '1900-01-01', 'VEHICULOS', 'JEFE DE TRANSPORTE', 'OPERACIONES Y MANTENIMIENTO', 'TRANSPORTE'),
('FPT110420080488', 'CAMION LIVIANO DYNA 2 TON 2023', 1, 'Funcional', '1900-01-01', 'VEHICULOS', 'JEFE DE TRANSPORTE', 'OPERACIONES Y MANTENIMIENTO', 'TRANSPORTE'),
('FPT110420080489', 'CAMION LIVIANO DYNA 2 TON 2024', 1, 'Funcional', '1900-01-01', 'VEHICULOS', 'JEFE DE TRANSPORTE', 'OPERACIONES Y MANTENIMIENTO', 'TRANSPORTE'),
('FPT110420080490', 'TERRENO CENTRO CULTURAL ', 1, 'Funcional', '1900-01-01', 'INMUEBLES', 'DIRECCION EJECUTIVA', 'ADMINISTRACION', 'INSTALACIONES'),
('FPT110420080491', 'TERRENO TEATRO YULKUIKAT', 1, 'Funcional', '1900-01-01', 'INMUEBLES', 'DIRECCION EJECUTIVA', 'ADMINISTRACION', 'INSTALACIONES'),
('FPT110420080492', 'TERRENO ECOVENTURA', 1, 'Funcional', '1900-01-01', 'INMUEBLES', 'DIRECCION EJECUTIVA', 'ADMINISTRACION', 'INSTALACIONES'),
('FPT110420080493', 'VENTILADOR DE TECHO ', 2, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080494', 'ARCHIVERO DE METAL 4 GAVETAS ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080495', 'ESCRITORIO TIPO MESA 1 GAVETA', 2, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080496', 'ESCRITORIO 4 GAVETAS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080497', 'SILLON AZUL ', 2, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080498', 'ESCRITORIO EN L CON GAVETAS ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080499', 'SILLA SECRETARIAL', 4, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080500', 'BASURERO DE PEDAL METALICO', 3, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080501', 'SILLON CAFÉ ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080502', 'MUEBLE PARA LAVAMANOS 2 PUERTAS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080503', 'ESPEJO PARA BAÑO 65X65CMS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'OFICINA ECOVENTURA'),
('FPT110420080504', 'PANTRIE DE 4 GAVETAS Y 4 PUERTAS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080505', 'MINI REFRIGERADORA', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080506', 'ESCRITORIO 4 GAVETAS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080507', 'SOPLADORA DE HOJAS BR420 ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080508', 'ESCALERA 2 BANDAS 7 PIES', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080509', 'CUMA DERECHA ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080510', 'MACHETE (CORVO) 20\"', 4, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080511', 'CHUZO ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080512', 'CORTAFRIO 1/2\"', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080513', 'RASTRILLO DE METAL 12 DIENTES', 3, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080514', 'AZADON CON MANGO', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080515', 'PIOCHA CON MANGO', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080516', 'PALA CUADRADA P/ALBAÑIL', 3, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080517', 'BARRA 6 PIES', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080518', 'PALA DUPLEX', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080519', 'TIJERA PARA PODAR 20\"', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080520', 'BARRA DE UÑA ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080521', 'AZADON SIN MANGO', 4, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080522', 'PIOCHA SIN MANGO', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080523', 'CAJA DE HERRAMIENTAS', 5, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080524', 'CARRETILLA DE TOLVA ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080525', 'VENTILADOR DE PEDESTAL', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080526', 'SERRUCHO DE 20\"', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080527', 'MARCO PARA SIERRA ', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080528', 'SILLA DE ESPERA METALICA ', 29, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080529', 'BASURERO CON RODO 32G', 3, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080530', 'ESCOBA DE JARDIN VERDE METAL ', 3, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'BRAYAN RAMOS', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080531', 'CARRETILLA DE TOLVA ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'BRAYAN RAMOS', 'ECOVENTURA', 'COCINA ECOVENTURA'),
('FPT110420080532', 'PALA CUADRADA P/ALBAÑIL', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'BRAYAN RAMOS', 'ECOVENTURA', 'COCINA ECOVENTURA'),
('FPT110420080533', 'PALA DUPLEX', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'BRAYAN RAMOS', 'ECOVENTURA', 'COCINA ECOVENTURA'),
('FPT110420080534', 'RASTRILLO DE METAL 12 DIENTES', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'BRAYAN RAMOS', 'ECOVENTURA', 'COCINA ECOVENTURA'),
('FPT110420080535', 'REFRIGERADORA 2 PUERTAS ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'COCINA ECOVENTURA'),
('FPT110420080536', 'SILLA DE ESPERA METALICA ', 75, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'COCINA ECOVENTURA'),
('FPT110420080537', 'TRIDENTE DE 4 DIENTES ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'COCINA ECOVENTURA'),
('FPT110420080538', 'SILLA DE METAL OCRE', 18, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'AULA DE BIENVENIDA'),
('FPT110420080539', 'SILLA PLASTICA BLANCA', 20, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'AULA DE BIENVENIDA'),
('FPT110420080540', 'MESA NEGRA DE MADERA ', 9, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'AULA DE BIENVENIDA'),
('FPT110420080541', 'PANTALLA PARA PROYECCION', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'AULA DE BIENVENIDA'),
('FPT110420080542', 'CASILLERO CON PUERTAS Y GAVETAS', 8, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'AULA DE BIENVENIDA'),
('FPT110420080543', 'CAMA ARMABLE EN CAMAROTE', 9, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'AULA DE BIENVENIDA'),
('FPT110420080544', 'MESA DE MADERA OCRE', 6, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'COCINA ECOVENTURA'),
('FPT110420080545', 'REFRIGERADORA 2 PUERTAS ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE CALLEJAS', 'TEATRO YULKUIKAT', 'CAFETERIA TEATRO'),
('FPT110420080546', 'REFRIGERADORA CON PUERTAS Y GAVETAS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE CALLEJAS', 'TEATRO YULKUIKAT', 'CAFETERIA TEATRO'),
('FPT110420080547', 'MINI REFRIGERADORA', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE CALLEJAS', 'TEATRO YULKUIKAT', 'OFICINA TEATRO'),
('FPT110420080548', 'JUEGO DE 6 SILLONES Y MESA REDONDA', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'PRESIDENCIA'),
('FPT110420080549', 'MESA RECTANGULAR Y 12 SILLAS ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'PRESIDENCIA'),
('FPT110420080550', 'ESCRITORIO TIPO MESA ', 2, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'PRESIDENCIA'),
('FPT110420080551', 'MINI REFRIGERADORA', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'PRESIDENCIA'),
('FPT110420080552', 'CAFETERA 10 TZ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'PRESIDENCIA'),
('FPT110420080553', 'ROPERO 2 PUERTAS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'PRESIDENCIA'),
('FPT110420080554', 'ESPEJO PARA BAÑO 65X65CMS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'PRESIDENCIA'),
('FPT110420080555', 'JUEGO DE COMEDOR CUADRADO 4 SILLAS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'PRESIDENCIA'),
('FPT110420080556', 'MESA ESCRITORIO ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'PRESIDENCIA'),
('FPT110420080557', 'SILLA EJECUTIVA', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'PRESIDENCIA'),
('FPT110420080558', 'SOFA CAMA BEIGE', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'PRESIDENCIA'),
('FPT110420080559', 'SILLON RECLINABLE', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'PRESIDENCIA'),
('FPT110420080560', 'BASURERO DE PEDAL METALICO', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'PRESIDENCIA'),
('FPT110420080561', 'FREEZER BLANCO', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'SAMUEL JUAREZ', 'ADMINISTRACION', 'CAFETERIA CC'),
('FPT110420080562', 'REFRIGERADORA 2 PUERTAS ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'SAMUEL JUAREZ', 'ADMINISTRACION', 'CAFETERIA CC'),
('FPT110420080563', 'COCINA REDONDA DE 2Q', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'SAMUEL JUAREZ', 'ADMINISTRACION', 'CAFETERIA CC'),
('FPT110420080564', 'TAMBO DE GAS ', 4, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'SAMUEL JUAREZ', 'ADMINISTRACION', 'CAFETERIA CC'),
('FPT110420080565', 'CAFETERA 100 TZ', 2, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'SAMUEL JUAREZ', 'ADMINISTRACION', 'CAFETERIA CC'),
('FPT110420080566', 'CAFETERA 100 TZ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'SAMUEL JUAREZ', 'ADMINISTRACION', 'CAFETERIA CC'),
('FPT110420080567', 'BATIDORA ELECTRICA', 1, 'Funcional', '1900-01-11', 'MOBILIARIO Y EQUIPO', 'SAMUEL JUAREZ', 'ADMINISTRACION', 'CAFETERIA CC'),
('FPT110420080568', 'OLLA DE PRESION 2 LTS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'SAMUEL JUAREZ', 'ADMINISTRACION', 'CAFETERIA CC'),
('FPT110420080569', 'OASIS PARA AGUA EN GARRAFON', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'MANUEL HERNANDEZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080570', 'CAFETERA 12 TZ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'MANUEL HERNANDEZ', 'ADMINISTRACION', 'OFICINA ADMINISTRATIVA'),
('FPT110420080571', 'MESA PLEGABLE DE 6 PIES', 7, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'SALA DE CAPACITACIONES'),
('FPT110420080572', 'SILLA DE ESPERA COLOR NEGRO', 60, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'SALA DE CAPACITACIONES'),
('FPT110420080573', 'SILLA DE ESPERA COLOR BEIGE METALICA', 19, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'SALA DE CAPACITACIONES'),
('FPT110420080574', 'BASURERO DE PEDAL METALICO', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'SALA DE CAPACITACIONES'),
('FPT110420080575', 'MESA PLASTICA CUADRADA DE 1MT', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'SALA DE CAPACITACIONES'),
('FPT110420080576', 'BASURERO 32 GAL CON RODOS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'SALA DE CAPACITACIONES'),
('FPT110420080577', 'SOFA CAMA BEIGE', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'BIBLIOTECA'),
('FPT110420080578', 'JUEGO DE COMEDOR REDONDO CON 6 SILLAS', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'BIBLIOTECA'),
('FPT110420080579', 'SILLON CAFÉ ', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'BIBLIOTECA'),
('FPT110420080580', 'SILLON RECLINABLE', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'BIBLIOTECA'),
('FPT110420080581', 'JUEGO DE SALA RATAN REDONDO 4 PARTES', 1, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'BIBLIOTECA'),
('FPT110420080582', 'LIBREROS DE MADERA (DIFERENTES TAMAÑOS)', 6, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'CARLOS CARPIO', 'OPERACIONES Y MANTENIMIENTO', 'BIBLIOTECA'),
('FPT110420080583', 'MESA PLEGABLE DE 6 PIES', 15, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE CALLEJAS', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080584', 'MESA DE MADERA GRANDE', 6, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE CALLEJAS', 'TEATRO YULKUIKAT', 'CAFETERIA TEATRO'),
('FPT110420080585', 'SILLA PLASTICA BLANCA', 90, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE CALLEJAS', 'TEATRO YULKUIKAT', 'CAFETERIA TEATRO'),
('FPT110420080586', 'SILLA CON FORRO DE TELA BRAZO DE MADERA', 46, 'Funcional', '1900-01-01', 'MOBILIARIO Y EQUIPO', 'JOSE CALLEJAS', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA'),
('FPT110420080587', 'ESCOBA DE JARDIN PLASTICO', 2, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080588', 'PALA PLASTICA ', 6, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080589', 'TIJERA CORTA TUBO DE PVC', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080590', 'TIJERA PARA PODAR PEQUEÑA', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080591', 'NIVEL DE CAJA 24\"', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080592', 'PANTALLA TV 49\" ', 1, 'Funcional', '1900-01-01', 'MULTIMEDIA', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'RECEPCIÓN'),
('FPT110420080593', 'AORILLADORA TRIMMER FS90R', 1, 'Funcional', '1900-01-01', 'HERRAMIENTAS', 'JOSE LUIS ALVARES', 'ECOVENTURA', 'BODEGA ECOVENTURA'),
('FPT110420080594', 'MAQUINA DE COSER ', 1, 'Funcional', '1900-01-00', 'HERRAMIENTAS', 'ANTONIO LEMUS', 'COMPONENTE CULTURAL', 'IMAGINARIUM'),
('FPT110420080595', 'VENTILADOR DE PEDESTAL ', 2, 'Funcional', '1900-01-00', 'MOBILIARIO Y EQUIPO', 'ANTONIO LEMUS', 'COMPONENTE CULTURAL', 'IMAGINARIUM'),
('FPT110420080596', 'MONITOR STAND 24F HP', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'DIRECTOR EJECUTIVO', 'DIRECCION EJECUTIVA', 'OFICINA EJECUTIVA'),
('FPT110420080597', 'IMPRESOR LASER JET PRO MFP M2831DW', 1, 'Funcional', '1900-01-01', 'INFORMATICA', 'DIRECTOR EJECUTIVO', 'DIRECCION EJECUTIVA', 'OFICINA EJECUTIVA'),
('FPT110420080598', 'PROYECTOR EPSON POWERLITE W52+', 1, 'Funcional', '2024-06-13', 'MULTIMEDIA', 'ARISTIDES HERNANDEZ', 'TEATRO YULKUIKAT', 'TEATRO Y CABINA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `programas`
--

DROP TABLE IF EXISTS `programas`;
CREATE TABLE IF NOT EXISTS `programas` (
  `ID_Programa` varchar(10) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Descripcion` text,
  PRIMARY KEY (`ID_Programa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `programas`
--

INSERT INTO `programas` (`ID_Programa`, `Nombre`, `Descripcion`) VALUES
('ADM', 'Administración', 'Gestión administrativa de la Fundación Pablo Tesak'),
('ART', 'Artes Escénicas', 'Programa dedicado al desarrollo de las artes escénicas en la Fundación Pablo Tesak'),
('CUL', 'Componente Cultural', 'Espacio para la promoción y preservación de la cultura en la comunidad'),
('ESC', 'Escuela de Creatividad', 'Espacio de aprendizaje creativo'),
('INV', 'Inventario', 'Registro y gestión de activos de la Fundación Pablo Tesak');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registros_caja_chica`
--

DROP TABLE IF EXISTS `registros_caja_chica`;
CREATE TABLE IF NOT EXISTS `registros_caja_chica` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_caja_chica` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecha` date DEFAULT NULL,
  `documento` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `proveedor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `concepto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `programa_area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `gastos` decimal(10,2) DEFAULT NULL,
  `saldos` decimal(10,2) DEFAULT NULL,
  `imagenes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `registros_caja_chica`
--

INSERT INTO `registros_caja_chica` (`id`, `id_caja_chica`, `fecha`, `documento`, `proveedor`, `concepto`, `programa_area`, `gastos`, `saldos`, `imagenes`) VALUES
(1, 'CAJA001', '2025-01-07', 'DOC001', 'Proveedor A', 'Compra de material', 'Program 1', 500.00, NULL, NULL),
(2, 'CAJA001', '2025-01-07', 'DOC002', 'Proveedor B', 'Servicio de transporte', 'Program 1', 700.00, NULL, NULL),
(3, 'CAJA001', '2025-01-07', 'DOC003', 'Proveedor C', 'Compra de equipo', 'Program 2', 300.00, NULL, NULL),
(4, 'CAJA001', '2025-01-07', 'DOC004', 'Proveedor D', 'Material de oficina', 'Program 2', 500.00, NULL, NULL),
(5, 'CAJA002', '2025-01-07', 'DOC005', 'Proveedor J', 'Compra de suministros', 'Program 1', 80.00, NULL, NULL),
(6, 'CAJA002', '2025-01-07', 'DOC006', 'Proveedor K', 'Servicio de limpieza', 'Program 1', 120.00, NULL, NULL),
(7, 'CAJA002', '2025-01-07', 'DOC007', 'Proveedor L', 'Material para oficina', 'Program 2', 90.00, NULL, NULL),
(8, 'CAJA002', '2025-01-07', 'DOC008', 'Proveedor M', 'Gastos imprevistos', 'Program 2', 100.00, NULL, NULL),
(9, 'CAJA002', '2025-01-07', 'DOC009', 'Proveedor N', 'Reemplazo de piezas', 'Program 3', 80.00, NULL, NULL),
(10, 'CAJA002', '2025-01-07', 'DOC010', 'Proveedor O', 'Servicio de reparación', 'Program 3', 60.00, NULL, NULL),
(11, 'CAJA002', '2025-01-07', 'DOC011', 'Proveedor P', 'Compra de accesorios', 'Program 4', 70.00, NULL, NULL),
(12, 'CAJA002', '2025-01-07', 'DOC012', 'Proveedor Q', 'Reparación de vehículos', 'Program 4', 90.00, NULL, NULL),
(13, 'CAJA002', '2025-01-07', 'DOC013', 'Proveedor R', 'Suministros de oficina', 'Program 5', 85.00, NULL, NULL),
(14, 'CAJA002', '2025-01-07', 'DOC014', 'Proveedor S', 'Gastos operativos', 'Program 5', 95.00, NULL, NULL),
(15, 'CAJA002', '2025-01-07', 'DOC015', 'Proveedor T', 'Compra de herramientas', 'Program 6', 60.00, NULL, NULL),
(16, 'CAJA002', '2025-01-07', 'DOC016', 'Proveedor U', 'Servicio de mantenimiento', 'Program 6', 90.00, NULL, NULL),
(17, 'CAJA002', '2025-01-07', 'DOC017', 'Proveedor V', 'Material de construcción', 'Program 7', 85.00, NULL, NULL),
(18, 'CAJA002', '2025-01-07', 'DOC018', 'Proveedor W', 'Servicio de limpieza', 'Program 7', 65.00, NULL, NULL),
(19, 'CAJA002', '2025-01-07', 'DOC019', 'Proveedor X', 'Compra de equipos', 'Program 8', 90.00, NULL, NULL),
(20, 'CAJA002', '2025-01-07', 'DOC020', 'Proveedor Y', 'Gastos generales', 'Program 8', 75.00, NULL, NULL),
(24, 'Caja003', '2025-01-08', '1', '1', '1', '1', 20.00, 2000.00, '[\"1_1.png\"]'),
(25, 'Caja003', '2025-01-08', '2', '2', '2', '2', 100.00, 1980.00, '[\"2_2.png\",\"2_2_001.png\"]'),
(26, 'Caja003', '2025-01-08', '3', '3', '3', '3', 25.00, 1880.00, '[\"3_3.png\",\"3_3_001.png\"]'),
(27, 'Caja003', '2025-01-08', '4', '4', '4', '4', 35.00, 1855.00, '[\"4_4.png\",\"4_4_001.png\",\"4_4_002.png\",\"4_4_003.png\"]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_actividades`
--

DROP TABLE IF EXISTS `registro_actividades`;
CREATE TABLE IF NOT EXISTS `registro_actividades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int NOT NULL,
  `nombre_usuario` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `accion` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecha_hora` datetime DEFAULT CURRENT_TIMESTAMP,
  `equipo_id` int DEFAULT NULL,
  `detalles` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci,
  `ip_origen` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=225 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `registro_actividades`
--

INSERT INTO `registro_actividades` (`id`, `usuario_id`, `nombre_usuario`, `accion`, `descripcion`, `fecha_hora`, `equipo_id`, `detalles`, `ip_origen`) VALUES
(4, 4, 'Juan Carlos Urbina', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-17 20:51:20', NULL, NULL, '192.168.1.23'),
(13, 6, 'Carlos Carpio', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-17 21:30:50', NULL, NULL, '100.100.220.34'),
(14, 6, 'Carlos Carpio', 'Cerrar Sesión', 'El usuario \'Carlos Carpio\' cerró sesión en el sistema.', '2024-12-17 21:39:25', NULL, NULL, '100.100.220.34'),
(15, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-17 21:39:31', NULL, NULL, '100.100.220.34'),
(16, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2024-12-17 21:42:31', NULL, NULL, '100.100.220.34'),
(17, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-17 21:42:38', NULL, NULL, '100.100.220.34'),
(18, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2024-12-17 21:47:43', NULL, NULL, '100.100.220.34'),
(19, 3, 'Aristides Hernandez', 'Fallo de Inicio', 'Contraseña incorrecta.', '2024-12-17 21:47:50', NULL, NULL, '100.100.220.34'),
(20, 3, 'Aristides Hernandez', 'Fallo de Inicio', 'Contraseña incorrecta.', '2024-12-17 21:50:39', NULL, NULL, '100.100.220.34'),
(21, 3, 'Aristides Hernandez', 'Fallo de Inicio', 'Contraseña incorrecta.', '2024-12-17 21:50:50', NULL, NULL, '100.100.220.34'),
(22, 3, 'Aristides Hernandez', 'Fallo de Inicio', 'Contraseña incorrecta.', '2024-12-17 21:53:04', NULL, NULL, '100.100.220.34'),
(23, 3, 'Aristides Hernandez', 'Fallo de Inicio', 'Contraseña incorrecta.', '2024-12-17 21:53:28', NULL, NULL, '100.100.220.34'),
(24, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-17 21:54:10', NULL, NULL, '100.100.220.34'),
(25, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2024-12-17 21:54:17', NULL, NULL, '100.100.220.34'),
(26, 6, 'Carlos Carpio', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-17 21:56:05', NULL, NULL, '100.100.220.34'),
(27, 6, 'Carlos Carpio', 'Cerrar Sesión', 'El usuario \'Carlos Carpio\' cerró sesión en el sistema.', '2024-12-17 21:56:09', NULL, NULL, '100.100.220.34'),
(28, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-17 21:56:27', NULL, NULL, '100.100.220.34'),
(29, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2024-12-17 21:58:53', NULL, NULL, '100.100.220.34'),
(30, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-17 21:58:58', NULL, NULL, '100.100.220.34'),
(31, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2024-12-17 21:59:03', NULL, NULL, '100.100.220.34'),
(32, 6, 'Carlos Carpio', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-17 21:59:11', NULL, NULL, '100.100.220.34'),
(33, 6, 'Carlos Carpio', 'Cerrar Sesión', 'El usuario \'Carlos Carpio\' cerró sesión en el sistema.', '2024-12-17 21:59:13', NULL, NULL, '100.100.220.34'),
(34, 3, 'Aristides Hernandez', 'Fallo de Inicio', 'Contraseña incorrecta.', '2024-12-17 22:02:10', NULL, NULL, '100.100.220.34'),
(35, 6, 'Carlos Carpio', 'Fallo de Inicio', 'Contraseña incorrecta.', '2024-12-17 22:02:19', NULL, NULL, '100.100.220.34'),
(36, 3, 'Aristides Hernandez', 'Fallo de Inicio', 'Contraseña incorrecta.', '2024-12-17 22:02:58', NULL, NULL, '100.100.220.34'),
(37, 3, 'Aristides Hernandez', 'Fallo de Inicio', 'Contraseña incorrecta.', '2024-12-17 22:03:15', NULL, NULL, '100.100.220.34'),
(38, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-17 22:03:37', NULL, NULL, '100.100.220.34'),
(39, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2024-12-17 22:14:33', NULL, NULL, '100.100.220.34'),
(40, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-21 14:12:31', NULL, NULL, '100.100.220.34'),
(41, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2024-12-21 14:18:55', NULL, NULL, '100.100.220.34'),
(42, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-21 14:54:10', NULL, NULL, '100.100.220.34'),
(43, 3, 'Aristides Hernandez', 'Fallo de Inicio', 'Usuario no autorizado al programa \'INV\'.', '2024-12-21 14:55:48', NULL, NULL, '100.100.220.34'),
(44, 1, 'Manuel Hernandez', 'Fallo de Inicio', 'Contraseña incorrecta.', '2024-12-21 14:56:03', NULL, NULL, '100.100.220.34'),
(45, 1, 'Manuel Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-21 14:56:18', NULL, NULL, '100.100.220.34'),
(46, 1, 'Manuel Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-21 14:56:38', NULL, NULL, '100.100.220.34'),
(47, 1, 'Manuel Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-21 14:56:49', NULL, NULL, '100.100.220.34'),
(48, 1, 'Manuel Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-21 15:01:21', NULL, NULL, '100.100.220.34'),
(49, 1, 'Manuel Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-21 15:04:00', NULL, NULL, '100.100.220.34'),
(50, 0, 'Desconocido', 'Error en Sistema', 'Datos del formulario incompletos.', '2024-12-21 15:04:00', NULL, NULL, '100.100.220.34'),
(51, 1, 'Manuel Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-21 15:08:20', NULL, NULL, '100.100.220.34'),
(52, 0, 'Desconocido', 'Error en Sistema', 'Datos del formulario incompletos.', '2024-12-21 15:08:20', NULL, NULL, '100.100.220.34'),
(53, 1, 'Manuel Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-21 15:08:32', NULL, NULL, '100.100.220.34'),
(54, 0, 'Desconocido', 'Error en Sistema', 'Datos del formulario incompletos.', '2024-12-21 15:08:32', NULL, NULL, '100.100.220.34'),
(55, 1, 'Manuel Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-21 15:08:45', NULL, NULL, '100.100.220.34'),
(56, 0, 'Desconocido', 'Error en Sistema', 'Datos del formulario incompletos.', '2024-12-21 15:08:45', NULL, NULL, '100.100.220.34'),
(57, 1, 'Manuel Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-21 15:09:40', NULL, NULL, '100.100.220.34'),
(58, 0, 'Desconocido', 'Error en Sistema', 'Datos del formulario incompletos.', '2024-12-21 15:09:40', NULL, NULL, '100.100.220.34'),
(59, 3, 'Aristides Hernandez', 'Fallo de Inicio', 'No autorizado al programa \'ADM\'.', '2024-12-21 15:10:32', NULL, NULL, '100.100.220.34'),
(60, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2024-12-21 15:11:15', NULL, NULL, '100.100.220.34'),
(61, 0, 'Desconocido', 'Error en Sistema', 'Datos del formulario incompletos.', '2024-12-21 15:11:15', NULL, NULL, '100.100.220.34'),
(62, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2024-12-21 15:13:37', NULL, NULL, '100.100.220.34'),
(63, 0, 'Desconocido', 'Error en Sistema', 'Credenciales no enviadas.', '2024-12-21 15:13:37', NULL, NULL, '100.100.220.34'),
(64, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2024-12-21 15:15:04', NULL, NULL, '100.100.220.34'),
(65, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2024-12-21 15:18:31', NULL, NULL, '100.100.220.34'),
(66, 1, 'Manuel Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2024-12-21 15:19:48', NULL, NULL, '100.100.220.34'),
(67, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2024-12-21 15:22:06', NULL, NULL, '100.100.220.34'),
(68, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2024-12-21 15:39:08', NULL, NULL, '100.100.220.34'),
(69, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2024-12-21 15:53:08', NULL, NULL, '100.100.220.34'),
(70, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2024-12-21 16:24:02', NULL, NULL, '100.100.220.34'),
(71, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2024-12-21 16:24:46', NULL, NULL, '100.100.220.34'),
(72, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2024-12-21 16:54:47', NULL, NULL, '100.100.220.34'),
(73, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2024-12-21 16:55:07', NULL, NULL, '100.100.220.34'),
(74, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2024-12-21 17:07:33', NULL, NULL, '100.100.220.34'),
(75, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-01-03 15:16:01', NULL, NULL, '100.100.220.34'),
(76, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-01-03 22:22:20', NULL, NULL, '100.100.220.34'),
(77, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-01-03 22:37:23', NULL, NULL, '100.100.220.34'),
(78, 0, 'Aristides Hernandez', 'Agregar Producto', 'Se agregó el producto \'prueb1\' con código \'FPT110420080600\'.', '2025-01-03 22:37:50', NULL, NULL, '100.100.220.34'),
(79, 3, 'Aristides Hernandez', 'Eliminar Producto', 'Se eliminó el producto \'ZXCZXZX\' (ID: \'FPT110420080599\', Cantidad: \'12\', Estado: \'Funcional\').', '2025-01-03 22:38:15', NULL, NULL, '100.100.220.34'),
(80, 3, 'Aristides Hernandez', 'Eliminar Producto', 'Se eliminó el producto \'prueb1\' (ID: \'FPT110420080600\', Cantidad: \'1\', Estado: \'Funcional\').', '2025-01-03 22:38:22', NULL, NULL, '100.100.220.34'),
(81, 3, 'Aristides Hernandez', 'Registro Baja de Equipo', 'Se registró una baja de equipo con código \'BJA11042008071\'.', '2025-01-03 22:38:54', NULL, NULL, '100.100.220.34'),
(82, 3, 'Aristides Hernandez', 'Eliminar Registro', 'Se eliminó el registro con código \'BJA11042008071\' y sus imágenes asociadas.', '2025-01-03 22:39:11', NULL, NULL, '100.100.220.34'),
(83, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-01-03 22:39:39', NULL, NULL, '100.100.220.34'),
(84, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-01-03 22:39:47', NULL, NULL, '100.100.220.34'),
(85, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-01-06 13:49:46', NULL, NULL, '100.100.220.34'),
(86, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-01-06 13:43:38', NULL, NULL, '100.100.220.34'),
(87, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-01-06 13:44:01', NULL, NULL, '100.100.220.34'),
(88, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-01-06 13:44:09', NULL, NULL, '100.100.220.34'),
(89, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-01-06 13:44:45', NULL, NULL, '100.100.220.34'),
(90, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-01-06 15:30:31', NULL, NULL, '192.168.1.43'),
(91, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-01-06 15:36:52', NULL, NULL, '192.168.1.43'),
(92, 3, 'Aristides Hernandez', 'Fallo de Inicio', 'Contraseña incorrecta.', '2025-01-06 15:37:39', NULL, NULL, '192.168.1.43'),
(93, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-01-06 15:37:50', NULL, NULL, '192.168.1.43'),
(94, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-01-06 16:13:05', NULL, NULL, '100.100.220.34'),
(95, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-01-07 07:34:12', NULL, NULL, '100.100.220.34'),
(96, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-01-07 08:57:10', NULL, NULL, '100.100.220.34'),
(97, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-01-07 10:28:56', NULL, NULL, '100.100.220.34'),
(98, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-01-07 14:39:06', NULL, NULL, '192.168.1.26'),
(99, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-01-07 14:39:08', NULL, NULL, '192.168.1.26'),
(100, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-01-07 14:39:17', NULL, NULL, '192.168.1.26'),
(101, 3, 'Aristides Hernandez', 'Fallo de Inicio', 'Contraseña incorrecta.', '2025-01-07 16:07:52', NULL, NULL, '100.100.220.34'),
(102, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-01-07 16:07:58', NULL, NULL, '100.100.220.34'),
(103, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-01-07 16:08:01', NULL, NULL, '100.100.220.34'),
(104, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-01-07 16:08:08', NULL, NULL, '100.100.220.34'),
(105, 3, 'Aristides Hernandez', 'Fallo de Inicio', 'Contraseña incorrecta.', '2025-01-07 16:22:14', NULL, NULL, '100.100.220.34'),
(106, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-01-07 16:22:21', NULL, NULL, '100.100.220.34'),
(107, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-01-07 16:39:44', NULL, NULL, '100.100.220.34'),
(108, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-01-08 07:46:28', NULL, NULL, '100.100.220.34'),
(109, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-01-08 11:45:16', NULL, NULL, '100.100.220.34'),
(110, 4, 'Juan Carlos Urbina', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-01-08 14:56:44', NULL, NULL, '192.168.1.23'),
(111, 0, 'Invitado', 'Cerrar Sesión', 'El usuario \'Invitado\' cerró sesión en el sistema.', '2025-01-08 16:14:39', NULL, NULL, '192.168.1.23'),
(112, 4, 'Juan Carlos Urbina', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-01-08 16:15:02', NULL, NULL, '192.168.1.23'),
(113, 4, 'Juan Carlos Urbina', 'Actualizar Registro', 'Se actualizó el registro con código \'BJA11042008005\'. Nuevos valores: Descripción=\'MONITOR MODELO L705\', Marca=\'HIUNDAI\', Estado=\'DAÑADO\', Ubicación=\'ESCUELA DE CREATIVIDAD\'.', '2025-01-08 16:16:39', NULL, NULL, '192.168.1.23'),
(114, 4, 'Juan Carlos Urbina', 'Actualizar Registro', 'Se actualizó el registro con código \'BJA11042008006\'. Nuevos valores: Descripción=\' MONITOR DELL\', Marca=\'DELL\', Estado=\'DAÑADO\', Ubicación=\'ESCUELA DE CREATIVIDAD\'.', '2025-01-08 16:20:21', NULL, NULL, '192.168.1.23'),
(115, 4, 'Juan Carlos Urbina', 'Actualizar Registro', 'Se actualizó el registro con código \'BJA11042008008\'. Nuevos valores: Descripción=\'MONITOR NEC\', Marca=\'NEC\', Estado=\'DAÑADO\', Ubicación=\'TEATRO YULKUIKAT\'.', '2025-01-08 16:21:52', NULL, NULL, '192.168.1.23'),
(116, 4, 'Juan Carlos Urbina', 'Actualizar Registro', 'Se actualizó el registro con código \'BJA11042008008\'. Nuevos valores: Descripción=\'MONITOR NEC\', Marca=\'NEC\', Estado=\'DAÑADO\', Ubicación=\'TEATRO YULKUIKAT\'.', '2025-01-08 16:22:55', NULL, NULL, '192.168.1.23'),
(117, 4, 'Juan Carlos Urbina', 'Cerrar Sesión', 'El usuario \'Juan Carlos Urbina\' cerró sesión en el sistema.', '2025-01-08 16:23:38', NULL, NULL, '192.168.1.23'),
(118, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-01-23 14:07:14', NULL, NULL, '100.100.220.34'),
(119, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-01-24 11:31:02', NULL, NULL, '192.168.1.199'),
(120, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-01-24 11:31:35', NULL, NULL, '192.168.1.199'),
(121, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-01-24 11:31:59', NULL, NULL, '192.168.1.199'),
(122, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-10 10:49:02', NULL, NULL, '100.100.220.34'),
(123, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-10 10:52:35', NULL, NULL, '100.100.220.34'),
(124, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-10 10:53:27', NULL, NULL, '100.100.220.34'),
(125, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-10 10:54:03', NULL, NULL, '100.100.220.34'),
(126, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-10 10:54:31', NULL, NULL, '100.100.220.34'),
(127, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-10 10:55:57', NULL, NULL, '100.100.220.34'),
(128, 0, 'CCarpio', 'Fallo de Inicio', 'Usuario no autorizado o no encontrado.', '2025-02-10 10:56:32', NULL, NULL, '100.100.220.34'),
(129, 5, 'Ángel López', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-10 10:56:49', NULL, NULL, '100.100.220.34'),
(130, 0, 'JCarlos', 'Fallo de Inicio', 'Usuario no autorizado o no encontrado.', '2025-02-10 10:57:07', NULL, NULL, '100.100.220.34'),
(131, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-10 11:01:15', NULL, NULL, '100.100.220.34'),
(132, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-10 13:23:06', NULL, NULL, '100.100.220.34'),
(133, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-10 13:23:40', NULL, NULL, '100.100.220.34'),
(134, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-10 15:47:30', NULL, NULL, '100.100.220.34'),
(135, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-10 16:56:26', NULL, NULL, '100.100.220.34'),
(136, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-02-10 16:56:33', NULL, NULL, '100.100.220.34'),
(137, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-10 16:56:50', NULL, NULL, '100.100.220.34'),
(138, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-02-10 16:57:10', NULL, NULL, '100.100.220.34'),
(139, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-11 09:53:58', NULL, NULL, '100.100.220.34'),
(140, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-11 11:10:40', NULL, NULL, '100.100.220.34'),
(141, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-11 11:35:04', NULL, NULL, '100.100.220.34'),
(142, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-11 17:01:37', NULL, NULL, '100.100.220.34'),
(143, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-12 08:47:05', NULL, NULL, '100.100.220.34'),
(144, 4, 'Juan Carlos Urbina', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-17 14:18:32', NULL, NULL, '192.168.1.123'),
(145, 0, 'Alex909w ', 'Fallo de Inicio', 'Usuario no encontrado.', '2025-02-25 07:51:11', NULL, NULL, '100.70.168.33'),
(146, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-25 07:51:20', NULL, NULL, '100.70.168.33'),
(147, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-02-25 07:52:13', NULL, NULL, '100.70.168.33'),
(148, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-25 07:53:09', NULL, NULL, '100.100.220.34'),
(149, 0, 'Aristides Hernandez', 'Agregar Producto', 'Se agregó el producto \'COMPUTADORA DESKTOP\' con código \'FPT110420080599\'.', '2025-02-25 08:07:01', NULL, NULL, '100.100.220.34'),
(150, 3, 'Aristides Hernandez', 'Eliminar Producto', 'Se eliminó el producto \'COMPUTADORA DESKTOP\' (ID: \'FPT110420080599\', Cantidad: \'1\', Estado: \'Funcional\').', '2025-02-25 08:07:17', NULL, NULL, '100.100.220.34'),
(151, 3, 'Aristides Hernandez', 'Actualizar Registro', 'Se actualizó el registro con código \'BJA11042008009\'. Nuevos valores: Descripción=\'MONITOR HYUNDAI IMAGEQUEST MODELO L70S\', Marca=\'HYUNDAI\', Estado=\'DAÑADO\', Ubicación=\'ESCUELA DE CREATIVIDAD\'.', '2025-02-25 08:28:50', NULL, NULL, '100.100.220.34'),
(152, 3, 'Aristides Hernandez', 'Actualizar Registro', 'Se actualizó el registro con código \'BJA11042008006\'. Nuevos valores: Descripción=\' MONITOR DELL\', Marca=\'DELL\', Estado=\'DAÑADO\', Ubicación=\'ESCUELA DE CREATIVIDAD\'.', '2025-02-25 08:30:07', NULL, NULL, '100.100.220.34'),
(153, 3, 'Aristides Hernandez', 'Actualizar Registro', 'Se actualizó el registro con código \'BJA11042008008\'. Nuevos valores: Descripción=\'MONITOR NEC\', Marca=\'NEC\', Estado=\'DAÑADO\', Ubicación=\'TEATRO YULKUIKAT\'.', '2025-02-25 08:30:56', NULL, NULL, '100.100.220.34'),
(154, 3, 'Aristides Hernandez', 'Actualizar Registro', 'Se actualizó el registro con código \'BJA11042008009\'. Nuevos valores: Descripción=\' MONITOR DELL\', Marca=\'DELL\', Estado=\'DAÑADO\', Ubicación=\'ESCUELA DE CREATIVIDAD\'.', '2025-02-25 08:32:14', NULL, NULL, '100.100.220.34'),
(155, 3, 'Aristides Hernandez', 'Actualizar Registro', 'Se actualizó el registro con código \'BJA11042008012\'. Nuevos valores: Descripción=\'PUNTO DE ACCESO WI-FI  WI-FI DAP-2330A1\', Marca=\'D-LINK\', Estado=\'DAÑADO\', Ubicación=\'IMAGINARIUM\'.', '2025-02-25 08:33:02', NULL, NULL, '100.100.220.34'),
(156, 3, 'Aristides Hernandez', 'Actualizar Registro', 'Se actualizó el registro con código \'BJA11042008020\'. Nuevos valores: Descripción=\'REPRODUCTOR DE DVD/CD MOD DVP-N5725P\', Marca=\'SONY\', Estado=\'FUERA_DE_USO\', Ubicación=\'TEATRO YULKUIKAT\'.', '2025-02-25 08:48:30', NULL, NULL, '100.100.220.34'),
(157, 3, 'Aristides Hernandez', 'Actualizar Registro', 'Se actualizó el registro con código \'BJA11042008021\'. Nuevos valores: Descripción=\'IMPRESORA MULTIFUNCIÓN PIXMA\', Marca=\'CANON\', Estado=\'DAÑADO\', Ubicación=\'MUNDO MESOAMERICANO OFICINA\'.', '2025-02-25 08:50:06', NULL, NULL, '100.100.220.34'),
(158, 3, 'Aristides Hernandez', 'Actualizar Registro', 'Se actualizó el registro con código \'BJA11042008021\'. Nuevos valores: Descripción=\'IMPRESORA MULTIFUNCIÓN PIXMA G2100\', Marca=\'CANON\', Estado=\'DAÑADO\', Ubicación=\'MUNDO MESOAMERICANO OFICINA\'.', '2025-02-25 08:50:32', NULL, NULL, '100.100.220.34'),
(159, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-02-25 10:01:52', NULL, NULL, '100.100.220.34'),
(160, 4, 'Juan Carlos Urbina', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-25 13:09:02', NULL, NULL, '192.168.1.34'),
(161, 4, 'Juan Carlos Urbina', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-25 14:11:20', NULL, NULL, '192.168.1.34'),
(162, 4, 'Juan Carlos Urbina', 'Actualizar Registro', 'Se actualizó el registro con código \'BJA11042008058\'. Nuevos valores: Descripción=\'UPS NT-511\', Marca=\'FORZA\', Estado=\'DAÑADO\', Ubicación=\'TEATRO\'.', '2025-02-25 14:23:42', NULL, NULL, '192.168.1.34'),
(163, 3, 'Aristides Hernandez', 'Fallo de Inicio', 'Contraseña incorrecta.', '2025-02-25 14:26:03', NULL, NULL, '100.100.220.34'),
(164, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-25 14:26:14', NULL, NULL, '100.100.220.34'),
(165, 4, 'Juan Carlos Urbina', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-25 15:26:04', NULL, NULL, '192.168.1.34'),
(166, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-25 15:34:15', NULL, NULL, '100.100.220.34'),
(167, 3, 'Aristides Hernandez', 'Eliminar Registro', 'Se eliminó el registro con código \'BJA11042008074\' y sus imágenes asociadas.', '2025-02-25 15:35:02', NULL, NULL, '100.100.220.34'),
(168, 4, 'Juan Carlos Urbina', 'Actualizar Registro', 'Se actualizó el registro con código \'BJA11042008070\'. Nuevos valores: Descripción=\'UPS NT-511\', Marca=\'FORZA\', Estado=\'DAÑADO\', Ubicación=\'Escuela de creatividad\'.', '2025-02-25 15:36:47', NULL, NULL, '192.168.1.34'),
(169, 4, 'Juan Carlos Urbina', 'Cerrar Sesión', 'El usuario \'Juan Carlos Urbina\' cerró sesión en el sistema.', '2025-02-25 15:53:58', NULL, NULL, '192.168.1.34'),
(170, 7, 'Oscar Alfaro', 'Fallo de Inicio', 'Usuario no autorizado al programa \'INV\'.', '2025-02-25 15:54:26', NULL, NULL, '192.168.1.34'),
(171, 7, 'Oscar Alfaro', 'Fallo de Inicio', 'Usuario no autorizado al programa \'INV\'.', '2025-02-25 15:54:49', NULL, NULL, '192.168.1.34'),
(172, 7, 'Oscar Alfaro', 'Fallo de Inicio', 'Usuario no autorizado al programa \'INV\'.', '2025-02-25 15:55:14', NULL, NULL, '192.168.1.34'),
(173, 7, 'Oscar Alfaro', 'Fallo de Inicio', 'Usuario no autorizado al programa \'INV\'.', '2025-02-25 15:55:27', NULL, NULL, '192.168.1.34'),
(174, 7, 'Oscar Alfaro', 'Fallo de Inicio', 'Usuario no autorizado al programa \'INV\'.', '2025-02-25 15:56:00', NULL, NULL, '192.168.1.34'),
(175, 7, 'Oscar Alfaro', 'Fallo de Inicio', 'Usuario no autorizado al programa \'INV\'.', '2025-02-26 11:20:29', NULL, NULL, '192.168.1.34'),
(176, 7, 'Oscar Alfaro', 'Fallo de Inicio', 'Usuario no autorizado al programa \'INV\'.', '2025-02-26 11:20:42', NULL, NULL, '192.168.1.34'),
(177, 4, 'Juan Carlos Urbina', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-26 11:21:41', NULL, NULL, '192.168.1.34'),
(178, 7, 'Oscar Alfaro', 'Fallo de Inicio', 'Usuario no autorizado al programa \'INV\'.', '2025-02-26 11:42:39', NULL, NULL, '100.100.220.34'),
(179, 7, 'Oscar Alfaro', 'Fallo de Inicio', 'Usuario no autorizado al programa \'INV\'.', '2025-02-26 11:43:17', NULL, NULL, '100.100.220.34'),
(180, 7, 'Oscar Alfaro', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-26 11:44:31', NULL, NULL, '100.100.220.34'),
(181, 7, 'Oscar Alfaro', 'Cerrar Sesión', 'El usuario \'Oscar Alfaro\' cerró sesión en el sistema.', '2025-02-26 11:46:25', NULL, NULL, '100.100.220.34'),
(182, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-26 11:46:30', NULL, NULL, '100.100.220.34'),
(183, 3, 'Aristides Hernandez', 'Actualizar Registro', 'Se actualizó el registro con código \'BJA11042008058\'. Nuevos valores: Descripción=\'UPS NT-511\', Marca=\'FORZA\', Estado=\'DAÑADO\', Ubicación=\'TEATRO\'.', '2025-02-26 11:46:55', NULL, NULL, '100.100.220.34'),
(184, 3, 'Aristides Hernandez', 'Actualizar Registro', 'Se actualizó el registro con código \'BJA11042008070\'. Nuevos valores: Descripción=\'UPS NT-511\', Marca=\'FORZA\', Estado=\'DAÑADO\', Ubicación=\'Escuela de creatividad\'.', '2025-02-26 11:47:31', NULL, NULL, '100.100.220.34'),
(185, 3, 'Aristides Hernandez', 'Actualizar Registro', 'Se actualizó el registro con código \'BJA11042008071\'. Nuevos valores: Descripción=\'REPRODUCTOR DE DVD/CD MOD DVL-919\', Marca=\'PIONEER\', Estado=\'DAÑADO\', Ubicación=\'Escuela de creatividad\'.', '2025-02-26 11:47:55', NULL, NULL, '100.100.220.34'),
(186, 3, 'Aristides Hernandez', 'Actualizar Registro', 'Se actualizó el registro con código \'BJA11042008072\'. Nuevos valores: Descripción=\'REPRODUCTOR DE DISCO LASER LD-V8000\', Marca=\'PIONEER\', Estado=\'DAÑADO\', Ubicación=\'Escuela de creatividad\'.', '2025-02-26 11:48:15', NULL, NULL, '100.100.220.34'),
(187, 3, 'Aristides Hernandez', 'Actualizar Registro', 'Se actualizó el registro con código \'BJA11042008073\'. Nuevos valores: Descripción=\'PROYECTOR XG-E3000U\', Marca=\'SHARP\', Estado=\'DAÑADO\', Ubicación=\'Escuela de creatividad\'.', '2025-02-26 11:48:35', NULL, NULL, '100.100.220.34'),
(188, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-26 11:54:29', NULL, NULL, '100.100.220.34'),
(189, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-26 11:57:54', NULL, NULL, '100.100.220.34'),
(190, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-02-26 12:03:10', NULL, NULL, '100.100.220.34'),
(191, 7, 'Oscar Alfaro', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-26 12:03:17', NULL, NULL, '100.100.220.34'),
(192, 7, 'Oscar Alfaro', 'Cerrar Sesión', 'El usuario \'Oscar Alfaro\' cerró sesión en el sistema.', '2025-02-26 12:03:19', NULL, NULL, '100.100.220.34'),
(193, 3, 'Aristides Hernandez', 'Fallo de Inicio', 'Contraseña incorrecta.', '2025-02-26 13:49:21', NULL, NULL, '::1'),
(194, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-26 13:49:32', NULL, NULL, '::1'),
(195, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-27 08:31:19', NULL, NULL, '::1'),
(196, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-02-27 08:31:21', NULL, NULL, '::1'),
(197, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-27 08:41:04', NULL, NULL, '::1'),
(198, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-02-27 08:41:06', NULL, NULL, '::1'),
(199, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-27 08:59:49', NULL, NULL, '::1'),
(200, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-02-27 08:59:51', NULL, NULL, '::1'),
(201, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-27 08:59:59', NULL, NULL, '::1'),
(202, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-02-27 09:00:01', NULL, NULL, '::1'),
(203, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-27 09:00:02', NULL, NULL, '::1'),
(204, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-02-27 09:00:03', NULL, NULL, '::1'),
(205, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-27 09:02:46', NULL, NULL, '::1'),
(206, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-27 09:05:12', NULL, NULL, '::1'),
(207, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-02-27 09:05:13', NULL, NULL, '::1'),
(208, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-27 09:12:10', NULL, NULL, '::1'),
(209, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-27 09:12:23', NULL, NULL, '::1'),
(210, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-02-27 09:12:25', NULL, NULL, '::1'),
(211, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-27 09:12:28', NULL, NULL, '::1'),
(212, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-27 09:57:27', NULL, NULL, '::1'),
(213, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-02-27 09:57:59', NULL, NULL, '::1'),
(214, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-27 09:58:28', NULL, NULL, '::1'),
(215, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-02-27 14:11:44', NULL, NULL, '::1'),
(216, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio exitoso.', '2025-02-27 14:11:50', NULL, NULL, '::1'),
(217, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-27 14:34:33', NULL, NULL, '::1'),
(218, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-02-27 15:08:19', NULL, NULL, '::1'),
(219, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-27 15:08:25', NULL, NULL, '::1'),
(220, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-27 16:32:23', NULL, NULL, '::1'),
(221, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-02-27 16:32:30', NULL, NULL, '::1'),
(222, 0, 'ari909w', 'Fallo de Inicio', 'Usuario no encontrado.', '2025-03-06 08:08:13', NULL, NULL, '::1'),
(223, 3, 'Aristides Hernandez', 'Inicio de Sesión', 'Inicio de sesión exitoso.', '2025-03-06 08:08:16', NULL, NULL, '::1'),
(224, 3, 'Aristides Hernandez', 'Cerrar Sesión', 'El usuario \'Aristides Hernandez\' cerró sesión en el sistema.', '2025-03-06 08:08:36', NULL, NULL, '::1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) NOT NULL,
  `Usuario` varchar(50) NOT NULL,
  `Contraseña` varchar(255) NOT NULL,
  `Tipo_Usuario` enum('admin','user','invitado') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Usuario` (`Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`ID`, `Nombre`, `Usuario`, `Contraseña`, `Tipo_Usuario`) VALUES
(1, 'Manuel Hernandez', 'MHernandez', 'administracion2024', 'user'),
(3, 'Aristides Hernandez', 'Alex909w', 'Alex28081992', 'admin'),
(4, 'Juan Carlos Urbina', 'JCarlos', 'JC2024', 'user'),
(5, 'Ángel López', 'ALopez', 'Lopez2024', 'user'),
(6, 'Carlos Carpio', 'CCarpio', 'Operaciones2024', 'user'),
(7, 'Oscar Alfaro', 'Administracion', 'Admin2025', 'user');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_programas`
--

DROP TABLE IF EXISTS `usuarios_programas`;
CREATE TABLE IF NOT EXISTS `usuarios_programas` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_Usuario` int NOT NULL,
  `ID_Programa` varchar(10) DEFAULT NULL,
  `Nombre_Usuario` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `unique_usuario_programa` (`ID_Usuario`,`ID_Programa`),
  KEY `ID_Usuario` (`ID_Usuario`),
  KEY `ID_Programa` (`ID_Programa`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuarios_programas`
--

INSERT INTO `usuarios_programas` (`ID`, `ID_Usuario`, `ID_Programa`, `Nombre_Usuario`) VALUES
(1, 3, 'INV', 'Aristides Hernandez'),
(2, 1, 'ADM', 'MHernandez'),
(3, 4, 'INV', 'Juan Carlos Urbina'),
(4, 5, 'ESC', 'Ángel López'),
(7, 6, 'INV', 'Carlos Carpio'),
(8, 3, 'ADM', 'Alex909w'),
(9, 3, 'ART', 'Alex909w'),
(10, 3, 'CUL', 'Alex909w'),
(12, 7, 'INV', 'Administracion');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asistencia_beneficiarios`
--
ALTER TABLE `asistencia_beneficiarios`
  ADD CONSTRAINT `Asistencia_Beneficiarios_ibfk_1` FOREIGN KEY (`ID_Institucion`) REFERENCES `asistencia_instituciones` (`ID_Institucion`) ON DELETE CASCADE,
  ADD CONSTRAINT `Asistencia_Beneficiarios_ibfk_2` FOREIGN KEY (`ID_Eje`) REFERENCES `asistencia_ejes` (`ID_Eje`) ON DELETE CASCADE;

--
-- Filtros para la tabla `asistencia_ejes`
--
ALTER TABLE `asistencia_ejes`
  ADD CONSTRAINT `Asistencia_Ejes_ibfk_1` FOREIGN KEY (`ID_Programa`) REFERENCES `asistencia_programas` (`ID_Programa`) ON DELETE CASCADE;

--
-- Filtros para la tabla `asistencia_registro`
--
ALTER TABLE `asistencia_registro`
  ADD CONSTRAINT `Asistencia_Registro_ibfk_1` FOREIGN KEY (`ID_Visita`) REFERENCES `asistencia_visitas` (`ID_Visita`) ON DELETE CASCADE,
  ADD CONSTRAINT `Asistencia_Registro_ibfk_2` FOREIGN KEY (`ID_Beneficiario`) REFERENCES `asistencia_beneficiarios` (`ID_Beneficiario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `asistencia_reportes`
--
ALTER TABLE `asistencia_reportes`
  ADD CONSTRAINT `Asistencia_Reportes_ibfk_1` FOREIGN KEY (`ID_Programa`) REFERENCES `asistencia_programas` (`ID_Programa`) ON DELETE CASCADE,
  ADD CONSTRAINT `Asistencia_Reportes_ibfk_2` FOREIGN KEY (`ID_Eje`) REFERENCES `asistencia_ejes` (`ID_Eje`) ON DELETE CASCADE,
  ADD CONSTRAINT `Asistencia_Reportes_ibfk_3` FOREIGN KEY (`ID_Tema`) REFERENCES `asistencia_temas` (`ID_Tema`) ON DELETE CASCADE,
  ADD CONSTRAINT `Asistencia_Reportes_ibfk_4` FOREIGN KEY (`ID_Visita`) REFERENCES `asistencia_visitas` (`ID_Visita`) ON DELETE CASCADE;

--
-- Filtros para la tabla `asistencia_temas`
--
ALTER TABLE `asistencia_temas`
  ADD CONSTRAINT `Asistencia_Temas_ibfk_1` FOREIGN KEY (`ID_Eje`) REFERENCES `asistencia_ejes` (`ID_Eje`) ON DELETE CASCADE;

--
-- Filtros para la tabla `asistencia_visitas`
--
ALTER TABLE `asistencia_visitas`
  ADD CONSTRAINT `Asistencia_Visitas_ibfk_1` FOREIGN KEY (`ID_Tema`) REFERENCES `asistencia_temas` (`ID_Tema`) ON DELETE CASCADE;

--
-- Filtros para la tabla `asistencia_visitas_beneficiarios`
--
ALTER TABLE `asistencia_visitas_beneficiarios`
  ADD CONSTRAINT `Asistencia_Visitas_Beneficiarios_ibfk_1` FOREIGN KEY (`ID_Visita`) REFERENCES `asistencia_visitas` (`ID_Visita`) ON DELETE CASCADE,
  ADD CONSTRAINT `Asistencia_Visitas_Beneficiarios_ibfk_2` FOREIGN KEY (`ID_Beneficiario`) REFERENCES `asistencia_beneficiarios` (`ID_Beneficiario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuarios_programas`
--
ALTER TABLE `usuarios_programas`
  ADD CONSTRAINT `Usuarios_Programas_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuarios` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Usuarios_Programas_ibfk_2` FOREIGN KEY (`ID_Programa`) REFERENCES `programas` (`ID_Programa`) ON DELETE CASCADE ON UPDATE CASCADE;
--
-- Base de datos: `gestorcontrataciones`
--
DROP DATABASE IF EXISTS `gestorcontrataciones`;
CREATE DATABASE IF NOT EXISTS `gestorcontrataciones` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `gestorcontrataciones`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargos`
--

DROP TABLE IF EXISTS `cargos`;
CREATE TABLE IF NOT EXISTS `cargos` (
  `idCargo` int NOT NULL AUTO_INCREMENT,
  `cargo` varchar(50) NOT NULL,
  `descripcionCargo` text,
  `jefatura` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idCargo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cargos`
--

INSERT INTO `cargos` (`idCargo`, `cargo`, `descripcionCargo`, `jefatura`) VALUES
(1, 'Gerente', 'Responsable de la gestión del departamento', 1),
(2, 'Desarrollador', 'Encargado del desarrollo de software', 0),
(3, 'Analista Financiero', 'Análisis de estados financieros', 0),
(4, 'Ejecutivo de Ventas', 'Responsable de cerrar ventas', 0),
(5, 'Diseñador Gráfico', 'Creación de material gráfico', 0),
(6, 'Coordinador de Logística', 'Planificación de la distribución', 1),
(7, 'Administrador de Sistemas', 'Gestión y mantenimiento de infraestructuras tecnológicas', 0),
(8, 'Líder de Proyecto', 'Gestión de equipos de desarrollo de software', 1),
(9, 'Consultor IT', 'Asesoramiento en soluciones tecnológicas', 0),
(10, 'Desarrollador Front-End', 'Desarrollo de interfaces de usuario', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contrataciones`
--

DROP TABLE IF EXISTS `contrataciones`;
CREATE TABLE IF NOT EXISTS `contrataciones` (
  `idContratacion` int NOT NULL AUTO_INCREMENT,
  `idEmpleado` int NOT NULL,
  `idDepartamento` int NOT NULL,
  `idCargo` int NOT NULL,
  `idTipoContratacion` int NOT NULL,
  `fechaContratacion` date NOT NULL,
  `salario` decimal(10,2) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idContratacion`),
  KEY `idEmpleado` (`idEmpleado`),
  KEY `idDepartamento` (`idDepartamento`),
  KEY `idCargo` (`idCargo`),
  KEY `idTipoContratacion` (`idTipoContratacion`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `contrataciones`
--

INSERT INTO `contrataciones` (`idContratacion`, `idEmpleado`, `idDepartamento`, `idCargo`, `idTipoContratacion`, `fechaContratacion`, `salario`, `estado`) VALUES
(1, 1, 1, 1, 1, '2015-06-01', 50000.00, 1),
(2, 2, 2, 2, 1, '2017-08-15', 45000.00, 1),
(3, 3, 2, 3, 2, '2018-03-10', 40000.00, 1),
(4, 4, 3, 4, 1, '2019-02-22', 35000.00, 1),
(5, 5, 4, 5, 3, '2020-05-30', 32000.00, 1),
(6, 6, 5, 6, 2, '2021-09-18', 38000.00, 1),
(7, 7, 1, 1, 1, '2016-07-11', 55000.00, 1),
(8, 8, 2, 7, 1, '2022-11-01', 47000.00, 1),
(9, 9, 3, 8, 4, '2022-01-20', 30000.00, 1),
(10, 10, 4, 9, 5, '2023-07-01', 31000.00, 1),
(11, 1, 5, 2, 2, '2015-06-01', 50000.00, 0),
(12, 2, 1, 6, 1, '2017-08-15', 46000.00, 1),
(13, 3, 4, 10, 1, '2018-03-10', 43000.00, 1),
(14, 4, 5, 3, 4, '2019-02-22', 34000.00, 1),
(15, 5, 3, 4, 5, '2020-05-30', 33000.00, 1),
(16, 6, 2, 3, 2, '2021-09-18', 39000.00, 1),
(17, 7, 1, 6, 3, '2016-07-11', 56000.00, 1),
(18, 8, 4, 7, 1, '2022-11-01', 48000.00, 1),
(19, 9, 5, 8, 4, '2022-01-20', 31000.00, 0),
(20, 10, 1, 1, 5, '2023-07-01', 32000.00, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

DROP TABLE IF EXISTS `departamento`;
CREATE TABLE IF NOT EXISTS `departamento` (
  `idDepartamento` int NOT NULL AUTO_INCREMENT,
  `nombreDepartamento` varchar(50) NOT NULL,
  `descripcionDepartamento` text,
  PRIMARY KEY (`idDepartamento`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `departamento`
--

INSERT INTO `departamento` (`idDepartamento`, `nombreDepartamento`, `descripcionDepartamento`) VALUES
(1, 'Recursos Humanos', '                                                GestiÃ³n del personal y contrataciones\r\n                    \r\n                    '),
(2, 'Tecnología', 'Desarrollo y soporte tecnológico'),
(3, 'Ventas', 'Estrategias y ejecución de ventas'),
(4, 'Marketing', 'Creación y gestión de campañas de marketing'),
(5, 'Logística', 'Coordinación de distribución de productos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

DROP TABLE IF EXISTS `empleados`;
CREATE TABLE IF NOT EXISTS `empleados` (
  `idEmpleado` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `genero` char(1) NOT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correoElectronico` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idEmpleado`),
  UNIQUE KEY `correoElectronico` (`correoElectronico`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`idEmpleado`, `nombre`, `apellido`, `fechaNacimiento`, `genero`, `direccion`, `telefono`, `correoElectronico`) VALUES
(1, 'Juan', 'Perez', '1990-05-15', 'M', 'Calle 123, Ciudad', '555-1234', 'juan.perez@example.com'),
(2, 'Ana', 'Gómez', '1985-07-10', 'F', 'Calle 456, Ciudad', '555-5678', 'ana.gomez@example.com'),
(3, 'Carlos', 'Sánchez', '1992-11-20', 'M', 'Calle 789, Ciudad', '555-8765', 'carlos.sanchez@example.com'),
(4, 'María', 'Fernández', '1988-03-25', 'F', 'Calle 101, Ciudad', '555-4321', 'maria.fernandez@example.com'),
(5, 'Luis', 'Martínez', '1993-06-17', 'M', 'Calle 202, Ciudad', '555-1357', 'luis.martinez@example.com'),
(6, 'Paula', 'Ramírez', '1990-12-05', 'F', 'Calle 303, Ciudad', '555-2468', 'paula.ramirez@example.com'),
(7, 'Pedro', 'Hernández', '1987-02-12', 'M', 'Calle 404, Ciudad', '555-9876', 'pedro.hernandez@example.com'),
(8, 'Laura', 'Díaz', '1994-09-21', 'F', 'Calle 505, Ciudad', '555-6543', 'laura.diaz@example.com'),
(9, 'Ricardo', 'López', '1986-01-30', 'M', 'Calle 606, Ciudad', '555-3210', 'ricardo.lopez@example.com'),
(10, 'Sofia', 'García', '1991-04-18', 'F', 'Calle 707, Ciudad', '555-7412', 'sofia.garcia@example.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipocontratacion`
--

DROP TABLE IF EXISTS `tipocontratacion`;
CREATE TABLE IF NOT EXISTS `tipocontratacion` (
  `idTipoContratacion` int NOT NULL AUTO_INCREMENT,
  `tipoContratacion` varchar(100) NOT NULL,
  PRIMARY KEY (`idTipoContratacion`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `tipocontratacion`
--

INSERT INTO `tipocontratacion` (`idTipoContratacion`, `tipoContratacion`) VALUES
(1, 'Tiempo Completo'),
(2, 'Medio Tiempo'),
(3, 'Freelance'),
(4, 'Prácticas'),
(5, 'Contrato por Proyecto');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `contrataciones`
--
ALTER TABLE `contrataciones`
  ADD CONSTRAINT `contrataciones_ibfk_1` FOREIGN KEY (`idEmpleado`) REFERENCES `empleados` (`idEmpleado`) ON DELETE CASCADE,
  ADD CONSTRAINT `contrataciones_ibfk_2` FOREIGN KEY (`idDepartamento`) REFERENCES `departamento` (`idDepartamento`) ON DELETE CASCADE,
  ADD CONSTRAINT `contrataciones_ibfk_3` FOREIGN KEY (`idCargo`) REFERENCES `cargos` (`idCargo`) ON DELETE CASCADE,
  ADD CONSTRAINT `contrataciones_ibfk_4` FOREIGN KEY (`idTipoContratacion`) REFERENCES `tipocontratacion` (`idTipoContratacion`) ON DELETE CASCADE;
--
-- Base de datos: `proyectflow`
--
DROP DATABASE IF EXISTS `proyectflow`;
CREATE DATABASE IF NOT EXISTS `proyectflow` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `proyectflow`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `backups`
--

DROP TABLE IF EXISTS `backups`;
CREATE TABLE IF NOT EXISTS `backups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filepath` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` bigint NOT NULL COMMENT 'Tamaño en bytes',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

DROP TABLE IF EXISTS `configuracion`;
CREATE TABLE IF NOT EXISTS `configuracion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valor` text COLLATE utf8mb4_unicode_ci,
  `es_critica` tinyint(1) NOT NULL DEFAULT '0',
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_clave` (`clave`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `clave`, `valor`, `es_critica`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 'system_version', '1.0.0', 1, 'Versión actual del sistema', '2025-03-25 20:16:52', '2025-03-25 20:16:52'),
(2, 'backup_path', '/var/backups/app', 0, 'Ruta donde se guardan los backups', '2025-03-25 20:16:53', '2025-03-25 20:16:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs_acceso`
--

DROP TABLE IF EXISTS `logs_acceso`;
CREATE TABLE IF NOT EXISTS `logs_acceso` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_email` varchar(100) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `dispositivo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_email` (`usuario_email`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `logs_acceso`
--

INSERT INTO `logs_acceso` (`id`, `fecha`, `usuario_email`, `ip`, `dispositivo`) VALUES
(1, '2025-03-25 19:27:13', 'luis.miembro@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0'),
(2, '2025-03-25 19:27:27', 'carlos.admin@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0'),
(3, '2025-03-25 19:30:34', 'ana.gerente@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0'),
(4, '2025-03-25 19:30:50', 'carlos.admin@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0'),
(5, '2025-03-25 20:18:36', 'carlos.admin@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0'),
(6, '2025-03-25 21:14:43', 'carlos.admin@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0'),
(7, '2025-03-27 17:26:01', 'carlos.admin@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0'),
(8, '2025-03-27 17:29:04', 'luis.miembro@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0'),
(9, '2025-03-27 17:32:21', 'ana.gerente@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0'),
(10, '2025-03-27 17:33:26', 'luis.miembro@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0'),
(11, '2025-03-27 17:37:11', 'carlos.admin@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0'),
(12, '2025-03-27 17:39:38', 'luis.miembro@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0'),
(13, '2025-03-27 17:43:09', 'luis.miembro@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0'),
(14, '2025-03-27 17:44:17', 'ana.gerente@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0'),
(15, '2025-03-27 20:23:08', 'carlos.admin@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0'),
(16, '2025-03-27 21:00:09', 'carlos.admin@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0'),
(17, '2025-03-27 21:00:15', 'luis.miembro@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0'),
(18, '2025-03-27 21:00:23', 'ana.gerente@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0'),
(19, '2025-03-31 02:24:17', 'carlos.admin@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0'),
(20, '2025-03-31 02:25:18', 'carlos.admin@example.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs_actividad`
--

DROP TABLE IF EXISTS `logs_actividad`;
CREATE TABLE IF NOT EXISTS `logs_actividad` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_email` varchar(100) DEFAULT NULL,
  `usuario_nombre` varchar(100) DEFAULT NULL,
  `accion` varchar(100) NOT NULL,
  `detalles` text,
  PRIMARY KEY (`id`),
  KEY `usuario_email` (`usuario_email`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `logs_actividad`
--

INSERT INTO `logs_actividad` (`id`, `fecha`, `usuario_email`, `usuario_nombre`, `accion`, `detalles`) VALUES
(1, '2025-03-25 19:27:13', 'luis.miembro@example.com', NULL, 'Inicio de sesión exitoso', NULL),
(2, '2025-03-25 19:27:27', 'carlos.admin@example.com', NULL, 'Inicio de sesión exitoso', NULL),
(3, '2025-03-25 19:29:47', 'sistema', NULL, 'Actualización de rol', 'Rol: gerente, Descripción: Gerente con permisos de gestión, Permisos: 1, 3'),
(4, '2025-03-25 19:30:34', 'ana.gerente@example.com', NULL, 'Inicio de sesión exitoso', NULL),
(5, '2025-03-25 19:30:50', 'carlos.admin@example.com', NULL, 'Inicio de sesión exitoso', NULL),
(6, '2025-03-25 20:18:36', 'carlos.admin@example.com', NULL, 'Inicio de sesión exitoso', NULL),
(7, '2025-03-25 21:14:43', 'carlos.admin@example.com', NULL, 'Inicio de sesión exitoso', NULL),
(8, '2025-03-27 17:26:01', 'carlos.admin@example.com', NULL, 'Inicio de sesión exitoso', NULL),
(9, '2025-03-27 17:29:04', 'luis.miembro@example.com', NULL, 'Inicio de sesión exitoso', NULL),
(10, '2025-03-27 17:32:21', 'ana.gerente@example.com', NULL, 'Inicio de sesión exitoso', NULL),
(11, '2025-03-27 17:33:26', 'luis.miembro@example.com', NULL, 'Inicio de sesión exitoso', NULL),
(12, '2025-03-27 17:37:11', 'carlos.admin@example.com', NULL, 'Inicio de sesión exitoso', NULL),
(13, '2025-03-27 17:39:38', 'luis.miembro@example.com', NULL, 'Inicio de sesión exitoso', NULL),
(14, '2025-03-27 17:43:09', 'luis.miembro@example.com', NULL, 'Inicio de sesión exitoso', NULL),
(15, '2025-03-27 17:44:17', 'ana.gerente@example.com', NULL, 'Inicio de sesión exitoso', NULL),
(16, '2025-03-27 20:23:08', 'carlos.admin@example.com', NULL, 'Inicio de sesión exitoso', NULL),
(17, '2025-03-27 20:23:31', 'sistema', NULL, 'Actualización de rol', 'Rol: gerente, Descripción: Gerente con permisos de gestión, Permisos: '),
(18, '2025-03-27 21:00:09', 'carlos.admin@example.com', NULL, 'Inicio de sesión exitoso', NULL),
(19, '2025-03-27 21:00:15', 'luis.miembro@example.com', NULL, 'Inicio de sesión exitoso', NULL),
(20, '2025-03-27 21:00:23', 'ana.gerente@example.com', NULL, 'Inicio de sesión exitoso', NULL),
(21, '2025-03-31 02:24:17', 'carlos.admin@example.com', NULL, 'Inicio de sesión exitoso', NULL),
(22, '2025-03-31 02:25:18', 'carlos.admin@example.com', NULL, 'Inicio de sesión exitoso', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs_sistema`
--

DROP TABLE IF EXISTS `logs_sistema`;
CREATE TABLE IF NOT EXISTS `logs_sistema` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mensaje` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `nivel` enum('info','warning','error','critical') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'info',
  `origen` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usuario_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_fecha` (`fecha`),
  KEY `idx_nivel` (`nivel`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `logs_sistema`
--

INSERT INTO `logs_sistema` (`id`, `fecha`, `mensaje`, `nivel`, `origen`, `usuario_id`) VALUES
(1, '2025-03-25 14:16:53', 'Sistema iniciado correctamente', 'info', 'Sistema', NULL),
(2, '2025-03-25 14:16:53', 'Base de datos conectada', 'info', 'Database', NULL),
(3, '2025-03-25 14:16:53', 'Panel de mantenimiento cargado', 'info', 'Mantenimiento', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

DROP TABLE IF EXISTS `permisos`;
CREATE TABLE IF NOT EXISTS `permisos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`id`, `nombre`, `descripcion`) VALUES
(1, 'crear_usuarios', 'Permiso para crear nuevos usuarios'),
(2, 'editar_usuarios', 'Permiso para editar usuarios existentes'),
(3, 'eliminar_usuarios', 'Permiso para eliminar usuarios'),
(4, 'ver_reportes', 'Permiso para ver reportes del sistema'),
(5, 'gestionar_roles', 'Permiso para gestionar roles y permisos'),
(6, 'configurar_sistema', 'Permiso para configurar el sistema');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `restore_logs`
--

DROP TABLE IF EXISTS `restore_logs`;
CREATE TABLE IF NOT EXISTS `restore_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `backup_id` int NOT NULL,
  `restored_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_backup_id` (`backup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `rol` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rol`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`rol`, `descripcion`) VALUES
('admin', 'Administrador con todos los permisos'),
('gerente', 'Gerente con permisos de gestión'),
('miembro', 'Usuario básico con permisos limitados');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_permisos`
--

DROP TABLE IF EXISTS `rol_permisos`;
CREATE TABLE IF NOT EXISTS `rol_permisos` (
  `rol` varchar(50) NOT NULL,
  `permiso_id` int NOT NULL,
  PRIMARY KEY (`rol`,`permiso_id`),
  KEY `permiso_id` (`permiso_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `rol_permisos`
--

INSERT INTO `rol_permisos` (`rol`, `permiso_id`) VALUES
('admin', 1),
('admin', 2),
('admin', 3),
('admin', 4),
('admin', 5),
('admin', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas`
--

DROP TABLE IF EXISTS `tareas`;
CREATE TABLE IF NOT EXISTS `tareas` (
  `id` int NOT NULL,
  `nombreProyecto` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_general_ci,
  `fechaInicio` date DEFAULT NULL,
  `fechaFin` date DEFAULT NULL,
  `creadoPor` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `estado` enum('pendiente','en_progreso','completada') COLLATE utf8mb4_general_ci DEFAULT 'pendiente',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tareas`
--

INSERT INTO `tareas` (`id`, `nombreProyecto`, `descripcion`, `fechaInicio`, `fechaFin`, `creadoPor`, `estado`, `created_at`) VALUES
(1, 'login', 'login consumiendo api de google', '2025-03-27', '2025-04-04', '', 'pendiente', '2025-03-26 11:24:35'),
(2, 'Dashboard', 'Diagramas de avances y progresos', '2025-04-03', '2025-04-10', '', 'completada', '2025-03-27 04:04:44'),
(0, 'ZXC', 'ZXC', '2025-03-27', '2025-03-28', '', 'pendiente', '2025-03-27 21:00:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `rol` varchar(50) NOT NULL DEFAULT 'miembro',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_usuario_rol` (`rol`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `contraseña`, `fecha_registro`, `rol`) VALUES
(1, 'Carlos Admin', 'carlos.admin@example.com', 'password123', '2025-03-19 15:51:46', 'admin'),
(2, 'Ana Gerente', 'ana.gerente@example.com', 'password456', '2025-03-19 15:51:46', 'gerente'),
(3, 'Luis Miembro', 'luis.miembro@example.com', 'password789', '2025-03-19 15:51:46', 'miembro'),
(4, 'Antonio juan pretronilo', 'Aqui@primeraPrueba.com', '12345678', '2025-03-19 16:00:03', 'miembro'),
(6, 'asde', 'alex909w@gmail.com', '12345678', '2025-03-25 17:03:21', 'miembro');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `restore_logs`
--
ALTER TABLE `restore_logs`
  ADD CONSTRAINT `fk_backup_id` FOREIGN KEY (`backup_id`) REFERENCES `backups` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
