# README

# Progetto scuola Web

Bogo Federico

___

# Descrizione del progetto

Il progetto e una web app scolastica sviluppata in Java Servlet, JSP e DAO, con database MySQL/MariaDB.  
L'applicazione permette di gestire utenti, studenti, docenti, classi e voti attraverso un sistema di login con ruoli.


___

# Funzionalita realizzate

Il sistema prevede una pagina di login con controllo delle credenziali e creazione della sessione utente.  
Dopo l'accesso, l'utente viene indirizzato alla dashboard principale, che mostra funzioni diverse in base al ruolo:

- preside / admin
- insegnante
- segreteria
- studente

La gestione dei ruoli permette di proteggere le pagine e limitare le operazioni disponibili.  
Ad esempio, uno studente puo consultare solo i propri dati, mentre un docente puo inserire e gestire solo i voti degli studenti appartenenti alle sue classi.

___

# Login e sessioni

Sono stati sviluppati il sistema di autenticazione e la gestione della sessione.  
Il login controlla username e password nel database, salva l'utente in sessione e permette alla dashboard di mostrare le sezioni corrette.

Sono presenti:

- `LoginServlet`
- `LogoutServlet`
- `UserDao`
- modello `User`
- pagina `login.jsp`
- pagina `dashboard.jsp`

Il modello `User` contiene anche i collegamenti a `id_studente` e `id_docente`, necessari per distinguere l'account dalla persona reale collegata.

___

# Gestione utenti

L'area admin permette di visualizzare e aggiungere utenti del sistema.  
La tabella utenti mostra solo informazioni utili all'utilizzo dell'applicazione, evitando di mostrare campi tecnici come gli id.

Sono presenti:

- `UserServlet`
- `UserAdminDao`
- `utenti.jsp`
- `formUtente.jsp`

___

# Gestione studenti

La gestione studenti permette ad admin e segreteria di consultare l'elenco degli studenti e aggiungerne di nuovi.  
Ogni studente puo essere collegato a una classe.

Lo studente, accedendo con il proprio account, vede una pagina personale con:

- classe
- compagni di classe
- professori assegnati
- voti ricevuti
- media dei voti
- esito generale

Sono presenti:

- `StudenteServlet`
- `StudenteDao`
- `studenti.jsp`
- `formStudente.jsp`
- `studente.jsp`

___

# Gestione docenti

La gestione docenti permette ad admin e segreteria di consultare l'elenco dei docenti e aggiungerne di nuovi.  
I docenti possono essere associati alle classi.

L'interfaccia docente permette di vedere:

- classi assegnate
- studenti presenti in ogni classe

Sono presenti:

- `DocenteServlet`
- `DocenteDao`
- `DocenteClasseDao`
- `docenti.jsp`
- `formDocente.jsp`

___

# Gestione voti

La gestione voti permette ai docenti di inserire, modificare ed eliminare voti.  
L'inserimento avviene selezionando studente, materia, voto e data.

La visualizzazione cambia in base al ruolo:

- lo studente vede solo i propri voti
- il docente vede gli studenti raggruppati per classe, con tutti i voti e la media per ogni studente
- admin e segreteria possono consultare i voti registrati nel sistema

Sono presenti controlli per evitare che un docente modifichi o cancelli voti non collegati alle sue classi.

Sono presenti:

- `VotoServlet`
- `VotoDao`
- `voti.jsp`
- `formVoto.jsp`

___

# Gestione note alunni

La gestione note permette ai docenti di inserire note generiche o disciplinari per gli alunni delle proprie classi.  
Ogni nota richiede studente, tipo, testo, data e ora.

La visualizzazione cambia in base al ruolo:

- lo studente vede solo le proprie note
- il docente vede le note degli studenti delle sue classi
- il docente puo modificare o cancellare solo le note inserite da lui
- admin e segreteria possono consultare le note registrate

Sono presenti controlli per evitare che un docente inserisca, modifichi o cancelli note di studenti non assegnati.

Sono presenti:

- `NotaServlet`
- `NotaDao`
- modello `Nota`
- `note.jsp`
- `formNota.jsp`

___

# Database

Il database contiene le tabelle principali:

- `users`
- `roles`
- `studenti`
- `docenti`
- `classi`
- `docenti_classi`
- `voti`
- `note_alunni`

La connessione viene configurata tramite il file:

- `WEB-INF/dbcfg.xml`

___

# Struttura generale

Il progetto segue una struttura MVC semplice:

- **Model**: classi Java che rappresentano le entita del database
- **DAO**: classi per l'accesso ai dati
- **Controller**: servlet che gestiscono richieste e permessi
- **View**: pagine JSP per l'interfaccia utente

Le pagine principali includono un pulsante `Home` per tornare alla dashboard.

___
