/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.7.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: scuolaweb
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES
(1,'admin','admin123');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classi`
--

DROP TABLE IF EXISTS `classi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `classi` (
  `classe` varchar(10) NOT NULL,
  `n_alunni` int(11) NOT NULL,
  PRIMARY KEY (`classe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classi`
--

LOCK TABLES `classi` WRITE;
/*!40000 ALTER TABLE `classi` DISABLE KEYS */;
INSERT INTO `classi` VALUES
('4A INF',22),
('5A INF',20);
/*!40000 ALTER TABLE `classi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `docenti`
--

DROP TABLE IF EXISTS `docenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `docenti` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nome_materia` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `nome_materia` (`nome_materia`),
  CONSTRAINT `docenti_ibfk_1` FOREIGN KEY (`nome_materia`) REFERENCES `materie` (`nome_materia`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `docenti`
--

LOCK TABLES `docenti` WRITE;
/*!40000 ALTER TABLE `docenti` DISABLE KEYS */;
INSERT INTO `docenti` VALUES
(1,'Mario','Rossi','pass','Informatica'),
(2,'Laura','Bianchi','pass','Sistemi e Reti'),
(3,'Giuseppe','Verdi','pass','Matematica'),
(4,'Anna','Neri','pass','Italiano'),
(5,'Roberto','Gialli','pass','Inglese');
/*!40000 ALTER TABLE `docenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `giorni`
--

DROP TABLE IF EXISTS `giorni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `giorni` (
  `nome_giorno` varchar(15) NOT NULL,
  PRIMARY KEY (`nome_giorno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `giorni`
--

LOCK TABLES `giorni` WRITE;
/*!40000 ALTER TABLE `giorni` DISABLE KEYS */;
INSERT INTO `giorni` VALUES
('Giovedì'),
('Lunedì'),
('Martedì'),
('Mercoledì'),
('Sabato'),
('Venerdì');
/*!40000 ALTER TABLE `giorni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materie`
--

DROP TABLE IF EXISTS `materie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `materie` (
  `nome_materia` varchar(50) NOT NULL,
  PRIMARY KEY (`nome_materia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materie`
--

LOCK TABLES `materie` WRITE;
/*!40000 ALTER TABLE `materie` DISABLE KEYS */;
INSERT INTO `materie` VALUES
('Informatica'),
('Inglese'),
('Italiano'),
('Matematica'),
('Sistemi e Reti');
/*!40000 ALTER TABLE `materie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orari`
--

DROP TABLE IF EXISTS `orari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `orari` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_docente` int(11) DEFAULT NULL,
  `nome_giorno` varchar(15) DEFAULT NULL,
  `orario_inizio` time NOT NULL,
  `orario_fine` time NOT NULL,
  `classe` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_docente` (`id_docente`),
  KEY `nome_giorno` (`nome_giorno`),
  KEY `classe` (`classe`),
  CONSTRAINT `orari_ibfk_1` FOREIGN KEY (`id_docente`) REFERENCES `docenti` (`id`) ON DELETE CASCADE,
  CONSTRAINT `orari_ibfk_2` FOREIGN KEY (`nome_giorno`) REFERENCES `giorni` (`nome_giorno`) ON DELETE CASCADE,
  CONSTRAINT `orari_ibfk_3` FOREIGN KEY (`classe`) REFERENCES `classi` (`classe`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orari`
--

LOCK TABLES `orari` WRITE;
/*!40000 ALTER TABLE `orari` DISABLE KEYS */;
INSERT INTO `orari` VALUES
(1,1,'Lunedì','08:00:00','10:00:00','5A INF'),
(2,3,'Lunedì','10:00:00','11:00:00','5A INF'),
(3,5,'Lunedì','11:00:00','13:00:00','5A INF'),
(4,2,'Martedì','08:00:00','10:00:00','5A INF'),
(5,1,'Martedì','10:00:00','12:00:00','5A INF'),
(6,4,'Martedì','12:00:00','13:00:00','5A INF'),
(7,3,'Mercoledì','08:00:00','10:00:00','5A INF'),
(8,2,'Mercoledì','10:00:00','11:00:00','5A INF'),
(9,4,'Mercoledì','11:00:00','13:00:00','5A INF'),
(10,5,'Giovedì','08:00:00','09:00:00','5A INF'),
(11,1,'Giovedì','09:00:00','11:00:00','5A INF'),
(12,3,'Giovedì','11:00:00','13:00:00','5A INF'),
(13,4,'Venerdì','08:00:00','10:00:00','5A INF'),
(14,2,'Venerdì','10:00:00','12:00:00','5A INF'),
(15,5,'Venerdì','12:00:00','13:00:00','5A INF'),
(16,1,'Sabato','08:00:00','09:00:00','5A INF'),
(17,3,'Sabato','09:00:00','11:00:00','5A INF'),
(18,2,'Sabato','11:00:00','13:00:00','5A INF'),
(19,4,'Lunedì','08:00:00','10:00:00','4A INF'),
(20,2,'Lunedì','10:00:00','12:00:00','4A INF'),
(21,3,'Lunedì','12:00:00','13:00:00','4A INF'),
(22,1,'Martedì','08:00:00','09:00:00','4A INF'),
(23,5,'Martedì','09:00:00','11:00:00','4A INF'),
(24,2,'Martedì','11:00:00','13:00:00','4A INF'),
(25,5,'Mercoledì','08:00:00','10:00:00','4A INF'),
(26,3,'Mercoledì','10:00:00','12:00:00','4A INF'),
(27,1,'Mercoledì','12:00:00','13:00:00','4A INF'),
(28,2,'Giovedì','08:00:00','10:00:00','4A INF'),
(29,4,'Giovedì','10:00:00','11:00:00','4A INF'),
(30,5,'Giovedì','11:00:00','13:00:00','4A INF'),
(31,3,'Venerdì','08:00:00','10:00:00','4A INF'),
(32,1,'Venerdì','10:00:00','12:00:00','4A INF'),
(33,4,'Venerdì','12:00:00','13:00:00','4A INF'),
(34,5,'Sabato','08:00:00','09:00:00','4A INF'),
(35,2,'Sabato','09:00:00','11:00:00','4A INF'),
(36,4,'Sabato','11:00:00','13:00:00','4A INF');
/*!40000 ALTER TABLE `orari` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studenti`
--

DROP TABLE IF EXISTS `studenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `studenti` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `classe` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `classe` (`classe`),
  CONSTRAINT `studenti_ibfk_1` FOREIGN KEY (`classe`) REFERENCES `classi` (`classe`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studenti`
--

LOCK TABLES `studenti` WRITE;
/*!40000 ALTER TABLE `studenti` DISABLE KEYS */;
INSERT INTO `studenti` VALUES
(1,'Luca','Fumagalli','stud1','5A INF'),
(2,'Sofia','Esposito','stud2','5A INF'),
(3,'Marco','Rizzo','stud3','4A INF'),
(4,'Elena','Galli','stud4','4A INF');
/*!40000 ALTER TABLE `studenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voti`
--

DROP TABLE IF EXISTS `voti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `voti` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_studente` int(11) NOT NULL,
  `id_docente` int(11) NOT NULL,
  `voto` decimal(4,2) NOT NULL,
  `data` date NOT NULL,
  `descrizione` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_studente` (`id_studente`),
  KEY `id_docente` (`id_docente`),
  CONSTRAINT `voti_ibfk_1` FOREIGN KEY (`id_studente`) REFERENCES `studenti` (`id`) ON DELETE CASCADE,
  CONSTRAINT `voti_ibfk_2` FOREIGN KEY (`id_docente`) REFERENCES `docenti` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voti`
--

LOCK TABLES `voti` WRITE;
/*!40000 ALTER TABLE `voti` DISABLE KEYS */;
INSERT INTO `voti` VALUES
(1,1,1,8.50,'2024-05-01','Verifica Java'),
(2,1,3,6.00,'2024-05-05','Interrogazione Analisi'),
(3,2,1,7.00,'2024-05-01','Verifica Java'),
(4,3,4,9.00,'2024-05-06','Tema letteratura'),
(5,4,2,5.50,'2024-05-07','Test Reti');
/*!40000 ALTER TABLE `voti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'scuolaweb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-05-20  8:20:47
