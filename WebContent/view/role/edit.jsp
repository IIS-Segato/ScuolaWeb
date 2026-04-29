<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="model.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Recupero dati dal request (passati dalla Servlet)
    Utente utente = (Utente) request.getAttribute("utente");
    List<Utente> listaUtenti = (List<Utente>) request.getAttribute("listaUtenti");
    String action = (String) request.getAttribute("action");

    // Fallback per evitare errori se arrivi alla pagina senza passare dalla Servlet
    if (utente == null) {
        utente = (Utente) session.getAttribute("utente"); // usa quello loggato
        if (utente == null) utente = new Utente(); // se proprio non c'è nulla, evita crash
    }
    if (listaUtenti == null) listaUtenti = new ArrayList<Utente>();
    if (action == null) action = "UPDATE";
%>    
<!DOCTYPE html>
<html>
  <head>
    <title>Edit Utente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  </head>
  <body class="p-5">
    <a href="index.html">
      <button type="button" class="btn btn-warning">TORNA AL LOGIN</button>
    </a>
    
    <h1 class="fw-bold mt-3"><span class="text-primary">MODIFICA</span> UTENTE</h1>
    
    <h3 class="fw-bold mt-4">Seleziona un utente:</h3>
    <ol>
      <% for (Utente u : listaUtenti) { %>
      <li>
        <a href="Utente?action=edit&email=<%=u.getEmail()%>" style="text-decoration:none;">
          <strong><%=u.getNome()%> <%=u.getCognome()%></strong> — <%=u.getEmail()%> (<%=u.getRuolo()%>)
        </a>
      </li>
      <% } %>
    </ol>

    <hr>

    <form action="Utente" method="post">
      <input type="hidden" name="action" value="<%=action%>">
      
      <div class="mb-3">
        <label class="form-label fw-bold">Nome:</label>
        <input type="text" class="form-control" name="nome" 
               value="<%= utente.getNome() != null ? utente.getNome() : "" %>" required>
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold">Cognome:</label>
        <input type="text" class="form-control" name="cognome" 
               value="<%= utente.getCognome() != null ? utente.getCognome() : "" %>" required>
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold">Email (ID univoco):</label>
        <input type="email" class="form-control" name="email" 
               value="<%= utente.getEmail() != null ? utente.getEmail() : "" %>" required>
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold">Password:</label>
        <input type="password" class="form-control" name="password" 
               value="<%= utente.getPassword() != null ? utente.getPassword() : "" %>">
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold">Ruolo:</label>
        <select class="form-control" name="ruolo" required>
          <option value="DOCENTE" <%= "DOCENTE".equals(utente.getRuolo()) ? "selected" : "" %>>Docente</option>
          <option value="STUDENTE" <%= "STUDENTE".equals(utente.getRuolo()) ? "selected" : "" %>>Studente</option>
          <option value="AMMINISTRATORE" <%= "AMMINISTRATORE".equals(utente.getRuolo()) ? "selected" : "" %>>Amministratore</option>
        </select>
      </div>

      <button type="submit" class="btn btn-success">Salva Modifiche</button>
    </form>
  </body>
</html>