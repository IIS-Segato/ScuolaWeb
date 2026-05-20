DROP DATABASE IF EXISTS scuola;
CREATE DATABASE scuola;
USE scuola;

-- =========================
-- PERSONE
-- =========================
CREATE OR REPLACE TABLE persone(
 id_persona INT AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(50) NOT NULL,
 cognome VARCHAR(50) NOT NULL,
 email VARCHAR(100) UNIQUE,
 cf VARCHAR(16) UNIQUE,
 nascita DATE,
 img_profilo BLOB
);

-- =========================
-- RUOLI
-- =========================
CREATE OR REPLACE TABLE ruoli(
 id_ruolo INT AUTO_INCREMENT PRIMARY KEY,
 nome_ruolo VARCHAR(20) UNIQUE NOT NULL,

 gestione_utenti BOOLEAN DEFAULT FALSE,

 voti_modifica_tutti BOOLEAN DEFAULT FALSE,
 voti_visualizza_tutti BOOLEAN DEFAULT FALSE,
 voti_modifica_propri BOOLEAN DEFAULT FALSE,
 voti_visualizza_propri BOOLEAN DEFAULT TRUE,
 voti_visualizza_classe BOOLEAN DEFAULT FALSE,

 orario_modifica BOOLEAN DEFAULT FALSE,
 orario_visualizza BOOLEAN DEFAULT TRUE,

 aule_modifica BOOLEAN DEFAULT FALSE,
 aule_visualizza BOOLEAN DEFAULT TRUE,

 bacheca_pubblica BOOLEAN DEFAULT FALSE,
 bacheca_visualizza BOOLEAN DEFAULT TRUE,

 dati_visualizza BOOLEAN DEFAULT TRUE,

 assenze_inserimento BOOLEAN DEFAULT FALSE,
 assenze_visualizza_classe BOOLEAN DEFAULT FALSE,
 assenze_visualizza_proprie BOOLEAN DEFAULT TRUE,
 assenze_giustifica BOOLEAN DEFAULT FALSE,
 assenze_approva_giustifica BOOLEAN DEFAULT FALSE
);

-- =========================
-- RUOLI DATI
-- =========================

INSERT INTO ruoli VALUES (
1,'ADMIN',
TRUE,
TRUE, TRUE, TRUE, TRUE, TRUE,
TRUE, TRUE,
TRUE, TRUE,
TRUE, TRUE,
TRUE,
TRUE, TRUE, TRUE, TRUE, TRUE
);

INSERT INTO ruoli VALUES (
2,'SEGRETARIO',
TRUE,
FALSE, FALSE, FALSE, FALSE, FALSE,
TRUE, TRUE,
TRUE, TRUE,
TRUE, TRUE,
TRUE,
FALSE, FALSE, FALSE, FALSE, FALSE
);

INSERT INTO ruoli VALUES (
3,'RAPPRESENTANTE',
FALSE,
FALSE, FALSE, TRUE, TRUE, TRUE,
FALSE, TRUE,
FALSE, TRUE,
FALSE, TRUE,
TRUE,
TRUE, TRUE, TRUE, TRUE, TRUE
);

INSERT INTO ruoli VALUES (
4,'DOCENTE',
FALSE,
FALSE, FALSE, TRUE, TRUE, FALSE,
FALSE, TRUE,
FALSE, TRUE,
FALSE, TRUE,
TRUE,
TRUE, TRUE, FALSE, FALSE, TRUE
);

INSERT INTO ruoli VALUES (
5,'STUDENTE',
FALSE,
FALSE, FALSE, FALSE, TRUE, FALSE,
FALSE, TRUE,
FALSE, TRUE,
FALSE, TRUE,
TRUE,
FALSE, FALSE, TRUE, TRUE, FALSE
);

-- =========================
-- UTENTI LOGIN
-- =========================
CREATE OR REPLACE TABLE utenti(
 id_utente INT AUTO_INCREMENT PRIMARY KEY,
 username VARCHAR(50) UNIQUE NOT NULL,
 password_hash VARCHAR(255) NOT NULL,
 id_persona INT NOT NULL,
 id_ruolo INT NOT NULL,

 FOREIGN KEY(id_persona) REFERENCES persone(id_persona)
 ON DELETE CASCADE ON UPDATE CASCADE,

 FOREIGN KEY(id_ruolo) REFERENCES ruoli(id_ruolo)
 ON DELETE CASCADE ON UPDATE CASCADE
);

-- =========================
-- CLASSI
-- =========================
CREATE OR REPLACE TABLE classi(
 id_classe INT AUTO_INCREMENT PRIMARY KEY,
 anno INT NOT NULL,
 sezione VARCHAR(5),
 indirizzo VARCHAR(50)
);

-- =========================
-- STUDENTI
-- =========================
CREATE OR REPLACE TABLE studenti(
 id_studente INT AUTO_INCREMENT PRIMARY KEY,
 id_persona INT UNIQUE,
 id_classe INT,

 FOREIGN KEY(id_persona) REFERENCES persone(id_persona)
 ON DELETE CASCADE,

 FOREIGN KEY(id_classe) REFERENCES classi(id_classe)
 ON DELETE SET NULL
);

-- =========================
-- DOCENTI
-- =========================
CREATE OR REPLACE TABLE docenti(
 id_docente INT AUTO_INCREMENT PRIMARY KEY,
 id_persona INT UNIQUE,

 FOREIGN KEY(id_persona) REFERENCES persone(id_persona)
 ON DELETE CASCADE
);

-- =========================
-- MATERIE
-- =========================
CREATE OR REPLACE TABLE materie(
 id_materia INT AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(50) UNIQUE NOT NULL
);

-- =========================
-- INSEGNAMENTI
-- =========================
CREATE OR REPLACE TABLE insegnamenti(
 id_insegnamento INT AUTO_INCREMENT PRIMARY KEY,
 id_docente INT,
 id_materia INT,
 id_classe INT,

 UNIQUE(id_docente,id_materia,id_classe),

 FOREIGN KEY(id_docente) REFERENCES docenti(id_docente)
 ON DELETE CASCADE,

 FOREIGN KEY(id_materia) REFERENCES materie(id_materia)
 ON DELETE CASCADE,

 FOREIGN KEY(id_classe) REFERENCES classi(id_classe)
 ON DELETE CASCADE
);

-- =========================
-- AULE
-- =========================
CREATE OR REPLACE TABLE aule(
 id_aula INT AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(30) UNIQUE,
 capienza INT
);

-- =========================
-- ORARIO
-- =========================
CREATE OR REPLACE TABLE orario(
 id_orario INT AUTO_INCREMENT PRIMARY KEY,
 id_insegnamento INT,
 id_aula INT,

 giorno ENUM('LUN','MAR','MER','GIO','VEN','SAB'),
 ora_inizio TIME,
 ora_fine TIME,

 FOREIGN KEY(id_insegnamento) REFERENCES insegnamenti(id_insegnamento)
 ON DELETE CASCADE,

 FOREIGN KEY(id_aula) REFERENCES aule(id_aula)
 ON DELETE CASCADE
);

-- =========================
-- VOTI
-- =========================
CREATE OR REPLACE TABLE voti(
 id_voto INT AUTO_INCREMENT PRIMARY KEY,
 id_studente INT,
 id_insegnamento INT,
 voto DECIMAL(3,1),
 data_voto DATE,
 descrizione VARCHAR(100),

 FOREIGN KEY(id_studente) REFERENCES studenti(id_studente)
 ON DELETE CASCADE,

 FOREIGN KEY(id_insegnamento) REFERENCES insegnamenti(id_insegnamento)
 ON DELETE CASCADE
);

-- =========================
-- ASSENZE
-- =========================
CREATE OR REPLACE TABLE assenze(
 id_assenza INT AUTO_INCREMENT PRIMARY KEY,
 id_utente INT NOT NULL,
 data_evento DATE NOT NULL,
 tipo ENUM('ASSENZA','RITARDO','USCITA') NOT NULL,
 ora_evento TIME NULL,
 giustificata BOOLEAN DEFAULT FALSE,
 motivazione TEXT,
 giustificata_da INT NULL,
 data_giustifica DATETIME NULL,

 FOREIGN KEY(id_utente) REFERENCES utenti(id_utente),
 FOREIGN KEY(giustificata_da) REFERENCES utenti(id_utente)
);

-- =========================
-- BACHECA ANNUNCI
-- =========================
CREATE OR REPLACE TABLE annunci(
 id_annuncio INT AUTO_INCREMENT PRIMARY KEY,
 titolo VARCHAR(100),
 contenuto TEXT,
 data_pubblicazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
 autore INT,

 FOREIGN KEY(autore) REFERENCES utenti(id_utente)
 ON DELETE SET NULL
);

-- =========================
-- ANNUNCI CLASSE
-- =========================
CREATE OR REPLACE TABLE annunci_classe(
 id_annuncio INT NOT NULL,
 id_classe INT NOT NULL,
 id_docente INT NOT NULL,
 PRIMARY KEY(id_annuncio, id_classe),

 FOREIGN KEY (id_annuncio)
    REFERENCES annunci(id_annuncio)
    ON DELETE CASCADE,

 FOREIGN KEY (id_classe)
    REFERENCES classi(id_classe)
    ON DELETE CASCADE
);
