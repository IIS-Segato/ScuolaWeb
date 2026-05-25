<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Classe" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Nuovo Utente — Admin</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<div class="layout">

  <!-- Sidebar -->
  <aside class="sidebar">
    <div class="sidebar-logo">
      <div class="school-name">Istituto Scolastico</div>
      <div class="school-sub">Pannello Admin</div>
    </div>

    <div class="sidebar-user">
      <div class="user-avatar">A</div>
      <div class="user-name">Amministratore</div>
      <div class="user-role">Admin</div>
    </div>

    <nav class="sidebar-nav">
      <div class="nav-label">Gestione</div>
      <a href="/ScuolaWeb/Utente" class="nav-item">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/></svg>
        Lista Utenti
      </a>
      <div class="nav-label">Azioni rapide</div>
      <a href="/ScuolaWeb/nuovoUtente" class="nav-item active">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
        Nuovo Utente
      </a>
    </nav>

    <div class="sidebar-footer">
      <a href="../../index.html">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
        Esci
      </a>
    </div>
  </aside>

  <!-- Main -->
  <div class="main">
    <header class="topbar">
      <span class="topbar-title">Nuovo Utente</span>
      <div class="topbar-right">
        <a href="/ScuolaWeb/Utente" class="btn btn-ghost btn-sm">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M19 12H5"/><polyline points="12 19 5 12 12 5"/></svg>
          Torna Indietro
        </a>
        <span class="badge-role">Admin</span>
      </div>
    </header>

    <div class="content">

      <div class="section-heading">
        <h2>Registra Nuovo Utente</h2>
        <div class="section-line"></div>
      </div>

      <div class="form-card">
        <form action="/ScuolaWeb/Utente" method="post">
          <input type="hidden" name="action" value="INSERT">

          <div class="form-group">
            <label class="form-label required">Nome</label>
            <input type="text" class="form-control" name="nome" placeholder="Es: Mario" required>
          </div>

          <div class="form-group">
            <label class="form-label required">Cognome</label>
            <input type="text" class="form-control" name="cognome" placeholder="Es: Rossi" required>
          </div>

          <div class="form-group">
            <label class="form-label required">Email</label>
            <input type="email" class="form-control" name="email" placeholder="mario.rossi@scuola.it" required>
          </div>

          <div class="form-group">
            <label class="form-label required">Password</label>
            <input type="password" class="form-control" name="password" required>
          </div>

          <div class="form-group">
            <label class="form-label required">Ruolo</label>
            <select class="form-select" name="ruolo" id="ruolo" required>
              <option value="" selected disabled>Scegli un ruolo...</option>
              <option value="STUDENTE">STUDENTE</option>
              <option value="DOCENTE">DOCENTE</option>
              <option value="AMMINISTRATORE">AMMINISTRATORE</option>
            </select>
            <div class="form-hint">In base al ruolo, l'utente verrà salvato nella tabella corretta.</div>
          </div>

          <!-- CAMPI STUDENTE -->
          <div id="campiStudente" style="display:none;">
            <div class="form-group">
              <label class="form-label">Classe (solo studenti)</label>
              <select class="form-select" name="classe">
                <option value="" selected disabled>Seleziona una classe...</option>
                <%
                  List<Classe> classi = (List<Classe>) request.getAttribute("classi");
                  if (classi != null) {
                    for (Classe c : classi) {
                %>
                  <option value="<%= c.getId() %>">
                    <%= c.getAnno() %>ª <%= c.getSezione() %>
                  </option>
                <%
                    }
                  }
                %>
              </select>
            </div>
          </div>

          <!-- CAMPI DOCENTE -->
          <div id="campiDocente" style="display:none;">
            <div class="form-group">
              <label class="form-label">Materia</label>
              <input type="text" class="form-control" name="materia" placeholder="Es: Matematica">
            </div>
          </div>

          <button class="btn btn-accent" type="submit" style="width:100%; justify-content:center; padding:12px; margin-top:4px;">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
            Registra Utente
          </button>

        </form>
      </div>

    </div>
  </div>
</div>

<script>
  const ruoloSelect = document.getElementById("ruolo");
  const campiStudente = document.getElementById("campiStudente");
  const campiDocente = document.getElementById("campiDocente");

  ruoloSelect.addEventListener("change", function () {
    campiStudente.style.display = "none";
    campiDocente.style.display = "none";
    if (this.value === "STUDENTE") campiStudente.style.display = "block";
    if (this.value === "DOCENTE")  campiDocente.style.display = "block";
  });
</script>

</body>
</html>