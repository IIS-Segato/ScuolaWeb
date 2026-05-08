INSERT INTO CLASSI (SEZIONE, ANNO, N_STUDENTI) VALUES
  ('A', 1, 25),
  ('B', 1, 23),
  ('A', 2, 27),
  ('B', 2, 24),
  ('A', 3, 22);

INSERT INTO AULE (NOME, CAPIENZA) VALUES
  ('Aula HIG', 30),
  ('Aula AB', 28),
  ('Aula DD', 32),
  ('Laboratorio Informatica', 25),
  ('Laboratorio Scienze', 20),
  ('Aula Magna', 100);


INSERT INTO DOCENTI (NOME, COGNOME, MATERIA, EMAIL, PWD) VALUES
  ('Marco',   'Rossi',    'Matematica',  'm.rossi@scuola.it',   'UserDoc01'),
  ('Laura',   'Bianchi',  'Italiano',    'l.bianchi@scuola.it', 'UserDoc02'),
  ('Giorgio', 'Ferrari',  'Storia',      'g.ferrari@scuola.it', 'UserDoc03'),
  ('Silvia',  'Conti',    'Scienze',     's.conti@scuola.it',   'UserDoc04'),
  ('Luca',    'Mancini',  'Informatica', 'l.mancini@scuola.it', 'UserDoc05'),
  ('Anna',    'Ricci',    'Inglese',     'a.ricci@scuola.it',   'UserDoc06');

INSERT INTO AMMINISTRATORI (NOME, COGNOME, EMAIL, PWD) VALUES
  ('Carlo',   'Esposito', 'c.esposito@scuola.it', 'UserAmm01'),
  ('Martina', 'De Luca',  'm.deluca@scuola.it',   'UserAmm02');

INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES
  ('Alice',    'Galli',      'alice.galli@studenti.it',      'UserStu01', 1),
  ('Matteo',   'Bruno',      'matteo.bruno@studenti.it',     'UserStu02', 1),
  ('Sofia',    'Marino',     'sofia.marino@studenti.it',     'UserStu03', 1),
  ('Davide',   'Greco',      'davide.greco@studenti.it',     'UserStu04', 2),
  ('Chiara',   'Lombardi',   'chiara.lombardi@studenti.it',  'UserStu05', 2),
  ('Nicola',   'Fontana',    'nicola.fontana@studenti.it',   'UserStu06', 2),
  ('Giulia',   'Caruso',     'giulia.caruso@studenti.it',    'UserStu07', 3),
  ('Lorenzo',  'Santoro',    'lorenzo.santoro@studenti.it',  'UserStu08', 3),
  ('Beatrice', 'Ferrara',    'beatrice.ferrara@studenti.it', 'UserStu09', 3),
  ('Filippo',  'Costa',      'filippo.costa@studenti.it',    'UserStu10', 4),
  ('Valeria',  'Gentile',    'valeria.gentile@studenti.it',  'UserStu11', 4),
  ('Simone',   'Vitale',     'simone.vitale@studenti.it',    'UserStu12', 4),
  ('Alessia',  'Barbieri',   'alessia.barbieri@studenti.it', 'UserStu13', 5),
  ('Federico', 'Coppola',    'federico.coppola@studenti.it', 'UserStu14', 5),
  ('Marta',    'Pellegrini', 'marta.pellegrini@studenti.it', 'UserStu15', 5);

INSERT INTO ORARIO (ID_D, ID_C, NOME_AULA, GIORNO, ORA_INI, ORA_FIN) VALUES
  (1, 1, 'Aula HIG',                'Lunedi',    '08:00', '09:00'),
  (2, 1, 'Aula HIG',                'Lunedi',    '09:00', '10:00'),
  (3, 2, 'Aula AB',                 'Lunedi',    '08:00', '09:00'),
  (4, 2, 'Aula AB',                 'Lunedi',    '09:00', '10:00'),
  (5, 3, 'Laboratorio Informatica', 'Martedi',   '10:00', '11:00'),
  (6, 3, 'Aula DD',                 'Martedi',   '11:00', '12:00');