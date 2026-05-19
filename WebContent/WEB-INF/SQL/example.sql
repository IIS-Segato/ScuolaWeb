-- phpMyAdmin SQL Dump

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `example`
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE `example`;

-- --------------------------------------------------------
-- TABELLA ROLES
-- --------------------------------------------------------

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- DATI ROLES

INSERT INTO `roles` (`id`, `name`, `description`) VALUES
(1, 'Preside', 'Controllo completo'),
(2, 'Insegnante', 'Controllo parziale'),
(3, 'Segreteria', 'Gestione amministrativa'),
(4, 'Studente', 'Consultazione limitata');

-- --------------------------------------------------------
-- TABELLA USERS
-- --------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `role_id` int(11) NOT NULL,

  PRIMARY KEY (`id`),

  CONSTRAINT `fk_user_role`
    FOREIGN KEY (`role_id`)
    REFERENCES `roles`(`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- DATI USERS

INSERT INTO `users`
(`username`,`password`,`role_id`)
VALUES
('admin','admin123',1),
('teacher','teacher123',2),
('student','student123',4);

-- --------------------------------------------------------
-- TABELLA VOTI
-- --------------------------------------------------------

CREATE TABLE voti (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_studente INT NOT NULL,
    id_docente INT NOT NULL,
    materia VARCHAR(50) NOT NULL,
    voto DECIMAL(4,2) NOT NULL,
    data DATE NOT NULL,
    FOREIGN KEY (id_studente) REFERENCES studenti(id),
    FOREIGN KEY (id_docente) REFERENCES docenti(id)
);

INSERT INTO voti (id_studente, id_docente, materia, voto, data) VALUES
(1, 2, 'Matematica', 8.5, '2024-01-15'),
(1, 2, 'Matematica', 7.0, '2024-02-10'),
(2, 3, 'Italiano', 6.5, '2024-01-20'),
(2, 3, 'Italiano', 7.5, '2024-03-05'),
(3, 2, 'Matematica', 9.0, '2024-02-18'),
(3, 4, 'Inglese', 8.0, '2024-03-12'),
(4, 4, 'Inglese', 6.0, '2024-01-25'),
(4, 3, 'Italiano', 7.0, '2024-02-28'),
(5, 2, 'Matematica', 5.5, '2024-03-10'),
(5, 4, 'Inglese', 6.5, '2024-03-15');

COMMIT;
