-- 1. PULIZIA TOTALE (Ordine corretto per i vincoli)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE orari;
TRUNCATE TABLE studenti;
TRUNCATE TABLE docenti;
TRUNCATE TABLE admin;
TRUNCATE TABLE classi;
TRUNCATE TABLE materie;
TRUNCATE TABLE giorni;
SET FOREIGN_KEY_CHECKS = 1;

-- 2. TABELLE DI RIFERIMENTO (Fondamenta)
INSERT INTO giorni (nome_giorno) VALUES 
('Lunedì'), ('Martedì'), ('Mercoledì'), ('Giovedì'), ('Venerdì');

INSERT INTO materie (nome_materia) VALUES 
('Matematica'), ('Italiano'), ('Storia'), ('TPSIT'), ('GPOI'), ('Informatica'), ('Inglese');

INSERT INTO classi (classe, n_alunni) VALUES 
('5A INF', 22), 
('5B INF', 20),
('4A INF', 18);

-- 3. UTENTI (Admin, Docenti, Studenti)
INSERT INTO admin (username, password) VALUES 
('admin', 'admin123');

-- Nota: Gli ID auto_increment partiranno da 1
INSERT INTO docenti (nome, cognome, password, nome_materia) VALUES 
('Mario', 'Rossi', 'docente123', 'TPSIT'),        -- ID 1
('Laura', 'Bianchi', 'laura_pass', 'GPOI'),        -- ID 2
('Giuseppe', 'Verdi', 'verdi_99', 'Matematica'),   -- ID 3
('Elena', 'Galli', 'elena_99', 'Italiano'),       -- ID 4
('Pietro', 'Neri', 'pietro_pass', 'Inglese');      -- ID 5

INSERT INTO studenti (nome, cognome, password, classe) VALUES 
('Luca', 'Neri', 'luca_pwd', '5A INF'),
('Anna', 'Gialli', 'anna_2005', '5A INF'),
('Marco', 'Bru', 'marco_pass', '4A INF');

-- 4. ORARIO COMPLETO (Lunedì per la classe 5A INF)
-- Copre dalle 08:00 alle 13:00 senza buchi
INSERT INTO orari (id_docente, nome_giorno, orario_inizio, orario_fine, classe) VALUES 
(1, 'Lunedì', '08:00:00', '09:00:00', '5A INF'), -- 1° ora: TPSIT (Mario)
(1, 'Lunedì', '09:00:00', '10:00:00', '5A INF'), -- 2° ora: TPSIT (Mario)
(3, 'Lunedì', '10:00:00', '11:00:00', '5A INF'), -- 3° ora: Matematica (Giuseppe)
(5, 'Lunedì', '11:00:00', '12:00:00', '5A INF'), -- 4° ora: Inglese (Pietro)
(4, 'Lunedì', '12:00:00', '13:00:00', '5A INF'); -- 5° ora: Italiano (Elena)

-- Aggiungiamo anche un martedì parziale per varietà
INSERT INTO orari (id_docente, nome_giorno, orario_inizio, orario_fine, classe) VALUES 
(2, 'Martedì', '08:00:00', '11:00:00', '5A INF'), -- Laura (GPOI)
(5, 'Martedì', '11:00:00', '13:00:00', '4A INF'); -- Pietro (Inglese) in un'altra classe



