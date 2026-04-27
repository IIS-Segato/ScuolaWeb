-- 1. CREAZIONE DELLE TABELLE

CREATE TABLE classi (
    classe VARCHAR(10) PRIMARY KEY,
    n_alunni INT NOT NULL
);

CREATE TABLE giorni (
    nome_giorno VARCHAR(15) PRIMARY KEY
);

CREATE TABLE materie (
    nome_materia VARCHAR(50) PRIMARY KEY
);

-- Tabella per gli amministratori del sistema
CREATE TABLE admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL -- In un caso reale, qui andrebbe l'hash della password
);

CREATE TABLE studenti (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL, -- Nuovo campo password
    classe VARCHAR(10),
    FOREIGN KEY (classe) REFERENCES classi(classe) ON DELETE SET NULL
);

CREATE TABLE docenti (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL, -- Nuovo campo password
    nome_materia VARCHAR(50),
    FOREIGN KEY (nome_materia) REFERENCES materie(nome_materia) ON DELETE SET NULL
);

CREATE TABLE orari (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_docente INT,
    nome_giorno VARCHAR(15),
    orario_inizio TIME NOT NULL,
    orario_fine TIME NOT NULL,
    classe VARCHAR(10),
    FOREIGN KEY (id_docente) REFERENCES docenti(id) ON DELETE CASCADE,
    FOREIGN KEY (nome_giorno) REFERENCES giorni(nome_giorno) ON DELETE CASCADE,
    FOREIGN KEY (classe) REFERENCES classi(classe) ON DELETE CASCADE
);

-- 2. INSERIMENTO DATI DI ESEMPIO

-- Giorni e Materie
INSERT INTO giorni (nome_giorno) VALUES ('Lunedì'), ('Martedì'), ('Mercoledì'), ('Giovedì'), ('Venerdì');
INSERT INTO materie (nome_materia) VALUES ('Matematica'), ('Italiano'), ('Storia'), ('TPSIT'), ('GPOI');

-- Admin
INSERT INTO admin (username, password) VALUES ('superadmin', 'admin123'), ('segreteria_01', 'passwordSicura');

-- Classi
INSERT INTO classi (classe, n_alunni) VALUES ('5A INF', 22), ('5B INF', 20);

-- Docenti (con password)
INSERT INTO docenti (nome, cognome, password, nome_materia) VALUES 
('Mario', 'Rossi', 'docente123', 'TPSIT'),
('Laura', 'Bianchi', 'laura_pass', 'GPOI'),
('Giuseppe', 'Verdi', 'verdi_99', 'Matematica');

-- Studenti (con password)
INSERT INTO studenti (nome, cognome, password, classe) VALUES 
('Luca', 'Neri', 'luca_pwd', '5A INF'),
('Anna', 'Gialli', 'anna_2005', '5A INF');

-- Orari
INSERT INTO orari (id_docente, nome_giorno, orario_inizio, orario_fine, classe) VALUES 
(1, 'Lunedì', '08:00:00', '10:00:00', '5A INF'),
(2, 'Lunedì', '10:00:00', '12:00:00', '5A INF');