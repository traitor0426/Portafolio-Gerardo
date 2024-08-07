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
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `NoEmpleado` varchar(10) NOT NULL,
  `Nombre` varchar(20) DEFAULT NULL,
  `ApellidoPat` varchar(20) DEFAULT NULL,
  `ApellidoMat` varchar(20) DEFAULT NULL,
  `Calle` varchar(20) DEFAULT NULL,
  `noExterior` varchar(20) DEFAULT NULL,
  `colonia` varchar(20) DEFAULT NULL,
  `CP` varchar(10) DEFAULT NULL,
  `Municipio` varchar(20) DEFAULT NULL,
  `Estado` varchar(20) DEFAULT NULL,
  `Sueldo` float DEFAULT NULL,
  PRIMARY KEY (`NoEmpleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES ('em-002','Lourdes','Landero','Escobar','Pascuala vazquez','55','Gavilán','93629','San Rafael','Veracruz',3000),('em-003','Alfonso','Hernández','Bautista','Ignacio Zaragoza','667','Colosio','94365','Tlapacoyan','Veracruz',5000),('em-004','Eliseo','Jacobo','Landero','Miguel de Iturbide','621','Costitucion','94365','Tlapacoyan','Veracruz',3000),('em-005','Alberto','Gonzalez','Calderon','Cuahutemoc','202','Centro','91234','Martinez','Veracruz',3000),('em-006','Reyna','Caballero','Ramos','Cuahutemoc','433','Cualquiera','91234','Martinez','Veracruz',2500),('em-007','Irene','Carmona','Martínez','Manuel Camacho','55','Rodriguez cano','93506','Martinez','Veracruz',3000),('em-008','Daniel','Aguirre','Jaimes','Emiliano zapata','78','Rojo Gomez','93506','Martinez','Veracruz',5000),('em-009','Fabiola','Castañeda','Cruz','Isabel de castillo','356','Vernandita','95608','Martinez','Veracruz',3000),('em-010','Laura','Díaz','Vazquez','Maricruz de allende','544','El Progreso','94336','Martinez','Veracruz',3000),('em-011','Adela','Bello','Vazquez','Dinamark','100','Cotitución','94336','Martinez','Veracruz',3000),('em-012','Christine','Dominguez','Herrera','La espaldilla','45','Cerro Azul','7890','Martínez','Veracruz',3545);
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-13 14:26:31
