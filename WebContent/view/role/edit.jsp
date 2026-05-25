<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Role, model.Utente, utils.StringUtils" %>
<%
    Role role = (Role) request.getAttribute("role");
    if (role == null) role = new Role();
    String id = "0";
    if (request.getAttribute("id") != null) {
        id = Integer.toString((Integer) request.getAttribute("id"));
    }
    String action = (String) request.getAttribute("action");
    boolean isInsert = "INSERT".equals(action);
    String pageTitle = isInsert ? "Nuovo Ruolo" : "Modifica Ruolo";
%>
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>ScuolaWeb – <%= pageTitle %></title>
  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <style>body { background-color: #f0f2f5; }</style>
</head>
<body>
  <%@ include file="../includes/navbar.jsp" %>

  <div class="container py-4">
    <div class="row justify-content-center">
      <div class="col-md-8 col-lg-6">

        <div class="mb-3">
          <a href="Role" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i>Torna all'elenco
          </a>
        </div>

        <div class="card border-0 shadow-sm">
          <div class="card-header bg-danger text-white py-3">
            <h5 class="mb-0 fw-bold">
              <i class="bi bi-<%= isInsert ? "plus-circle" : "pencil" %>-fill me-2"></i>
              <%= pageTitle %>
            </h5>
          </div>
          <div class="card-body p-4">
            <form action="Role" method="post" novalidate>
              <input type="hidden" name="id" value="<%= id %>">
              <input type="hidden" name="action" value="<%= action %>">

              <div class="mb-3">
                <label for="role_name" class="form-label fw-semibold">
                  <i class="bi bi-shield me-1"></i>Nome Ruolo <span class="text-danger">*</span>
                </label>
                <input type="text" class="form-control" id="role_name" name="role_name"
                       value="<%= role.getRole_name() != null ? role.getRole_name() : StringUtils.STRING_EMPTY %>"
                       placeholder="es. admin, docente, studente" required>
              </div>

              <div class="mb-4">
                <label for="description" class="form-label fw-semibold">
                  <i class="bi bi-card-text me-1"></i>Descrizione
                </label>
                <textarea class="form-control" id="description" name="description"
                          rows="3" placeholder="Descrizione del ruolo..."><%= role.getDescription() != null ? role.getDescription() : StringUtils.STRING_EMPTY %></textarea>
              </div>

              <div class="d-flex gap-2">
                <button type="submit" class="btn btn-danger fw-semibold">
                  <i class="bi bi-check-circle me-1"></i>Salva
                </button>
                <button type="reset" class="btn btn-outline-secondary">
                  <i class="bi bi-arrow-counterclockwise me-1"></i>Reset
                </button>
                <a href="Role" class="btn btn-outline-secondary ms-auto">
                  <i class="bi bi-x-circle me-1"></i>Annulla
                </a>
              </div>
            </form>
          </div>
        </div>

      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> ciao

