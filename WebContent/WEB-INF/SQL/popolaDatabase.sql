-- 1. DISABILITA I CONTROLLI PER LA PULIZIA
SET FOREIGN_KEY_CHECKS = 0;

-- 2. PULIZIA TOTALE (RESETTA ANCHE GLI ID)
TRUNCATE TABLE orari;
TRUNCATE TABLE studenti;
TRUNCATE TABLE docenti;
TRUNCATE TABLE materie;
TRUNCATE TABLE giorni;
TRUNCATE TABLE classi;
TRUNCATE TABLE admin;

-- 3. CREAZIONE TABELLA VOTI (se non esiste già)
CREATE TABLE IF NOT EXISTS voti (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_studente INT NOT NULL,
    id_docente INT NOT NULL,
    voto DECIMAL(4,2) NOT NULL,
    data DATE NOT NULL,
    descrizione VARCHAR(100),
    FOREIGN KEY (id_studente) REFERENCES studenti(id) ON DELETE CASCADE,
    FOREIGN KEY (id_docente) REFERENCES docenti(id) ON DELETE CASCADE
);

-- 4. DATI DI BASE
INSERT INTO giorni (nome_giorno) VALUES ('Lunedì'), ('Martedì'), ('Mercoledì'), ('Giovedì'), ('Venerdì'), ('Sabato');
INSERT INTO materie (nome_materia) VALUES ('Informatica'), ('Sistemi e Reti'), ('Matematica'), ('Italiano'), ('Inglese');
INSERT INTO classi (classe, n_alunni) VALUES ('4A INF', 22), ('5A INF', 20);
INSERT INTO admin (username, password) VALUES ('admin', 'admin123');

-- 5. DOCENTI E STUDENTI
INSERT INTO docenti (id, nome, cognome, password, nome_materia) VALUES 
(1, 'Mario', 'Rossi', 'pass', 'Informatica'),
(2, 'Laura', 'Bianchi', 'pass', 'Sistemi e Reti'),
(3, 'Giuseppe', 'Verdi', 'pass', 'Matematica'),
(4, 'Anna', 'Neri', 'pass', 'Italiano'),
(5, 'Roberto', 'Gialli', 'pass', 'Inglese');

INSERT INTO studenti (id, nome, cognome, password, classe) VALUES 
(1, 'Luca', 'Fumagalli', 'stud1', '5A INF'),
(2, 'Sofia', 'Esposito', 'stud2', '5A INF'),
(3, 'Marco', 'Rizzo', 'stud3', '4A INF'),
(4, 'Elena', 'Galli', 'stud4', '4A INF');

-- 6. ORARIO COMPLETO (6 GIORNI, 5 ORE/GIORNO)
-- Utilizziamo blocchi da 2 ore per simulare laboratori o lezioni pesanti

-- CLASSE 5A INF
INSERT INTO orari (id_docente, nome_giorno, orario_inizio, orario_fine, classe) VALUES 
(1, 'Lunedì', '08:00:00', '10:00:00', '5A INF'), (3, 'Lunedì', '10:00:00', '11:00:00', '5A INF'), (5, 'Lunedì', '11:00:00', '13:00:00', '5A INF'),
(2, 'Martedì', '08:00:00', '10:00:00', '5A INF'), (1, 'Martedì', '10:00:00', '12:00:00', '5A INF'), (4, 'Martedì', '12:00:00', '13:00:00', '5A INF'),
(3, 'Mercoledì', '08:00:00', '10:00:00', '5A INF'), (2, 'Mercoledì', '10:00:00', '11:00:00', '5A INF'), (4, 'Mercoledì', '11:00:00', '13:00:00', '5A INF'),
(5, 'Giovedì', '08:00:00', '09:00:00', '5A INF'), (1, 'Giovedì', '09:00:00', '11:00:00', '5A INF'), (3, 'Giovedì', '11:00:00', '13:00:00', '5A INF'),
(4, 'Venerdì', '08:00:00', '10:00:00', '5A INF'), (2, 'Venerdì', '10:00:00', '12:00:00', '5A INF'), (5, 'Venerdì', '12:00:00', '13:00:00', '5A INF'),
(1, 'Sabato', '08:00:00', '09:00:00', '5A INF'), (3, 'Sabato', '09:00:00', '11:00:00', '5A INF'), (2, 'Sabato', '11:00:00', '13:00:00', '5A INF');

-- CLASSE 4A INF
INSERT INTO orari (id_docente, nome_giorno, orario_inizio, orario_fine, classe) VALUES 
(4, 'Lunedì', '08:00:00', '10:00:00', '4A INF'), (2, 'Lunedì', '10:00:00', '12:00:00', '4A INF'), (3, 'Lunedì', '12:00:00', '13:00:00', '4A INF'),
(1, 'Martedì', '08:00:00', '09:00:00', '4A INF'), (5, 'Martedì', '09:00:00', '11:00:00', '4A INF'), (2, 'Martedì', '11:00:00', '13:00:00', '4A INF'),
(5, 'Mercoledì', '08:00:00', '10:00:00', '4A INF'), (3, 'Mercoledì', '10:00:00', '12:00:00', '4A INF'), (1, 'Mercoledì', '12:00:00', '13:00:00', '4A INF'),
(2, 'Giovedì', '08:00:00', '10:00:00', '4A INF'), (4, 'Giovedì', '10:00:00', '11:00:00', '4A INF'), (5, 'Giovedì', '11:00:00', '13:00:00', '4A INF'),
(3, 'Venerdì', '08:00:00', '10:00:00', '4A INF'), (1, 'Venerdì', '10:00:00', '12:00:00', '4A INF'), (4, 'Venerdì', '12:00:00', '13:00:00', '4A INF'),
(5, 'Sabato', '08:00:00', '09:00:00', '4A INF'), (2, 'Sabato', '09:00:00', '11:00:00', '4A INF'), (4, 'Sabato', '11:00:00', '13:00:00', '4A INF');

-- 7. POPOLAMENTO VOTI (Esempi per vari studenti)
INSERT INTO voti (id_studente, id_docente, voto, data, descrizione) VALUES 
(1, 1, 8.5, '2024-05-01', 'Verifica Java'),
(1, 3, 6.0, '2024-05-05', 'Interrogazione Analisi'),
(2, 1, 7.0, '2024-05-01', 'Verifica Java'),
(3, 4, 9.0, '2024-05-06', 'Tema letteratura'),
(4, 2, 5.5, '2024-05-07', 'Test Reti');

-- 8. RIABILITA I CONTROLLI
SET FOREIGN_KEY_CHECKS = 1;