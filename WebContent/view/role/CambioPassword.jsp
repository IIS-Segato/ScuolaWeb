<%@ page import="model.*" %>
<%@ page language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String nome, cognome, email;
	int id;
	
	Studente studente = (Studente) session.getAttribute("studente");
	Docente docente   = (Docente)  session.getAttribute("docente");
	
	if(studente != null){
	  nome     = studente.getNome();
	  cognome  = studente.getCognome();
	  email    = studente.getEmail();
	  id       = studente.getSid();
	} else {
	  nome     = docente.getNome();
	  cognome  = docente.getCognome();
	  email    = docente.getEmail();
	  id       = docente.getDid();
	}

	/* Calcolo iniziali */
	String sNome = nome != null ? nome : "";
	String sCogn = cognome != null ? cognome : "";
	String sIniz = "";
	if(!sNome.isEmpty()) sIniz += sNome.charAt(0);
	if(!sCogn.isEmpty()) sIniz += sCogn.charAt(0);
	sIniz = sIniz.toUpperCase();

	/* Messaggio di errore o successo dalla servlet */
	String errore  = (String) request.getAttribute("errore");
	String successo = (String) request.getAttribute("successo");
%>

<!DOCTYPE html>
<html lang="it">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cambia password</title>

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
  --bg:           #0b0f14;
  --surface:      #111820;
  --surface2:     #161e28;
  --border:       rgba(255,255,255,0.07);
  --border-hi:    rgba(99,190,140,0.35);
  --accent:       #63be8c;
  --accent-bg:    rgba(99,190,140,0.08);
  --text-1:       #e8f0ec;
  --text-2:       #8a9fa4;
  --text-3:       #4d6168;
  --red:          #f87171;
  --red-bg:       rgba(248,113,113,0.10);
  --red-border:   rgba(248,113,113,0.25);
  --green-bg:     rgba(99,190,140,0.10);
  --green-border: rgba(99,190,140,0.30);
  --mono:         'DM Mono', monospace;
  --sans:         'DM Sans', sans-serif;
  --radius-sm:    8px;
  --radius-md:    12px;
  --radius-lg:    18px;
  --radius-xl:    24px;
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
  max-width: 520px;
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

/* ── HERO MINI ── */

.hero {
  background: var(--surface);
  border: 0.5px solid var(--border);
  border-radius: var(--radius-xl);
  padding: 22px 26px;
  display: flex;
  align-items: center;
  gap: 16px;
  animation: fadeUp .45s ease .05s both;
}

.hero-avatar {
  width: 46px;
  height: 46px;
  border-radius: 50%;
  background: var(--accent-bg);
  border: 0.5px solid var(--border-hi);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 16px;
  font-weight: 500;
  color: var(--accent);
  font-family: var(--mono);
  flex-shrink: 0;
}

.hero-info h2 {
  font-size: 17px;
  font-weight: 500;
  color: var(--text-1);
}

.hero-info p {
  font-size: 12px;
  color: var(--text-3);
  font-family: var(--mono);
  margin-top: 2px;
}

/* ── CARD FORM ── */

.card {
  background: var(--surface);
  border: 0.5px solid var(--border);
  border-radius: var(--radius-xl);
  padding: 28px 30px;
  display: flex;
  flex-direction: column;
  gap: 20px;
  animation: fadeUp .45s ease .10s both;
}

.card-title {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 17px;
  font-weight: 500;
  color: var(--text-1);
}

.card-title svg {
  width: 18px;
  height: 18px;
  stroke: var(--accent);
  fill: none;
  stroke-width: 1.8;
  stroke-linecap: round;
  stroke-linejoin: round;
}

.divider {
  height: 0.5px;
  background: var(--border);
}

/* ── FEEDBACK ── */

.feedback {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 11px 14px;
  border-radius: var(--radius-sm);
  font-size: 13px;
  animation: fadeSlide .3s ease both;
}

.feedback svg {
  width: 15px;
  height: 15px;
  stroke: currentColor;
  fill: none;
  stroke-width: 1.8;
  stroke-linecap: round;
  stroke-linejoin: round;
  flex-shrink: 0;
}

.feedback-error {
  background: var(--red-bg);
  border: 0.5px solid var(--red-border);
  color: var(--red);
}

.feedback-success {
  background: var(--green-bg);
  border: 0.5px solid var(--green-border);
  color: var(--accent);
}

/* ── FORM ── */

.form-fields {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.field {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.field label {
  font-size: 11px;
  font-weight: 500;
  color: var(--text-3);
  letter-spacing: 0.08em;
  text-transform: uppercase;
}

.field input {
  background: var(--surface2);
  border: 0.5px solid var(--border);
  border-radius: var(--radius-sm);
  color: var(--text-1);
  font-family: var(--mono);
  font-size: 14px;
  padding: 11px 14px;
  outline: none;
  transition: border-color .2s ease, box-shadow .2s ease;
  width: 100%;
}

.field input::placeholder {
  color: var(--text-3);
}

.field input:hover {
  border-color: rgba(255,255,255,0.12);
}

.field input:focus {
  border-color: var(--border-hi);
  box-shadow: 0 0 0 3px rgba(99,190,140,0.10);
}

.field input.input-error {
  border-color: var(--red-border);
  box-shadow: 0 0 0 3px var(--red-bg);
}

/* ── BOTTONE ── */

.submit-btn {
  width: 100%;
  background: var(--accent-bg);
  border: 0.5px solid var(--border-hi);
  border-radius: var(--radius-sm);
  color: var(--accent);
  font-family: var(--sans);
  font-size: 13px;
  font-weight: 500;
  padding: 12px;
  cursor: pointer;
  letter-spacing: 0.07em;
  text-transform: uppercase;
  transition: background .2s ease, transform .15s ease, box-shadow .2s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

.submit-btn svg {
  width: 14px;
  height: 14px;
  stroke: currentColor;
  fill: none;
  stroke-width: 2;
  stroke-linecap: round;
  stroke-linejoin: round;
}

.submit-btn:hover {
  background: rgba(99,190,140,0.14);
  border-color: var(--accent);
  box-shadow: 0 4px 18px rgba(99,190,140,0.14);
  transform: translateY(-1px);
}

.submit-btn:active {
  transform: translateY(0);
  box-shadow: none;
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

@keyframes fadeSlide {
  from { opacity: 0; transform: translateY(-5px); }
  to   { opacity: 1; transform: translateY(0); }
}

/* ── RESPONSIVE ── */

@media (max-width: 560px) {
  .page { padding: 20px 16px 48px; }
  .card { padding: 22px 18px; }
  .topbar .brand-name { display: none; }
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

    <a href="/ScuolaWeb/login" class="back-btn">
      <svg viewBox="0 0 24 24">
        <line x1="19" y1="12" x2="5" y2="12"/>
        <polyline points="12 19 5 12 12 5"/>
      </svg>
      Torna al profilo
    </a>

  </div>

  <!-- HERO MINI -->

  <div class="hero">

    <div class="hero-avatar"><%= sIniz %></div>

    <div class="hero-info">
      <h2><%= nome %> <%= cognome %></h2>
      <p><%= email %></p>
    </div>

  </div>

  <!-- CARD FORM -->

  <div class="card">

    <div class="card-title">
      <svg viewBox="0 0 24 24">
        <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
        <path d="M7 11V7a5 5 0 0110 0v4"/>
      </svg>
      Cambia password
    </div>

    <div class="divider"></div>

    <!-- Messaggio di errore dalla servlet -->
    <% if(errore != null){ %>
      <div class="feedback feedback-error">
        <svg viewBox="0 0 24 24">
          <circle cx="12" cy="12" r="10"/>
          <line x1="12" y1="8" x2="12" y2="12"/>
          <line x1="12" y1="16" x2="12.01" y2="16"/>
        </svg>
        <%= errore %>
      </div>
    <% } %>

    <!-- Messaggio di successo dalla servlet -->
    <% if(successo != null){ %>
      <div class="feedback feedback-success">
        <svg viewBox="0 0 24 24">
          <polyline points="20 6 9 17 4 12"/>
        </svg>
        <%= successo %>
      </div>
    <% } %>

    <form action="/ScuolaWeb/CambioPasswordController" method="post">

      <input type="hidden" name="id" value="<%= id %>">
      <input type="hidden" name="tipo" value="<%= studente != null ? "studente" : "docente" %>">

      <div class="form-fields">

        <div class="field">
          <label for="nuovaPassword">Nuova password</label>
          <input
            type="password"
            id="nuovaPassword"
            name="nuovaPassword"
            placeholder="••••••••"
            required
            autocomplete="new-password">
        </div>

        <div class="field">
          <label for="confermaPassword">Conferma password</label>
          <input
            type="password"
            id="confermaPassword"
            name="confermaPassword"
            placeholder="••••••••"
            required
            autocomplete="new-password">
        </div>

      </div>

      <button type="submit" class="submit-btn" style="margin-top: 22px;">
        <svg viewBox="0 0 24 24">
          <polyline points="20 6 9 17 4 12"/>
        </svg>
        Salva nuova password
      </button>

    </form>

  </div>

</div>

<script>
  /* Evidenzia il campo conferma se le password non coincidono */
  const nuova    = document.getElementById('nuovaPassword');
  const conferma = document.getElementById('confermaPassword');

  function checkMatch(){
    if(conferma.value.length === 0) return;
    if(conferma.value !== nuova.value){
      conferma.classList.add('input-error');
    } else {
      conferma.classList.remove('input-error');
    }
  }

  nuova.addEventListener('input', checkMatch);
  conferma.addEventListener('input', checkMatch);

  /* Blocca il submit se le password non coincidono */
  conferma.closest('form').addEventListener('submit', function(e){
    if(nuova.value !== conferma.value){
      e.preventDefault();
      conferma.classList.add('input-error');
      conferma.focus();
    }
  });
</script>

</body>

</html>
