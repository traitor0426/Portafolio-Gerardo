-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ohmymakers
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `proveedoresproductos`
--

DROP TABLE IF EXISTS `proveedoresproductos`;
/*!50001 DROP VIEW IF EXISTS `proveedoresproductos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `proveedoresproductos` AS SELECT 
 1 AS `codigoProducto`,
 1 AS `NombreProducto`,
 1 AS `precio`,
 1 AS `stock`,
 1 AS `compaÃ±ia`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `empeladoscurptelmun`
--

DROP TABLE IF EXISTS `empeladoscurptelmun`;
/*!50001 DROP VIEW IF EXISTS `empeladoscurptelmun`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `empeladoscurptelmun` AS SELECT 
 1 AS `NoEmpleado`,
 1 AS `Nombre`,
 1 AS `CURP`,
 1 AS `NoTelefono`,
 1 AS `Municipio`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `entregasmetpagen`
--

DROP TABLE IF EXISTS `entregasmetpagen`;
/*!50001 DROP VIEW IF EXISTS `entregasmetpagen`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `entregasmetpagen` AS SELECT 
 1 AS `NoEntrega`,
 1 AS `MetodoPago`,
 1 AS `TipoEnvio`,
 1 AS `Total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `catalogo`
--

DROP TABLE IF EXISTS `catalogo`;
/*!50001 DROP VIEW IF EXISTS `catalogo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `catalogo` AS SELECT 
 1 AS `codigoProducto`,
 1 AS `NombreProducto`,
 1 AS `NombreCategoria`,
 1 AS `precio`,
 1 AS `stock`,
 1 AS `descripcion`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `ventasproductos`
--

DROP TABLE IF EXISTS `ventasproductos`;
/*!50001 DROP VIEW IF EXISTS `ventasproductos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ventasproductos` AS SELECT 
 1 AS `NoVenta`,
 1 AS `codigoProducto`,
 1 AS `NombreProducto`,
 1 AS `FechaVenta`,
 1 AS `descripcion`,
 1 AS `precio`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `proveedorcomp`
--

DROP TABLE IF EXISTS `proveedorcomp`;
/*!50001 DROP VIEW IF EXISTS `proveedorcomp`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `proveedorcomp` AS SELECT 
 1 AS `CodigoProveedor`,
 1 AS `CompaÃ±ia`,
 1 AS `NombreContacto`,
 1 AS `ApellidoPat`,
 1 AS `ApellidoMat`,
 1 AS `Calle`,
 1 AS `noExterior`,
 1 AS `colonia`,
 1 AS `CP`,
 1 AS `Municipio`,
 1 AS `Estado`,
 1 AS `telefono`,
 1 AS `eMail`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `entregasproductos`
--

DROP TABLE IF EXISTS `entregasproductos`;
/*!50001 DROP VIEW IF EXISTS `entregasproductos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `entregasproductos` AS SELECT 
 1 AS `NoEntrega`,
 1 AS `codigoProducto`,
 1 AS `NombreProducto`,
 1 AS `FechaPedido`,
 1 AS `FechaEntrega`,
 1 AS `descripcion`,
 1 AS `precio`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `proveedoresproductos`
--

/*!50001 DROP VIEW IF EXISTS `proveedoresproductos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `proveedoresproductos` AS select `productos`.`codigoProducto` AS `codigoProducto`,`productos`.`NombreProducto` AS `NombreProducto`,`productos`.`Precio` AS `precio`,`productos`.`Stock` AS `stock`,`proveedores`.`Compa¤ia` AS `compa¤ia` from (`productos` join `proveedores`) where (`productos`.`CodigoProveedor` = `proveedores`.`CodigoProveedor`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `empeladoscurptelmun`
--

/*!50001 DROP VIEW IF EXISTS `empeladoscurptelmun`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `empeladoscurptelmun` AS select `empleados`.`NoEmpleado` AS `NoEmpleado`,`empleados`.`Nombre` AS `Nombre`,`curpempleados`.`CURP` AS `CURP`,`notelefonoempleados`.`NoTelefono` AS `NoTelefono`,`empleados`.`Municipio` AS `Municipio` from ((`empleados` join `curpempleados`) join `notelefonoempleados`) where ((`empleados`.`NoEmpleado` = `curpempleados`.`NoEmpleado`) and (`empleados`.`NoEmpleado` = `notelefonoempleados`.`NoEmpleado`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `entregasmetpagen`
--

/*!50001 DROP VIEW IF EXISTS `entregasmetpagen`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `entregasmetpagen` AS select `entregas`.`NoEntrega` AS `NoEntrega`,`metodopagoentregas`.`MetodoPago` AS `MetodoPago`,`tipoenvioentregas`.`TipoEnvio` AS `TipoEnvio`,`entregas`.`Total` AS `Total` from ((`entregas` join `metodopagoentregas`) join `tipoenvioentregas`) where ((`entregas`.`NoEntrega` = `metodopagoentregas`.`NoEntrega`) and (`entregas`.`NoEntrega` = `tipoenvioentregas`.`NoEntrega`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `catalogo`
--

/*!50001 DROP VIEW IF EXISTS `catalogo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `catalogo` AS select `productos`.`codigoProducto` AS `codigoProducto`,`productos`.`NombreProducto` AS `NombreProducto`,`categorias`.`NombreCategoria` AS `NombreCategoria`,`productos`.`Precio` AS `precio`,`productos`.`Stock` AS `stock`,`productos`.`Descripcion` AS `descripcion` from (`productos` join `categorias`) where (`categorias`.`claveCategoria` = `productos`.`claveCategoria`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ventasproductos`
--

/*!50001 DROP VIEW IF EXISTS `ventasproductos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ventasproductos` AS select `tiene`.`NoVenta` AS `NoVenta`,`tiene`.`codigoProducto` AS `codigoProducto`,`productos`.`NombreProducto` AS `NombreProducto`,`ventasfisicas`.`FechaVenta` AS `FechaVenta`,`productos`.`Descripcion` AS `descripcion`,`productos`.`Precio` AS `precio` from ((`productos` join `tiene`) join `ventasfisicas`) where ((`ventasfisicas`.`NoVenta` = `tiene`.`NoVenta`) and (`productos`.`codigoProducto` = `tiene`.`codigoProducto`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `proveedorcomp`
--

/*!50001 DROP VIEW IF EXISTS `proveedorcomp`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `proveedorcomp` AS select `proveedores`.`CodigoProveedor` AS `CodigoProveedor`,`proveedores`.`Compa¤ia` AS `Compa¤ia`,`proveedores`.`NombreContacto` AS `NombreContacto`,`proveedores`.`ApellidoPat` AS `ApellidoPat`,`proveedores`.`ApellidoMat` AS `ApellidoMat`,`proveedores`.`Calle` AS `Calle`,`proveedores`.`noExterior` AS `noExterior`,`proveedores`.`colonia` AS `colonia`,`proveedores`.`CP` AS `CP`,`proveedores`.`Municipio` AS `Municipio`,`proveedores`.`Estado` AS `Estado`,`telefonoproveedores`.`telefono` AS `telefono`,`emailproveedores`.`eMail` AS `eMail` from ((`proveedores` join `telefonoproveedores`) join `emailproveedores`) where ((`proveedores`.`CodigoProveedor` = `telefonoproveedores`.`CodigoProveedor`) and (`proveedores`.`CodigoProveedor` = `emailproveedores`.`CodigoProveedor`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `entregasproductos`
--

/*!50001 DROP VIEW IF EXISTS `entregasproductos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `entregasproductos` AS select `existe`.`NoEntrega` AS `NoEntrega`,`existe`.`codigoProducto` AS `codigoProducto`,`productos`.`NombreProducto` AS `NombreProducto`,`entregas`.`FechaPedido` AS `FechaPedido`,`entregas`.`FechaEntrega` AS `FechaEntrega`,`productos`.`Descripcion` AS `descripcion`,`productos`.`Precio` AS `precio` from ((`productos` join `existe`) join `entregas`) where ((`entregas`.`NoEntrega` = `existe`.`NoEntrega`) and (`productos`.`codigoProducto` = `existe`.`codigoProducto`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'ohmymakers'
--

--
-- Dumping routines for database 'ohmymakers'
--
/*!50003 DROP PROCEDURE IF EXISTS `agregarCategorias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarCategorias`(in claveCat varchar(10), in nombreCat varchar(20), in descripcionCat varchar(100))
BEGIN
INSERT INTO Categorias VALUES (claveCat, nombreCat, descripcionCat);
SELECT * FROM Categorias;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `agregarCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarCliente`(in NoCli varchar(10), in NombreCli varchar(20), in ApellidoPCli varchar(20), 
in ApellidoMCli varchar(20), CalleCli varchar(20), noExtCli varchar(20), coloniaCli varchar(20), CPCli varchar(10),
in MunicipioCli varchar(20), EstadoCli varchar(20))
BEGIN
INSERT INTO Clientes VALUES (NoCli, NombreCli, ApellidoPCli, ApellidoMCli, CalleCli, noExtCli, coloniaCli, 
CPCli, MunicipioCli, EstadoCli);
SELECT * FROM Clientes; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `agregarEmpleado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarEmpleado`(in numeroEmp varchar(10), in nombreEmp varchar(20), 
in apellidoPEmp varchar(20), in apellidoMEmp varchar(20), 
in calleEmp varchar(20), in noExtEmp varchar(20), in coloniaEmp varchar(20), 
in cpEmp varchar(10), in municipioEmp varchar(20), in estadoEmp varchar(20), 
in sueldoEmp float)
BEGIN 
INSERT INTO Empleados VALUES (numeroEmp, nombreEmp, apellidoPEmp, apellidoMEmp, 
calleEmp, noExtEmp, coloniaEmp, cpEmp, municipioEmp, estadoEmp,
sueldoEmp);
SELECT * FROM Empleados; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `agregarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarProducto`(in codigoPro varchar(10), in nombrePro varchar(20), in descripcionPro varchar(100), in stockPro tinyint, in precioPro float, in codigoProv varchar(10), in categoriaP varchar(10))
BEGIN 
INSERT INTO Productos VALUES (codigoPro, nombrePro, descripcionPro, stockPro, precioPro, codigoProv, categoriaP);
SELECT * FROM Productos; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `agregarProveedor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarProveedor`(in codigoProv varchar(10), in compa¤iaProv varchar(20), in nombreContacProv varchar(20), 
in apellidoPProv varchar(20), in apellidoMProv varchar(20), in calleProv varchar(20), in noExtProv varchar(10), in coloniaProv varchar(20), 
in CPProv varchar(10), in MunicipioProv varchar(20), in EstadoProv varchar(20))
BEGIN
INSERT INTO Proveedores VALUES (codigoProv, compa¤iaProv, nombreContacProv, apellidoPProv, apellidoMProv, calleProv, noExtProv, coloniaProv,  
CPProv, MunicipioProv, EstadoProv);
SELECT * FROM Proveedores; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `aumentoProductosPlu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `aumentoProductosPlu`()
BEGIN 
SET @productosar = (SELECT MIN(Precio) FROM Productos);
UPDATE Productos SET Precio = Precio * .80 
WHERE Precio = @productosar;
SELECT * FROM Productos; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultarCantProduMasVen` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarCantProduMasVen`()
BEGIN 
SELECT Productos.codigoProducto, NombreProducto, claveCategoria, Precio, CantidadProductos FROM 
Productos, tiene WHERE Productos.CodigoProducto = tiene.CodigoProducto AND 
CantidadProductos = (SELECT MAX(CantidadProductos) FROM tiene);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultarEmpleadoCMasPrecio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarEmpleadoCMasPrecio`()
BEGIN 
SELECT ventasFisicas.NoEmpleado, Nombre, ApellidoPat, ApellidoMat FROM 
VentasFisicas, Empleados WHERE Empleados.NoEmpleado = VentasFisicas.NoEmpleado AND 
TotalVenta = (SELECT MAX(TotalVenta) FROM ventasFisicas WHERE 
FechaVenta >= '2022-06-01' AND FechaVenta <= '2022-06-30');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultarEntregasCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarEntregasCliente`()
BEGIN 
SELECT NoEntrega, FechaPedido, FechaEntrega, Entregas.Calle, Entregas.noExterior, 
Entregas.colonia, Entregas.CP, Entregas.Municipio,
Entregas.Estado, Total, NoEmpleado, Entregas.NoCliente, Nombre, ApellidoPat, ApellidoMat 
FROM Entregas, Clientes WHERE Entregas.NoCliente = Clientes.NoCliente AND Total = 
(SELECT Total FROM Entregas WHERE Total >= 1000);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultarProductoCat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarProductoCat`()
BEGIN 
SELECT codigoProducto, NombreProducto, Productos.Descripcion, Stock, Precio, CodigoProveedor, Productos.claveCategoria, NombreCategoria
FROM Productos, Categorias WHERE Productos.claveCategoria = Categorias.claveCategoria
AND Precio IN (SELECT Precio FROM Productos WHERE Precio <= 150); 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultarProductoCMenosStock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarProductoCMenosStock`()
BEGIN
SELECT codigoProducto, NombreProducto, claveCategoria, Precio, stock, Productos.CodigoProveedor, Compa¤ia
FROM Productos, Proveedores WHERE Productos.CodigoProveedor = Proveedores.CodigoProveedor 
AND stock = (SELECT stock FROM Productos WHERE stock <= 3);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `descuento5Venta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `descuento5Venta`()
BEGIN 
SET @totalMayor = (SELECT TotalVenta FROM VentasFisicas WHERE TotalVenta > 1000); 
UPDATE VentasFisicas SET TotalVenta = TotalVenta *.95 WHERE 
TotalVenta = @totalMayor; 
SELECT * FROM VentasFisicas; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `descuentosProductos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `descuentosProductos`()
BEGIN 
SET @costoMayorP = (SELECT MAX(Precio) FROM Productos);
UPDATE Productos SET Precio = Precio * .80 WHERE 
Precio = @costoMayorP; 
SELECT * FROM Productos;  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `empleadosConSueldoMenor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `empleadosConSueldoMenor`()
BEGIN 
SET @sueldomenor = (SELECT MIN(Sueldo) FROM Empleados);
UPDATE Empleados SET Sueldo = Sueldo + 1200 WHERE 
Sueldo = @sueldomenor;
SELECT * FROM Empleados; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `entregasMayorADosMil` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `entregasMayorADosMil`()
BEGIN 
SET @entregamayor = (SELECT Total FROM Entregas WHERE Total > 1000);
UPDATE Entregas SET Total = Total * .90 WHERE
Total = @entregamayor;
SELECT * FROM Entregas; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-13 14:26:31
