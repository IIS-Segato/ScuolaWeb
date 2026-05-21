<%@page import="java.util.ArrayList"%>
<%@ page import="model.*" %>
<%@ page language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	ArrayList<Voto> voti =
		(ArrayList<Voto>) request.getAttribute("voti");

	Studente studente =
		(Studente) request.getAttribute("studente");

	String materia =
		(String) request.getAttribute("materia");

	Docente docente =
		(Docente) session.getAttribute("docente");

	/* Calcolo iniziali studente */
	String sNome = studente.getNome() != null ? studente.getNome() : "";
	String sCogn = studente.getCognome() != null ? studente.getCognome() : "";
	String sIniz = "";
	if(!sNome.isEmpty()) sIniz += sNome.charAt(0);
	if(!sCogn.isEmpty()) sIniz += sCogn.charAt(0);
	sIniz = sIniz.toUpperCase();

	/* Calcolo media voti */
	int numVoti = (voti != null) ? voti.size() : 0;
	double media = 0;
	if(numVoti > 0){
		double somma = 0;
		for(Voto v : voti) somma += v.getVoto();
		media = somma / numVoti;
	}
	String mediaStr = numVoti > 0
		? String.format("%.1f", media).replace(",", ".")
		: "—";

	/* Colore media */
	String mediaColor = "--text-1";
	if(numVoti > 0){
		if(media >= 7)       mediaColor = "--accent";
		else if(media >= 5)  mediaColor = "--yellow";
		else                 mediaColor = "--red";
	}
%>

<!DOCTYPE html>
<html lang="it">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Voti — <%= studente.getNome() %> <%= studente.getCognome() %></title>

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
  --yellow:      #fbbf24;
  --yellow-bg:   rgba(251,191,36,0.10);
  --yellow-border:rgba(251,191,36,0.25);
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
  max-width: 1000px;
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

/* ── HERO STUDENTE ── */

.hero {
  background: var(--surface);
  border: 0.5px solid var(--border);
  border-radius: var(--radius-xl);
  padding: 28px 30px;
  display: flex;
  align-items: center;
  gap: 20px;
  position: relative;
  overflow: hidden;
  animation: fadeUp .45s ease .05s both;
}

.hero::before {
  content: '';
  position: absolute;
  top: -60px;
  right: -60px;
  width: 220px;
  height: 220px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(91,156,246,0.06) 0%, transparent 70%);
  pointer-events: none;
}

.hero-avatar {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  background: var(--blue-bg);
  border: 0.5px solid var(--blue-border);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  font-weight: 500;
  color: var(--blue);
  font-family: var(--mono);
  flex-shrink: 0;
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
  flex-wrap: wrap;
}

.hero-id {
  font-family: var(--mono);
  font-size: 12px;
  color: var(--text-3);
}

.hero-id span { color: var(--text-2); }

.tag {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  padding: 4px 11px;
  border-radius: 999px;
  font-size: 12px;
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

/* ── STATS ── */

.stats-row {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 14px;
  animation: fadeUp .45s ease .10s both;
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
  font-size: 28px;
  font-weight: 300;
  color: var(--text-1);
  line-height: 1;
}

.stat-value.mono {
  font-family: var(--mono);
  font-size: 16px;
  font-weight: 400;
  padding-top: 4px;
}

/* ── SEZIONE TABELLA ── */

.section {
  background: var(--surface);
  border: 0.5px solid var(--border);
  border-radius: var(--radius-xl);
  padding: 28px 30px;
  animation: fadeUp .45s ease .15s both;
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

tbody tr:hover { background: var(--surface2); }

td {
  padding: 15px 16px;
  vertical-align: middle;
}

/* Badge voto */

.voto-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 42px;
  height: 42px;
  border-radius: var(--radius-sm);
  font-family: var(--mono);
  font-size: 16px;
  font-weight: 500;
}

.voto-alto {
  background: var(--accent-bg);
  border: 0.5px solid var(--border-hi);
  color: var(--accent);
}

.voto-medio {
  background: var(--yellow-bg);
  border: 0.5px solid var(--yellow-border);
  color: var(--yellow);
}

.voto-basso {
  background: var(--red-bg);
  border: 0.5px solid var(--red-border);
  color: var(--red);
}

.td-mono {
  font-family: var(--mono);
  font-size: 13px;
  color: var(--text-2);
}

.td-dim {
  font-family: var(--mono);
  font-size: 12px;
  color: var(--text-3);
}

.delete-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 34px;
  height: 34px;
  background: var(--red-bg);
  border: 0.5px solid var(--red-border);
  border-radius: var(--radius-sm);
  color: var(--red);
  cursor: pointer;
  transition: all .2s ease;
}

.delete-btn:hover {
  background: rgba(248,113,113,0.18);
  border-color: var(--red);
  transform: translateY(-1px);
  box-shadow: 0 4px 14px rgba(248,113,113,0.15);
}

.delete-btn svg {
  width: 14px;
  height: 14px;
  stroke: currentColor;
  fill: none;
  stroke-width: 1.8;
  stroke-linecap: round;
  stroke-linejoin: round;
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
  from { opacity: 0; transform: translateY(12px); }
  to   { opacity: 1; transform: translateY(0); }
}

@keyframes fadeDown {
  from { opacity: 0; transform: translateY(-10px); }
  to   { opacity: 1; transform: translateY(0); }
}

/* ── RESPONSIVE ── */

@media (max-width: 700px) {
  .page { padding: 20px 16px 48px; }
  .stats-row { grid-template-columns: 1fr 1fr; }
  .stats-row .stat:last-child { grid-column: span 2; }
  .section { padding: 20px 16px; }
  .topbar .brand-name { display: none; }
  .hero { padding: 20px; gap: 14px; }
  .hero-info h2 { font-size: 18px; }
}

@media (max-width: 480px) {
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

    <!-- Torna alla pagina della classe con il cid corretto -->
    <a href="ClasseDocente?cid=<%= studente.getCid() %>&did=<%= docente.getDid() %>" class="back-btn">
      <svg viewBox="0 0 24 24">
        <line x1="19" y1="12" x2="5" y2="12"/>
        <polyline points="12 19 5 12 12 5"/>
      </svg>
      Torna alla classe
    </a>

  </div>

  <!-- HERO STUDENTE -->

  <div class="hero">

    <div class="hero-avatar"><%= sIniz %></div>

    <div class="hero-info">

      <h2><%= studente.getNome() %> <%= studente.getCognome() %></h2>

      <div class="hero-meta">

        <span class="hero-id">
          ID&nbsp;<span><%= studente.getSid() %></span>
        </span>

        <span class="tag tag-blue">
          <svg viewBox="0 0 24 24">
            <path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"/>
            <circle cx="12" cy="7" r="4"/>
          </svg>
          Studente
        </span>

        <span class="tag tag-green">
          <svg viewBox="0 0 24 24">
            <path d="M2 3h6a4 4 0 014 4v14a3 3 0 00-3-3H2z"/>
            <path d="M22 3h-6a4 4 0 00-4 4v14a3 3 0 013-3h7z"/>
          </svg>
          <%= materia %>
        </span>

      </div>

    </div>

  </div>

  <!-- STATISTICHE -->

  <div class="stats-row">

    <div class="stat">
      <div class="stat-label">
        <svg viewBox="0 0 24 24">
          <path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8z"/>
          <polyline points="14 2 14 8 20 8"/>
        </svg>
        Voti totali
      </div>
      <div class="stat-value"><%= numVoti %></div>
    </div>

    <div class="stat">
      <div class="stat-label">
        <svg viewBox="0 0 24 24">
          <line x1="18" y1="20" x2="18" y2="10"/>
          <line x1="12" y1="20" x2="12" y2="4"/>
          <line x1="6"  y1="20" x2="6"  y2="14"/>
        </svg>
        Media
      </div>
      <div class="stat-value" style="color: var(<%= mediaColor %>)">
        <%= mediaStr %>
      </div>
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

  </div>

  <!-- TABELLA VOTI -->

  <div class="section">

    <div class="section-header">
      <div class="section-title">Storico voti</div>
      <span class="section-count"><%= numVoti %> vot<%= numVoti != 1 ? "i" : "o" %></span>
    </div>

    <%
      if(voti == null || voti.isEmpty()){
    %>

      <div class="empty-box">
        Nessun voto registrato per questa materia.
      </div>

    <% } else { %>

      <div class="table-wrap">

        <table>

          <thead>
            <tr>
              <th>Voto</th>
              <th>Materia</th>
              <th>Data</th>
              <th>ID Voto</th>
              <th>ID Docente</th>
              <th>Azione</th>
            </tr>
          </thead>

          <tbody>

          <% for(int i = 0; i < voti.size(); i++){
               Voto v = voti.get(i);

               /* Classe CSS del badge in base al valore */
               String badgeClass = "voto-medio";
               double val = v.getVoto();
               if(val >= 7)      badgeClass = "voto-alto";
               else if(val < 5)  badgeClass = "voto-basso";
          %>

            <tr style="animation-delay: <%= (i * 0.05) %>s">

              <!-- Voto -->
              <td>
                <div class="voto-badge <%= badgeClass %>">
                  <%= v.getVoto() %>
                </div>
              </td>

              <!-- Materia -->
              <td class="td-mono"><%= v.getMateria() %></td>

              <!-- Data -->
              <td class="td-mono"><%= v.getData() %></td>

              <!-- ID Voto -->
              <td class="td-dim"><%= v.getVid() %></td>

              <!-- ID Docente -->
              <td class="td-dim"><%= v.getDid() %></td>

				<!-- Elimina voto -->
				<td>
				  <form action="EliminaVoto" method="post">
				    <input type="hidden" name="vid" value="<%= v.getVid() %>">
				    <input type="hidden" name="sid" value="<%= studente.getSid() %>">
				    <input type="hidden" name="materia" value="<%= materia %>">
				    <button type="submit" class="delete-btn">
				      <svg viewBox="0 0 24 24">
				        <polyline points="3 6 5 6 21 6"/>
				        <path d="M19 6l-1 14a2 2 0 01-2 2H8a2 2 0 01-2-2L5 6"/>
				        <path d="M10 11v6M14 11v6"/>
				        <path d="M9 6V4h6v2"/>
				      </svg>
				    </button>
				  </form>
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
