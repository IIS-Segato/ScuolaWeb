-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 23, 2026 alle 14:46
-- Versione del server: 10.4.32-MariaDB
-- Versione PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `scuola`
--
CREATE DATABASE IF NOT EXISTS `scuola` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `scuola`;

-- --------------------------------------------------------

--
-- Struttura della tabella `amministratori`
--

DROP TABLE IF EXISTS `amministratori`;
CREATE TABLE `amministratori` (
  `aid` int(11) NOT NULL,
  `email` varchar(80) NOT NULL,
  `password` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `amministratori`
--

INSERT INTO `amministratori` (`aid`, `email`, `password`) VALUES
(1, 'direzione@scuola.it', 'admin');

-- --------------------------------------------------------

--
-- Struttura della tabella `classi`
--

DROP TABLE IF EXISTS `classi`;
CREATE TABLE `classi` (
  `cid` int(11) NOT NULL,
  `anno` int(11) NOT NULL,
  `sezione` varchar(3) NOT NULL
) ;

--
-- Dump dei dati per la tabella `classi`
--

INSERT INTO `classi` (`cid`, `anno`, `sezione`) VALUES
(1, 1, 'A'),
(2, 1, 'B'),
(3, 2, 'A'),
(4, 2, 'B'),
(5, 3, 'A'),
(6, 3, 'B'),
(7, 4, 'A'),
(8, 4, 'B'),
(9, 5, 'A'),
(10, 5, 'B');

-- --------------------------------------------------------

--
-- Struttura della tabella `docenti`
--

DROP TABLE IF EXISTS `docenti`;
CREATE TABLE `docenti` (
  `did` int(11) NOT NULL,
  `email` varchar(80) NOT NULL,
  `password` varchar(80) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `cognome` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `docenti`
--

INSERT INTO `docenti` (`did`, `email`, `password`, `nome`, `cognome`) VALUES
(1, 'm.conti@scuola.it', 'A7!dkP9#qL', 'Matteo', 'Conti'),
(2, 'l.greco@scuola.it', 'Zx3@Lm8!Rt', 'Laura', 'Greco'),
(3, 'f.rinaldi@scuola.it', 'Qw9#Bn2$Ye', 'Francesco', 'Rinaldi'),
(4, 'c.mancini@scuola.it', 'Lp4!Ts7@Ka', 'Chiara', 'Mancini'),
(5, 'a.moretti@scuola.it', 'Mn8@Qw3!Zd', 'Alessandro', 'Moretti'),
(6, 's.lombardi@scuola.it', 'Rt6#Yp1!Xs', 'Silvia', 'Lombardi'),
(7, 'd.barone@scuola.it', 'Uv2!Ke9@Wp', 'Davide', 'Barone'),
(8, 'g.ferraro@scuola.it', 'Pl7@Cx4!Vm', 'Giulia', 'Ferraro'),
(9, 'e.martini@scuola.it', 'Kd3!Nz8@Qa', 'Elisa', 'Martini'),
(10, 'r.santoro@scuola.it', 'Wx5@Lm1!Tr', 'Roberto', 'Santoro');

-- --------------------------------------------------------

--
-- Struttura della tabella `materie`
--

DROP TABLE IF EXISTS `materie`;
CREATE TABLE `materie` (
  `cid` int(11) NOT NULL,
  `did` int(11) NOT NULL,
  `materia` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `materie`
--

INSERT INTO `materie` (`cid`, `did`, `materia`) VALUES
(1, 1, 'Matematica'),
(1, 2, 'Italiano'),
(1, 3, 'Inglese'),
(1, 4, 'Storia'),
(1, 5, 'Scienze'),
(1, 6, 'Informatica'),
(1, 7, 'Geografia'),
(1, 8, 'Arte'),
(1, 9, 'Educazione Fisica'),
(2, 1, 'Matematica'),
(2, 2, 'Italiano'),
(2, 3, 'Inglese'),
(2, 4, 'Storia'),
(2, 5, 'Scienze'),
(2, 6, 'Informatica'),
(2, 7, 'Geografia'),
(2, 8, 'Arte'),
(2, 9, 'Educazione Fisica'),
(3, 1, 'Matematica'),
(3, 2, 'Italiano'),
(3, 3, 'Inglese'),
(3, 4, 'Storia'),
(3, 5, 'Scienze'),
(3, 6, 'Informatica'),
(3, 7, 'Geografia'),
(3, 8, 'Arte'),
(3, 9, 'Educazione Fisica'),
(4, 1, 'Matematica'),
(4, 2, 'Italiano'),
(4, 3, 'Inglese'),
(4, 4, 'Storia'),
(4, 5, 'Scienze'),
(4, 6, 'Informatica'),
(4, 7, 'Geografia'),
(4, 8, 'Arte'),
(4, 9, 'Educazione Fisica'),
(5, 1, 'Matematica'),
(5, 2, 'Italiano'),
(5, 3, 'Inglese'),
(5, 4, 'Storia'),
(5, 6, 'Informatica'),
(5, 8, 'Arte'),
(5, 9, 'Educazione Fisica'),
(5, 10, 'Fisica'),
(6, 1, 'Matematica'),
(6, 2, 'Italiano'),
(6, 3, 'Inglese'),
(6, 4, 'Storia'),
(6, 6, 'Informatica'),
(6, 8, 'Arte'),
(6, 9, 'Educazione Fisica'),
(6, 10, 'Fisica'),
(7, 1, 'Matematica'),
(7, 2, 'Italiano'),
(7, 3, 'Inglese'),
(7, 4, 'Storia'),
(7, 6, 'Informatica'),
(7, 8, 'Arte'),
(7, 9, 'Educazione Fisica'),
(7, 10, 'Fisica'),
(8, 1, 'Matematica'),
(8, 2, 'Italiano'),
(8, 3, 'Inglese'),
(8, 4, 'Storia'),
(8, 6, 'Informatica'),
(8, 8, 'Arte'),
(8, 9, 'Educazione Fisica'),
(8, 10, 'Fisica'),
(9, 1, 'Matematica'),
(9, 2, 'Italiano'),
(9, 3, 'Inglese'),
(9, 4, 'Storia'),
(9, 6, 'Informatica'),
(9, 8, 'Arte'),
(9, 9, 'Educazione Fisica'),
(9, 10, 'Fisica'),
(10, 1, 'Matematica'),
(10, 2, 'Italiano'),
(10, 3, 'Inglese'),
(10, 4, 'Storia'),
(10, 6, 'Informatica'),
(10, 8, 'Arte'),
(10, 9, 'Educazione Fisica'),
(10, 10, 'Fisica');

-- --------------------------------------------------------

--
-- Struttura della tabella `studenti`
--

DROP TABLE IF EXISTS `studenti`;
CREATE TABLE `studenti` (
  `sid` int(11) NOT NULL,
  `email` varchar(80) NOT NULL,
  `password` varchar(80) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `cognome` varchar(80) NOT NULL,
  `nascita` date NOT NULL,
  `cid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `studenti`
--

INSERT INTO `studenti` (`sid`, `email`, `password`, `nome`, `cognome`, `nascita`, `cid`) VALUES
(1, 'luca.rossi@scuola.it', 'K!3pLs9@Wx', 'Luca', 'Rossi', '2010-02-14', 1),
(2, 'marco.bianchi@scuola.it', 'Zx8@Q!2LmP', 'Marco', 'Bianchi', '2010-06-21', 2),
(3, 'giulia.verdi@scuola.it', 'T!7kP2#sDd', 'Giulia', 'Verdi', '2009-11-03', 3),
(4, 'anna.neri@scuola.it', 'Qp3@L!9ZxA', 'Anna', 'Neri', '2009-01-30', 4),
(5, 'paolo.galli@scuola.it', 'V!2Lm8@Qwe', 'Paolo', 'Galli', '2008-09-12', 5),
(6, 'sara.costa@scuola.it', 'N#4pT!7sXc', 'Sara', 'Costa', '2008-03-18', 6),
(7, 'davide.ferrari@scuola.it', 'Y!8Qw2@LpZ', 'Davide', 'Ferrari', '2007-07-09', 7),
(8, 'elena.romano@scuola.it', 'Jk!3Lm9@Px', 'Elena', 'Romano', '2007-12-01', 8),
(9, 'simone.ricci@scuola.it', 'W!2pLs8@Qr', 'Simone', 'Ricci', '2006-05-25', 9),
(10, 'chiara.marino@scuola.it', 'P!9Lm3@Qaz', 'Chiara', 'Marino', '2006-08-14', 10),
(11, 'gabriele.conti@scuola.it', 'X!7sLp2@Zm', 'Gabriele', 'Conti', '2010-04-11', 1),
(12, 'sofia.greco@scuola.it', 'C!2Lm8@Pqa', 'Sofia', 'Greco', '2010-10-22', 2),
(13, 'lorenzo.rinaldi@scuola.it', 'D!4pZx9@Ws', 'Lorenzo', 'Rinaldi', '2009-02-02', 3),
(14, 'aurora.mancini@scuola.it', 'F!8Lm1@Qwe', 'Aurora', 'Mancini', '2009-06-06', 4),
(15, 'matteo.moretti@scuola.it', 'G!3sLp7@Az', 'Matteo', 'Moretti', '2008-09-29', 5),
(16, 'chiara.lombardi@scuola.it', 'H!6Lm2@Qzx', 'Chiara', 'Lombardi', '2008-01-19', 6),
(17, 'davide.barone@scuola.it', 'J!9pLs4@Wx', 'Davide', 'Barone', '2007-03-07', 7),
(18, 'giulia.ferraro@scuola.it', 'K!2Lm8@Qaz', 'Giulia', 'Ferraro', '2007-11-13', 8),
(19, 'martina.martini@scuola.it', 'L!5pLs1@Qwe', 'Martina', 'Martini', '2006-12-05', 9),
(20, 'edoardo.santoro@scuola.it', 'M!8Lm3@Qzx', 'Edoardo', 'Santoro', '2006-07-27', 10),
(21, 'alessio.rizzo@scuola.it', 'N!2pLs9@Qwe', 'Alessio', 'Rizzo', '2010-01-15', 1),
(22, 'francesca.leone@scuola.it', 'O!4Lm7@Qzx', 'Francesca', 'Leone', '2010-02-20', 2),
(23, 'nicolo.guerra@scuola.it', 'P!6pLs2@Qaz', 'Nicolo', 'Guerra', '2009-03-30', 3),
(24, 'valentina.parisi@scuola.it', 'Q!8Lm1@Qwe', 'Valentina', 'Parisi', '2009-04-10', 4),
(25, 'tommaso.coppola@scuola.it', 'R!3pLs6@Qzx', 'Tommaso', 'Coppola', '2008-05-22', 5),
(26, 'luca.deangelis@scuola.it', 'S!7Lm4@Qaz', 'Luca', 'De Angelis', '2008-06-18', 6),
(27, 'silvia.messina@scuola.it', 'T!2pLs8@Qwe', 'Silvia', 'Messina', '2007-07-09', 7),
(28, 'andrea.longo@scuola.it', 'U!5Lm3@Qzx', 'Andrea', 'Longo', '2007-08-14', 8),
(29, 'marta.vitali@scuola.it', 'V!9pLs1@Qaz', 'Marta', 'Vitali', '2006-09-27', 9),
(30, 'riccardo.basili@scuola.it', 'W!6Lm2@Qwe', 'Riccardo', 'Basili', '2006-10-31', 10),
(31, 'alessandro.ferrari@scuola.it', 'A!7kLp2@Qz', 'Alessandro', 'Ferrari', '2010-03-12', 1),
(32, 'beatrice.galli@scuola.it', 'B!3mQw8@Lp', 'Beatrice', 'Galli', '2010-05-21', 2),
(33, 'carmine.russo@scuola.it', 'C!9pLs4@Xz', 'Carmine', 'Russo', '2009-10-02', 3),
(34, 'daria.conti@scuola.it', 'D!2Lm7@Qw', 'Daria', 'Conti', '2009-01-18', 4),
(35, 'edoardo.mancini@scuola.it', 'E!5pLs1@Az', 'Edoardo', 'Mancini', '2008-06-09', 5),
(36, 'federica.rinaldi@scuola.it', 'F!8Lm3@Qz', 'Federica', 'Rinaldi', '2008-09-14', 6),
(37, 'giorgio.moretti@scuola.it', 'G!4pLs9@Qw', 'Giorgio', 'Moretti', '2007-11-30', 7),
(38, 'hannah.lombardi@scuola.it', 'H!6Lm2@Xz', 'Hannah', 'Lombardi', '2008-02-11', 8),
(39, 'ignazio.barone@scuola.it', 'I!3pLs7@Qw', 'Ignazio', 'Barone', '2006-04-27', 9),
(40, 'jessica.ferraro@scuola.it', 'J!9Lm1@Az', 'Jessica', 'Ferraro', '2006-07-03', 10),
(41, 'karl.romano@scuola.it', 'K!2pLs8@Qw', 'Karl', 'Romano', '2010-08-19', 1),
(42, 'ludovica.ricci@scuola.it', 'L!5Lm4@Qz', 'Ludovica', 'Ricci', '2010-12-22', 2),
(43, 'matilde.marino@scuola.it', 'M!7pLs2@Xz', 'Matilde', 'Marino', '2009-01-08', 3),
(44, 'nicola.greco@scuola.it', 'N!4Lm9@Qw', 'Nicola', 'Greco', '2009-03-15', 4),
(45, 'olivia.rizzo@scuola.it', 'O!6pLs1@Az', 'Olivia', 'Rizzo', '2008-05-29', 5),
(46, 'pietro.leone@scuola.it', 'P!8Lm3@Qw', 'Pietro', 'Leone', '2008-06-06', 6),
(47, 'quinto.guerra@scuola.it', 'Q!2pLs7@Xz', 'Quinto', 'Guerra', '2007-09-17', 7),
(48, 'raffaella.parisi@scuola.it', 'R!5Lm8@Qw', 'Raffaella', 'Parisi', '2007-10-24', 8),
(49, 'sergio.coppola@scuola.it', 'S!3pLs4@Az', 'Sergio', 'Coppola', '2006-12-05', 9),
(50, 'teresina.deangelis@scuola.it', 'T!9Lm1@Qz', 'Teresina', 'De Angelis', '2006-02-28', 10),
(51, 'ugo.messina@scuola.it', 'U!6pLs2@Qw', 'Ugo', 'Messina', '2010-04-14', 1),
(52, 'valerio.longo@scuola.it', 'V!8Lm7@Xz', 'Valerio', 'Longo', '2010-06-30', 2),
(53, 'wanda.vitali@scuola.it', 'W!2pLs9@Qw', 'Wanda', 'Vitali', '2009-09-11', 3),
(54, 'xenia.basili@scuola.it', 'X!4Lm1@Az', 'Xenia', 'Basili', '2009-11-19', 4),
(55, 'yuri.santoro@scuola.it', 'Y!7pLs3@Qz', 'Yuri', 'Santoro', '2008-01-23', 5),
(56, 'zaira.farina@scuola.it', 'Z!5Lm2@Qw', 'Zaira', 'Farina', '2008-03-08', 6),
(57, 'alba.rossi@scuola.it', 'A!8pLs1@Xz', 'Alba', 'Rossi', '2007-05-16', 7),
(58, 'bruno.bianchi@scuola.it', 'B!2Lm7@Qw', 'Bruno', 'Bianchi', '2007-07-21', 8),
(59, 'carla.verdi@scuola.it', 'C!6pLs4@Az', 'Carla', 'Verdi', '2006-09-27', 9),
(60, 'domenico.neri@scuola.it', 'D!9Lm3@Qz', 'Domenico', 'Neri', '2006-12-02', 10),
(61, 'emanuele.galli@scuola.it', 'E!3pLs8@Qw', 'Emanuele', 'Galli', '2010-02-14', 1),
(62, 'franco.conti@scuola.it', 'F!7Lm2@Xz', 'Franco', 'Conti', '2010-04-18', 2),
(63, 'gaia.mancini@scuola.it', 'G!5pLs1@Qz', 'Gaia', 'Mancini', '2009-06-25', 3),
(64, 'helena.rinaldi@scuola.it', 'H!2Lm9@Qw', 'Helena', 'Rinaldi', '2009-08-09', 4),
(65, 'ivan.moretti@scuola.it', 'I!8pLs3@Az', 'Ivan', 'Moretti', '2008-10-13', 5),
(66, 'jasmine.lombardi@scuola.it', 'J!6Lm4@Qz', 'Jasmine', 'Lombardi', '2008-12-30', 6),
(67, 'kevin.barone@scuola.it', 'K!3pLs7@Qw', 'Kevin', 'Barone', '2007-03-05', 7),
(68, 'lisa.ferraro@scuola.it', 'L!9Lm1@Xz', 'Lisa', 'Ferraro', '2007-05-17', 8),
(69, 'mario.romano@scuola.it', 'M!2pLs6@Qz', 'Mario', 'Romano', '2006-07-22', 9),
(70, 'noemi.ricci@scuola.it', 'N!8Lm3@Qw', 'Noemi', 'Ricci', '2006-09-29', 10);

-- --------------------------------------------------------

--
-- Struttura della tabella `voti`
--

DROP TABLE IF EXISTS `voti`;
CREATE TABLE `voti` (
  `vid` int(11) NOT NULL,
  `voto` decimal(4,2) NOT NULL,
  `materia` varchar(80) NOT NULL,
  `data` date NOT NULL,
  `did` int(11) NOT NULL,
  `sid` int(11) NOT NULL
) ;

--
-- Dump dei dati per la tabella `voti`
--

INSERT INTO `voti` (`vid`, `voto`, `materia`, `data`, `did`, `sid`) VALUES
(1, 7.50, 'Matematica', '2026-03-12', 1, 1),
(2, 8.15, 'Italiano', '2026-03-13', 2, 1),
(3, 6.85, 'Inglese', '2026-03-14', 3, 1),
(4, 6.50, 'Matematica', '2026-03-12', 1, 11),
(5, 7.15, 'Scienze', '2026-03-13', 5, 11),
(6, 8.85, 'Informatica', '2026-03-14', 6, 11),
(7, 5.50, 'Italiano', '2026-03-12', 2, 21),
(8, 6.15, 'Geografia', '2026-03-13', 7, 21),
(9, 7.85, 'Arte', '2026-03-14', 8, 21),
(10, 8.50, 'Matematica', '2026-03-12', 1, 31),
(11, 7.15, 'Storia', '2026-03-13', 4, 31),
(12, 9.85, 'Informatica', '2026-03-14', 6, 31),
(13, 6.50, 'Scienze', '2026-03-12', 5, 41),
(14, 7.85, 'Italiano', '2026-03-13', 2, 41),
(15, 8.15, 'Educazione Fisica', '2026-03-14', 9, 41),
(16, 8.15, 'Matematica', '2026-03-12', 1, 3),
(17, 7.50, 'Italiano', '2026-03-13', 2, 3),
(18, 6.85, 'Inglese', '2026-03-14', 3, 3),
(19, 6.50, 'Scienze', '2026-03-12', 5, 13),
(20, 7.15, 'Matematica', '2026-03-13', 1, 13),
(21, 8.85, 'Informatica', '2026-03-14', 6, 13),
(22, 5.85, 'Italiano', '2026-03-12', 2, 23),
(23, 6.50, 'Storia', '2026-03-13', 4, 23),
(24, 7.15, 'Arte', '2026-03-14', 8, 23),
(25, 8.50, 'Matematica', '2026-03-12', 1, 33),
(26, 7.85, 'Scienze', '2026-03-13', 5, 33),
(27, 9.15, 'Informatica', '2026-03-14', 6, 33),
(28, 6.15, 'Italiano', '2026-03-12', 2, 43),
(29, 7.50, 'Inglese', '2026-03-13', 3, 43),
(30, 8.85, 'Educazione Fisica', '2026-03-14', 9, 43),
(31, 7.50, 'Fisica', '2026-03-12', 10, 9),
(32, 8.15, 'Matematica', '2026-03-13', 1, 9),
(33, 6.85, 'Italiano', '2026-03-14', 2, 9),
(34, 5.50, 'Fisica', '2026-03-12', 10, 19),
(35, 6.15, 'Informatica', '2026-03-13', 6, 19),
(36, 7.85, 'Arte', '2026-03-14', 8, 19),
(37, 8.50, 'Matematica', '2026-03-12', 1, 29),
(38, 7.15, 'Fisica', '2026-03-13', 10, 29),
(39, 9.85, 'Informatica', '2026-03-14', 6, 29),
(40, 6.85, 'Italiano', '2026-03-12', 2, 39),
(41, 7.50, 'Storia', '2026-03-13', 4, 39),
(42, 8.15, 'Educazione Fisica', '2026-03-14', 9, 39),
(43, 5.15, 'Matematica', '2026-03-12', 1, 49),
(44, 6.50, 'Fisica', '2026-03-13', 10, 49),
(45, 7.85, 'Arte', '2026-03-14', 8, 49),
(46, 8.50, 'Informatica', '2026-03-12', 6, 59),
(47, 7.15, 'Fisica', '2026-03-13', 10, 59),
(48, 6.85, 'Italiano', '2026-03-14', 2, 59),
(49, 7.50, 'Matematica', '2026-03-12', 1, 69),
(50, 8.15, 'Fisica', '2026-03-13', 10, 69),
(51, 9.85, 'Informatica', '2026-03-14', 6, 69);

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `amministratori`
--
ALTER TABLE `amministratori`
  ADD PRIMARY KEY (`aid`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indici per le tabelle `classi`
--
ALTER TABLE `classi`
  ADD PRIMARY KEY (`cid`),
  ADD UNIQUE KEY `anno` (`anno`,`sezione`);

--
-- Indici per le tabelle `docenti`
--
ALTER TABLE `docenti`
  ADD PRIMARY KEY (`did`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indici per le tabelle `materie`
--
ALTER TABLE `materie`
  ADD PRIMARY KEY (`cid`,`did`,`materia`),
  ADD KEY `did` (`did`);

--
-- Indici per le tabelle `studenti`
--
ALTER TABLE `studenti`
  ADD PRIMARY KEY (`sid`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `cid` (`cid`);

--
-- Indici per le tabelle `voti`
--
ALTER TABLE `voti`
  ADD PRIMARY KEY (`vid`),
  ADD KEY `did` (`did`),
  ADD KEY `sid` (`sid`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `amministratori`
--
ALTER TABLE `amministratori`
  MODIFY `aid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT per la tabella `classi`
--
ALTER TABLE `classi`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `docenti`
--
ALTER TABLE `docenti`
  MODIFY `did` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT per la tabella `studenti`
--
ALTER TABLE `studenti`
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT per la tabella `voti`
--
ALTER TABLE `voti`
  MODIFY `vid` int(11) NOT NULL AUTO_INCREMENT;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `materie`
--
ALTER TABLE `materie`
  ADD CONSTRAINT `materie_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `classi` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `materie_ibfk_2` FOREIGN KEY (`did`) REFERENCES `docenti` (`did`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `studenti`
--
ALTER TABLE `studenti`
  ADD CONSTRAINT `studenti_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `classi` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `voti`
--
ALTER TABLE `voti`
  ADD CONSTRAINT `voti_ibfk_1` FOREIGN KEY (`did`) REFERENCES `docenti` (`did`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `voti_ibfk_2` FOREIGN KEY (`sid`) REFERENCES `studenti` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
