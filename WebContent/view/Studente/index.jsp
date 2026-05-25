<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList, model.Studente, model.Utente" %>
<%
    List<Studente> studenti = (List<Studente>) request.getAttribute("studenti");
    if (studenti == null) studenti = new ArrayList<>();
    Utente utente = (Utente) session.getAttribute("utente");
    boolean isAdmin = utente != null && utente.isAdmin();
    String filtroClasse = (String) request.getAttribute("filtroClasse");
    if (filtroClasse == null) filtroClasse = "";
%>
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>ScuolaWeb – Studenti</title>
  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <style>
    body { background-color: #f0f2f5; }
    .table-hover tbody tr:hover { background-color: #e8f5e9; }
  </style>
</head>
<body>
  <%@ include file="../includes/navbar.jsp" %>

  <div class="container py-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
      <div>
        <h3 class="fw-bold mb-0">
          <i class="bi bi-people-fill text-success me-2"></i>Elenco Studenti
        </h3>
        <p class="text-muted small mb-0">
          <%= studenti.size() %> studenti trovati
          <% if (!filtroClasse.isEmpty()) { %> (classe: <strong><%= filtroClasse %></strong>)<% } %>
        </p>
      </div>
      <% if (isAdmin) { %>
      <a href="Studente?action=INSERT" class="btn btn-success">
        <i class="bi bi-plus-circle me-1"></i>Nuovo Studente
      </a>
      <% } %>
    </div>

    <!-- Filtro per classe -->
    <div class="card border-0 shadow-sm mb-4">
      <div class="card-body py-2">
        <form action="Studente" method="get" class="row g-2 align-items-end">
          <div class="col-auto">
            <label class="form-label small fw-semibold mb-1">
              <i class="bi bi-funnel me-1"></i>Filtra per classe:
            </label>
            <input type="text" name="classe" class="form-control form-control-sm"
                   placeholder="es. 3A" value="<%= filtroClasse %>">
          </div>
          <div class="col-auto">
            <button type="submit" class="btn btn-outline-secondary btn-sm">Cerca</button>
            <% if (!filtroClasse.isEmpty()) { %>
            <a href="Studente" class="btn btn-outline-danger btn-sm ms-1">
              <i class="bi bi-x"></i> Reset
            </a>
            <% } %>
          </div>
        </form>
      </div>
    </div>

    <!-- Table -->
    <div class="card border-0 shadow-sm">
      <div class="card-body p-0">
        <% if (studenti.isEmpty()) { %>
        <div class="text-center py-5 text-muted">
          <i class="bi bi-inbox display-4 d-block mb-2"></i>
          Nessuno studente trovato.
          <% if (isAdmin) { %>
          <br><a href="Studente?action=INSERT">Aggiungi il primo studente</a>
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
                <th scope="col">Classe</th>
                <% if (isAdmin) { %><th scope="col" class="text-center">Azioni</th><% } %>
              </tr>
            </thead>
            <tbody>
              <% for (Studente s : studenti) { %>
              <tr>
                <td class="text-muted small"><%= s.getId() %></td>
                <td class="fw-semibold"><%= s.getCognome() %></td>
                <td><%= s.getNome() %></td>
                <td>
                  <span class="badge bg-success bg-opacity-75"><%= s.getClasse() %></span>
                </td>
                <% if (isAdmin) { %>
                <td class="text-center">
                  <a href="Studente?action=EDIT&id=<%= s.getId() %>"
                     class="btn btn-sm btn-outline-primary me-1" title="Modifica">
                    <i class="bi bi-pencil-fill"></i>
                  </a>
                  <a href="Studente?action=DELETE&id=<%= s.getId() %>"
                     class="btn btn-sm btn-outline-danger"
                     title="Elimina"
                     onclick="return confirm('Eliminare lo studente <%= s.getNome() %> <%= s.getCognome() %>?')">
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
