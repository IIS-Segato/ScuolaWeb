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

COMMIT;
