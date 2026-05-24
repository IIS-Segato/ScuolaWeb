<%@page import="java.util.ArrayList"%>
<%@page import="java.util.LinkedHashMap"%>
<%@ page import="java.time.LocalDate"%>
<%@page import="java.util.Map"%>
<%@ page import="model.*" %>
<%@ page language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// Prendo lo studente in sessione
	Studente studente =
		(Studente) session.getAttribute("studente");

	// Prendo i voti dello studente
	ArrayList<Voto> voti = studente.getVoti();
	
	// Prendo la classe dalla richiesta
	Classe classe = (Classe) request.getAttribute("classe");

	// Iniziali per profilo
	String sNome = studente.getNome() != null ? studente.getNome() : "";
	String sCogn = studente.getCognome() != null ? studente.getCognome() : "";
	String sIniz = "";
	if(!sNome.isEmpty()) sIniz += sNome.charAt(0);
	if(!sCogn.isEmpty()) sIniz += sCogn.charAt(0);
	sIniz = sIniz.toUpperCase();

	// Numero voti totale + media generale
	int numVoti = (voti != null) ? voti.size() : 0;

	double mediaGenerale = 0;
	String mediaStr = "—";
	String mediaColor = "--text-1";

	if(numVoti > 0){
		double somma = 0;
		for(Voto v : voti) somma += v.getVoto();
		mediaGenerale = somma / numVoti;
		mediaStr = String.format("%.1f", mediaGenerale).replace(",", ".");
		if(mediaGenerale >= 7)      mediaColor = "--accent";
		else if(mediaGenerale >= 5) mediaColor = "--yellow";
		else                        mediaColor = "--red";
	}

	// HashMap per raggruppamento voti per materia
	LinkedHashMap<String, ArrayList<Voto>> votiPerMateria = new LinkedHashMap<>();
	if(voti != null){
		for(Voto v : voti){
			String mat = v.getMateria();
			if(!votiPerMateria.containsKey(mat))
				votiPerMateria.put(mat, new ArrayList<Voto>());
			votiPerMateria.get(mat).add(v);
		}
	}

	int numMaterie = votiPerMateria.size();
	
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
<title>Dashboard studente</title>

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
  --blue:         #5b9cf6;
  --blue-bg:      rgba(91,156,246,0.10);
  --blue-border:  rgba(91,156,246,0.25);
  --red:          #f87171;
  --red-bg:       rgba(248,113,113,0.10);
  --red-border:   rgba(248,113,113,0.25);
  --yellow:       #fbbf24;
  --yellow-bg:    rgba(251,191,36,0.10);
  --yellow-border:rgba(251,191,36,0.25);
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
  text-decoration: none;
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
  stroke-width: 2.2;
  stroke-linecap: round;
  stroke-linejoin: round;
}

/* ── HERO ── */

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
  background: radial-gradient(circle, rgba(99,190,140,0.06) 0%, transparent 70%);
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
}

.hero-info { flex: 1; }

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

.tag-green {
  background: var(--accent-bg);
  border: 0.5px solid var(--border-hi);
  color: var(--accent);
}

.tag-blue {
  background: var(--blue-bg);
  border: 0.5px solid var(--blue-border);
  color: var(--blue);
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
  grid-template-columns: repeat(4, 1fr);
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
  font-size: 26px;
  font-weight: 300;
  color: var(--text-1);
  line-height: 1;
}

.stat-value.mono {
  font-family: var(--mono);
  font-size: 15px;
  font-weight: 400;
  padding-top: 4px;
}

/* ── FILTRO MATERIA ── */

.filter-bar {
  display: flex;
  align-items: center;
  gap: 10px;
  animation: fadeUp .45s ease .13s both;
}

.filter-label {
  font-size: 12px;
  color: var(--text-3);
  text-transform: uppercase;
  letter-spacing: 0.07em;
  white-space: nowrap;
}

.filter-select {
  background: var(--surface);
  border: 0.5px solid var(--border);
  border-radius: var(--radius-sm);
  color: var(--text-1);
  font-family: var(--mono);
  font-size: 13px;
  padding: 8px 12px;
  outline: none;
  cursor: pointer;
  transition: border-color .2s;
  appearance: none;
  -webkit-appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%234d6168' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 10px center;
  padding-right: 30px;
}

.filter-select:focus {
  border-color: var(--border-hi);
}

/* ── SEZIONE TABELLA ── */

.section {
  background: var(--surface);
  border: 0.5px solid var(--border);
  border-radius: var(--radius-xl);
  padding: 28px 30px;
  animation: fadeUp .45s ease .16s both;
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

thead tr { background: var(--surface2); }

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

/* Riga separatore materia */
.materia-row td {
  padding: 10px 16px 6px;
  border-top: 0.5px solid var(--border);
}

.materia-row:first-child td {
  border-top: none;
}

.materia-label {
  font-size: 11px;
  font-weight: 500;
  color: var(--accent);
  text-transform: uppercase;
  letter-spacing: 0.09em;
  display: flex;
  align-items: center;
  gap: 6px;
}

.materia-label::before {
  content: '';
  display: inline-block;
  width: 5px;
  height: 5px;
  border-radius: 50%;
  background: var(--accent);
}

td {
  padding: 13px 16px;
  vertical-align: middle;
}

/* Badge voto */
.voto-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  border-radius: var(--radius-sm);
  font-family: var(--mono);
  font-size: 15px;
  font-weight: 500;
}

.voto-alto   { background: var(--accent-bg);  border: 0.5px solid var(--border-hi);      color: var(--accent); }
.voto-medio  { background: var(--yellow-bg);  border: 0.5px solid var(--yellow-border);  color: var(--yellow); }
.voto-basso  { background: var(--red-bg);     border: 0.5px solid var(--red-border);     color: var(--red); }

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

@keyframes pulse {
  0%, 100% { opacity: 1; transform: scale(1); }
  50%       { opacity: .4; transform: scale(1.6); }
}

/* ── RESPONSIVE ── */

@media (max-width: 750px) {
  .page { padding: 20px 16px 48px; }
  .stats-row { grid-template-columns: 1fr 1fr; }
  .section { padding: 20px 16px; }
  .topbar .brand-name { display: none; }
  .hero { padding: 20px; gap: 14px; }
  .hero-info h2 { font-size: 18px; }
}

@media (max-width: 480px) {
  .stats-row { grid-template-columns: 1fr 1fr; }
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

    <a href="logout" class="logout-btn">
      <svg viewBox="0 0 24 24">
        <path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4"/>
        <polyline points="16 17 21 12 16 7"/>
        <line x1="21" y1="12" x2="9" y2="12"/>
      </svg>
      Esci
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

        <span class="hero-id">
          <%= studente.getEmail() %>
        </span>
        
        <span class="tag tag-blue">
		  <svg viewBox="0 0 24 24">
		    <path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/>
		    <circle cx="9" cy="7" r="4"/>
		    <path d="M23 21v-2a4 4 0 00-3-3.87"/>
		    <path d="M16 3.13a4 4 0 010 7.75"/>
		  </svg>
		  Classe <%= classe.getAnno() + classe.getSezione() %>
		</span>

        <span class="tag tag-green status-dot">Studente attivo</span>

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
	    Classe
	  </div>
	  <div class="stat-value">
	    <%= classe.getAnno() + classe.getSezione() %>
	  </div>
	</div>

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
        Media generale
      </div>
      <div class="stat-value" style="color: var(<%= mediaColor %>)">
        <%= mediaStr %>
      </div>
    </div>
	
	<div class="stat">
	  <div class="stat-label">
	    <svg viewBox="0 0 24 24">
	      <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
	      <line x1="16" y1="2" x2="16" y2="6"/>
	      <line x1="8"  y1="2" x2="8"  y2="6"/>
	      <line x1="3"  y1="10" x2="21" y2="10"/>
	    </svg>
	    Anno scolastico
	  </div>
	  <div class="stat-value mono"><%= primoAnno + "/" + secondoAnno %></div>
	</div>

  </div>

  <!-- FILTRO MATERIA -->

  <% if(numMaterie > 1){ %>

  <div class="filter-bar">

    <span class="filter-label">Filtra per materia</span>

    <select class="filter-select" id="filtroMateria" onchange="filtraMateria(this.value)">
      <option value="tutte">Tutte le materie</option>
      <% for(String mat : votiPerMateria.keySet()){ %>
        <option value="<%= mat %>"><%= mat %></option>
      <% } %>
    </select>

  </div>

  <% } %>

  <!-- TABELLA VOTI -->

  <div class="section">

    <div class="section-header">
      <div class="section-title">I miei voti</div>
      <span class="section-count"><%= numVoti %> vot<%= numVoti != 1 ? "i" : "o" %></span>
    </div>

    <%
      if(voti == null || voti.isEmpty()){
    %>

      <div class="empty-box">
        Nessun voto registrato per il momento.
      </div>

    <% } else { %>

      <div class="table-wrap">

        <table id="tabellaVoti">

          <thead>
            <tr>
              <th>Voto</th>
              <th>Materia</th>
              <th>Data</th>
            </tr>
          </thead>

          <tbody>

          <%
            int rowIdx = 0;
            for(Map.Entry<String, ArrayList<Voto>> entry : votiPerMateria.entrySet()){
              String mat        = entry.getKey();
              ArrayList<Voto> votiMat = entry.getValue();

              // Calcolo media per materia
              double sommaMat = 0;
              for(Voto v : votiMat) sommaMat += v.getVoto();
              double mediaMat = sommaMat / votiMat.size();
              String mediaMatStr = String.format("%.1f", mediaMat).replace(",", ".");
              String mediaMatColor = "";
              if(mediaMat >= 6)      mediaMatColor = "--accent";
	      		else if(mediaMat >= 5) mediaMatColor = "--yellow";
	      		else                        mediaMatColor = "--red";
          %>

            <!-- Separatore di materia -->
            <tr class="materia-row" data-materia="<%= mat %>">
              <td colspan="3">
                <div class="materia-label" style="color: var(<%= mediaMatColor %>)">
                  <%= mat %> &nbsp;·&nbsp; media <%= mediaMatStr %>
                </div>
              </td>
            </tr>

            <%
              for(Voto v : votiMat){
                String badgeClass = "voto-medio";
                double val = v.getVoto();
                if(val >= 6)     badgeClass = "voto-alto";
                else if(val < 5) badgeClass = "voto-basso";
                
                // sostituisco con +,- e 1/2
                double voto = v.getVoto();
				
				String votoView = "";
			
				int intero = (int) voto;
				double decimale = Math.round((voto - intero) * 100.0) / 100.0;
			
				if(decimale == 0){
			
					votoView = String.valueOf(intero);
			
				}else if(decimale == 0.15){
			
					votoView = intero + "+";
			
				}else if(decimale == 0.5){
			
					votoView = intero + "½";
			
				}else if(decimale == 0.85){
			
					votoView = (intero + 1) + "-";
			
				}else{
			
					votoView = String.format("%.2f", voto);
			
				}
            %>

            <tr data-materia="<%= mat %>"
                style="animation-delay: <%= (rowIdx * 0.04) %>s">

              <!-- Voto -->
              <td>
                <div class="voto-badge <%= badgeClass %>">
                  <%= votoView %>
                </div>
              </td>

              <!-- Materia -->
              <td class="td-mono"><%= v.getMateria() %></td>

              <!-- Data -->
              <td class="td-dim"><%= v.getData() %></td>

            </tr>

            <% rowIdx++; } %>

          <% } %>

          </tbody>

        </table>

      </div>

    <% } %>

  </div>

</div>

<script>
  // Filtro righe per materia lato client
  function filtraMateria(materia) {
    const righe = document.querySelectorAll('#tabellaVoti tbody tr');
    righe.forEach(riga => {
      if(materia === 'tutte' || riga.dataset.materia === materia){
        riga.style.display = '';
      } else {
        riga.style.display = 'none';
      }
    });
  }
</script>

</body>

</html>
