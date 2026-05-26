-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 26, 2026 alle 09:31
-- Versione del server: 10.4.32-MariaDB
-- Versione PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `scuolaweb`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `classi`
--

CREATE TABLE `classi` (
  `id` int(11) NOT NULL,
  `nome` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `classi`
--

INSERT INTO `classi` (`id`, `nome`) VALUES
(3, '4IA'),
(4, '4IB'),
(1, '5IA'),
(2, '5IB');

-- --------------------------------------------------------

--
-- Struttura della tabella `docente_classi`
--

CREATE TABLE `docente_classi` (
  `docente_id` int(11) NOT NULL,
  `classe_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `docente_classi`
--

INSERT INTO `docente_classi` (`docente_id`, `classe_id`) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 3),
(3, 1),
(3, 4),
(4, 2),
(4, 4);

-- --------------------------------------------------------

--
-- Struttura della tabella `docenti`
--

CREATE TABLE `docenti` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `materia` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `docenti`
--

INSERT INTO `docenti` (`id`, `nome`, `cognome`, `materia`, `email`) VALUES
(1, 'Mario', 'Rossi', 'Informatica', 'm.rossi@scuola.it'),
(2, 'Luigi', 'Bianchi', 'Matematica', 'l.bianchi@scuola.it'),
(3, 'Anna', 'Verdi', 'TPSIT', 'a.verdi@scuola.it'),
(4, 'Paolo', 'Neri', 'Sistemi', 'p.neri@scuola.it');

-- --------------------------------------------------------

--
-- Struttura della tabella `orario`
--

CREATE TABLE `orario` (
  `id` int(11) NOT NULL,
  `classe_id` int(11) NOT NULL,
  `docente_id` int(11) NOT NULL,
  `materia` varchar(50) NOT NULL,
  `giorno` varchar(20) NOT NULL,
  `ora` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `orario`
--

INSERT INTO `orario` (`id`, `classe_id`, `docente_id`, `materia`, `giorno`, `ora`) VALUES
(1, 1, 1, 'Informatica', 'Lunedi', '08:00 - 09:00'),
(2, 1, 2, 'Matematica', 'Lunedi', '09:00 - 10:00'),
(3, 1, 3, 'TPSIT', 'Martedi', '10:00 - 11:00'),
(4, 1, 4, 'Sistemi', 'Mercoledi', '11:00 - 12:00'),
(5, 2, 1, 'Informatica', 'Lunedi', '10:00 - 11:00'),
(6, 2, 4, 'Sistemi', 'Martedi', '08:00 - 09:00'),
(7, 3, 2, 'Matematica', 'Giovedi', '09:00 - 10:00'),
(8, 4, 3, 'TPSIT', 'Venerdi', '11:00 - 12:00');

-- --------------------------------------------------------

--
-- Struttura della tabella `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`) VALUES
(1, 'ADMIN', 'Amministratore sistema'),
(2, 'STUDENTE', 'Studente'),
(3, 'DOCENTE', 'Docente');

-- --------------------------------------------------------

--
-- Struttura della tabella `studenti`
--

CREATE TABLE `studenti` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `classe_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `studenti`
--

INSERT INTO `studenti` (`id`, `nome`, `cognome`, `classe_id`) VALUES
(1, 'Luca', 'De Rossi', 1),
(2, 'Marco', 'Fontana', 1),
(4, 'Sara', 'Bianchi', 2),
(5, 'Andrea', 'Costa', 2),
(6, 'Matteo', 'Villa', 3),
(7, 'Chiara', 'Martin', 3),
(8, 'Davide', 'Ferro', 4);

-- --------------------------------------------------------

--
-- Struttura della tabella `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(64) NOT NULL,
  `role_id` int(11) NOT NULL,
  `studente_id` int(11) DEFAULT NULL,
  `docente_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role_id`, `studente_id`, `docente_id`) VALUES
(1, 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 1, NULL, NULL),
(2, 'studente1', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 2, 1, NULL),
(3, 'studente2', '8d23cf6c86e834a7aa6eded54c26ce2bb2e74903538c61bdd5d2197997ab2f72', 2, 2, NULL),
(4, 'docente1', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 3, NULL, 1),
(5, 'docente2', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 3, NULL, 2);

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `classi`
--
ALTER TABLE `classi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Indici per le tabelle `docente_classi`
--
ALTER TABLE `docente_classi`
  ADD PRIMARY KEY (`docente_id`,`classe_id`),
  ADD KEY `classe_id` (`classe_id`);

--
-- Indici per le tabelle `docenti`
--
ALTER TABLE `docenti`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `orario`
--
ALTER TABLE `orario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `classe_id` (`classe_id`),
  ADD KEY `docente_id` (`docente_id`);

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
  ADD KEY `classe_id` (`classe_id`);

--
-- Indici per le tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `studente_id` (`studente_id`),
  ADD KEY `docente_id` (`docente_id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `classi`
--
ALTER TABLE `classi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT per la tabella `docenti`
--
ALTER TABLE `docenti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT per la tabella `orario`
--
ALTER TABLE `orario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT per la tabella `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `studenti`
--
ALTER TABLE `studenti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT per la tabella `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `docente_classi`
--
ALTER TABLE `docente_classi`
  ADD CONSTRAINT `docente_classi_ibfk_1` FOREIGN KEY (`docente_id`) REFERENCES `docenti` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `docente_classi_ibfk_2` FOREIGN KEY (`classe_id`) REFERENCES `classi` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `orario`
--
ALTER TABLE `orario`
  ADD CONSTRAINT `orario_ibfk_1` FOREIGN KEY (`classe_id`) REFERENCES `classi` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orario_ibfk_2` FOREIGN KEY (`docente_id`) REFERENCES `docenti` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `studenti`
--
ALTER TABLE `studenti`
  ADD CONSTRAINT `studenti_ibfk_1` FOREIGN KEY (`classe_id`) REFERENCES `classi` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`studente_id`) REFERENCES `studenti` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_ibfk_3` FOREIGN KEY (`docente_id`) REFERENCES `docenti` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
