ALTER TABLE registro_eventi
  MODIFY tipo varchar(20) NOT NULL;

UPDATE registro_eventi
SET tipo = 'ASSENTE'
WHERE tipo IN ('ASSENZA', 'RITARDO', 'USCITA');

ALTER TABLE registro_eventi
  MODIFY tipo enum('PRESENTE','ASSENTE') NOT NULL,
  CHANGE ora ora_ingresso time DEFAULT NULL;

ALTER TABLE registro_eventi
  DROP COLUMN note;

ALTER TABLE registro_eventi
  ADD COLUMN ora_uscita time DEFAULT NULL;

ALTER TABLE registro_eventi
  ADD UNIQUE KEY studente_data (id_studente, data);
