<%@ page import="java.util.ArrayList"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="model.*" %>
<%@ page language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// prendo il docente in sessione
	Docente docente =
		(Docente) session.getAttribute("docente");

	// prendo la lista delle classi del docente
	ArrayList<Classe> classi =
		docente.getClassi();

	// Iniziali maiuscole per il profilo
	String nomeDocente  = docente.getNome();
	String cognomeDocente = docente.getCognome();
	String iniziali = "";
	if(nomeDocente != null && !nomeDocente.isEmpty())
		iniziali += nomeDocente.charAt(0);
	if(cognomeDocente != null && !cognomeDocente.isEmpty())
		iniziali += cognomeDocente.charAt(0);
	iniziali = iniziali.toUpperCase();

	// numero classi del docente
	int numClassi = (classi != null) ? classi.size() : 0;
	
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
<title>Dashboard Docente</title>

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
  --bg:        #0b0f14;
  --surface:   #111820;
  --surface2:  #161e28;
  --border:    rgba(255,255,255,0.07);
  --border-hi: rgba(99,190,140,0.35);
  --accent:    #63be8c;
  --accent-dim:#2d6a4f;
  --accent-bg: rgba(99,190,140,0.08);
  --text-1:    #e8f0ec;
  --text-2:    #8a9fa4;
  --text-3:    #4d6168;
  --blue:      #5b9cf6;
  --blue-bg:   rgba(91,156,246,0.10);
  --blue-border:rgba(91,156,246,0.25);
  --mono:      'DM Mono', monospace;
  --sans:      'DM Sans', sans-serif;
  --radius-sm: 8px;
  --radius-md: 12px;
  --radius-lg: 18px;
  --radius-xl: 24px;
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
  gap: 24px;
}

/* ── TOPBAR ── */

.topbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  animation: fadeDown .5s ease both;
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

.logout-btn {
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
  transition: all .2s ease;
}

.logout-btn:hover {
  border-color: rgba(255,255,255,0.15);
  color: var(--text-1);
  background: var(--surface2);
}

.logout-btn svg {
  width: 14px;
  height: 14px;
  stroke: currentColor;
  fill: none;
  stroke-width: 2;
  stroke-linecap: round;
  stroke-linejoin: round;
}

/* ── HERO DOCENTE ── */

.hero {
  background: var(--surface);
  border: 0.5px solid var(--border);
  border-radius: var(--radius-xl);
  padding: 28px 32px;
  display: flex;
  align-items: center;
  gap: 22px;
  position: relative;
  overflow: hidden;
  animation: fadeUp .5s ease .05s both;
}

.hero::before {
  content: '';
  position: absolute;
  top: -60px;
  right: -60px;
  width: 220px;
  height: 220px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(99,190,140,0.07) 0%, transparent 70%);
  pointer-events: none;
}

.hero-avatar {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  background: var(--accent-bg);
  border: 0.5px solid var(--border-hi);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  font-weight: 500;
  color: var(--accent);
  font-family: var(--mono);
  flex-shrink: 0;
  letter-spacing: 0.02em;
}

.hero-info {
  flex: 1;
}

.hero-info h2 {
  font-size: 22px;
  font-weight: 500;
  color: var(--text-1);
  line-height: 1.2;
}

.hero-meta {
  display: flex;
  align-items: center;
  gap: 14px;
  margin-top: 6px;
}

.hero-id {
  font-family: var(--mono);
  font-size: 12px;
  color: var(--text-3);
}

.hero-id span {
  color: var(--text-2);
}

.status-dot {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 12px;
  color: var(--accent);
}

.status-dot::before {
  content: '';
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: var(--accent);
  animation: pulse 2s ease infinite;
}

/* ── STATS ── */

.stats-row {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 14px;
  animation: fadeUp .5s ease .12s both;
}

.stat {
  background: var(--surface);
  border: 0.5px solid var(--border);
  border-radius: var(--radius-lg);
  padding: 20px 22px;
  display: flex;
  flex-direction: column;
  gap: 6px;
  transition: border-color .2s;
}

.stat:hover {
  border-color: rgba(255,255,255,0.12);
}

.stat-label {
  font-size: 12px;
  color: var(--text-3);
  text-transform: uppercase;
  letter-spacing: 0.07em;
  display: flex;
  align-items: center;
  gap: 6px;
}

.stat-label svg {
  width: 13px;
  height: 13px;
  stroke: var(--text-3);
  fill: none;
  stroke-width: 2;
  stroke-linecap: round;
  stroke-linejoin: round;
}

.stat-value {
  font-size: 28px;
  font-weight: 300;
  color: var(--text-1);
  line-height: 1;
}

.stat-value.mono {
  font-family: var(--mono);
  font-size: 18px;
  font-weight: 400;
}

/* ── SEZIONE CLASSI ── */

.section {
  background: var(--surface);
  border: 0.5px solid var(--border);
  border-radius: var(--radius-xl);
  padding: 28px 32px;
  animation: fadeUp .5s ease .18s both;
}

.section-header {
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  margin-bottom: 22px;
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

/* ── GRID CLASSI ── */

.class-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 14px;
}

.class-card {
  background: var(--surface2);
  border: 0.5px solid var(--border);
  border-radius: var(--radius-lg);
  padding: 22px 20px 18px;
  text-decoration: none;
  display: flex;
  flex-direction: column;
  gap: 14px;
  transition: all .22s ease;
  animation: fadeUp .45s ease both;
  position: relative;
  overflow: hidden;
}

.class-card:hover {
  border-color: var(--border-hi);
  transform: translateY(-3px);
  background: #18222e;
}

.class-card:hover .class-arrow {
  color: var(--accent);
  gap: 8px;
}

.class-card-top {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
}

.class-nome {
  font-size: 32px;
  font-weight: 300;
  color: var(--text-1);
  line-height: 1;
  letter-spacing: -0.02em;
}

.class-tag {
  font-family: var(--mono);
  font-size: 10px;
  color: var(--accent);
  background: var(--accent-bg);
  border: 0.5px solid var(--border-hi);
  padding: 3px 8px;
  border-radius: 999px;
  letter-spacing: 0.06em;
  text-transform: uppercase;
}

.class-sub {
  font-size: 12px;
  color: var(--text-3);
}

.class-arrow {
  display: flex;
  align-items: center;
  gap: 5px;
  font-size: 12px;
  color: var(--text-3);
  transition: all .2s ease;
}

.class-arrow svg {
  width: 12px;
  height: 12px;
  stroke: currentColor;
  fill: none;
  stroke-width: 2.2;
  stroke-linecap: round;
  stroke-linejoin: round;
  transition: transform .2s ease;
}

.class-card:hover .class-arrow svg {
  transform: translateX(3px);
}

/* ── EMPTY ── */

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
  from { opacity: 0; transform: translateY(14px); }
  to   { opacity: 1; transform: translateY(0); }
}

@keyframes fadeDown {
  from { opacity: 0; transform: translateY(-10px); }
  to   { opacity: 1; transform: translateY(0); }
}

@keyframes pulse {
  0%, 100% { opacity: 1; transform: scale(1); }
  50%       { opacity: .4; transform: scale(1.5); }
}

/* ── DIVISORE ── */

.divider {
  height: 0.5px;
  background: var(--border);
  margin: 2px 0;
}

/* ── RESPONSIVE ── */

@media (max-width: 700px) {
  .page { padding: 20px 16px 48px; }
  .hero { padding: 20px; gap: 16px; }
  .hero-info h2 { font-size: 18px; }
  .stats-row { grid-template-columns: 1fr 1fr; }
  .stats-row .stat:last-child { grid-column: span 2; }
  .section { padding: 20px 18px; }
  .class-grid { grid-template-columns: 1fr 1fr; }
  .topbar .brand-name { display: none; }
}

@media (max-width: 480px) {
  .class-grid { grid-template-columns: 1fr; }
  .stats-row { grid-template-columns: 1fr; }
  .stats-row .stat:last-child { grid-column: span 1; }
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

    <button class="logout-btn" onclick="location.href='logout'">
      <svg viewBox="0 0 24 24">
        <path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4"/>
        <polyline points="16 17 21 12 16 7"/>
        <line x1="21" y1="12" x2="9" y2="12"/>
      </svg>
      Esci
    </button>

  </div>

  <!-- HERO DOCENTE -->

  <div class="hero">

    <div class="hero-avatar">
      <%= iniziali %>
    </div>

    <div class="hero-info">

      <h2>
        <%= docente.getNome() %>
        <%= docente.getCognome() %>
      </h2>

      <div class="hero-meta">

        <span class="hero-id">
          ID&nbsp;<span><%= docente.getDid() %></span>
        </span>

        <span class="status-dot">Attivo</span>

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
        Classi assegnate
      </div>
      <div class="stat-value"><%= numClassi %></div>
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

    <div class="stat">
      <div class="stat-label">
        <svg viewBox="0 0 24 24">
          <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/>
        </svg>
        Ruolo
      </div>
      <div class="stat-value mono" style="font-size:16px;padding-top:4px">Docente</div>
    </div>

  </div>

  <!-- CLASSI -->

  <div class="section">

    <div class="section-header">

      <div class="section-title">Le tue classi</div>

      <span class="section-count">
        <%= numClassi %> class<%= numClassi != 1 ? "i" : "e" %>
      </span>

    </div>

    <%
      if(classi == null || classi.isEmpty()){
    %>

      <div class="empty-box">
        Nessuna classe assegnata al momento.
      </div>

    <% } else { %>

      <div class="class-grid">

        <% for(int i = 0; i < classi.size(); i++){
             Classe c = classi.get(i);
        %>

          <a
            href="ClasseDocente?cid=<%= c.getCid() %>&did=<%= docente.getDid() %>"
            class="class-card"
            style="animation-delay: <%= (i * 0.07) %>s">

            <div class="class-card-top">

              <div class="class-nome">
                <%= c.getAnno() + c.getSezione() %>
              </div>

              <div class="class-tag">Classe</div>

            </div>

            <div class="class-sub">
              Studenti e voti
            </div>

            <div class="class-arrow">
              Apri
              <svg viewBox="0 0 24 24">
                <line x1="5" y1="12" x2="19" y2="12"/>
                <polyline points="12 5 19 12 12 19"/>
              </svg>
            </div>

          </a>

        <% } %>

      </div>

    <% } %>

  </div>

</div>

</body>

</html>
