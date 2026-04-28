-- AULE
INSERT INTO AULE (NOME, CAPIENZA) VALUES
  ('Aula 1A', 30),
  ('Aula 1B', 28),
  ('Aula 2A', 32),
  ('Laboratorio Informatica', 25),
  ('Laboratorio Scienze', 20),
  ('Aula Magna', 100);
  
  -- CLASSI
INSERT INTO CLASSI (ID_C, SEZIONE, ANNO, N_STUDENTI) VALUES
  (1, 'A', 1, 25),
  (2, 'B', 1, 23),
  (3, 'A', 2, 27),
  (4, 'B', 2, 24),
  (5, 'A', 3, 22);
  
  -- DOCENTI 
INSERT INTO DOCENTI (ID_D, NOME, COGNOME, MATERIA, EMAIL, PWD) VALUES
  (1, 'Marco',    'Rossi',     'Matematica',      'm.rossi@scuola.it',     'UserDoc01'),
  (2, 'Laura',    'Bianchi',   'Italiano',         'l.bianchi@scuola.it',   'UserDoc02'),
  (3, 'Giorgio',  'Ferrari',   'Storia',           'g.ferrari@scuola.it',   'UserDoc03'),
  (4, 'Silvia',   'Conti',     'Scienze',          's.conti@scuola.it',     'UserDoc04'),
  (5, 'Luca',     'Mancini',   'Informatica',      'l.mancini@scuola.it',   'UserDoc05'),
  (6, 'Anna',     'Ricci',     'Inglese',          'a.ricci@scuola.it',     'UserDoc06');
  
  -- AMMINISTRATORI
INSERT INTO AMMINISTRATORI (ID_A, NOME, COGNOME, EMAIL, PWD) VALUES
  (1, 'Carlo',    'Esposito',  'c.esposito@scuola.it',  'UserAmm01'),
  (2, 'Martina',  'De Luca',   'm.deluca@scuola.it',    'UserAmm02');
  
  -- STUDENTI (3 per classe)
INSERT INTO STUDENTI (ID_S, NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  (1,  'Alice',    'Galli',      'alice.galli@studenti.it',      'UserStu01', 1),
  (2,  'Matteo',   'Bruno',      'matteo.bruno@studenti.it',     'UserStu02', 1),
  (3,  'Sofia',    'Marino',     'sofia.marino@studenti.it',     'UserStu03', 1),
  (4,  'Davide',   'Greco',      'davide.greco@studenti.it',     'UserStu04', 2),
  (5,  'Chiara',   'Lombardi',   'chiara.lombardi@studenti.it',  'UserStu05', 2),
  (6,  'Nicola',   'Fontana',    'nicola.fontana@studenti.it',   'UserStu06', 2),
  (7,  'Giulia',   'Caruso',     'giulia.caruso@studenti.it',    'UserStu07', 3),
  (8,  'Lorenzo',  'Santoro',    'lorenzo.santoro@studenti.it',  'UserStu08', 3),
  (9,  'Beatrice', 'Ferrara',    'beatrice.ferrara@studenti.it', 'UserStu09', 3),
  (10, 'Filippo',  'Costa',      'filippo.costa@studenti.it',    'UserStu10', 4),
  (11, 'Valeria',  'Gentile',    'valeria.gentile@studenti.it',  'UserStu11', 4),
  (12, 'Simone',   'Vitale',     'simone.vitale@studenti.it',    'UserStu12', 4),
  (13, 'Alessia',  'Barbieri',   'alessia.barbieri@studenti.it', 'UserStu12', 5),
  (14, 'Federico', 'Coppola',    'federico.coppola@studenti.it', 'UserStu13', 5),
  (15, 'Marta',    'Pellegrini', 'marta.pellegrini@studenti.it', 'UserStu14', 5);
  
  -- ORARIO 
INSERT INTO ORARIO (ID_ORARIO, ID_D, ID_C, NOME_AULA, GIORNO, ORA_INI, ORA_FIN) VALUES
  (1,  1, 1, 'Aula 1A',                'Lunedi',    '08:00', '09:00'),
  (2,  2, 1, 'Aula 1A',                'Lunedi',    '09:00', '10:00'),
  (3,  3, 2, 'Aula 1B',                'Lunedi',    '08:00', '09:00'),
  (4,  4, 2, 'Aula 1B',                'Lunedi',    '09:00', '10:00'),
  (5,  5, 3, 'Laboratorio Informatica', 'Martedi',   '10:00', '11:00'),
  (6,  6, 3, 'Aula 2A',                'Martedi',   '11:00', '12:00'),
  (7,  1, 4, 'Aula 2A',                'Mercoledi', '08:00', '09:00'),
  (8,  2, 4, 'Aula 2A',                'Mercoledi', '09:00', '10:00'),
  (9,  3, 5, 'Aula 1B',                'Giovedi',   '10:00', '11:00'),
  (10, 4, 5, 'Laboratorio Scienze',     'Giovedi',   '11:00', '12:00'),
  (11, 5, 1, 'Laboratorio Informatica', 'Venerdi',   '08:00', '09:00'),
  (12, 6, 2, 'Aula 1B',                'Venerdi',   '09:00', '10:00');