<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList, model.Docente, model.Utente" %>
<%
    List<Docente> docenti = (List<Docente>) request.getAttribute("docenti");
    if (docenti == null) docenti = new ArrayList<>();
    Utente utente = (Utente) session.getAttribute("utente");
    boolean isAdmin = utente != null && utente.isAdmin();
%>
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>ScuolaWeb – Docenti</title>
  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <style>
    body { background-color: #f0f2f5; }
    .table-hover tbody tr:hover { background-color: #e3f2fd; }
  </style>
</head>
<body>
  <%@ include file="../includes/navbar.jsp" %>

  <div class="container py-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
      <div>
        <h3 class="fw-bold mb-0">
          <i class="bi bi-person-badge-fill text-primary me-2"></i>Elenco Docenti
        </h3>
        <p class="text-muted small mb-0"><%= docenti.size() %> docenti registrati</p>
      </div>
      <% if (isAdmin) { %>
      <a href="Docente?action=INSERT" class="btn btn-primary">
        <i class="bi bi-plus-circle me-1"></i>Nuovo Docente
      </a>
      <% } %>
    </div>

    <div class="card border-0 shadow-sm">
      <div class="card-body p-0">
        <% if (docenti.isEmpty()) { %>
        <div class="text-center py-5 text-muted">
          <i class="bi bi-inbox display-4 d-block mb-2"></i>
          Nessun docente trovato.
          <% if (isAdmin) { %>
          <br><a href="Docente?action=INSERT">Aggiungi il primo docente</a>
          <% } %>
        </div>
        <% } else { %>
        <div class="table-responsive">
          <table class="table table-hover align-middle mb-0">
            <thead class="table-dark">
              <tr>
                <th scope="col" style="width:60px">#</th>
                <th scope="col">Cognome</th>
                <th scope="col">Nome</th>
                <th scope="col">Materia</th>
                <% if (isAdmin) { %><th scope="col" class="text-center">Azioni</th><% } %>
              </tr>
            </thead>
            <tbody>
              <% for (Docente d : docenti) { %>
              <tr>
                <td class="text-muted small"><%= d.getId() %></td>
                <td class="fw-semibold"><%= d.getCognome() %></td>
                <td><%= d.getNome() %></td>
                <td>
                  <span class="badge bg-primary bg-opacity-75">
                    <i class="bi bi-book me-1"></i><%= d.getMateria() %>
                  </span>
                </td>
                <% if (isAdmin) { %>
                <td class="text-center">
                  <a href="Docente?action=EDIT&id=<%= d.getId() %>"
                     class="btn btn-sm btn-outline-primary me-1" title="Modifica">
                    <i class="bi bi-pencil-fill"></i>
                  </a>
                  <a href="Docente?action=DELETE&id=<%= d.getId() %>"
                     class="btn btn-sm btn-outline-danger"
                     title="Elimina"
                     onclick="return confirm('Eliminare il docente <%= d.getNome() %> <%= d.getCognome() %>?')">
                    <i class="bi bi-trash3-fill"></i>
                  </a>
                </td>
                <% } %>
              </tr>
              <% } %>
            </tbody>
          </table>
        </div>
        <% } %>
      </div>
    </div>

  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
