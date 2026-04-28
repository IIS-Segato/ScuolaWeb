# ScuolaWeb

> Applicazione web per la digitalizzazione e la gestione di studenti, docenti e organizzazione interna scolastica.

---

## 📋 Indice

- [Panoramica](#-panoramica)
- [Funzionalità](#-funzionalità)
- [Ruoli e Permessi](#-ruoli-e-permessi)
- [Struttura del Progetto](#-struttura-del-progetto)
- [Installazione](#-installazione)
- [Utilizzo](#-utilizzo)
- [Contribuire](#-contribuire)
- [Licenza](#-licenza)

---

## 🔍 Panoramica

**SchoolManager** è una piattaforma centralizzata pensata per semplificare la gestione amministrativa e didattica di un istituto scolastico. Permette di coordinare studenti, docenti, aule e orari in un unico sistema, con un sistema di ruoli granulare per garantire la sicurezza e la riservatezza dei dati.

---

## ⚙️ Funzionalità

### 👤 Gestione Utenti
- **Inserimento** di nuovi docenti e studenti nel sistema
- **Visualizzazione** dei profili e dei dati anagrafici
- **Modifica** delle informazioni personali e di ruolo
- **Eliminazione** di profili dal registro

### 📝 Valutazione
- Registrazione e modifica dei **voti degli studenti** da parte dei docenti
- Visualizzazione del registro voti per materia e per classe

### 🗓️ Orario Scolastico
- Creazione e modifica dell'**orario settimanale** per classi e docenti
- Visualizzazione degli orari da parte di tutti gli utenti autorizzati

### 🏛️ Gestione Aule
- Assegnazione delle **aule** in base agli studenti e alle classi presenti
- Visualizzazione della disponibilità e dell'occupazione delle aule

### 📢 Bacheca Annunci
- Pubblicazione di **comunicazioni e avvisi** da parte della segreteria
- Visibilità degli annunci per tutti gli utenti del sistema

---

## 🔐 Ruoli e Permessi

Il sistema implementa un controllo degli accessi basato su ruoli (**RBAC — Role-Based Access Control**). Di seguito la matrice completa dei permessi.

### Tabella Riassuntiva

| Funzionalità | Admin | Segretario | Rappresentante | Docente | Studente |
|---|:---:|:---:|:---:|:---:|:---:|
| Gestione utenti (CRUD) | ✅ | ✅ | ❌ | ❌ | ❌ |
| Voti — tutti gli studenti della classe | ✅ | ✅ | ✅ lettura | ❌ | ❌ |
| Voti — propria materia | ✅ | ✅ | ✅ | ✅ | ❌ |
| Voti — propri | ✅ | ✅ | ✅ | ✅ | ✅ lettura |
| Orario — modifica | ✅ | ✅ | ❌ | ❌ | ❌ |
| Orario — visualizzazione | ✅ | ✅ | ✅ | ✅ | ✅ |
| Aule — modifica | ✅ | ✅ | ❌ | ❌ | ❌ |
| Aule — visualizzazione | ✅ | ✅ | ✅ | ✅ | ✅ |
| Bacheca — pubblica annunci | ✅ | ✅ | ❌ | ❌ | ❌ |
| Bacheca — visualizzazione | ✅ | ✅ | ✅ | ✅ | ✅ |
| Dati personali — visualizzazione | ✅ | ✅ | ✅ | ✅ | ✅ |

---

### 🛡️ Descrizione dei Ruoli

#### 👑 Admin
Dispone di **accesso illimitato** a tutte le funzionalità del sistema: gestione utenti, voti, orari, aule, bacheca e configurazione della piattaforma.

#### 🗂️ Segretario
Ruolo operativo per la gestione amministrativa:
- Pubblica e visualizza annunci sulla bacheca
- Modifica i dati anagrafici di tutti gli utenti
- Gestisce e visualizza orari e aule

#### 🎓 Rappresentante
Ruolo ibrido con responsabilità sia studentesche che didattiche:
- Visualizza i voti di tutti gli studenti della **propria classe**
- Modifica e visualizza i voti relativi alla **propria materia**
- Accede in lettura a bacheca, orari e aule

#### 📚 Docente
Ruolo focalizzato sull'attività didattica:
- Modifica e visualizza i voti della **propria materia**
- Visualizza i propri dati personali
- Accede in lettura a bacheca, orari e aule

#### 🧑‍🎓 Studente
Ruolo con accesso in sola lettura ai propri dati:
- Visualizza esclusivamente i **propri voti**
- Consulta i propri dati anagrafici
- Accede in lettura a bacheca, orari e aule

---

## 🗂️ Struttura del Progetto

```
school-manager/
│
├── backend/
│   ├── controllers/        # Logica delle route (utenti, voti, orari, aule)
│   ├── models/             # Modelli del database
│   ├── middlewares/        # Autenticazione e autorizzazione RBAC
│   ├── routes/             # Definizione delle API REST
│   └── config/             # Configurazioni (DB, JWT, ecc.)
│
├── frontend/
│   ├── components/         # Componenti UI riutilizzabili
│   ├── pages/              # Viste per ogni sezione (dashboard, voti, orari...)
│   ├── services/           # Chiamate API
│   └── store/              # Gestione dello stato (es. autenticazione)
│
├── docs/                   # Documentazione aggiuntiva
├── .env.example            # Variabili d'ambiente di esempio
├── README.md
└── ...
```

---

## 🚀 Installazione

### Prerequisiti
- [Node.js](https://nodejs.org/) v18+
- [npm](https://www.npmjs.com/) o [yarn](https://yarnpkg.com/)
- Database (es. PostgreSQL / MySQL / MongoDB)

### Setup

```bash
# 1. Clona il repository
git clone https://github.com/tuo-utente/school-manager.git
cd school-manager

# 2. Installa le dipendenze del backend
cd backend
npm install

# 3. Configura le variabili d'ambiente
cp .env.example .env
# Modifica il file .env con le tue credenziali

# 4. Esegui le migrazioni del database
npm run migrate

# 5. Avvia il server
npm run dev
```

```bash
# In un secondo terminale, avvia il frontend
cd frontend
npm install
npm run dev
```

---

## 💡 Utilizzo

Una volta avviata l'applicazione, accedi tramite browser all'indirizzo `http://localhost:3000`.

Al primo avvio, effettua il login con le credenziali dell'**Admin** di default (configurabili nel file `.env`) per creare gli utenti e configurare il sistema.

---

## 🤝 Contribuire

I contributi sono benvenuti! Per proporre modifiche:

1. Fai un **fork** del repository
2. Crea un branch per la tua feature: `git checkout -b feature/nome-feature`
3. Effettua le modifiche e committa: `git commit -m "feat: descrizione della modifica"`
4. Fai push del branch: `git push origin feature/nome-feature`
5. Apri una **Pull Request**

Si prega di seguire le convenzioni di commit [Conventional Commits](https://www.conventionalcommits.org/).

---

## 📄 Licenza

Distribuito sotto licenza **MIT**. Consulta il file [`LICENSE`](./LICENSE) per i dettagli.

---

<p align="center">
  Realizzato con ❤️ per semplificare la vita scolastica
</p>
