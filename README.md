# SCUOLAWEB
### Gruppo: Dal Zotto, Dell'Agostin, Fattor, Follador

Gestionale scolastico sviluppato in **Java** con **Servlet**, **JSP** e **MySQL**, utilizzando architettura **MVC**, pattern **DAO** e tecnologia **JDBC**.

---

# Funzionalità

## Sistema di autenticazione
- Login utenti tramite email e password;
- Gestione sessioni;
- Redirect automatico in base al ruolo.

---

## Dashboard amministratore
Sezione dedicata alla gestione completa del sistema scolastico:

- Creazione classi;
- Creazione studenti;
- Creazione docenti;
- Visualizzazione utenti;
- Gestione dati scolastici.

---

## Dashboard docenti
Area riservata ai docenti:

- Visualizzazione delle classi assegnate;
- Visualizzazione studenti per classe;
- Inserimento voti;
- Gestione valutazioni degli studenti.

---

## Dashboard studenti
Area personale dello studente:

- Visualizzazione voti;
- Consultazione andamento scolastico;
- Visualizzazione media scolastica.

---

# Creazione database

Eseguire il file:

```text
WEB-INF/SQL/creazioneDB.sql
```

all’interno di MySQL.

Verrà creato automaticamente il database:

```text
scuola
```

# Credenziali di test

## Amministratore

### Credenziali

```text
Email: direzione@scuola.it
Password: admin
```

---

## Docente

### Credenziali

```text
Email: m.conti@scuola.it
Password: m.conti
```

---

## Studente (Classe 1A)

### Credenziali

```text
Email: luca.rossi@scuola.it
Password: luca.rossi
```