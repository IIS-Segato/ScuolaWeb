-- ========================================
-- POPOLAMENTO DATABASE SCUOLA
-- File: popolamento_database.sql
-- Descrizione: Inserimento di tutti i dati
-- ========================================

-- ========================================
-- INSERIMENTO AULE
-- ========================================

INSERT INTO AULE (NOME, CAPIENZA) VALUES
  -- Aule standard con codici a 2-3 lettere
  ('Aula HIG', 30),
  ('Aula AB', 28),
  ('Aula DD', 32),
  ('Aula EF', 30),
  ('Aula GH', 28),
  ('Aula IJ', 30),
  ('Aula KL', 32),
  ('Aula MN', 30),
  ('Aula OP', 28),
  ('Aula QR', 30),
  ('Aula ST', 32),
  ('Aula UV', 28),
  ('Aula WX', 30),
  ('Aula YZ', 32),
  ('Aula BC', 30),
  ('Aula CD', 28),
  ('Aula FG', 32),
  ('Aula HI', 30),
  ('Aula JK', 28),
  ('Aula LM', 30),
  
  -- Laboratori specializzati
  ('Laboratorio Informatica', 25),
  ('Laboratorio Scienze', 20),
  ('Laboratorio Fisica', 22),
  ('Laboratorio Chimica', 20),
  ('Laboratorio Lingue', 24),
  ('Laboratorio Multimediale', 26),
  ('Laboratorio Elettronica', 18),
  ('Laboratorio Robotica', 20),
  
  -- Spazi comuni
  ('Aula Magna', 100),
  ('Biblioteca', 40),
  ('Sala Professori', 15),
  ('Sala Conferenze', 60),
  ('Palestra', 50),
  ('Sala Musica', 15),
  ('Auditorium', 120),
  ('Aula Video', 35);

-- ========================================
-- INSERIMENTO CLASSI
-- ========================================

INSERT INTO CLASSI (SEZIONE, ANNO) VALUES
  -- Primo anno
  ('A', 1),
  ('B', 1),
  ('C', 1),
  ('D', 1),
  
  -- Secondo anno
  ('A', 2),
  ('B', 2),
  ('C', 2),
  ('D', 2),
  
  -- Terzo anno
  ('A', 3),
  ('B', 3),
  ('C', 3),
  ('D', 3),
  
  -- Quarto anno
  ('A', 4),
  ('B', 4),
  ('C', 4),
  ('D', 4),
  
  -- Quinto anno
  ('A', 5),
  ('B', 5),
  ('C', 5),
  ('D', 5);

-- ========================================
-- INSERIMENTO DOCENTI
-- ========================================

INSERT INTO DOCENTI (NOME, COGNOME, MATERIA, EMAIL, PWD) VALUES
  -- Materie scientifiche
  ('Marco',     'Rossi',      'Matematica',        'm.rossi@scuola.it',        'UserDoc01'),
  ('Alberto',   'Colombo',    'Matematica',        'a.colombo@scuola.it',      'UserDoc02'),
  ('Paolo',     'Moretti',    'Fisica',            'p.moretti@scuola.it',      'UserDoc03'),
  ('Elena',     'Lombardi',   'Chimica',           'e.lombardi@scuola.it',     'UserDoc04'),
  ('Silvia',    'Conti',      'Scienze',           's.conti@scuola.it',        'UserDoc05'),
  ('Luca',      'Mancini',    'Informatica',       'l.mancini@scuola.it',      'UserDoc06'),
  ('Tommaso',   'Piras',      'Informatica',       't.piras@scuola.it',        'UserDoc07'),
  
  -- Materie umanistiche
  ('Laura',     'Bianchi',    'Italiano',          'l.bianchi@scuola.it',      'UserDoc08'),
  ('Monica',    'Ferri',      'Italiano',          'm.ferri@scuola.it',        'UserDoc09'),
  ('Giorgio',   'Ferrari',    'Storia',            'g.ferrari@scuola.it',      'UserDoc10'),
  ('Roberto',   'Martini',    'Filosofia',         'r.martini@scuola.it',      'UserDoc11'),
  ('Francesca', 'Romano',     'Geografia',         'f.romano@scuola.it',       'UserDoc12'),
  ('Sara',      'Pellegrino', 'Latino',            's.pellegrino@scuola.it',   'UserDoc13'),
  ('Massimo',   'Villa',      'Greco',             'm.villa@scuola.it',        'UserDoc14'),
  ('Emanuele',  'Testa',      'Storia dell''Arte', 'e.testa@scuola.it',        'UserDoc15'),
  
  -- Lingue straniere
  ('Anna',      'Ricci',      'Inglese',           'a.ricci@scuola.it',        'UserDoc16'),
  ('Cristina',  'Benedetti',  'Spagnolo',          'c.benedetti@scuola.it',    'UserDoc17'),
  ('Giovanni',  'Mariani',    'Tedesco',           'g.mariani@scuola.it',      'UserDoc18'),
  
  -- Altre materie
  ('Andrea',    'Gallo',      'Arte',              'a.gallo@scuola.it',        'UserDoc19'),
  ('Valentina', 'Costa',      'Musica',            'v.costa@scuola.it',        'UserDoc20'),
  ('Stefano',   'Rizzo',      'Ed. Fisica',        's.rizzo@scuola.it',        'UserDoc21'),
  ('Paola',     'Neri',       'Scienze Motorie',   'p.neri@scuola.it',         'UserDoc22'),
  ('Michela',   'Greco',      'Diritto',           'm.greco@scuola.it',        'UserDoc23'),
  ('Daniele',   'Ferretti',   'Economia',          'd.ferretti@scuola.it',     'UserDoc24'),
  ('Claudia',   'Serra',      'Religione',         'c.serra@scuola.it',        'UserDoc25');

-- ========================================
-- INSERIMENTO AMMINISTRATORI
-- ========================================

INSERT INTO AMMINISTRATORI (NOME, COGNOME, EMAIL, PWD) VALUES
  ('Carlo',     'Esposito',  'c.esposito@scuola.it',  'UserAmm01'),
  ('Martina',   'De Luca',   'm.deluca@scuola.it',    'UserAmm02'),
  ('Giuseppe',  'Palmieri',  'g.palmieri@scuola.it',  'UserAmm03'),
  ('Daniela',   'Monti',     'd.monti@scuola.it',     'UserAmm04'),
  ('Francesco', 'Bassi',     'f.bassi@scuola.it',     'UserAmm05');

-- ========================================
-- INSERIMENTO STUDENTI
-- ========================================

-- Classe 1A (ID_C = 1)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Alice',      'Galli',       'alice.galli@studenti.it',       'UserStu01', 1),
  ('Matteo',     'Bruno',       'matteo.bruno@studenti.it',      'UserStu02', 1),
  ('Sofia',      'Marino',      'sofia.marino@studenti.it',      'UserStu03', 1),
  ('Marco',      'Rossi',       'marco.rossi1a@studenti.it',     'UserStu04', 1),
  ('Elena',      'Bianchi',     'elena.bianchi1a@studenti.it',   'UserStu05', 1),
  ('Luca',       'Verdi',       'luca.verdi@studenti.it',        'UserStu06', 1),
  ('Francesca',  'Neri',        'francesca.neri@studenti.it',    'UserStu07', 1),
  ('Alessandro', 'Moretti',     'alessandro.moretti1a@studenti.it', 'UserStu08', 1),
  ('Martina',    'Ricci',       'martina.ricci1a@studenti.it',   'UserStu09', 1),
  ('Andrea',     'Ferrari',     'andrea.ferrari1a@studenti.it',  'UserStu10', 1);

-- Classe 1B (ID_C = 2)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Davide',     'Greco',       'davide.greco@studenti.it',      'UserStu11', 2),
  ('Chiara',     'Lombardi',    'chiara.lombardi@studenti.it',   'UserStu12', 2),
  ('Nicola',     'Fontana',     'nicola.fontana@studenti.it',    'UserStu13', 2),
  ('Giorgia',    'Romano',      'giorgia.romano@studenti.it',    'UserStu14', 2),
  ('Tommaso',    'Gatti',       'tommaso.gatti1b@studenti.it',   'UserStu15', 2),
  ('Silvia',     'De Santis',   'silvia.desantis1b@studenti.it', 'UserStu16', 2),
  ('Riccardo',   'Riva',        'riccardo.riva1b@studenti.it',   'UserStu17', 2),
  ('Camilla',    'Sanna',       'camilla.sanna1b@studenti.it',   'UserStu18', 2),
  ('Gabriele',   'Mazza',       'gabriele.mazza1b@studenti.it',  'UserStu19', 2),
  ('Elisa',      'Sala',        'elisa.sala@studenti.it',        'UserStu20', 2);

-- Classe 1C (ID_C = 3)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Pietro',     'Moretti',     'pietro.moretti@studenti.it',    'UserStu21', 3),
  ('Valentina',  'Battaglia',   'valentina.battaglia@studenti.it', 'UserStu22', 3),
  ('Antonio',    'Messina',     'antonio.messina@studenti.it',   'UserStu23', 3),
  ('Nicole',     'Orlando',     'nicole.orlando@studenti.it',    'UserStu24', 3),
  ('Edoardo',    'Leone',       'edoardo.leone@studenti.it',     'UserStu25', 3),
  ('Rebecca',    'Marchetti',   'rebecca.marchetti1c@studenti.it', 'UserStu26', 3),
  ('Manuel',     'Silvestri',   'manuel.silvestri@studenti.it',  'UserStu27', 3),
  ('Jasmine',    'Colombo',     'jasmine.colombo@studenti.it',   'UserStu28', 3),
  ('Kevin',      'Rossetti',    'kevin.rossetti@studenti.it',    'UserStu29', 3),
  ('Aurora',     'Barone',      'aurora.barone1c@studenti.it',   'UserStu30', 3);

-- Classe 1D (ID_C = 4)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Christian',  'Poli',        'christian.poli@studenti.it',    'UserStu31', 4),
  ('Emma',       'Marchi',      'emma.marchi@studenti.it',       'UserStu32', 4),
  ('Samuel',     'Benedetti',   'samuel.benedetti1d@studenti.it', 'UserStu33', 4),
  ('Greta',      'Santini',     'greta.santini@studenti.it',     'UserStu34', 4),
  ('Leonardo',   'Esposito',    'leonardo.esposito1d@studenti.it', 'UserStu35', 4),
  ('Sara',       'Martinelli',  'sara.martinelli1d@studenti.it', 'UserStu36', 4),
  ('Jacopo',     'Ruggeri',     'jacopo.ruggeri1d@studenti.it',  'UserStu37', 4),
  ('Irene',      'De Rosa',     'irene.derosa1d@studenti.it',    'UserStu38', 4),
  ('Thomas',     'Farina',      'thomas.farina@studenti.it',     'UserStu39', 4),
  ('Viola',      'Caputo',      'viola.caputo@studenti.it',      'UserStu40', 4);

-- Classe 2A (ID_C = 5)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Giulia',     'Caruso',      'giulia.caruso@studenti.it',     'UserStu41', 5),
  ('Lorenzo',    'Santoro',     'lorenzo.santoro@studenti.it',   'UserStu42', 5),
  ('Beatrice',   'Ferrara',     'beatrice.ferrara@studenti.it',  'UserStu43', 5),
  ('Tommaso',    'Gatti',       'tommaso.gatti2a@studenti.it',   'UserStu44', 5),
  ('Silvia',     'De Santis',   'silvia.desantis2a@studenti.it', 'UserStu45', 5),
  ('Riccardo',   'Riva',        'riccardo.riva2a@studenti.it',   'UserStu46', 5),
  ('Camilla',    'Sanna',       'camilla.sanna2a@studenti.it',   'UserStu47', 5),
  ('Michele',    'Guerra',      'michele.guerra@studenti.it',    'UserStu48', 5),
  ('Arianna',    'Monti',       'arianna.monti@studenti.it',     'UserStu49', 5),
  ('Stefano',    'Bernardi',    'stefano.bernardi@studenti.it',  'UserStu50', 5);

-- Classe 2B (ID_C = 6)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Filippo',    'Costa',       'filippo.costa@studenti.it',     'UserStu51', 6),
  ('Valeria',    'Gentile',     'valeria.gentile@studenti.it',   'UserStu52', 6),
  ('Simone',     'Vitale',      'simone.vitale@studenti.it',     'UserStu53', 6),
  ('Gabriele',   'Mazza',       'gabriele.mazza2b@studenti.it',  'UserStu54', 6),
  ('Elisa',      'Sala',        'elisa.sala2b@studenti.it',      'UserStu55', 6),
  ('Daniele',    'Cattaneo',    'daniele.cattaneo@studenti.it',  'UserStu56', 6),
  ('Serena',     'Fabbri',      'serena.fabbri@studenti.it',     'UserStu57', 6),
  ('Diego',      'Giordano',    'diego.giordano2b@studenti.it',  'UserStu58', 6),
  ('Ludovica',   'Pagano',      'ludovica.pagano2b@studenti.it', 'UserStu59', 6),
  ('Gabriel',    'Milani',      'gabriel.milani@studenti.it',    'UserStu60', 6);

-- Classe 2C (ID_C = 7)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Rebecca',    'Marchetti',   'rebecca.marchetti2c@studenti.it', 'UserStu61', 7),
  ('Manuel',     'Silvestri',   'manuel.silvestri2c@studenti.it', 'UserStu62', 7),
  ('Jasmine',    'Colombo',     'jasmine.colombo2c@studenti.it', 'UserStu63', 7),
  ('Kevin',      'Rossetti',    'kevin.rossetti2c@studenti.it',  'UserStu64', 7),
  ('Noemi',      'Vitali',      'noemi.vitali@studenti.it',      'UserStu65', 7),
  ('Nathan',     'Benedetto',   'nathan.benedetto@studenti.it',  'UserStu66', 7),
  ('Melissa',    'D''Angelo',   'melissa.dangelo@studenti.it',   'UserStu67', 7),
  ('Alex',       'Tosi',        'alex.tosi@studenti.it',         'UserStu68', 7),
  ('Marika',     'Negri',       'marika.negri@studenti.it',      'UserStu69', 7),
  ('Nicholas',   'Marini',      'nicholas.marini2c@studenti.it', 'UserStu70', 7);

-- Classe 2D (ID_C = 8)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Angelica',   'De Luca',     'angelica.deluca@studenti.it',   'UserStu71', 8),
  ('Ivan',       'Grassi',      'ivan.grassi@studenti.it',       'UserStu72', 8),
  ('Martina',    'Cattaneo',    'martina.cattaneo2d@studenti.it', 'UserStu73', 8),
  ('Cristian',   'Giuliani',    'cristian.giuliani@studenti.it', 'UserStu74', 8),
  ('Denise',     'Palmieri',    'denise.palmieri@studenti.it',   'UserStu75', 8),
  ('Omar',       'Ferraro',     'omar.ferraro@studenti.it',      'UserStu76', 8),
  ('Sabrina',    'Longo',       'sabrina.longo@studenti.it',     'UserStu77', 8),
  ('Amir',       'Rizzi',       'amir.rizzi2d@studenti.it',      'UserStu78', 8),
  ('Eleonora',   'Mancini',     'eleonora.mancini2d@studenti.it', 'UserStu79', 8),
  ('Samuele',    'Sartori',     'samuele.sartori2d@studenti.it', 'UserStu80', 8);

-- Classe 3A (ID_C = 9)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Alessia',    'Barbieri',    'alessia.barbieri@studenti.it',  'UserStu81', 9),
  ('Federico',   'Coppola',     'federico.coppola@studenti.it',  'UserStu82', 9),
  ('Marta',      'Pellegrini',  'marta.pellegrini@studenti.it',  'UserStu83', 9),
  ('Chiara',     'Amato',       'chiara.amato@studenti.it',      'UserStu84', 9),
  ('Mattia',     'Parisi',      'mattia.parisi@studenti.it',     'UserStu85', 9),
  ('Aurora',     'Barone',      'aurora.barone3a@studenti.it',   'UserStu86', 9),
  ('Christian',  'Poli',        'christian.poli3a@studenti.it',  'UserStu87', 9),
  ('Emma',       'Marchi',      'emma.marchi3a@studenti.it',     'UserStu88', 9),
  ('Samuel',     'Benedetti',   'samuel.benedetti3a@studenti.it', 'UserStu89', 9),
  ('Greta',      'Santini',     'greta.santini3a@studenti.it',   'UserStu90', 9);

-- Classe 3B (ID_C = 10)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Leonardo',   'Esposito',    'leonardo.esposito3b@studenti.it', 'UserStu91', 10),
  ('Sara',       'Martinelli',  'sara.martinelli3b@studenti.it', 'UserStu92', 10),
  ('Jacopo',     'Ruggeri',     'jacopo.ruggeri3b@studenti.it',  'UserStu93', 10),
  ('Irene',      'De Rosa',     'irene.derosa3b@studenti.it',    'UserStu94', 10),
  ('Thomas',     'Farina',      'thomas.farina3b@studenti.it',   'UserStu95', 10),
  ('Viola',      'Caputo',      'viola.caputo3b@studenti.it',    'UserStu96', 10),
  ('Diego',      'Giordano',    'diego.giordano3b@studenti.it',  'UserStu97', 10),
  ('Ludovica',   'Pagano',      'ludovica.pagano3b@studenti.it', 'UserStu98', 10),
  ('Gabriel',    'Milani',      'gabriel.milani3b@studenti.it',  'UserStu99', 10),
  ('Noemi',      'Vitali',      'noemi.vitali3b@studenti.it',    'UserStu100', 10);

-- Classe 3C (ID_C = 11)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Nathan',     'Benedetto',   'nathan.benedetto3c@studenti.it', 'UserStu101', 11),
  ('Melissa',    'D''Angelo',   'melissa.dangelo3c@studenti.it', 'UserStu102', 11),
  ('Alex',       'Tosi',        'alex.tosi3c@studenti.it',       'UserStu103', 11),
  ('Marika',     'Negri',       'marika.negri3c@studenti.it',    'UserStu104', 11),
  ('Nicholas',   'Marini',      'nicholas.marini3c@studenti.it', 'UserStu105', 11),
  ('Angelica',   'De Luca',     'angelica.deluca3c@studenti.it', 'UserStu106', 11),
  ('Ivan',       'Grassi',      'ivan.grassi3c@studenti.it',     'UserStu107', 11),
  ('Martina',    'Cattaneo',    'martina.cattaneo3c@studenti.it', 'UserStu108', 11),
  ('Cristian',   'Giuliani',    'cristian.giuliani3c@studenti.it', 'UserStu109', 11),
  ('Denise',     'Palmieri',    'denise.palmieri3c@studenti.it', 'UserStu110', 11);

-- Classe 3D (ID_C = 12)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Omar',       'Ferraro',     'omar.ferraro3d@studenti.it',    'UserStu111', 12),
  ('Sabrina',    'Longo',       'sabrina.longo3d@studenti.it',   'UserStu112', 12),
  ('Amir',       'Rizzi',       'amir.rizzi3d@studenti.it',      'UserStu113', 12),
  ('Eleonora',   'Mancini',     'eleonora.mancini3d@studenti.it', 'UserStu114', 12),
  ('Samuele',    'Sartori',     'samuele.sartori3d@studenti.it', 'UserStu115', 12),
  ('Federica',   'Villa',       'federica.villa3d@studenti.it',  'UserStu116', 12),
  ('Liam',       'Rossini',     'liam.rossini@studenti.it',      'UserStu117', 12),
  ('Ginevra',    'Marini',      'ginevra.marini@studenti.it',    'UserStu118', 12),
  ('Noah',       'Fontana',     'noah.fontana@studenti.it',      'UserStu119', 12),
  ('Vittoria',   'Galli',       'vittoria.galli@studenti.it',    'UserStu120', 12);

-- Classe 4A (ID_C = 13)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Emanuele',   'Conti',       'emanuele.conti@studenti.it',    'UserStu121', 13),
  ('Carlotta',   'Ferretti',    'carlotta.ferretti@studenti.it', 'UserStu122', 13),
  ('Mattia',     'Rossetti',    'mattia.rossetti@studenti.it',   'UserStu123', 13),
  ('Bianca',     'Moretti',     'bianca.moretti@studenti.it',    'UserStu124', 13),
  ('Alessio',    'Caruso',      'alessio.caruso@studenti.it',    'UserStu125', 13),
  ('Giulia',     'Fabbri',      'giulia.fabbri@studenti.it',     'UserStu126', 13),
  ('Davide',     'Bellini',     'davide.bellini@studenti.it',    'UserStu127', 13),
  ('Lucrezia',   'Marchetti',   'lucrezia.marchetti@studenti.it', 'UserStu128', 13),
  ('Tommaso',    'Ferrara',     'tommaso.ferrara@studenti.it',   'UserStu129', 13),
  ('Benedetta',  'Leone',       'benedetta.leone@studenti.it',   'UserStu130', 13);

-- Classe 4B (ID_C = 14)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Francesco',  'Romano',      'francesco.romano@studenti.it',  'UserStu131', 14),
  ('Margherita', 'Vitale',      'margherita.vitale@studenti.it', 'UserStu132', 14),
  ('Pietro',     'Greco',       'pietro.greco@studenti.it',      'UserStu133', 14),
  ('Elisa',      'Lombardi',    'elisa.lombardi@studenti.it',    'UserStu134', 14),
  ('Giovanni',   'Marini',      'giovanni.marini4b@studenti.it', 'UserStu135', 14),
  ('Anna',       'Barbieri',    'anna.barbieri@studenti.it',     'UserStu136', 14),
  ('Simone',     'Gentile',     'simone.gentile4b@studenti.it',  'UserStu137', 14),
  ('Chiara',     'Pellegrino',  'chiara.pellegrino@studenti.it', 'UserStu138', 14),
  ('Marco',      'De Luca',     'marco.deluca@studenti.it',      'UserStu139', 14),
  ('Sofia',      'Conti',       'sofia.conti@studenti.it',       'UserStu140', 14);

-- Classe 4C (ID_C = 15)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Lorenzo',    'Ricci',       'lorenzo.ricci@studenti.it',     'UserStu141', 15),
  ('Giulia',     'Russo',       'giulia.russo@studenti.it',      'UserStu142', 15),
  ('Alessandro', 'Ferrari',     'alessandro.ferrari4c@studenti.it', 'UserStu143', 15),
  ('Martina',    'Esposito',    'martina.esposito@studenti.it',  'UserStu144', 15),
  ('Andrea',     'Bianchi',     'andrea.bianchi4c@studenti.it',  'UserStu145', 15),
  ('Francesca',  'Romano',      'francesca.romano4c@studenti.it', 'UserStu146', 15),
  ('Nicola',     'Greco',       'nicola.greco@studenti.it',      'UserStu147', 15),
  ('Elena',      'Fontana',     'elena.fontana@studenti.it',     'UserStu148', 15),
  ('Davide',     'Mariani',     'davide.mariani@studenti.it',    'UserStu149', 15),
  ('Chiara',     'Ferretti',    'chiara.ferretti@studenti.it',   'UserStu150', 15);

-- Classe 4D (ID_C = 16)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Matteo',     'Colombo',     'matteo.colombo@studenti.it',    'UserStu151', 16),
  ('Alice',      'Moretti',     'alice.moretti@studenti.it',     'UserStu152', 16),
  ('Federico',   'Rinaldi',     'federico.rinaldi@studenti.it',  'UserStu153', 16),
  ('Beatrice',   'Galli',       'beatrice.galli@studenti.it',    'UserStu154', 16),
  ('Gabriele',   'Serra',       'gabriele.serra@studenti.it',    'UserStu155', 16),
  ('Vittoria',   'Caruso',      'vittoria.caruso@studenti.it',   'UserStu156', 16),
  ('Riccardo',   'Martini',     'riccardo.martini@studenti.it',  'UserStu157', 16),
  ('Camilla',    'Benedetti',   'camilla.benedetti@studenti.it', 'UserStu158', 16),
  ('Luca',       'Farina',      'luca.farina@studenti.it',       'UserStu159', 16),
  ('Sofia',      'De Rosa',     'sofia.derosa@studenti.it',      'UserStu160', 16);

-- Classe 5A (ID_C = 17)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Edoardo',    'Lombardi',    'edoardo.lombardi@studenti.it',  'UserStu161', 17),
  ('Greta',      'Ferrari',     'greta.ferrari@studenti.it',     'UserStu162', 17),
  ('Tommaso',    'Russo',       'tommaso.russo@studenti.it',     'UserStu163', 17),
  ('Emma',       'Gentile',     'emma.gentile@studenti.it',      'UserStu164', 17),
  ('Filippo',    'Marino',      'filippo.marino@studenti.it',    'UserStu165', 17),
  ('Giorgia',    'Santoro',     'giorgia.santoro@studenti.it',   'UserStu166', 17),
  ('Leonardo',   'Villa',       'leonardo.villa@studenti.it',    'UserStu167', 17),
  ('Aurora',     'Mancini',     'aurora.mancini@studenti.it',    'UserStu168', 17),
  ('Samuele',    'Costa',       'samuele.costa@studenti.it',     'UserStu169', 17),
  ('Viola',      'Rizzo',       'viola.rizzo@studenti.it',       'UserStu170', 17);

-- Classe 5B (ID_C = 18)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Michele',    'Pellegrini',  'michele.pellegrini@studenti.it', 'UserStu171', 18),
  ('Alessia',    'Ferri',       'alessia.ferri@studenti.it',     'UserStu172', 18),
  ('Christian',  'Battaglia',   'christian.battaglia@studenti.it', 'UserStu173', 18),
  ('Ginevra',    'Rossetti',    'ginevra.rossetti@studenti.it',  'UserStu174', 18),
  ('Noah',       'Moretti',     'noah.moretti@studenti.it',      'UserStu175', 18),
  ('Margherita', 'Bellini',     'margherita.bellini@studenti.it', 'UserStu176', 18),
  ('Samuel',     'Neri',        'samuel.neri@studenti.it',       'UserStu177', 18),
  ('Benedetta',  'Marini',      'benedetta.marini@studenti.it',  'UserStu178', 18),
  ('Gabriel',    'Fontana',     'gabriel.fontana@studenti.it',   'UserStu179', 18),
  ('Carlotta',   'Greco',       'carlotta.greco@studenti.it',    'UserStu180', 18);

-- Classe 5C (ID_C = 19)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Liam',       'Esposito',    'liam.esposito@studenti.it',     'UserStu181', 19),
  ('Ludovica',   'Romano',      'ludovica.romano@studenti.it',   'UserStu182', 19),
  ('Alessio',    'Conti',       'alessio.conti5c@studenti.it',   'UserStu183', 19),
  ('Eleonora',   'Ferretti',    'eleonora.ferretti@studenti.it', 'UserStu184', 19),
  ('Nathan',     'Galli',       'nathan.galli@studenti.it',      'UserStu185', 19),
  ('Melissa',    'Bruno',       'melissa.bruno@studenti.it',     'UserStu186', 19),
  ('Alex',       'Ricci',       'alex.ricci@studenti.it',        'UserStu187', 19),
  ('Marika',     'Serra',       'marika.serra@studenti.it',      'UserStu188', 19),
  ('Ivan',       'Marchetti',   'ivan.marchetti@studenti.it',    'UserStu189', 19),
  ('Denise',     'Colombo',     'denise.colombo@studenti.it',    'UserStu190', 19);

-- Classe 5D (ID_C = 20)
INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Omar',       'Vitale',      'omar.vitale@studenti.it',       'UserStu191', 20),
  ('Sabrina',    'Caruso',      'sabrina.caruso@studenti.it',    'UserStu192', 20),
  ('Amir',       'De Luca',     'amir.deluca@studenti.it',       'UserStu193', 20),
  ('Federica',   'Gentile',     'federica.gentile@studenti.it',  'UserStu194', 20),
  ('Cristian',   'Pellegrino',  'cristian.pellegrino@studenti.it', 'UserStu195', 20),
  ('Angelica',   'Fabbri',      'angelica.fabbri@studenti.it',   'UserStu196', 20),
  ('Nicholas',   'Barbieri',    'nicholas.barbieri@studenti.it', 'UserStu197', 20),
  ('Irene',      'Lombardi',    'irene.lombardi@studenti.it',    'UserStu198', 20),
  ('Thomas',     'Moretti',     'thomas.moretti@studenti.it',    'UserStu199', 20),
  ('Jasmine',    'Ferrara',     'jasmine.ferrara@studenti.it',   'UserStu200', 20);

-- ========================================
-- INSERIMENTO ORARI
-- ========================================

-- LUNEDI - Classi 1A, 1B, 1C, 1D
INSERT INTO ORARIO (ID_D, ID_C, NOME_AULA, GIORNO, ORA_INI, ORA_FIN) VALUES
  -- Classe 1A
  (1,  1, 'Aula HIG',                'Lunedi', '08:00', '09:00'),
  (8,  1, 'Aula HIG',                'Lunedi', '09:00', '10:00'),
  (16, 1, 'Aula HIG',                'Lunedi', '10:00', '11:00'),
  (21, 1, 'Palestra',                'Lunedi', '11:00', '12:00'),
  (5,  1, 'Laboratorio Scienze',     'Lunedi', '12:00', '13:00'),
  
  -- Classe 1B
  (2,  2, 'Aula AB',                 'Lunedi', '08:00', '09:00'),
  (9,  2, 'Aula AB',                 'Lunedi', '09:00', '10:00'),
  (10, 2, 'Aula AB',                 'Lunedi', '10:00', '11:00'),
  (6,  2, 'Laboratorio Informatica', 'Lunedi', '11:00', '12:00'),
  (12, 2, 'Aula AB',                 'Lunedi', '12:00', '13:00'),
  
  -- Classe 1C
  (1,  3, 'Aula EF',                 'Lunedi', '08:00', '09:00'),
  (8,  3, 'Aula EF',                 'Lunedi', '09:00', '10:00'),
  (3,  3, 'Laboratorio Fisica',      'Lunedi', '10:00', '11:00'),
  (19, 3, 'Aula EF',                 'Lunedi', '11:00', '12:00'),
  (20, 3, 'Sala Musica',             'Lunedi', '12:00', '13:00'),
  
  -- Classe 1D
  (2,  4, 'Aula GH',                 'Lunedi', '08:00', '09:00'),
  (9,  4, 'Aula GH',                 'Lunedi', '09:00', '10:00'),
  (16, 4, 'Aula GH',                 'Lunedi', '10:00', '11:00'),
  (4,  4, 'Laboratorio Chimica',     'Lunedi', '11:00', '12:00'),
  (25, 4, 'Aula GH',                 'Lunedi', '12:00', '13:00');

-- MARTEDI - Classi 2A, 2B, 2C, 2D
INSERT INTO ORARIO (ID_D, ID_C, NOME_AULA, GIORNO, ORA_INI, ORA_FIN) VALUES
  -- Classe 2A
  (1,  5, 'Aula IJ',                 'Martedi', '08:00', '09:00'),
  (8,  5, 'Aula IJ',                 'Martedi', '09:00', '10:00'),
  (10, 5, 'Aula IJ',                 'Martedi', '10:00', '11:00'),
  (16, 5, 'Aula IJ',                 'Martedi', '11:00', '12:00'),
  (13, 5, 'Aula IJ',                 'Martedi', '12:00', '13:00'),
  
  -- Classe 2B
  (2,  6, 'Aula KL',                 'Martedi', '08:00', '09:00'),
  (9,  6, 'Aula KL',                 'Martedi', '09:00', '10:00'),
  (3,  6, 'Laboratorio Fisica',      'Martedi', '10:00', '11:00'),
  (22, 6, 'Palestra',                'Martedi', '11:00', '12:00'),
  (17, 6, 'Laboratorio Lingue',      'Martedi', '12:00', '13:00'),
  
  -- Classe 2C
  (1,  7, 'Aula MN',                 'Martedi', '08:00', '09:00'),
  (8,  7, 'Aula MN',                 'Martedi', '09:00', '10:00'),
  (7,  7, 'Laboratorio Informatica', 'Martedi', '10:00', '11:00'),
  (12, 7, 'Aula MN',                 'Martedi', '11:00', '12:00'),
  (5,  7, 'Laboratorio Scienze',     'Martedi', '12:00', '13:00'),
  
  -- Classe 2D
  (2,  8, 'Aula OP',                 'Martedi', '08:00', '09:00'),
  (9,  8, 'Aula OP',                 'Martedi', '09:00', '10:00'),
  (11, 8, 'Aula OP',                 'Martedi', '10:00', '11:00'),
  (16, 8, 'Aula OP',                 'Martedi', '11:00', '12:00'),
  (4,  8, 'Laboratorio Chimica',     'Martedi', '12:00', '13:00');

-- MERCOLEDI - Classi 3A, 3B, 3C, 3D
INSERT INTO ORARIO (ID_D, ID_C, NOME_AULA, GIORNO, ORA_INI, ORA_FIN) VALUES
  -- Classe 3A
  (1,  9,  'Aula QR',                'Mercoledi', '08:00', '09:00'),
  (8,  9,  'Aula QR',                'Mercoledi', '09:00', '10:00'),
  (13, 9,  'Aula QR',                'Mercoledi', '10:00', '11:00'),
  (11, 9,  'Aula QR',                'Mercoledi', '11:00', '12:00'),
  (14, 9,  'Aula QR',                'Mercoledi', '12:00', '13:00'),
  
  -- Classe 3B
  (2,  10, 'Aula ST',                'Mercoledi', '08:00', '09:00'),
  (9,  10, 'Aula ST',                'Mercoledi', '09:00', '10:00'),
  (3,  10, 'Laboratorio Fisica',     'Mercoledi', '10:00', '11:00'),
  (16, 10, 'Aula ST',                'Mercoledi', '11:00', '12:00'),
  (15, 10, 'Aula ST',                'Mercoledi', '12:00', '13:00'),
  
  -- Classe 3C
  (1,  11, 'Aula UV',                'Mercoledi', '08:00', '09:00'),
  (8,  11, 'Aula UV',                'Mercoledi', '09:00', '10:00'),
  (7,  11, 'Laboratorio Informatica', 'Mercoledi', '10:00', '11:00'),
  (17, 11, 'Laboratorio Lingue',     'Mercoledi', '11:00', '12:00'),
  (21, 11, 'Palestra',               'Mercoledi', '12:00', '13:00'),
  
  -- Classe 3D
  (2,  12, 'Aula WX',                'Mercoledi', '08:00', '09:00'),
  (9,  12, 'Aula WX',                'Mercoledi', '09:00', '10:00'),
  (10, 12, 'Aula WX',                'Mercoledi', '10:00', '11:00'),
  (5,  12, 'Laboratorio Scienze',    'Mercoledi', '11:00', '12:00'),
  (18, 12, 'Laboratorio Lingue',     'Mercoledi', '12:00', '13:00');

-- GIOVEDI - Classi 4A, 4B, 4C, 4D
INSERT INTO ORARIO (ID_D, ID_C, NOME_AULA, GIORNO, ORA_INI, ORA_FIN) VALUES
  -- Classe 4A
  (1,  13, 'Aula YZ',                'Giovedi', '08:00', '09:00'),
  (8,  13, 'Aula YZ',                'Giovedi', '09:00', '10:00'),
  (11, 13, 'Aula YZ',                'Giovedi', '10:00', '11:00'),
  (23, 13, 'Aula YZ',                'Giovedi', '11:00', '12:00'),
  (24, 13, 'Aula YZ',                'Giovedi', '12:00', '13:00'),
  
  -- Classe 4B
  (2,  14, 'Aula BC',                'Giovedi', '08:00', '09:00'),
  (9,  14, 'Aula BC',                'Giovedi', '09:00', '10:00'),
  (3,  14, 'Laboratorio Fisica',     'Giovedi', '10:00', '11:00'),
  (16, 14, 'Aula BC',                'Giovedi', '11:00', '12:00'),
  (22, 14, 'Palestra',               'Giovedi', '12:00', '13:00'),
  
  -- Classe 4C
  (1,  15, 'Aula CD',                'Giovedi', '08:00', '09:00'),
  (8,  15, 'Aula CD',                'Giovedi', '09:00', '10:00'),
  (7,  15, 'Laboratorio Informatica', 'Giovedi', '10:00', '11:00'),
  (13, 15, 'Aula CD',                'Giovedi', '11:00', '12:00'),
  (17, 15, 'Laboratorio Lingue',     'Giovedi', '12:00', '13:00'),
  
  -- Classe 4D
  (2,  16, 'Aula FG',                'Giovedi', '08:00', '09:00'),
  (9,  16, 'Aula FG',                'Giovedi', '09:00', '10:00'),
  (11, 16, 'Aula FG',                'Giovedi', '10:00', '11:00'),
  (23, 16, 'Aula FG',                'Giovedi', '11:00', '12:00'),
  (4,  16, 'Laboratorio Chimica',    'Giovedi', '12:00', '13:00');

-- VENERDI - Classi 5A, 5B, 5C, 5D
INSERT INTO ORARIO (ID_D, ID_C, NOME_AULA, GIORNO, ORA_INI, ORA_FIN) VALUES
  -- Classe 5A
  (1,  17, 'Aula HI',                'Venerdi', '08:00', '09:00'),
  (8,  17, 'Aula HI',                'Venerdi', '09:00', '10:00'),
  (13, 17, 'Aula HI',                'Venerdi', '10:00', '11:00'),
  (11, 17, 'Aula HI',                'Venerdi', '11:00', '12:00'),
  (14, 17, 'Aula HI',                'Venerdi', '12:00', '13:00'),
  
  -- Classe 5B
  (2,  18, 'Aula JK',                'Venerdi', '08:00', '09:00'),
  (9,  18, 'Aula JK',                'Venerdi', '09:00', '10:00'),
  (3,  18, 'Laboratorio Fisica',     'Venerdi', '10:00', '11:00'),
  (24, 18, 'Aula JK',                'Venerdi', '11:00', '12:00'),
  (16, 18, 'Aula JK',                'Venerdi', '12:00', '13:00'),
  
  -- Classe 5C
  (1,  19, 'Aula LM',                'Venerdi', '08:00', '09:00'),
  (8,  19, 'Aula LM',                'Venerdi', '09:00', '10:00'),
  (7,  19, 'Laboratorio Informatica', 'Venerdi', '10:00', '11:00'),
  (23, 19, 'Aula LM',                'Venerdi', '11:00', '12:00'),
  (21, 19, 'Palestra',               'Venerdi', '12:00', '13:00'),
  
  -- Classe 5D
  (2,  20, 'Aula DD',                'Venerdi', '08:00', '09:00'),
  (9,  20, 'Aula DD',                'Venerdi', '09:00', '10:00'),
  (11, 20, 'Aula DD',                'Venerdi', '10:00', '11:00'),
  (5,  20, 'Laboratorio Scienze',    'Venerdi', '11:00', '12:00'),
  (18, 20, 'Laboratorio Lingue',     'Venerdi', '12:00', '13:00');

-- Orari aggiuntivi per completare la settimana
INSERT INTO ORARIO (ID_D, ID_C, NOME_AULA, GIORNO, ORA_INI, ORA_FIN) VALUES
  -- MARTEDI - Classi 1A e 1B (lezioni pomeridiane)
  (6,  1, 'Laboratorio Informatica', 'Martedi', '14:00', '15:00'),
  (19, 1, 'Aula HIG',                'Martedi', '15:00', '16:00'),
  
  (5,  2, 'Laboratorio Scienze',     'Martedi', '14:00', '15:00'),
  (21, 2, 'Palestra',                'Martedi', '15:00', '16:00'),
  
  -- MERCOLEDI - Classi 1C e 1D (lezioni pomeridiane)
  (6,  3, 'Laboratorio Informatica', 'Mercoledi', '14:00', '15:00'),
  (17, 3, 'Laboratorio Lingue',      'Mercoledi', '15:00', '16:00'),
  
  (7,  4, 'Laboratorio Informatica', 'Mercoledi', '14:00', '15:00'),
  (22, 4, 'Palestra',                'Mercoledi', '15:00', '16:00'),
  
  -- GIOVEDI - Classi 2A e 2B (lezioni pomeridiane)
  (19, 5, 'Aula IJ',                 'Giovedi', '14:00', '15:00'),
  (14, 5, 'Aula IJ',                 'Giovedi', '15:00', '16:00'),
  
  (18, 6, 'Laboratorio Lingue',      'Giovedi', '14:00', '15:00'),
  (20, 6, 'Sala Musica',             'Giovedi', '15:00', '16:00'),
  
  -- VENERDI - Classi 3A e 3B (lezioni pomeridiane)
  (19, 9,  'Aula QR',                'Venerdi', '14:00', '15:00'),
  (6,  9,  'Laboratorio Informatica', 'Venerdi', '15:00', '16:00'),
  
  (18, 10, 'Laboratorio Lingue',     'Venerdi', '14:00', '15:00'),
  (20, 10, 'Sala Musica',            'Venerdi', '15:00', '16:00');