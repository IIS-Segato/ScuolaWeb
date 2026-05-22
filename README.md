# Scuola Web

Applicazione web per la gestione di un portale scolastico con login, sessioni e
ruoli differenti per admin, docenti e studenti.

## Funzionalità
- Gestione degli accessi per 3 tipi di account: admin, docenti e studenti.
- Login con sessione.
- Interfaccia grafica in CSS.
- Navigazione tra le pagine in stile portale scolastico.

## Architettura
- **Model**: classi Java.
- **Controller**: servlet.
- **View**: JSP.
- **DAO**: accesso al database con JDBC.

## Struttura del database
- **STUDENTI**: id, nome, cognome, email, età, id_classe
- **DOCENTI**: id, nome, cognome, email, materia
- **ADMINS**: id, nome, cognome, email
- **AULA**: id, numero
- **CLASSE**: id, nome, numero_studenti
- **LEZIONE**: id, id_classe, id_docente, id_aula

## Organizzazione del progetto
- **Dona**: frontend JSP.
- **Enrico**: controller.
- **Luan**: database e JDBC.
- **Zappa**: struttura pagine e navigazione.

## Obiettivo
Interfaccia simile a Argo DidUp, con pagine collegate in base al tipo di utente
e una navigazione semplice e accessibile.
