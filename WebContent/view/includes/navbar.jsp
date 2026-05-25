<%@ page import="model.Utente" %>
<%
    Utente _u = (Utente) session.getAttribute("utente");
    String _ruoloBadge = "";
    String _badgeClass = "bg-secondary";
    if (_u != null) {
        _ruoloBadge = _u.getRuolo().substring(0,1).toUpperCase() + _u.getRuolo().substring(1);
        if (_u.isAdmin())    _badgeClass = "bg-danger";
        else if (_u.isDocente())  _badgeClass = "bg-primary";
        else _badgeClass = "bg-success";
    }
%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
  <div class="container-fluid">
    <a class="navbar-brand fw-bold" href="Dashboard">
      <i class="bi bi-mortarboard-fill me-2"></i>ScuolaWeb
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarMain">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarMain">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link" href="Dashboard"><i class="bi bi-house me-1"></i>Dashboard</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="Studente"><i class="bi bi-people me-1"></i>Studenti</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="Docente"><i class="bi bi-person-badge me-1"></i>Docenti</a>
        </li>
        <% if (_u != null && _u.isAdmin()) { %>
        <li class="nav-item">
          <a class="nav-link" href="Role"><i class="bi bi-shield-lock me-1"></i>Ruoli</a>
        </li>
        <% } %>
      </ul>
      <div class="d-flex align-items-center gap-3">
        <% if (_u != null) { %>
        <span class="text-white-50 small">
          <i class="bi bi-person-circle me-1"></i>
          <%= _u.getNome() %> <%= _u.getCognome() %>
          <span class="badge <%= _badgeClass %> ms-1"><%= _ruoloBadge %></span>
        </span>
        <% } %>
        <a href="Logout" class="btn btn-outline-light btn-sm">
          <i class="bi bi-box-arrow-right me-1"></i>Esci
        </a>
      </div>
    </div>
  </div>
</nav>
