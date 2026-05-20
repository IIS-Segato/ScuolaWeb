<%@ page import="model.Utente" %>
<%@ page import="model.Classe" %>
<%@ page import="model.Aula" %>
<%@ page import="model.Orario" %>
<%@ page import="java.util.List" %>

<%
    Utente u = (Utente) session.getAttribute("utente");
    if (u == null) {
        response.sendRedirect("../../index.html");
        return;
    }
    String materia = (String) request.getAttribute("materia");
    List<Classe> classi = (List<Classe>) request.getAttribute("classiDocente");
    List<Aula> aule = (List<Aula>) request.getAttribute("auleDocente");
    List<Orario> orario = (List<Orario>) request.getAttribute("orarioDocente");
%>
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Area Docente <%= u.getNome() %></title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/style.css">
</head>
<body>
<div class="layout">

  <!-- Sidebar -->
  <aside class="sidebar">
    <div class="sidebar-logo">
      <div class="school-name">Istituto Scolastico</div>
      <div class="school-sub">Portale Didattico</div>
    </div>

    <div class="sidebar-user">
      <div class="user-avatar"><%= u.getNome().charAt(0) %><%= u.getCognome().charAt(0) %></div>
      <div class="user-name">Prof. <%= u.getNome() %> <%= u.getCognome() %></div>
      <div class="user-role">Docente</div>
    </div>

    <nav class="sidebar-nav">
      <div class="nav-label">Menu</div>
      <a href="#profilo" class="nav-item active">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 20c0-4 3.6-7 8-7s8 3 8 7"/></svg>
        Profilo
      </a>
      <a href="#classi" class="nav-item">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
        Classi
      </a>
      <a href="#aule" class="nav-item">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="3" width="20" height="14" rx="2"/><line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/></svg>
        Aule
      </a>
      <a href="#orario" class="nav-item">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>
        Orario
      </a>
    </nav>

    <div class="sidebar-footer">
      <a href="<%=request.getContextPath()%>/index.html">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
        Esci
      </a>
    </div>
  </aside>

  <!-- Main -->
  <div class="main">
    <header class="topbar">
      <span class="topbar-title">Prof. <%= u.getNome() %> <%= u.getCognome() %></span>
      <div class="topbar-right">
        <span class="badge-role">Docente</span>
      </div>
    </header>

    <div class="content">

      <!-- Stat cards -->
      <div class="card-grid">
        <div class="stat-card">
          <div class="stat-label">Materia</div>
          <div class="stat-value" style="font-size:1.1rem;"><%= materia != null ? materia : "—" %></div>
        </div>
        <div class="stat-card">
          <div class="stat-label">Classi assegnate</div>
          <div class="stat-value"><%= classi != null ? classi.size() : "0" %></div>
        </div>
        <div class="stat-card">
          <div class="stat-label">Aule in uso</div>
          <div class="stat-value"><%= aule != null ? aule.size() : "0" %></div>
        </div>
        <div class="stat-card">
          <div class="stat-label">Ore settimanali</div>
          <div class="stat-value"><%= orario != null ? orario.size() : "0" %></div>
        </div>
      </div>

      <!-- Profilo -->
      <div class="section-heading" id="profilo">
        <h2>Dati personali</h2>
        <div class="section-line"></div>
      </div>
      <div class="table-wrap">
        <table>
          <thead><tr><th>Campo</th><th>Valore</th></tr></thead>
          <tbody>
            <tr><td>ID</td><td><%= u.getId() %></td></tr>
            <tr><td>Nome</td><td><%= u.getNome() %></td></tr>
            <tr><td>Cognome</td><td><%= u.getCognome() %></td></tr>
            <tr><td>Email</td><td><%= u.getEmail() %></td></tr>
            <tr><td>Ruolo</td><td><span class="pill pill-gold"><%= u.getRuolo() %></span></td></tr>
            <tr><td>Materia</td><td><%= materia %></td></tr>
          </tbody>
        </table>
      </div>

      <!-- Classi -->
      <div class="section-heading" id="classi">
        <h2>Classi in cui insegni</h2>
        <div class="section-line"></div>
      </div>
      <div class="table-wrap">
        <table>
          <thead>
            <tr><th>ID</th><th>Sezione</th><th>Anno</th><th>N &deg studenti</th></tr>
          </thead>
          <tbody>
            <% if (classi != null && !classi.isEmpty()) {
                for (Classe c : classi) { %>
            <tr>
              <td><%= c.getId() %></td>
              <td><%= c.getSezione() %></td>
              <td><%= c.getAnno() %>&deg</td>
              <td><%= c.getNumeroStudenti() %></td>
            </tr>
            <% } } else { %>
            <tr><td colspan="4" style="color:var(--text-muted);text-align:center;padding:24px;">Nessuna classe assegnata</td></tr>
            <% } %>
          </tbody>
        </table>
      </div>

      <!-- Aule -->
      <div class="section-heading" id="aule">
        <h2>Aule in cui insegni</h2>
        <div class="section-line"></div>
      </div>
      <div class="table-wrap">
        <table>
          <thead>
            <tr><th>Nome aula</th><th>Capienza</th></tr>
          </thead>
          <tbody>
            <% if (aule != null && !aule.isEmpty()) {
                for (Aula a : aule) { %>
            <tr>
              <td><%= a.getNome() %></td>
              <td><%= a.getCapienza() %> posti</td>
            </tr>
            <% } } else { %>
            <tr><td colspan="2" style="color:var(--text-muted);text-align:center;padding:24px;">Nessuna aula trovata</td></tr>
            <% } %>
          </tbody>
        </table>
      </div>

      <!-- Orario -->
      <div class="section-heading" id="orario">
        <h2>Orario delle lezioni</h2>
        <div class="section-line"></div>
      </div>
      <div class="table-wrap">
        <table>
          <thead>
            <tr><th>Giorno</th><th>Inizio</th><th>Fine</th><th>Classe</th><th>Aula</th></tr>
          </thead>
          <tbody>
            <% if (orario != null && !orario.isEmpty()) {
                for (Orario o : orario) { %>
            <tr>
              <td><%= o.getGiorno() %></td>
              <td><%= o.getOraIni() %></td>
              <td><%= o.getOraFin() %></td>
              <td><%= o.getClasse() %></td>
              <td><span class="pill pill-navy"><%= o.getAula() %></span></td>
            </tr>
            <% } } else { %>
            <tr><td colspan="5" style="color:var(--text-muted);text-align:center;padding:24px;">Nessun orario trovato</td></tr>
            <% } %>
          </tbody>
        </table>
      </div>

    </div>
  </div>
</div>
</body>
</html>
