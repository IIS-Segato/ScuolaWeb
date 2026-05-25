<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Utente" %>
<%
    Utente utente = (Utente) session.getAttribute("utente");
%>
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>ScuolaWeb – Dashboard</title>
  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <style>
    body { background-color: #f0f2f5; }
    .hero {
      background: linear-gradient(135deg, #0f3460 0%, #533483 100%);
      color: white;
      padding: 3rem 2rem;
      border-radius: 1rem;
      margin-bottom: 2rem;
    }
    .stat-card {
      border: none;
      border-radius: .8rem;
      box-shadow: 0 4px 15px rgba(0,0,0,.08);
      transition: transform .2s, box-shadow .2s;
      overflow: hidden;
    }
    .stat-card:hover {
      transform: translateY(-4px);
      box-shadow: 0 8px 25px rgba(0,0,0,.15);
    }
    .stat-card .card-icon {
      font-size: 2.5rem;
      opacity: .85;
    }
    .card-stripe-studenti  { border-top: 4px solid #198754; }
    .card-stripe-docenti   { border-top: 4px solid #0d6efd; }
    .card-stripe-ruoli     { border-top: 4px solid #dc3545; }
    .card-stripe-info      { border-top: 4px solid #fd7e14; }
  </style>
</head>
<body>
  <%@ include file="includes/navbar.jsp" %>

  <div class="container py-4">

    
    <div class="hero shadow">
      <div class="row align-items-center">
        <div class="col-md-8">
          <h2 class="fw-bold mb-1">
            Benvenuto, <%= utente != null ? utente.getNome() + " " + utente.getCognome() : "Utente" %>!
          </h2>
          <p class="opacity-75 mb-0">
            Pannello di controllo del sistema scolastico ScuolaWeb
          </p>
        </div>
        <div class="col-md-4 text-end d-none d-md-block">
          <i class="bi bi-mortarboard-fill" style="font-size:5rem; opacity:.3;"></i>
        </div>
      </div>
    </div>


    <div class="row g-4">

      
      <div class="col-md-6 col-lg-4">
        <div class="card stat-card card-stripe-studenti h-100">
          <div class="card-body p-4">
            <div class="d-flex justify-content-between align-items-start mb-3">
              <div>
                <h5 class="fw-bold mb-1">Studenti</h5>
                <p class="text-muted small mb-0">Gestione anagrafica studenti</p>
              </div>
              <div class="card-icon text-success"><i class="bi bi-people-fill"></i></div>
            </div>
            <a href="Studente" class="btn btn-success btn-sm w-100">
              <i class="bi bi-arrow-right-circle me-1"></i>
              <%= utente != null && utente.isAdmin() ? "Gestisci Studenti" : "Visualizza Studenti" %>
            </a>
          </div>
        </div>
      </div>

    
      <div class="col-md-6 col-lg-4">
        <div class="card stat-card card-stripe-docenti h-100">
          <div class="card-body p-4">
            <div class="d-flex justify-content-between align-items-start mb-3">
              <div>
                <h5 class="fw-bold mb-1">Docenti</h5>
                <p class="text-muted small mb-0">Gestione anagrafica docenti</p>
              </div>
              <div class="card-icon text-primary"><i class="bi bi-person-badge-fill"></i></div>
            </div>
            <a href="Docente" class="btn btn-primary btn-sm w-100">
              <i class="bi bi-arrow-right-circle me-1"></i>
              <%= utente != null && utente.isAdmin() ? "Gestisci Docenti" : "Visualizza Docenti" %>
            </a>
          </div>
        </div>
      </div>

      <% if (utente != null && utente.isAdmin()) { %>
      
      <div class="col-md-6 col-lg-4">
        <div class="card stat-card card-stripe-ruoli h-100">
          <div class="card-body p-4">
            <div class="d-flex justify-content-between align-items-start mb-3">
              <div>
                <h5 class="fw-bold mb-1">Ruoli</h5>
                <p class="text-muted small mb-0">Configurazione ruoli sistema</p>
              </div>
              <div class="card-icon text-danger"><i class="bi bi-shield-lock-fill"></i></div>
            </div>
            <a href="Role" class="btn btn-danger btn-sm w-100">
              <i class="bi bi-arrow-right-circle me-1"></i>Gestisci Ruoli
            </a>
          </div>
        </div>
      </div>
      <% } %>

    
      <div class="col-md-6 col-lg-4">
        <div class="card stat-card card-stripe-info h-100">
          <div class="card-body p-4">
            <div class="d-flex justify-content-between align-items-start mb-3">
              <div>
                <h5 class="fw-bold mb-1">Il Tuo Profilo</h5>
                <p class="text-muted small mb-0">Informazioni account</p>
              </div>
              <div class="card-icon text-warning"><i class="bi bi-person-circle"></i></div>
            </div>
            <% if (utente != null) { %>
            <ul class="list-unstyled mb-3 small">
              <li><strong>Username:</strong> <%= utente.getUsername() %></li>
              <li><strong>Ruolo:</strong>
                <span class="badge
                  <%= utente.isAdmin() ? "bg-danger" : utente.isDocente() ? "bg-primary" : "bg-success" %>">
                  <%= utente.getRuolo() %>
                </span>
              </li>
              <li class="mt-1 text-muted">
                <% if (utente.isAdmin()) { %>
                  <i class="bi bi-check-circle-fill text-danger me-1"></i>Accesso completo al sistema
                <% } else { %>
                  <i class="bi bi-eye-fill text-muted me-1"></i>Sola consultazione
                <% } %>
              </li>
            </ul>
            <% } %>
          </div>
        </div>
      </div>

    </div>

  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
