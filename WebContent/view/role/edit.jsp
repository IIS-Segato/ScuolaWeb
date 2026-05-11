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
<html>
  <head>
    <title>Gestione Utenti</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  </head>
  <body class="p-5">
    <a href="index.html"><button type="button" class="btn btn-warning">TORNA AL LOGIN</button></a>
    
    <h1 class="fw-bold mt-3"><span class="text-primary">GESTIONE</span> UTENTI</h1>
    
    <div class="mt-4 mb-2">
        <a href="view/role/nuovoUtente.jsp" class="btn btn-primary fw-bold">+ INSERISCI NUOVO UTENTE</a>
    </div>
    
    <h3 class="fw-bold mt-4">Lista Utenti (Modifica o Elimina):</h3>
    <ul class="list-group">
      <% for (Utente u : listaUtenti) { %>
      <li class="list-group-item d-flex justify-content-between align-items-center">
        <div>
          <strong><%=u.getNome()%> <%=u.getCognome()%></strong> — <%=u.getEmail()%> (<%=u.getRuolo()%>)
        </div>
        <div>
          <!-- LINK MODIFICA -->
          <a href="Utente?action=edit&email=<%=u.getEmail()%>" class="btn btn-sm btn-outline-primary">Modifica</a>
          
          <!-- LINK ELIMINA (NUOVO!) -->
          <a href="Utente?action=delete&email=<%=u.getEmail()%>&ruolo=<%=u.getRuolo()%>" 
             class="btn btn-sm btn-danger" 
             onclick="return confirm('Sei sicuro di voler eliminare questo utente?')">Elimina</a>
        </div>
      </li>
      <% } %>
    </ul>

    <hr class="my-5">

    <h3 class="fw-bold">Dettagli Utente Selezionato</h3>
    <form action="Utente" method="post">
      <input type="hidden" name="action" value="UPDATE">
      
      <div class="mb-3">
        <label class="form-label fw-bold">Nome:</label>
        <input type="text" class="form-control" name="nome" value="<%= utente.getNome() != null ? utente.getNome() : "" %>" required>
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold">Cognome:</label>
        <input type="text" class="form-control" name="cognome" value="<%= utente.getCognome() != null ? utente.getCognome() : "" %>" required>
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold text-danger">Email (Non modificabile):</label>
        <input type="email" class="form-control bg-light" name="email" value="<%= utente.getEmail() != null ? utente.getEmail() : "" %>" readonly>
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold">Password:</label>
        <input type="password" class="form-control" name="password" value="<%= utente.getPassword() != null ? utente.getPassword() : "" %>">
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold">Ruolo:</label>
        <input type="text" class="form-control bg-light" value="<%= utente.getRuolo() != null ? utente.getRuolo() : "" %>" readonly>
        <!-- CAMBIO: Il ruolo viene passato come campo hidden per non perderlo -->
        <input type="hidden" name="ruolo" value="<%= utente.getRuolo() %>">
      </div>
      
      <button type="submit" class="btn btn-success w-100">Salva Modifiche</button>
    </form>
  </body>
</html>