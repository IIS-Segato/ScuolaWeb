# Scuola Web:

Applicazione web per la gestione di un portale scolasctico con le seguenti
funzionalita':

- Gestione degli accessi di 3 tipologie di account differenti (admin, docenti e
  studenti);
- Gestione login con sessione;
- Interfaccia grafica con CSS;


## Architettura MVC:

Model = Classi JAVA 
Control = Servlet
View = JSP

DAO = Accesso separato al database con JDBC


## Struttura DB:

STUDENTI
id, nome, cognome, email, eta, id_classe

DOCENTI
id, nome, cognome, email, materia

ADMINS
id, nome, cognome, email

AULA
id, numero

CLASSE
id, nome, numero_studenti

LEZIONE
id, id_classe, id_docente, id_aula


## Divisione compiti:

Dona: Frontend pagine JSP
Enrico: Control
Luan: Database con JDBC
Zappa: Struttura pagine e navigazione


interfaccia tipo argo didup, navigazione e struttura delle pagine. Pensarea a
come collegare le pagine, tra i diversi tipi di utenti es docenti, studenti.
Accessibilita dell' utente di come utilizza le pagine
