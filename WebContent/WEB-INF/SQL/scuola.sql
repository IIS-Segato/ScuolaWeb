SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
SET NAMES utf8mb4;

-- Usa il database già configurato in dbcfg.xml
CREATE DATABASE IF NOT EXISTS `example`
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_general_ci;
USE `example`;


-- TABELLA roles  

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id`          INT(11)      NOT NULL AUTO_INCREMENT,
  `name`        VARCHAR(20)  NOT NULL,
  `description` VARCHAR(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `roles` (`name`, `description`) VALUES
  ('admin',    'Amministratore con accesso completo al sistema'),
  ('docente',  'Docente: accesso in sola lettura'),
  ('studente', 'Studente: accesso in sola lettura');


-- TABELLA utenti 

DROP TABLE IF EXISTS `utenti`;
CREATE TABLE `utenti` (
  `id`       INT(11)      NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50)  NOT NULL UNIQUE,
  `password` VARCHAR(64)  NOT NULL COMMENT 'SHA-256 hash',
  `ruolo`    ENUM('admin','docente','studente') NOT NULL DEFAULT 'studente',
  `nome`     VARCHAR(50)  NOT NULL DEFAULT '',
  `cognome`  VARCHAR(50)  NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Password con hash 256:
--   admin123  → 240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9
--   doc123    → c3362e4da49c24d379b72152ae6c99f1fa035f52829dceed715a7bf8bb464b98
--   stu123    → c079b93d71c13c8b44e0d8e55abbdf1fe006e01f67a8b95c45500fb0df3598f8


INSERT INTO `utenti` (`username`, `password`, `ruolo`, `nome`, `cognome`) VALUES
  ('admin',    '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9',
               'admin',    'Mario',    'Rossi'),
  ('prof.bianchi', 'c3362e4da49c24d379b72152ae6c99f1fa035f52829dceed715a7bf8bb464b98',
               'docente',  'Michela',    'Bianchi'),
  ('stu.verdi','c079b93d71c13c8b44e0d8e55abbdf1fe006e01f67a8b95c45500fb0df3598f8',
               'studente', 'Giacomo',  'Verdi');

-- TABELLA studenti

DROP TABLE IF EXISTS `studenti`;
CREATE TABLE `studenti` (
  `id`      INT(11)     NOT NULL AUTO_INCREMENT,
  `nome`    VARCHAR(50) NOT NULL,
  `cognome` VARCHAR(50) NOT NULL,
  `classe`  VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `studenti` (`nome`, `cognome`, `classe`) VALUES
  ('Luca',     'Ferrari',   '3A'),
  ('Sofia',    'Colombo',   '3A'),
  ('Matteo',   'Ricci',     '3B'),
  ('Giulia',   'Marino',    '3B'),
  ('Andrea',   'Conti',     '4A'),
  ('Chiara',   'Greco',     '4A'),
  ('Federico', 'Mancini',   '4B'),
  ('Valentina','Bruno',     '4B'),
  ('Simone',   'Gallo',     '5A'),
  ('Elisa',    'Leone',     '5A'),
  ('Marco',    'Serra',     '5B'),
  ('Sara',     'Costa',     '5B');


-- TABELLA docenti

DROP TABLE IF EXISTS `docenti`;
CREATE TABLE `docenti` (
  `id`      INT(11)     NOT NULL AUTO_INCREMENT,
  `nome`    VARCHAR(50) NOT NULL,
  `cognome` VARCHAR(50) NOT NULL,
  `materia` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `docenti` (`nome`, `cognome`, `materia`) VALUES
  ('Marco',   'Esposito',   'Matematica'),
  ('Luisa',   'Bianchi',    'Italiano'),
  ('Roberto', 'De Luca',    'Storia'),
  ('Anna',    'Fontana',    'Inglese'),
  ('Paolo',   'Martini',    'Scienze'),
  ('Cristina','Ferrara',    'Educazione Fisica'),
  ('Giorgio', 'Barbieri',   'Informatica'),
  ('Elena',   'Moretti',    'Arte');

COMMIT;


