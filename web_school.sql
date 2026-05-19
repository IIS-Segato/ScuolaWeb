CREATE DATABASE IF NOT EXISTS scuola_db;
USE scuola_db;

-- 2. Tabella Utenti 
CREATE TABLE IF NOT EXISTS utenti (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    ruolo VARCHAR(20) NOT NULL 
);

-- 3. Tabella Studenti 
CREATE TABLE IF NOT EXISTS studenti (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    classe VARCHAR(10) NOT NULL
);


-- 4. Tabella Docenti 
CREATE TABLE IF NOT EXISTS docenti (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    materia VARCHAR(50) NOT NULL
);