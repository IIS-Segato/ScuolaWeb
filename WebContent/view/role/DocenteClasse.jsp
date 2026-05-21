<%@page import="java.util.ArrayList"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="model.*" %>
<%@ page language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// prendo gli studenti della classe dalla richiesta
	ArrayList<Studente> studenti =
		(ArrayList<Studente>) request.getAttribute("studenti");

	// prendo la materia della richiesta
	String materia = (String) request.getAttribute("materia");

	// prendo il docente in sessione
	Docente docente = (Docente) session.getAttribute("docente");

	// prendo la classe dalla richiesta
	Classe classe = (Classe) request.getAttribute("classe");

	// iniziali per profilo docente
	String nomeDocente    = docente.getNome();
	String cognomeDocente = docente.getCognome();
	String iniziali = "";
	if(nomeDocente != null && !nomeDocente.isEmpty())
		iniziali += nomeDocente.charAt(0);
	if(cognomeDocente != null && !cognomeDocente.isEmpty())
		iniziali += cognomeDocente.charAt(0);
	iniziali = iniziali.toUpperCase();

	// numero studenti classe
	int numStudenti = (studenti != null) ? studenti.size() : 0;
	
	// prendo l'anno scolastico attuale (se dopo settembre anno corrente e successivo, sennò anno corrente e precedente)
	LocalDate oggi = LocalDate.now();

    int annoCorrente = oggi.getYear();
    int mese = oggi.getMonthValue();

    int primoAnno;
    int secondoAnno;

    
    if (mese >= 9) {
        primoAnno = annoCorrente;
        secondoAnno = annoCorrente + 1;
    } else {
        primoAnno = annoCorrente - 1;
        secondoAnno = annoCorrente;
    }
%>

<!DOCTYPE html>
<html lang="it">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Classe <%= classe.getAnno() + classe.getSezione() %></title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,opsz,wght@0,9..40,300;0,9..40,400;0,9..40,500;1,9..40,300&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet">

<style>

/* ── RESET & BASE ── */

*, *::before, *::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

:root {
  --bg:          #0b0f14;
  --surface:     #111820;
  --surface2:    #161e28;
  --border:      rgba(255,255,255,0.07);
  --border-hi:   rgba(99,190,140,0.35);
  --accent:      #63be8c;
  --accent-dim:  #2d6a4f;
  --accent-bg:   rgba(99,190,140,0.08);
  --text-1:      #e8f0ec;
  --text-2:      #8a9fa4;
  --text-3:      #4d6168;
  --blue:        #5b9cf6;
  --blue-bg:     rgba(91,156,246,0.10);
  --blue-border: rgba(91,156,246,0.25);
  --red:         #f87171;
  --red-bg:      rgba(248,113,113,0.10);
  --red-border:  rgba(248,113,113,0.25);
  --mono:        'DM Mono', monospace;
  --sans:        'DM Sans', sans-serif;
  --radius-sm:   8px;
  --radius-md:   12px;
  --radius-lg:   18px;
  --radius-xl:   24px;
}

html, body {
  min-height: 100vh;
  background: var(--bg);
  color: var(--text-1);
  font-family: var(--sans);
  font-size: 15px;
  line-height: 1.6;
  -webkit-font-smoothing: antialiased;
}

/* ── LAYOUT ── */

.page {
  max-width: 1200px;
  margin: 0 auto;
  padding: 36px 28px 64px;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

/* ── TOPBAR ── */

.topbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  animation: fadeDown .45s ease both;
}

.brand {
  display: flex;
  align-items: center;
  gap: 10px;
}

.brand-icon {
  width: 34px;
  height: 34px;
  border-radius: var(--radius-sm);
  background: var(--accent-bg);
  border: 0.5px solid var(--border-hi);
  display: flex;
  align-items: center;
  justify-content: center;
}

.brand-icon svg {
  width: 17px;
  height: 17px;
  stroke: var(--accent);
  fill: none;
  stroke-width: 1.8;
  stroke-linecap: round;
  stroke-linejoin: round;
}

.brand-name {
  font-size: 13px;
  font-weight: 500;
  color: var(--text-2);
  letter-spacing: 0.04em;
  text-transform: uppercase;
}

.back-btn {
  display: flex;
  align-items: center;
  gap: 7px;
  background: var(--surface);
  border: 0.5px solid var(--border);
  color: var(--text-2);
  padding: 9px 16px;
  border-radius: var(--radius-sm);
  cursor: pointer;
  font-family: var(--sans);
  font-size: 13px;
  text-decoration: none;
  transition: all .2s ease;
}

.back-btn:hover {
  border-color: rgba(255,255,255,0.15);
  color: var(--text-1);
  background: var(--surface2);
}

.back-btn svg {
  width: 14px;
  height: 14px;
  stroke: currentColor;
  fill: none;
  stroke-width: 2.2;
  stroke-linecap: round;
  stroke-linejoin: round;
}

/* ── HERO ROW ── */

.hero-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
  animation: fadeUp .45s ease .05s both;
}

/* CARD CLASSE */

.class-hero {
  background: var(--surface);
  border: 0.5px solid var(--border);
  border-radius: var(--radius-xl);
  padding: 28px 30px;
  display: flex;
  flex-direction: column;
  gap: 14px;
  position: relative;
  overflow: hidden;
}

.class-hero::before {
  content: '';
  position: absolute;
  bottom: -50px;
  right: -50px;
  width: 180px;
  height: 180px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(99,190,140,0.06) 0%, transparent 70%);
  pointer-events: none;
}

.class-hero-top {
  display: flex;
  align-items: center;
  gap: 16px;
}

.class-number {
  font-size: 52px;
  font-weight: 300;
  color: var(--text-1);
  letter-spacing: -0.03em;
  line-height: 1;
}

.class-details {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.class-label {
  font-size: 11px;
  color: var(--text-3);
  text-transform: uppercase;
  letter-spacing: 0.08em;
}

.class-materia {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  background: var(--accent-bg);
  border: 0.5px solid var(--border-hi);
  color: var(--accent);
  padding: 5px 12px;
  border-radius: 999px;
  font-size: 13px;
  font-weight: 500;
}

.class-materia svg {
  width: 13px;
  height: 13px;
  stroke: var(--accent);
  fill: none;
  stroke-width: 2;
  stroke-linecap: round;
  stroke-linejoin: round;
}

.class-meta-row {
  display: flex;
  gap: 16px;
  border-top: 0.5px solid var(--border);
  padding-top: 14px;
}

.class-meta-item {
  display: flex;
  flex-direction: column;
  gap: 3px;
}

.class-meta-item .lbl {
  font-size: 11px;
  color: var(--text-3);
  text-transform: uppercase;
  letter-spacing: 0.06em;
}

.class-meta-item .val {
  font-family: var(--mono);
  font-size: 13px;
  color: var(--text-2);
}

/* CARD DOCENTE */

.docente-hero {
  background: var(--surface);
  border: 0.5px solid var(--border);
  border-radius: var(--radius-xl);
  padding: 28px 30px;
  display: flex;
  flex-direction: column;
  gap: 16px;
  position: relative;
  overflow: hidden;
}

.docente-hero::before {
  content: '';
  position: absolute;
  top: -40px;
  left: -40px;
  width: 160px;
  height: 160px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(91,156,246,0.05) 0%, transparent 70%);
  pointer-events: none;
}

.docente-top {
  display: flex;
  align-items: center;
  gap: 14px;
}

.docente-avatar {
  width: 52px;
  height: 52px;
  border-radius: 50%;
  background: var(--blue-bg);
  border: 0.5px solid var(--blue-border);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 18px;
  font-weight: 500;
  color: var(--blue);
  font-family: var(--mono);
  flex-shrink: 0;
}

.docente-info h3 {
  font-size: 18px;
  font-weight: 500;
  color: var(--text-1);
}

.docente-info p {
  font-size: 13px;
  color: var(--text-3);
  font-family: var(--mono);
  margin-top: 3px;
}

.docente-badge-row {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.tag {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  padding: 5px 11px;
  border-radius: 999px;
  font-size: 12px;
}

.tag-blue {
  background: var(--blue-bg);
  border: 0.5px solid var(--blue-border);
  color: var(--blue);
}

.tag-green {
  background: var(--accent-bg);
  border: 0.5px solid var(--border-hi);
  color: var(--accent);
}

.tag svg {
  width: 11px;
  height: 11px;
  stroke: currentColor;
  fill: none;
  stroke-width: 2;
  stroke-linecap: round;
  stroke-linejoin: round;
}

.status-dot::before {
  content: '';
  display: inline-block;
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: var(--accent);
  margin-right: 6px;
  animation: pulse 2s ease infinite;
}

/* ── STATS ── */

.stats-row {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 14px;
  animation: fadeUp .45s ease .12s both;
}

.stat {
  background: var(--surface);
  border: 0.5px solid var(--border);
  border-radius: var(--radius-lg);
  padding: 18px 20px;
  display: flex;
  flex-direction: column;
  gap: 6px;
  transition: border-color .2s;
}

.stat:hover { border-color: rgba(255,255,255,0.12); }

.stat-label {
  font-size: 11px;
  color: var(--text-3);
  text-transform: uppercase;
  letter-spacing: 0.07em;
  display: flex;
  align-items: center;
  gap: 5px;
}

.stat-label svg {
  width: 12px;
  height: 12px;
  stroke: var(--text-3);
  fill: none;
  stroke-width: 2;
  stroke-linecap: round;
  stroke-linejoin: round;
}

.stat-value {
  font-size: 26px;
  font-weight: 300;
  color: var(--text-1);
  line-height: 1;
}

.stat-value.mono {
  font-family: var(--mono);
  font-size: 16px;
  font-weight: 400;
  padding-top: 3px;
}

/* ── SECTION TABELLA ── */

.section {
  background: var(--surface);
  border: 0.5px solid var(--border);
  border-radius: var(--radius-xl);
  padding: 28px 30px;
  animation: fadeUp .45s ease .18s both;
}

.section-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
}

.section-title {
  font-size: 17px;
  font-weight: 500;
  color: var(--text-1);
}

.section-count {
  font-family: var(--mono);
  font-size: 12px;
  color: var(--text-3);
}

/* ── TABELLA ── */

.table-wrap {
  overflow-x: auto;
  border-radius: var(--radius-lg);
  border: 0.5px solid var(--border);
}

table {
  width: 100%;
  border-collapse: collapse;
}

thead tr {
  background: var(--surface2);
}

thead th {
  padding: 13px 16px;
  text-align: left;
  font-size: 11px;
  color: var(--text-3);
  text-transform: uppercase;
  letter-spacing: 0.08em;
  font-weight: 400;
  white-space: nowrap;
}

tbody tr {
  border-top: 0.5px solid var(--border);
  transition: background .15s;
  animation: fadeUp .35s ease both;
}

tbody tr:hover {
  background: var(--surface2);
}

td {
  padding: 15px 16px;
  vertical-align: middle;
}

/* Studente */

.student-wrap {
  display: flex;
  align-items: center;
  gap: 12px;
}

.student-avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: var(--surface2);
  border: 0.5px solid var(--border);
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: var(--mono);
  font-size: 12px;
  color: var(--text-2);
  flex-shrink: 0;
}

.student-name {
  font-size: 14px;
  font-weight: 500;
  color: var(--text-1);
}

.student-id {
  font-family: var(--mono);
  font-size: 11px;
  color: var(--text-3);
  margin-top: 2px;
}

.student-email {
  font-size: 13px;
  color: var(--text-3);
  font-family: var(--mono);
}

/* INPUT VOTO */

.vote-form {
  display: flex;
  align-items: center;
  gap: 10px;
}

.vote-input {
  width: 80px;
  background: var(--surface2);
  border: 0.5px solid var(--border);
  border-radius: var(--radius-sm);
  color: var(--text-1);
  padding: 9px 12px;
  font-family: var(--mono);
  font-size: 14px;
  outline: none;
  transition: all .2s ease;
  -moz-appearance: textfield;
}

.vote-input::-webkit-inner-spin-button,
.vote-input::-webkit-outer-spin-button {
  -webkit-appearance: none;
}

.vote-input::placeholder { color: var(--text-3); }

.vote-input:focus {
  border-color: var(--border-hi);
  background: #161e28;
  box-shadow: 0 0 0 3px rgba(99,190,140,0.10);
}

/* BOTTONE */

.submit-btn {
  display: flex;
  align-items: center;
  gap: 6px;
  background: var(--accent-bg);
  border: 0.5px solid var(--border-hi);
  color: var(--accent);
  padding: 9px 14px;
  border-radius: var(--radius-sm);
  cursor: pointer;
  font-family: var(--sans);
  font-size: 12px;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.06em;
  transition: all .2s ease;
  white-space: nowrap;
}

.submit-btn:hover {
  background: rgba(99,190,140,0.15);
  border-color: var(--accent);
  transform: translateY(-1px);
  box-shadow: 0 4px 14px rgba(99,190,140,0.15);
}

.submit-btn svg {
  width: 13px;
  height: 13px;
  stroke: currentColor;
  fill: none;
  stroke-width: 2.2;
  stroke-linecap: round;
  stroke-linejoin: round;
}

/* BOTTONE STORICO */

.history-btn {
  display: flex;
  align-items: center;
  gap: 6px;
  background: var(--blue-bg);
  border: 0.5px solid var(--blue-border);
  color: var(--blue);
  padding: 9px 14px;
  border-radius: var(--radius-sm);
  cursor: pointer;
  font-family: var(--sans);
  font-size: 12px;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.06em;
  transition: all .2s ease;
  white-space: nowrap;
  text-decoration: none;
}

.history-btn:hover {
  background: rgba(91,156,246,0.16);
  border-color: var(--blue);
  transform: translateY(-1px);
  box-shadow: 0 4px 14px rgba(91,156,246,0.15);
}

.history-btn svg {
  width: 13px; height: 13px;
  stroke: currentColor; fill: none;
  stroke-width: 2.2;
  stroke-linecap: round; stroke-linejoin: round;
}

.actions-cell {
  display: flex;
  align-items: center;
  gap: 8px;
}

/* EMPTY */

.empty-box {
  padding: 40px;
  border: 0.5px dashed var(--border);
  border-radius: var(--radius-lg);
  text-align: center;
  color: var(--text-3);
  font-size: 14px;
}

/* ── ANIMAZIONI ── */

@keyframes fadeUp {
  from { opacity: 0; transform: translateY(12px); }
  to   { opacity: 1; transform: translateY(0); }
}

@keyframes fadeDown {
  from { opacity: 0; transform: translateY(-10px); }
  to   { opacity: 1; transform: translateY(0); }
}

@keyframes pulse {
  0%, 100% { opacity: 1; transform: scale(1); }
  50%       { opacity: .4; transform: scale(1.6); }
}

/* ── RESPONSIVE ── */

@media (max-width: 900px) {
  .hero-row { grid-template-columns: 1fr; }
}

@media (max-width: 700px) {
  .page { padding: 20px 16px 48px; }
  .stats-row { grid-template-columns: 1fr 1fr; }
  .section { padding: 20px 16px; }
  .topbar .brand-name { display: none; }
}

@media (max-width: 480px) {
  .stats-row { grid-template-columns: 1fr; }
}

</style>

</head>

<body>

<div class="page">

  <!-- TOPBAR -->

  <div class="topbar">

    <div class="brand">
      <div class="brand-icon">
        <svg viewBox="0 0 24 24">
          <path d="M3 9l9-7 9 7v11a2 2 0 01-2 2H5a2 2 0 01-2-2z"/>
          <polyline points="9 22 9 12 15 12 15 22"/>
        </svg>
      </div>
      <span class="brand-name">Registro elettronico</span>
    </div>

    <a href="login" class="back-btn">
      <svg viewBox="0 0 24 24">
        <line x1="19" y1="12" x2="5" y2="12"/>
        <polyline points="12 19 5 12 12 5"/>
      </svg>
      Torna alle classi
    </a>

  </div>

  <!-- HERO ROW: CLASSE + DOCENTE -->

  <div class="hero-row">

    <!-- CARD CLASSE -->

    <div class="class-hero">

      <div class="class-hero-top">

        <div class="class-number">
          <%= classe.getAnno() + classe.getSezione() %>
        </div>

        <div class="class-details">
          <span class="class-label">Materia</span>
          <div class="class-materia">
            <svg viewBox="0 0 24 24">
              <path d="M2 3h6a4 4 0 014 4v14a3 3 0 00-3-3H2z"/>
              <path d="M22 3h-6a4 4 0 00-4 4v14a3 3 0 013-3h7z"/>
            </svg>
            <%= materia %>
          </div>
        </div>

      </div>

      <div class="class-meta-row">

        <div class="class-meta-item">
          <span class="lbl">Anno</span>
          <span class="val"><%= classe.getAnno() %>°</span>
        </div>

        <div class="class-meta-item">
          <span class="lbl">Sezione</span>
          <span class="val"><%= classe.getSezione() %></span>
        </div>

        <div class="class-meta-item">
          <span class="lbl">ID Classe</span>
          <span class="val"><%= classe.getCid() %></span>
        </div>

        <div class="class-meta-item">
          <span class="lbl">A.S.</span>
          <span class="val"><%= primoAnno + "/" + secondoAnno %></span>
        </div>

      </div>

    </div>

    <!-- CARD DOCENTE -->

    <div class="docente-hero">

      <div class="docente-top">

        <div class="docente-avatar"><%= iniziali %></div>

        <div class="docente-info">
          <h3><%= docente.getNome() %> <%= docente.getCognome() %></h3>
          <p>ID <%= docente.getDid() %></p>
        </div>

      </div>

      <div class="docente-badge-row">

        <span class="tag tag-blue">
          <svg viewBox="0 0 24 24">
            <path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"/>
            <circle cx="12" cy="7" r="4"/>
          </svg>
          Docente
        </span>

        <span class="tag tag-green">
          <svg viewBox="0 0 24 24">
            <path d="M2 3h6a4 4 0 014 4v14a3 3 0 00-3-3H2z"/>
            <path d="M22 3h-6a4 4 0 00-4 4v14a3 3 0 013-3h7z"/>
          </svg>
          <%= materia %>
        </span>

        <span class="tag tag-green status-dot">Sessione attiva</span>

      </div>

    </div>

  </div>

  <!-- STATISTICHE -->

  <div class="stats-row">

    <div class="stat">
      <div class="stat-label">
        <svg viewBox="0 0 24 24">
          <path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/>
          <circle cx="9" cy="7" r="4"/>
          <path d="M23 21v-2a4 4 0 00-3-3.87"/>
          <path d="M16 3.13a4 4 0 010 7.75"/>
        </svg>
        Studenti
      </div>
      <div class="stat-value"><%= numStudenti %></div>
    </div>

    <div class="stat">
      <div class="stat-label">
        <svg viewBox="0 0 24 24">
          <path d="M2 3h6a4 4 0 014 4v14a3 3 0 00-3-3H2z"/>
          <path d="M22 3h-6a4 4 0 00-4 4v14a3 3 0 013-3h7z"/>
        </svg>
        Materia
      </div>
      <div class="stat-value mono"><%= materia %></div>
    </div>

    <div class="stat">
      <div class="stat-label">
        <svg viewBox="0 0 24 24">
          <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
          <line x1="16" y1="2" x2="16" y2="6"/>
          <line x1="8" y1="2" x2="8" y2="6"/>
          <line x1="3" y1="10" x2="21" y2="10"/>
        </svg>
        Anno scolastico
      </div>
      <div class="stat-value mono"><%= primoAnno + "/" + secondoAnno %></div>
    </div>

  </div>

  <!-- TABELLA STUDENTI -->

  <div class="section">

    <div class="section-header">
      <div class="section-title">Studenti — inserimento voti</div>
      <span class="section-count"><%= numStudenti %> student<%= numStudenti != 1 ? "i" : "e" %></span>
    </div>

    <%
      if(studenti == null || studenti.isEmpty()){
    %>

      <div class="empty-box">
        Nessuno studente trovato per questa classe.
      </div>

    <% } else { %>

      <div class="table-wrap">

        <table>

          <thead>
            <tr>
              <th>Studente</th>
              <th>Email</th>
              <th>Voto</th>
              <th>Azione</th>
            </tr>
          </thead>

          <tbody>

          <% for(int i = 0; i < studenti.size(); i++){
               Studente s = studenti.get(i);
               String sNome = s.getNome() != null ? s.getNome() : "";
               String sCogn = s.getCognome() != null ? s.getCognome() : "";
               String sIniz = "";
               if(!sNome.isEmpty()) sIniz += sNome.charAt(0);
               if(!sCogn.isEmpty()) sIniz += sCogn.charAt(0);
               sIniz = sIniz.toUpperCase();
               // calcolo se lo studente è maggiorenne
               LocalDate nascita = LocalDate.parse(s.getNascita()); // formato atteso: yyyy-MM-dd
               boolean maggiorenne = !nascita.isAfter(LocalDate.now().minusYears(18));
          %>

            <tr style="animation-delay: <%= (i * 0.05) %>s">

              <!-- Nome studente -->
              <td>
                <div class="student-wrap">
                  <div class="student-avatar"><%= sIniz %></div>
                  <div>
                    <div class="student-name">
                      <%= s.getNome() %> <%= s.getCognome() %>
                    </div>
                    <div class="student-id">
                    	ID <%= s.getSid() %>
                    	<% if(maggiorenne){ %>
  							<span class="tag tag-blue" style="font-size:10px;padding:2px 7px;margin-top:5px;display:inline-flex">18+</span>
						<% } %>
					</div>
                  </div>
                </div>
              </td>

              <!-- Email -->
              <td class="student-email"><%= s.getEmail() %></td>

              <!-- Input voto + bottone nella stessa form che inizia qui... -->
              <td>
                <form action="InsertVotoController" method="post" class="vote-form">

                  <input type="hidden" name="sid" value="<%= s.getSid() %>">
                  <input type="hidden" name="cid" value="<%= classe.getCid() %>">
                  <input type="hidden" name="did" value="<%= docente.getDid() %>">
                  <input type="hidden" name="materia" value="<%= materia %>">
                  <input type="hidden" name="data" value="<%= oggi.toString() %>">

                  <select
					  name="voto"
					  required
					  class="vote-input">
					
					  <option value="">
					    —
					  </option>
					
					  <option value="1">1</option>
					  <option value="1.15">1+</option>
					  <option value="1.5">1½</option>
					
					  <option value="1.85">2-</option>
					  <option value="2">2</option>
					  <option value="2.15">2+</option>
					  <option value="2.5">2½</option>
					
					  <option value="2.85">3-</option>
					  <option value="3">3</option>
					  <option value="3.15">3+</option>
					  <option value="3.5">3½</option>
					
					  <option value="3.85">4-</option>
					  <option value="4">4</option>
					  <option value="4.15">4+</option>
					  <option value="4.5">4½</option>
					
					  <option value="4.85">5-</option>
					  <option value="5">5</option>
					  <option value="5.15">5+</option>
					  <option value="5.5">5½</option>
					
					  <option value="5.85">6-</option>
					  <option value="6">6</option>
					  <option value="6.15">6+</option>
					  <option value="6.5">6½</option>
					
					  <option value="6.85">7-</option>
					  <option value="7">7</option>
					  <option value="7.15">7+</option>
					  <option value="7.5">7½</option>
					
					  <option value="7.85">8-</option>
					  <option value="8">8</option>
					  <option value="8.15">8+</option>
					  <option value="8.5">8½</option>
					
					  <option value="8.85">9-</option>
					  <option value="9">9</option>
					  <option value="9.15">9+</option>
					  <option value="9.5">9½</option>
					
					  <option value="9.85">10-</option>
					  <option value="10">10</option>
					
					</select>

              </td>

              <!-- ...e il bottone submit nella cella successiva -->
				<td>
				  <div class="actions-cell">
				
				    <button type="submit" class="submit-btn">
				      <svg viewBox="0 0 24 24">
				        <polyline points="20 6 9 17 4 12"/>
				      </svg>
				      Salva
				    </button>
				
				  </form>
				
				    <a href="VotiStudente?sid=<%= s.getSid() %>&materia=<%= URLEncoder.encode(materia, "UTF-8") %>"
				       class="history-btn">
				      <svg viewBox="0 0 24 24">
				        <circle cx="12" cy="12" r="10"/>
				        <polyline points="12 6 12 12 16 14"/>
				      </svg>
				      Storico
				    </a>
				
				  </div>
				</td>
            </tr>

          <% } %>

          </tbody>

        </table>

      </div>

    <% } %>

  </div>

</div>

</body>

</html>
