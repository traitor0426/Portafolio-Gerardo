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
-- Table structure for table `entregas`
--

DROP TABLE IF EXISTS `entregas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entregas` (
  `NoEntrega` varchar(10) NOT NULL,
  `FechaPedido` datetime DEFAULT NULL,
  `FechaEntrega` datetime DEFAULT NULL,
  `Calle` varchar(20) DEFAULT NULL,
  `noExterior` varchar(10) DEFAULT NULL,
  `colonia` varchar(20) DEFAULT NULL,
  `CP` varchar(10) DEFAULT NULL,
  `Municipio` varchar(20) DEFAULT NULL,
  `Estado` varchar(20) DEFAULT NULL,
  `Total` float DEFAULT NULL,
  `NoEmpleado` varchar(10) DEFAULT NULL,
  `NoCliente` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`NoEntrega`),
  KEY `Fk_EntregasEmpleado` (`NoEmpleado`),
  KEY `Fk_Clientes` (`NoCliente`),
  CONSTRAINT `Fk_Clientes` FOREIGN KEY (`NoCliente`) REFERENCES `clientes` (`NoCliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Fk_EntregasEmpleado` FOREIGN KEY (`NoEmpleado`) REFERENCES `empleados` (`NoEmpleado`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entregas`
--

LOCK TABLES `entregas` WRITE;
/*!40000 ALTER TABLE `entregas` DISABLE KEYS */;
INSERT INTO `entregas` VALUES ('en-001','2022-06-12 00:00:00','2022-06-13 00:00:00','Maclovio Herrera','111','Francisco Villa','93610','Martínez de la Torre','Veracruz',201.6,'em-002','cl-001'),('en-002','2022-06-12 00:00:00','2022-06-13 00:00:00','Leona Vicario','103','Altamirano','93610','Martínez de la Torre','Veracruz',142.8,'em-002','cl-002'),('en-003','2022-06-30 00:00:00','2022-07-05 00:00:00','Pino Suarez','123','Francisco Villa','93610','Martínez de la Torre','Veracruz',151.2,'em-003','cl-003'),('en-004','2022-07-20 00:00:00','2022-07-25 00:00:00','Josefa Ortiz','145','Centro','93600','Martínez de la Torre','Veracruz',294,'em-004','cl-004'),('en-005','2022-07-21 00:00:00','2022-07-25 00:00:00','Manuel Avila Camacho','234','Centro','93600','Martínez de la Torre','Veracruz',294,'em-005','cl-005'),('en-006','2022-07-22 00:00:00','2022-07-25 00:00:00','Gabriela Mistral','212','Centro','93600','Martínez de la Torre','Veracruz',268.8,'em-006','cl-006'),('en-007','2022-07-24 00:00:00','2022-07-25 00:00:00','Rodriguez rivera','566','Elba Ester','93600','Martínez de la Torre','Veracruz',210,'em-007','cl-007'),('en-008','2022-09-13 00:00:00','2022-09-18 00:00:00','16 de septiembre','788','Angelopolis','72000','Puebla','Puebla',462,'em-008','cl-008'),('en-009','2022-09-15 00:00:00','2022-09-20 00:00:00','16 sur','999','Angelopolis','72000','Puebla','Puebla',231,'em-009','cl-009'),('en-010','2022-09-16 00:00:00','2022-09-26 00:00:00','Santa Trinidad','344','Ampliación Reforma','72000','Puebla','Puebla',462,'em-010','cl-010'),('en-012','2022-06-05 00:00:00','2022-06-10 00:00:00','Maclovio Herrera','111','Francisco Villa','93610','Martínez de la Torre','Veracruz',937.44,'em-005','cl-002');
/*!40000 ALTER TABLE `entregas` ENABLE KEYS */;
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
