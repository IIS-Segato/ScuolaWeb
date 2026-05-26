CREATE TABLE IF NOT EXISTS note_alunni (
  id int(11) NOT NULL AUTO_INCREMENT,
  id_studente int(11) NOT NULL,
  id_docente int(11) NOT NULL,
  tipo enum('DISCIPLINARE','GENERICA') NOT NULL,
  testo text NOT NULL,
  data date NOT NULL,
  ora time NOT NULL,
  created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY id_studente (id_studente),
  KEY id_docente (id_docente),
  KEY data_ora (data, ora),
  CONSTRAINT note_alunni_ibfk_1 FOREIGN KEY (id_studente) REFERENCES studenti (id),
  CONSTRAINT note_alunni_ibfk_2 FOREIGN KEY (id_docente) REFERENCES docenti (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
