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
-- Table structure for table `ventasfisicas`
--

DROP TABLE IF EXISTS `ventasfisicas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventasfisicas` (
  `NoVenta` varchar(10) NOT NULL,
  `FechaVenta` datetime DEFAULT NULL,
  `TotalVenta` float DEFAULT NULL,
  `NoEmpleado` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`NoVenta`),
  KEY `Fk_VentasFisiEmpleado` (`NoEmpleado`),
  CONSTRAINT `Fk_VentasFisiEmpleado` FOREIGN KEY (`NoEmpleado`) REFERENCES `empleados` (`NoEmpleado`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventasfisicas`
--

LOCK TABLES `ventasfisicas` WRITE;
/*!40000 ALTER TABLE `ventasfisicas` DISABLE KEYS */;
INSERT INTO `ventasfisicas` VALUES ('v-002','2022-04-27 00:00:00',2850,'em-002'),('v-003','2022-02-11 00:00:00',430,'em-003'),('v-004','2022-06-13 00:00:00',340,'em-004'),('v-005','2022-06-28 00:00:00',315,'em-005'),('v-006','2022-06-29 00:00:00',270,'em-006'),('v-007','2022-08-11 00:00:00',80,'em-007'),('v-008','2022-08-24 00:00:00',360,'em-008'),('v-009','2022-08-30 00:00:00',260,'em-009'),('v-010','2022-09-21 00:00:00',260,'em-010'),('v-011','2022-11-24 00:00:00',185,'em-007');
/*!40000 ALTER TABLE `ventasfisicas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-13 14:26:30
