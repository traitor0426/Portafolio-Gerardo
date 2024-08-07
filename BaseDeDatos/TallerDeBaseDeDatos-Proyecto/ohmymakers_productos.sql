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
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `codigoProducto` varchar(10) NOT NULL,
  `NombreProducto` varchar(20) DEFAULT NULL,
  `Descripcion` varchar(100) DEFAULT NULL,
  `Stock` tinyint DEFAULT NULL,
  `Precio` float DEFAULT NULL,
  `CodigoProveedor` varchar(10) DEFAULT NULL,
  `claveCategoria` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`codigoProducto`),
  KEY `Fk_ProducProveedor` (`CodigoProveedor`),
  KEY `Fk_ProducCategorias` (`claveCategoria`),
  CONSTRAINT `Fk_ProducCategorias` FOREIGN KEY (`claveCategoria`) REFERENCES `categorias` (`claveCategoria`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Fk_ProducProveedor` FOREIGN KEY (`CodigoProveedor`) REFERENCES `proveedores` (`CodigoProveedor`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES ('P-001','Libreta Van Gogh','Libreta tamaño francés hoja punteada  105 g',20,243.6,'pv-002','C-005'),('P-004','Plumones Clickart','Plumones retractiles base agua, punta media, 12 piezas, gama pastel',20,360.192,'pv-003','C-002'),('P-005','Plumones Tombow','Plumones punta pincel Tombow base agua, doble punta, 6 piezas',20,394.8,'pv-002','C-006'),('P-006','Plumones Zig Brush','Plumones punta pincel doble punta base agua, gama morados',20,331.8,'pv-006','C-006'),('P-007','Plumon perm Sharpie','Plumon punta fina color negro',20,94.08,'pv-007','C-002'),('P-008','Colores Indra','Colores de madera 36 colores, madera negra, punta 0.4 mm',20,369.6,'pv-005','C-001'),('P-009','Paquete Gelly Roll','Lapiceros de gel que escriben en hoja negra, 12 piezas',20,310.8,'pv-006','C-004'),('P-010','Post it otoño','Post its con forma de hoja otoñal.',20,134.4,'pv-004','C-007'),('P-011','Stickers picnic day','Set de stickers color durazno',20,151.2,'pv-008','C-008'),('P-012','Post-its animalitos','Set de post-its',20,151.2,'pv-009','C-007'),('P-013','Washi cuadros','Washi tape color café con estampado de cuadros.',20,130.2,'pv-010','C-010'),('P-014','Stickers gama azul','Stickers color azul',20,130.2,'pv-003','C-008'),('P-015','Rosyposy vol. 1','Libreta de stickers',20,239.4,'pv-002','C-008'),('P-016','Rosyposy vol. 2','Libreta de stickers',20,239.4,'pv-002','C-008'),('P-017','Rosyposy vol. 3','Libreta de stickers',20,239.4,'pv-002','C-008'),('P-018','Libreta snoopy','Libreta de gramaje alto',10,268.8,'pv-004','C-005'),('P-019','Libreta mini','Libreta de gramaje alto',10,142.8,'pv-004','C-005'),('P-020','Lapiceros bic','Lapiceros de gel',10,210,'pv-004','C-004'),('p-021','Marcadores Eco','Marcadores tinta base agua',2,210,'pv-004','C-006'),('p-050','Lapiz','Lapiz del no. 2',10,2,'pv-004','C-006');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-13 14:26:29
