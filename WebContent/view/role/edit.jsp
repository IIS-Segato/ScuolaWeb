<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="model.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Utente utente = (Utente) request.getAttribute("utente");
    List<Utente> listaUtenti = (List<Utente>) request.getAttribute("listaUtenti");
    if (utente == null) {
        utente = (Utente) session.getAttribute("utente");
        if (utente == null) utente = new Utente();
    }
    if (listaUtenti == null) listaUtenti = new ArrayList<Utente>();
%>
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Gestione Utenti — Admin</title>
  <link rel="stylesheet" href="style.css">
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
      <a href="#lista" class="nav-item active">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/></svg>
        Lista Utenti
      </a>
      <a href="#modifica" class="nav-item">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
        Modifica Utente
      </a>
      <div class="nav-label">Azioni rapide</div>
      <a href="${pageContext.request.contextPath}/nuovoUtente" class="nav-item">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
        Nuovo Utente
      </a>
    </nav>

    <div class="sidebar-footer">
      <a href="index.html">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
        Esci
      </a>
    </div>
  </aside>

  <!-- Main -->
  <div class="main">
    <header class="topbar">
      <span class="topbar-title">Gestione Utenti</span>
      <div class="topbar-right">
        <a href="${pageContext.request.contextPath}/nuovoUtente" class="btn btn-accent btn-sm">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
          Nuovo Utente
        </a>
        <span class="badge-role">Admin</span>
      </div>
    </header>

    <div class="content">

      <!-- Lista utenti -->
      <div class="section-heading" id="lista">
        <h2>Lista Utenti</h2>
        <div class="section-line"></div>
      </div>

      <div class="card" style="margin-bottom:36px;">
        <ul class="user-list">
          <% for (Utente u : listaUtenti) { %>
          <li class="user-list-item">
            <div class="user-info">
              <strong><%=u.getNome()%> <%=u.getCognome()%></strong>
              <span><%=u.getEmail()%> &nbsp;·&nbsp; <span class="pill pill-accent"><%=u.getRuolo()%></span></span>
            </div>
            <div class="user-actions">
              <a href="${pageContext.request.contextPath}/Utente?action=edit&email=<%=u.getEmail()%>" class="btn btn-ghost btn-sm">Modifica</a>
              <a href="${pageContext.request.contextPath}/Utente?action=delete&email=<%=u.getEmail()%>&ruolo=<%=u.getRuolo()%>"
                 class="btn btn-danger btn-sm"
                 onclick="return confirm('Eliminare <%=u.getNome()%> <%=u.getCognome()%>?')">Elimina</a>
            </div>
          </li>
          <% } %>
        </ul>
      </div>

      <!-- Modifica utente -->
      <div class="section-heading" id="modifica">
        <h2>Modifica Utente Selezionato</h2>
        <div class="section-line"></div>
      </div>

      <div class="form-card">
        <form action="${pageContext.request.contextPath}/Utente" method="post">
          <input type="hidden" name="action" value="UPDATE">

          <div class="form-group">
            <label class="form-label required">Nome</label>
            <input class="form-control" type="text" name="nome"
                   value="<%= utente.getNome() != null ? utente.getNome() : "" %>" required>
          </div>

          <div class="form-group">
            <label class="form-label required">Cognome</label>
            <input class="form-control" type="text" name="cognome"
                   value="<%= utente.getCognome() != null ? utente.getCognome() : "" %>" required>
          </div>

          <div class="form-group">
            <label class="form-label" style="color:var(--danger);">Email <small>(non modificabile)</small></label>
            <input class="form-control" type="email" name="email" readonly
                   value="<%= utente.getEmail() != null ? utente.getEmail() : "" %>">
          </div>

          <div class="form-group">
            <label class="form-label">Password</label>
            <input class="form-control" type="password" name="password"
                   value="<%= utente.getPassword() != null ? utente.getPassword() : "" %>">
          </div>

          <div class="form-group">
            <label class="form-label">Ruolo <small>(non modificabile)</small></label>
            <input class="form-control" type="text" readonly
                   value="<%= utente.getRuolo() != null ? utente.getRuolo() : "" %>">
            <input type="hidden" name="ruolo" value="<%= utente.getRuolo() %>">
          </div>

          <button class="btn btn-primary" type="submit" style="width:100%; justify-content:center; padding:12px; margin-top:4px;">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/><polyline points="17 21 17 13 7 13 7 21"/><polyline points="7 3 7 8 15 8"/></svg>
            Salva Modifiche
          </button>
        </form>
      </div>

    </div>
  </div>
</div>
</body>
</html>