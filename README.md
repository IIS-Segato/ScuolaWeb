# README    
  
# Progetto scuola Web  
    
Bogo Federico  
Troso Daniele  
Nogarè Matteo  
Visentin Samuele  
___

# indice  


- [Suddivisione del lavoro](#suddivisione-del-lavoro)
- [COMPONENTE 1 — LOGIN + CORE PROGETTO](#componente-1-login-core-progetto)
- [COMPONENTE 2 — MODULO STUDENTI](#componente-2-modulo-studenti)
- [COMPONENTE 3 — MODULO DOCENTI  GRAFICA](#componente-3-modulo-docenti-grafica)

___




# Suddivisione del lavoro
Il progetto è stato suddiviso in tre parti principali per ottimizzare la produttività del gruppo e permettere uno sviluppo parallelo dei diversi moduli.  
Questa scelta organizzativa ha reso possibile lavorare contemporaneamente su componenti indipendenti ma strettamente integrate tra loro. 
Ogni membro del team ha avuto un ruolo specifico, con responsabilità ben definite, così da garantire una chiara separazione dei compiti e una gestione più efficiente del flusso di lavoro.  
La divisione in moduli (autenticazione, gestione studenti, gestione docenti e grafica) ha inoltre favorito una più semplice integrazione finale.  

  
Il lavoro è stato diviso come segue:
###  Componente 1 — Login + Core progetto  
**Sviluppatore:** Bogo Federico  
- Sistema di login/logout  
- Gestione sessioni e ruoli  
- DAO utenti e ruoli  
- Configurazione database (dbcfg.xml)  
- Dashboard iniziale  
- Protezione pagine e struttura MVC di base  

###  Componente 2 — Modulo Studenti  
**Sviluppatore:** Troso Daniele  
- CRUD studenti (DAO + Servlet + JSP)  
- Validazione dati  
- Tabelle e form con Bootstrap  

###  Componente 3 — Modulo Docenti + Grafica + Funzionalità avanzata  
**Sviluppatori:** Nogarè Matteo, Visentin Samuele  
- CRUD docenti (DAO + Servlet + JSP)  
- Grafica generale del sito (navbar, layout, CSS)  
- Integrazione completa Bootstrap  
- Funzionalità avanzata: gestione aule / assegnazioni  


___
# COMPONENTE 1 — LOGIN + CORE PROGETTO

Questa sezione del progetto si occupa della gestione dell’autenticazione e dell’intera infrastruttura di base su cui si appoggiano gli altri moduli.  
Include la configurazione del database, la gestione delle sessioni, i ruoli utente e la protezione delle pagine tramite MVC + DAO.

### Funzionalità sviluppate

- **LoginServlet**  
  Gestisce l’autenticazione tramite form, validazione dei campi, chiamata al `UserDao`, creazione della sessione e redirect alla dashboard.

- **LogoutServlet**  
  Invalida la sessione esistente e reindirizza l’utente alla pagina di login.

- **UserDao**  
  Implementano l’accesso al database per utenti utilizzando query SQL e connessione configurata tramite file XML.

- **User.java**  
  Modello dati dell’utente con campi: `id`, `username`, `password`, `roleId`.

- **Pagine JSP principali**  
  - `login.jsp` — form di autenticazione con gestione errori  
  - `dashboard.jsp` — pagina iniziale protetta, accessibile solo dopo login  
  - `viewRole.jsp` — pagina di test per visualizzare il ruolo dell’utente  

- **Protezione delle pagine**  
  Controllo sessione integrato nelle JSP e nelle servlet per impedire accessi non autorizzati.

- **Configurazione database**  
  File `dbcfg.xml` in `WEB-INF` per definire driver, URL, credenziali e parametri di connessione.

### Struttura MVC realizzata
- **Model:** `User`, `Role`  
- **DAO:** `UserDao`, `RoleDao`  
- **Controller:** `LoginServlet`, `LogoutServlet`  
- **View:** `login.jsp`, `dashboard.jsp`, `viewRole.jsp`
- **SQL:** `creazione tabella users`

___

# COMPONENTE 2 — MODULO STUDENTI

# COMPONENTE 3 — MODULO DOCENTI + GRAFICA



