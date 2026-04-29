<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="model.*" %>
<%@ page import="utils.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<% Utente utente = (Utente) session.getAttribute("utente");   
String id = "1";
if(request.getAttribute("id") != null){
	id=Integer.toString((Integer)request.getAttribute("id"));
}

%>    
<!DOCTYPE html>
<html>
  <head>
    <title>Edit Utente</title>
  </head>
  <body class="p-5">
    <a href="Utente"
      ><button type="button" class="btn btn-warning mr-3">
        TORNA ALLA LISTA
      </button></a
    >
    <h1 class="fw-bold mt-3">
      <span class="text-primary">MODIFICA</span> UTENTE
    </h1>
    <br>
    <ol type="utenti">
    	
    </ol>
    <form action="UtenteDAO" method="post">
      <input type="hidden" name="id" value="<%=id%>">
      <input type="hidden" name="action" value="<%=request.getAttribute("action")%>">
      <div class="mb-3">
        <label class="form-label fw-bold">Nome:</label>
        <input
          type="text"
          class="form-control"
          name="nome"
          value="<%=utente.getNome() != null ? utente.getNome() : ""%>"
          required="required"
        />
      </div>
      <div class="mb-3">
        <label class="form-label fw-bold">Cognome:</label>
        <input
          type="text"
          class="form-control"
          name="cognome"
          value="<%=utente.getCognome() != null ? utente.getNome() : ""  %>"
          required="required"
        />
      </div>
       <div class="mb-3">
        <label class="form-label fw-bold">Email:</label>
        <input
          type="email"
          class="form-control"
          name="email"
          value="<%=utente.getEmail() != null ? utente.getNome() : "" %>"
          required="required"
        />
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold">Password:</label>
        <input
          type="password"
          class="form-control"
          name="password"
          value="<%=utente.getPassword() != null ? utente.getNome() : "" %>"
        />
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold">Ruolo:</label>
        <select class="form-control" name="ruolo" required="required">
          <option value="DOCENTE"   <%="DOCENTE".equals(utente.getRuolo())        ? "selected" : ""%>>Docente</option>
          <option value="STUDENTE"  <%="STUDENTE".equals(utente.getRuolo())       ? "selected" : ""%>>Studente</option>
          <option value="AMMINISTRATORE" <%="AMMINISTRATORE".equals(utente.getRuolo()) ? "selected" : ""%>>Amministratore</option>
        </select>
      </div>

      <button type="reset" class="btn btn-warning">svuota i campi</button>
      <button type="submit" class="btn btn-success">salva</button>
    </form>
  </body>
</html>

