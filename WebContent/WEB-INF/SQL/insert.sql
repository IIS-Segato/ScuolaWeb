-- =====================================================
-- INSERT DATI CASUALI (TUTTE LE TABELLE)
-- =====================================================

-- 1. CLASSI (3 classi)
INSERT INTO classi (id_classe, anno, sezione, indirizzo) VALUES
(1, 1, 'A', 'Informatica'),
(2, 1, 'B', 'Elettronica'),
(3, 2, 'A', 'Informatica');

-- 2. MATERIE (8 materie)
INSERT INTO materie (id_materia, nome) VALUES
(1, 'Italiano'),
(2, 'Matematica'),
(3, 'Informatica'),
(4, 'Sistemi e reti'),
(5, 'Inglese'),
(6, 'Storia'),
(7, 'Scienze motorie'),
(8, 'Elettronica');

-- 3. AULE (6 aule)
INSERT INTO aule (id_aula, nome, capienza) VALUES
(1, 'Aula 1.1', 30),
(2, 'Aula 1.2', 25),
(3, 'Laboratorio Info', 20),
(4, 'Aula 2.1', 28),
(5, 'Palestra', 40),
(6, 'Aula Magna', 100);

-- 4. PERSONE (26 studenti + 6 docenti + admin + segretario)
INSERT INTO persone (id_persona, nome, cognome, email, cf, nascita) VALUES
-- Studenti (id 1..26)
(1, 'Luca', 'Rossi', 'luca.rossi@scuola.it', 'RSSLUC01A01H501A', '2010-01-15'),
(2, 'Giulia', 'Bianchi', 'giulia.bianchi@scuola.it', 'BNCGIU02B02H501B', '2010-02-20'),
(3, 'Marco', 'Verdi', 'marco.verdi@scuola.it', 'VRDMRC03C03H501C', '2010-03-10'),
(4, 'Sara', 'Neri', 'sara.neri@scuola.it', 'NRISRA04D04H501D', '2010-04-05'),
(5, 'Francesco', 'Gialli', 'francesco.gialli@scuola.it', 'GLLFRC05E05H501E', '2010-05-12'),
(6, 'Alessia', 'Marroni', 'alessia.marroni@scuola.it', 'MRRLSS06F06H501F', '2010-06-18'),
(7, 'Matteo', 'Romani', 'matteo.romani@scuola.it', 'RMNMTT07G07H501G', '2010-07-22'),
(8, 'Chiara', 'Ferrari', 'chiara.ferrari@scuola.it', 'FRRCHR08H08H501H', '2010-08-30'),
(9, 'Davide', 'Esposito', 'davide.esposito@scuola.it', 'SPDDVD09I09H501I', '2010-09-14'),
(10, 'Elisa', 'Conti', 'elisa.conti@scuola.it', 'CNTELS10L10H501L', '2010-10-25'),
(11, 'Simone', 'Greco', 'simone.greco@scuola.it', 'GRCSMN11M11H501M', '2010-11-01'),
(12, 'Valentina', 'Rizzo', 'valentina.rizzo@scuola.it', 'RZZVNT12N12H501N', '2010-12-09'),
(13, 'Andrea', 'Lombardi', 'andrea.lombardi@scuola.it', 'LMBNDR13P13H501P', '2009-01-17'),
(14, 'Martina', 'Moretti', 'martina.moretti@scuola.it', 'MRTMTN14Q14H501Q', '2009-02-11'),
(15, 'Federico', 'Barbieri', 'federico.barbieri@scuola.it', 'BRBFRC15R15H501R', '2009-03-23'),
(16, 'Giorgia', 'Santoro', 'giorgia.santoro@scuola.it', 'SNTGRG16S16H501S', '2009-04-19'),
(17, 'Roberto', 'Mancini', 'roberto.mancini@scuola.it', 'MNCRRT17T17H501T', '2009-05-29'),
(18, 'Alice', 'Cattaneo', 'alice.cattaneo@scuola.it', 'CTTALC18U18H501U', '2009-06-13'),
(19, 'Stefano', 'Fabbri', 'stefano.fabbri@scuola.it', 'FBBSTF19V19H501V', '2009-07-02'),
(20, 'Serena', 'Rinaldi', 'serena.rinaldi@scuola.it', 'RNLSRN20Z20H501Z', '2009-08-21'),
(21, 'Emanuele', 'Gallo', 'emanuele.gallo@scuola.it', 'GLLMNL21A21H501A', '2009-09-07'),
(22, 'Federica', 'Carbone', 'federica.carbone@scuola.it', 'CRBFRC22B22H501B', '2009-10-14'),
(23, 'Daniele', 'Leone', 'daniele.leone@scuola.it', 'LNEDNL23C23H501C', '2009-11-20'),
(24, 'Silvia', 'Martini', 'silvia.martini@scuola.it', 'MRTSLV24D24H501D', '2009-12-01'),
(25, 'Paolo', 'Serra', 'paolo.serra@scuola.it', 'SRRPLA25E25H501E', '2010-01-09'),
(26, 'Valeria', 'Costa', 'valeria.costa@scuola.it', 'CSTVLR26F26H501F', '2010-02-18'),
-- Docenti (id 27..32)
(27, 'Paolo', 'Rossini', 'paolo.rossini@scuola.it', 'RSSPLA67E67H501C', '1980-05-10'),
(28, 'Laura', 'Fontana', 'laura.fontana@scuola.it', 'FNTLRA78F78H501D', '1975-09-25'),
(29, 'Giuseppe', 'Lombardo', 'giuseppe.lombardo@scuola.it', 'LMBGPP89G89H501E', '1978-11-30'),
(30, 'Maria', 'Galli', 'maria.galli@scuola.it', 'GLLMRA90H90H501F', '1982-07-19'),
(31, 'Antonio', 'Parisi', 'antonio.parisi@scuola.it', 'PRSNTN91I91H501G', '1970-03-12'),
(32, 'Elena', 'Vitale', 'elena.vitale@scuola.it', 'VTLLNE92L92H501H', '1985-12-01'),
-- Admin e Segretario (id 33,34)
(33, 'Admin', 'Sistema', 'admin@scuola.it', 'ADMSSS00A00H501X', '1990-01-01'),
(34, 'Segretario', 'Ufficio', 'segreteria@scuola.it', 'SGRSYS01B01H501Y', '1995-02-02');

-- 5. STUDENTI (associa persona id 1..26 alla rispettiva classe)
INSERT INTO studenti (id_studente, id_persona, id_classe) VALUES
(1,1,1), (2,2,1), (3,3,1), (4,4,1), (5,5,1), (6,6,1),   -- 1A
(7,7,2), (8,8,2), (9,9,2), (10,10,2), (11,11,2), (12,12,2), -- 1B
(13,13,3), (14,14,3), (15,15,3), (16,16,3), (17,17,3), (18,18,3),
(19,19,3), (20,20,3), (21,21,3), (22,22,3), (23,23,3), (24,24,3),
(25,25,3), (26,26,3);   -- 2A

-- 6. DOCENTI (associa persona id 27..32)
INSERT INTO docenti (id_docente, id_persona) VALUES
(1,27), (2,28), (3,29), (4,30), (5,31), (6,32);

-- 7. UTENTI (username = parte prima della @, password hash fittizia, ruolo determinato)
INSERT INTO utenti (id_utente, username, password_hash, id_persona, id_ruolo) VALUES
-- Studenti (ruolo 5)
(1, 'luca.rossi', '$2y$10$dummyhashdummyhashdummyhashdum', 1, 5),
(2, 'giulia.bianchi', '$2y$10$dummyhashdummyhashdummyhashdum', 2, 5),
(3, 'marco.verdi', '$2y$10$dummyhashdummyhashdummyhashdum', 3, 5),
(4, 'sara.neri', '$2y$10$dummyhashdummyhashdummyhashdum', 4, 5),
(5, 'francesco.gialli', '$2y$10$dummyhashdummyhashdummyhashdum', 5, 5),
(6, 'alessia.marroni', '$2y$10$dummyhashdummyhashdummyhashdum', 6, 5),
(7, 'matteo.romani', '$2y$10$dummyhashdummyhashdummyhashdum', 7, 5),
(8, 'chiara.ferrari', '$2y$10$dummyhashdummyhashdummyhashdum', 8, 5),
(9, 'davide.esposito', '$2y$10$dummyhashdummyhashdummyhashdum', 9, 5),
(10, 'elisa.conti', '$2y$10$dummyhashdummyhashdummyhashdum', 10, 5),
(11, 'simone.greco', '$2y$10$dummyhashdummyhashdummyhashdum', 11, 5),
(12, 'valentina.rizzo', '$2y$10$dummyhashdummyhashdummyhashdum', 12, 5),
(13, 'andrea.lombardi', '$2y$10$dummyhashdummyhashdummyhashdum', 13, 5),
(14, 'martina.moretti', '$2y$10$dummyhashdummyhashdummyhashdum', 14, 5),
(15, 'federico.barbieri', '$2y$10$dummyhashdummyhashdummyhashdum', 15, 5),
(16, 'giorgia.santoro', '$2y$10$dummyhashdummyhashdummyhashdum', 16, 5),
(17, 'roberto.mancini', '$2y$10$dummyhashdummyhashdummyhashdum', 17, 5),
(18, 'alice.cattaneo', '$2y$10$dummyhashdummyhashdummyhashdum', 18, 5),
(19, 'stefano.fabbri', '$2y$10$dummyhashdummyhashdummyhashdum', 19, 5),
(20, 'serena.rinaldi', '$2y$10$dummyhashdummyhashdummyhashdum', 20, 5),
(21, 'emanuele.gallo', '$2y$10$dummyhashdummyhashdummyhashdum', 21, 5),
(22, 'federica.carbone', '$2y$10$dummyhashdummyhashdummyhashdum', 22, 5),
(23, 'daniele.leone', '$2y$10$dummyhashdummyhashdummyhashdum', 23, 5),
(24, 'silvia.martini', '$2y$10$dummyhashdummyhashdummyhashdum', 24, 5),
(25, 'paolo.serra', '$2y$10$dummyhashdummyhashdummyhashdum', 25, 5),
(26, 'valeria.costa', '$2y$10$dummyhashdummyhashdummyhashdum', 26, 5),
-- Docenti (ruolo 4, tranne Paolo Rossini che sarà rappresentante ruolo 3)
(27, 'paolo.rossini', '$2y$10$dummyhashdummyhashdummyhashdum', 27, 4),   -- diventerà 3 dopo
(28, 'laura.fontana', '$2y$10$dummyhashdummyhashdummyhashdum', 28, 4),
(29, 'giuseppe.lombardo', '$2y$10$dummyhashdummyhashdummyhashdum', 29, 4),
(30, 'maria.galli', '$2y$10$dummyhashdummyhashdummyhashdum', 30, 4),
(31, 'antonio.parisi', '$2y$10$dummyhashdummyhashdummyhashdum', 31, 4),
(32, 'elena.vitale', '$2y$10$dummyhashdummyhashdummyhashdum', 32, 4),
-- Admin e Segretario
(33, 'admin', '$2y$10$dummyhashdummyhashdummyhashdum', 33, 1),
(34, 'segreteria', '$2y$10$dummyhashdummyhashdummyhashdum', 34, 2);

-- Imposta Paolo Rossini come RAPPRESENTANTE (ruolo 3) invece di DOCENTE
UPDATE utenti SET id_ruolo = 3 WHERE id_persona = 27;

-- 8. INSEGNAMENTI (3 classi * 6 materie ciascuna = 18 insegnamenti)
INSERT INTO insegnamenti (id_insegnamento, id_docente, id_materia, id_classe) VALUES
-- Classe 1A (id_classe=1)
(1, 1, 1, 1),  -- Italiano - Rossini
(2, 2, 2, 1),  -- Matematica - Fontana
(3, 3, 3, 1),  -- Informatica - Lombardo
(4, 4, 5, 1),  -- Inglese - Galli
(5, 5, 6, 1),  -- Storia - Parisi
(6, 6, 7, 1),  -- Scienze motorie - Vitale
-- Classe 1B (id_classe=2)
(7, 1, 1, 2),  -- Italiano - Rossini
(8, 2, 2, 2),  -- Matematica - Fontana
(9, 6, 8, 2),  -- Elettronica - Vitale
(10, 4, 5, 2), -- Inglese - Galli
(11, 5, 6, 2), -- Storia - Parisi
(12, 3, 3, 2), -- Informatica - Lombardo
-- Classe 2A (id_classe=3)
(13, 1, 1, 3),  -- Italiano - Rossini
(14, 2, 2, 3),  -- Matematica - Fontana
(15, 3, 3, 3),  -- Informatica - Lombardo
(16, 4, 5, 3),  -- Inglese - Galli
(17, 5, 6, 3),  -- Storia - Parisi
(18, 6, 4, 3);  -- Sistemi e reti - Vitale

-- 9. ORARIO (solo per insegnamenti esistenti, id_insegnamento 1..18)
INSERT INTO orario (id_orario, id_insegnamento, id_aula, giorno, ora_inizio, ora_fine) VALUES
(1, 1, 1, 'LUN', '08:00', '09:00'),
(2, 2, 2, 'LUN', '09:00', '10:00'),
(3, 3, 3, 'LUN', '10:00', '11:00'),
(4, 4, 1, 'LUN', '11:00', '12:00'),
(5, 5, 2, 'LUN', '12:00', '13:00'),
(6, 6, 5, 'MAR', '08:00', '09:00'),
(7, 7, 1, 'MAR', '09:00', '10:00'),
(8, 8, 2, 'MAR', '10:00', '11:00'),
(9, 9, 3, 'MAR', '11:00', '12:00'),
(10, 10, 1, 'MAR', '12:00', '13:00'),
(11, 11, 2, 'MER', '08:00', '09:00'),
(12, 12, 3, 'MER', '09:00', '10:00'),
(13, 13, 1, 'MER', '10:00', '11:00'),
(14, 14, 4, 'MER', '11:00', '12:00'),
(15, 15, 2, 'MER', '12:00', '13:00'),
(16, 16, 3, 'GIO', '08:00', '09:00'),
(17, 17, 1, 'GIO', '09:00', '10:00'),
(18, 18, 2, 'GIO', '10:00', '11:00');

-- 10. VOTI (almeno 3 voti per studente, usando insegnamenti della sua classe)
-- Per ogni studente, inserisco 3-5 voti casuali su materie della propria classe.
-- Ho precalcolato una selezione per evitare SELECT.
-- Di seguito 100 voti distribuiti su tutti gli studenti (abbastanza per coprire >=3 ciascuno)
INSERT INTO voti (id_voto, id_studente, id_insegnamento, voto, data_voto, descrizione) VALUES
-- Studenti 1A (id_studente 1..6, insegnamenti id 1..6)
(1,1,1,7.5,'2025-03-10','Interrogazione'),
(2,1,2,8.0,'2025-03-12','Compito in classe'),
(3,1,3,6.5,'2025-03-15','Verifica orale'),
(4,2,1,9.0,'2025-03-10','Interrogazione'),
(5,2,4,7.0,'2025-03-11','Compito in classe'),
(6,2,5,8.5,'2025-03-14','Verifica orale'),
(7,3,2,6.0,'2025-03-09','Compito in classe'),
(8,3,3,7.0,'2025-03-12','Interrogazione'),
(9,3,6,8.0,'2025-03-16','Verifica orale'),
(10,4,1,8.5,'2025-03-08','Interrogazione'),
(11,4,4,7.5,'2025-03-13','Compito in classe'),
(12,4,5,9.0,'2025-03-15','Verifica orale'),
(13,5,2,7.0,'2025-03-11','Interrogazione'),
(14,5,3,6.0,'2025-03-14','Compito in classe'),
(15,5,6,7.5,'2025-03-17','Verifica orale'),
(16,6,1,6.0,'2025-03-09','Compito in classe'),
(17,6,4,8.0,'2025-03-12','Interrogazione'),
(18,6,5,7.0,'2025-03-18','Verifica orale'),
-- Studenti 1B (id_studente 7..12, insegnamenti id 7..12)
(19,7,7,7.0,'2025-03-10','Interrogazione'),
(20,7,8,8.0,'2025-03-12','Compito in classe'),
(21,7,9,6.5,'2025-03-15','Verifica orale'),
(22,8,7,9.0,'2025-03-10','Interrogazione'),
(23,8,10,7.0,'2025-03-11','Compito in classe'),
(24,8,11,8.5,'2025-03-14','Verifica orale'),
(25,9,8,6.0,'2025-03-09','Compito in classe'),
(26,9,9,7.0,'2025-03-12','Interrogazione'),
(27,9,12,8.0,'2025-03-16','Verifica orale'),
(28,10,7,8.5,'2025-03-08','Interrogazione'),
(29,10,10,7.5,'2025-03-13','Compito in classe'),
(30,10,11,9.0,'2025-03-15','Verifica orale'),
(31,11,8,7.0,'2025-03-11','Interrogazione'),
(32,11,9,6.0,'2025-03-14','Compito in classe'),
(33,11,12,7.5,'2025-03-17','Verifica orale'),
(34,12,7,6.0,'2025-03-09','Compito in classe'),
(35,12,10,8.0,'2025-03-12','Interrogazione'),
(36,12,11,7.0,'2025-03-18','Verifica orale'),
-- Studenti 2A (id_studente 13..26, insegnamenti id 13..18)
(37,13,13,7.5,'2025-03-10','Interrogazione'),
(38,13,14,8.0,'2025-03-12','Compito in classe'),
(39,13,15,6.5,'2025-03-15','Verifica orale'),
(40,14,13,9.0,'2025-03-10','Interrogazione'),
(41,14,16,7.0,'2025-03-11','Compito in classe'),
(42,14,17,8.5,'2025-03-14','Verifica orale'),
(43,15,14,6.0,'2025-03-09','Compito in classe'),
(44,15,15,7.0,'2025-03-12','Interrogazione'),
(45,15,18,8.0,'2025-03-16','Verifica orale'),
(46,16,13,8.5,'2025-03-08','Interrogazione'),
(47,16,16,7.5,'2025-03-13','Compito in classe'),
(48,16,17,9.0,'2025-03-15','Verifica orale'),
(49,17,14,7.0,'2025-03-11','Interrogazione'),
(50,17,15,6.0,'2025-03-14','Compito in classe'),
(51,17,18,7.5,'2025-03-17','Verifica orale'),
(52,18,13,6.0,'2025-03-09','Compito in classe'),
(53,18,16,8.0,'2025-03-12','Interrogazione'),
(54,18,17,7.0,'2025-03-18','Verifica orale'),
(55,19,14,8.0,'2025-03-10','Interrogazione'),
(56,19,15,7.5,'2025-03-12','Compito in classe'),
(57,19,18,9.0,'2025-03-15','Verifica orale'),
(58,20,13,7.0,'2025-03-11','Interrogazione'),
(59,20,16,8.0,'2025-03-14','Compito in classe'),
(60,20,17,6.5,'2025-03-16','Verifica orale'),
(61,21,14,9.0,'2025-03-09','Interrogazione'),
(62,21,15,8.0,'2025-03-12','Compito in classe'),
(63,21,18,7.0,'2025-03-17','Verifica orale'),
(64,22,13,6.5,'2025-03-08','Compito in classe'),
(65,22,16,7.0,'2025-03-13','Interrogazione'),
(66,22,17,8.5,'2025-03-15','Verifica orale'),
(67,23,14,7.5,'2025-03-10','Interrogazione'),
(68,23,15,6.0,'2025-03-12','Compito in classe'),
(69,23,18,8.0,'2025-03-14','Verifica orale'),
(70,24,13,8.0,'2025-03-11','Interrogazione'),
(71,24,16,9.0,'2025-03-13','Compito in classe'),
(72,24,17,7.5,'2025-03-16','Verifica orale'),
(73,25,14,6.0,'2025-03-09','Compito in classe'),
(74,25,15,7.0,'2025-03-12','Interrogazione'),
(75,25,18,8.5,'2025-03-15','Verifica orale'),
(76,26,13,7.0,'2025-03-10','Interrogazione'),
(77,26,16,8.0,'2025-03-14','Compito in classe'),
(78,26,17,6.0,'2025-03-17','Verifica orale');

-- 11. ASSENZE (per alcuni studenti, casuali)
INSERT INTO assenze (id_assenza, id_utente, data_evento, tipo, ora_evento, giustificata, motivazione, giustificata_da, data_giustifica) VALUES
(1, 1, '2025-04-10', 'ASSENZA', NULL, TRUE, 'Febbre', 27, '2025-04-11 09:00:00'),
(2, 2, '2025-04-12', 'RITARDO', '08:35:00', FALSE, 'Traffico', NULL, NULL),
(3, 3, '2025-04-14', 'USCITA', '11:00:00', TRUE, 'Visita medica', 27, '2025-04-14 15:30:00'),
(4, 7, '2025-04-11', 'ASSENZA', NULL, FALSE, NULL, NULL, NULL),
(5, 8, '2025-04-09', 'RITARDO', '08:45:00', TRUE, 'Problemi mezzi', 28, '2025-04-10 08:00:00'),
(6, 13, '2025-04-08', 'ASSENZA', NULL, TRUE, 'Mal di testa', 29, '2025-04-09 14:00:00'),
(7, 14, '2025-04-13', 'USCITA', '10:30:00', FALSE, NULL, NULL, NULL),
(8, 15, '2025-04-10', 'RITARDO', '08:20:00', TRUE, 'Sveglia saltata', 30, '2025-04-10 12:00:00'),
(9, 19, '2025-04-12', 'ASSENZA', NULL, FALSE, NULL, NULL, NULL),
(10, 20, '2025-04-14', 'ASSENZA', NULL, TRUE, 'Influenza', 31, '2025-04-15 09:30:00'),
(11, 22, '2025-04-07', 'RITARDO', '08:50:00', FALSE, NULL, NULL, NULL),
(12, 25, '2025-04-11', 'USCITA', '12:00:00', TRUE, 'Visita specialistica', 32, '2025-04-11 16:00:00'),
(13, 26, '2025-04-09', 'ASSENZA', NULL, FALSE, NULL, NULL, NULL),
(14, 5, '2025-04-15', 'RITARDO', '08:15:00', TRUE, 'Treno in ritardo', 27, '2025-04-15 08:45:00'),
(15, 10, '2025-04-16', 'ASSENZA', NULL, TRUE, 'Febbre alta', 28, '2025-04-17 10:00:00');

-- 12. ANNUNCI (bacheca generale)
INSERT INTO annunci (id_annuncio, titolo, contenuto, autore) VALUES
(1, 'Benvenuto nuovo anno', 'Le lezioni inizieranno il 15 settembre. Consultare il sito per gli orari.', 33),
(2, 'Sciopero trasporti', 'Venerdì 20 ottobre sciopero generale. Le lezioni potrebbero subire variazioni.', 34),
(3, 'Consegna libri di testo', 'I libri per le classi prime sono disponibili in segreteria.', 34),
(4, 'Corso di recupero', 'Attivati corsi di recupero di matematica per le classi seconde. Iscrizioni entro il 30 novembre.', 27),
(5, 'Gita scolastica', 'Gita a Roma per le classi terze il 10-12 maggio. Autorizzazioni da consegnare entro il 20 aprile.', 28);

-- 13. ANNUNCI PER CLASSE (associa annunci a classi specifiche)
INSERT INTO annunci_classe (id_annuncio, id_classe, id_docente) VALUES
(4, 3, 2),   -- Corso di recupero per classe 2A, docente Fontana
(5, 3, 5);   -- Gita per classe 2A, docente Parisi
