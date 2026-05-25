-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 22, 2026 alle 18:26
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
-- Database: `example`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `classi`
--

CREATE TABLE `classi` (
  `id` int(11) NOT NULL,
  `nome` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `classi`
--

INSERT INTO `classi` (`id`, `nome`) VALUES
(1, '1A'),
(2, '2A'),
(3, '3A');

-- --------------------------------------------------------

--
-- Struttura della tabella `docenti`
--

CREATE TABLE `docenti` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `docenti`
--

INSERT INTO `docenti` (`id`, `nome`, `cognome`) VALUES
(1, 'Giovanni', 'Rossi'),
(2, 'Maria', 'Bianchi'),
(3, 'Elena', 'Blu'),
(4, 'Roberto', 'Viola'),
(5, 'Chiara', 'Verdi'),
(6, 'Lorenzo', 'Gialli');

-- --------------------------------------------------------

--
-- Struttura della tabella `docenti_classi`
--

CREATE TABLE `docenti_classi` (
  `id_docente` int(11) NOT NULL,
  `id_classe` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `docenti_classi`
--

INSERT INTO `docenti_classi` (`id_docente`, `id_classe`) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 2),
(4, 3),
(5, 3),
(6, 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`) VALUES
(1, 'Preside', 'Controllo completo'),
(2, 'Insegnante', 'Controllo parziale'),
(3, 'Segreteria', 'Gestione amministrativa'),
(4, 'Studente', 'Consultazione limitata');

-- --------------------------------------------------------

--
-- Struttura della tabella `studenti`
--

CREATE TABLE `studenti` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `id_classe` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `studenti`
--

INSERT INTO `studenti` (`id`, `nome`, `cognome`, `id_classe`) VALUES
(1, 'Marco', 'Rossi', 1),
(2, 'Luca', 'Bianchi', 1),
(3, 'Anna', 'Verdi', 2),
(4, 'Sara', 'Neri', 2),
(5, 'Paolo', 'Gialli', 3),
(6, 'Giulia', 'Rosa', 3),
(7, 'Davide', 'Blu', 1),
(8, 'Marta', 'Viola', 2);

-- --------------------------------------------------------

--
-- Struttura della tabella `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role_id` int(11) NOT NULL,
  `id_studente` int(11) DEFAULT NULL,
  `id_docente` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role_id`, `id_studente`, `id_docente`) VALUES
(1, 'grossi', '1234', 2, NULL, 1),
(2, 'mbianchi', '1234', 2, NULL, 2),
(3, 'eblu', '1234', 2, NULL, 3),
(4, 'rviola', '1234', 2, NULL, 4),
(5, 'cverdi', '1234', 2, NULL, 5),
(6, 'lgialli', '1234', 2, NULL, 6),
(10, 'admin', 'admin123', 1, NULL, NULL),
(11, 'segreteria', 'seg123', 3, NULL, NULL),
(12, 'preside', 'preside123', 1, NULL, NULL),
(51, 'mrossi', '1234', 4, 1, NULL),
(52, 'lbianchi', '1234', 4, 2, NULL),
(53, 'averdi', '1234', 4, 3, NULL),
(54, 'sneri', '1234', 4, 4, NULL),
(55, 'pgialli', '1234', 4, 5, NULL),
(56, 'grosa', '1234', 4, 6, NULL),
(57, 'dblublu', '1234', 4, 7, NULL),
(58, 'mviola', '1234', 4, 8, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `voti`
--

CREATE TABLE `voti` (
  `id` int(11) NOT NULL,
  `id_studente` int(11) NOT NULL,
  `id_docente` int(11) NOT NULL,
  `materia` varchar(50) NOT NULL,
  `voto` decimal(4,2) NOT NULL,
  `data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `voti`
--

INSERT INTO `voti` (`id`, `id_studente`, `id_docente`, `materia`, `voto`, `data`) VALUES
(1, 1, 1, 'Matematica', 8.50, '2024-01-15'),
(2, 1, 1, 'Matematica', 7.00, '2024-02-10'),
(3, 2, 2, 'Italiano', 6.50, '2024-01-20'),
(4, 2, 2, 'Italiano', 7.50, '2024-03-05'),
(5, 3, 1, 'Matematica', 9.40, '2024-02-18'),
(6, 3, 3, 'Inglese', 8.00, '2024-03-12'),
(7, 4, 3, 'Inglese', 6.00, '2024-01-25'),
(8, 4, 2, 'Italiano', 7.00, '2024-02-28'),
(9, 5, 4, 'Inglese', 6.50, '2024-03-15'),
(10, 6, 5, 'Storia', 7.80, '2024-03-10'),
(11, 7, 6, 'Scienze', 8.20, '2024-02-22'),
(12, 8, 3, 'Inglese', 7.10, '2024-03-02');

-- --------------------------------------------------------

--
-- Struttura della tabella `registro_eventi`
--

CREATE TABLE `registro_eventi` (
  `id` int(11) NOT NULL,
  `id_studente` int(11) NOT NULL,
  `id_docente` int(11) NOT NULL,
  `tipo` enum('PRESENTE','ASSENTE') NOT NULL,
  `data` date NOT NULL,
  `ora_ingresso` time DEFAULT NULL,
  `ora_uscita` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `registro_eventi`
--

INSERT INTO `registro_eventi` (`id`, `id_studente`, `id_docente`, `tipo`, `data`, `ora_ingresso`, `ora_uscita`) VALUES
(1, 1, 1, 'ASSENTE', '2024-03-18', NULL, NULL),
(2, 2, 2, 'ASSENTE', '2024-03-19', '08:25:00', NULL),
(3, 3, 3, 'PRESENTE', '2024-03-20', NULL, '12:10:00');

-- 
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `classi`
--
ALTER TABLE `classi`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `docenti`
--
ALTER TABLE `docenti`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `docenti_classi`
--
ALTER TABLE `docenti_classi`
  ADD PRIMARY KEY (`id_docente`,`id_classe`),
  ADD KEY `id_classe` (`id_classe`);

--
-- Indici per le tabelle `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `studenti`
--
ALTER TABLE `studenti`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_classe` (`id_classe`);

--
-- Indici per le tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `id_studente` (`id_studente`),
  ADD KEY `id_docente` (`id_docente`);

--
-- Indici per le tabelle `voti`
--
ALTER TABLE `voti`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_studente` (`id_studente`),
  ADD KEY `id_docente` (`id_docente`);

--
-- Indici per la tabella `registro_eventi`
--
ALTER TABLE `registro_eventi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_studente` (`id_studente`),
  ADD KEY `id_docente` (`id_docente`),
  ADD UNIQUE KEY `studente_data` (`id_studente`,`data`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `classi`
--
ALTER TABLE `classi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `docenti`
--
ALTER TABLE `docenti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT per la tabella `studenti`
--
ALTER TABLE `studenti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT per la tabella `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT per la tabella `voti`
--
ALTER TABLE `voti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT per la tabella `registro_eventi`
--
ALTER TABLE `registro_eventi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `docenti_classi`
--
ALTER TABLE `docenti_classi`
  ADD CONSTRAINT `docenti_classi_ibfk_1` FOREIGN KEY (`id_docente`) REFERENCES `docenti` (`id`),
  ADD CONSTRAINT `docenti_classi_ibfk_2` FOREIGN KEY (`id_classe`) REFERENCES `classi` (`id`);

--
-- Limiti per la tabella `studenti`
--
ALTER TABLE `studenti`
  ADD CONSTRAINT `studenti_ibfk_1` FOREIGN KEY (`id_classe`) REFERENCES `classi` (`id`);

--
-- Limiti per la tabella `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`id_studente`) REFERENCES `studenti` (`id`),
  ADD CONSTRAINT `users_ibfk_3` FOREIGN KEY (`id_docente`) REFERENCES `docenti` (`id`);

--
-- Limiti per la tabella `voti`
--
ALTER TABLE `voti`
  ADD CONSTRAINT `voti_ibfk_1` FOREIGN KEY (`id_studente`) REFERENCES `studenti` (`id`),
  ADD CONSTRAINT `voti_ibfk_2` FOREIGN KEY (`id_docente`) REFERENCES `docenti` (`id`);

--
-- Limiti per la tabella `registro_eventi`
--
ALTER TABLE `registro_eventi`
  ADD CONSTRAINT `registro_eventi_ibfk_1` FOREIGN KEY (`id_studente`) REFERENCES `studenti` (`id`),
  ADD CONSTRAINT `registro_eventi_ibfk_2` FOREIGN KEY (`id_docente`) REFERENCES `docenti` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
