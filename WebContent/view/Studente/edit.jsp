<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Studente, utils.StringUtils" %>
<%
    Studente studente = (Studente) request.getAttribute("studente");
    if (studente == null) studente = new Studente();
    String action = (String) request.getAttribute("action");
    boolean isInsert = "INSERT".equals(action);
    String errore = (String) request.getAttribute("errore");
    String pageTitle = isInsert ? "Nuovo Studente" : "Modifica Studente";
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
          <a href="Studente" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i>Torna all'elenco
          </a>
        </div>

        <div class="card border-0 shadow-sm">
          <div class="card-header bg-success text-white py-3">
            <h5 class="mb-0 fw-bold">
              <i class="bi bi-<%= isInsert ? "plus-circle" : "pencil" %>-fill me-2"></i>
              <%= pageTitle %>
            </h5>
          </div>
          <div class="card-body p-4">

            <% if (errore != null) { %>
            <div class="alert alert-danger d-flex align-items-center">
              <i class="bi bi-exclamation-triangle-fill me-2"></i><%= errore %>
            </div>
            <% } %>

            <form action="Studente" method="post" novalidate>
              <input type="hidden" name="id" value="<%= studente.getId() %>">
              <input type="hidden" name="action" value="<%= action %>">

              <div class="mb-3">
                <label for="nome" class="form-label fw-semibold">
                  <i class="bi bi-person me-1"></i>Nome <span class="text-danger">*</span>
                </label>
                <input type="text" class="form-control" id="nome" name="nome"
                       value="<%= studente.getNome() != null ? studente.getNome() : StringUtils.STRING_EMPTY %>"
                       placeholder="Inserisci il nome" required>
              </div>

              <div class="mb-3">
                <label for="cognome" class="form-label fw-semibold">
                  <i class="bi bi-person me-1"></i>Cognome <span class="text-danger">*</span>
                </label>
                <input type="text" class="form-control" id="cognome" name="cognome"
                       value="<%= studente.getCognome() != null ? studente.getCognome() : StringUtils.STRING_EMPTY %>"
                       placeholder="Inserisci il cognome" required>
              </div>

              <div class="mb-4">
                <label for="classe" class="form-label fw-semibold">
                  <i class="bi bi-bookmark me-1"></i>Classe <span class="text-danger">*</span>
                </label>
                <input type="text" class="form-control" id="classe" name="classe"
                       value="<%= studente.getClasse() != null ? studente.getClasse() : StringUtils.STRING_EMPTY %>"
                       placeholder="es. 3A, 4B, 5C" required maxlength="10">
                <div class="form-text">Formato consigliato: anno + sezione (es. 3A)</div>
              </div>

              <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success fw-semibold">
                  <i class="bi bi-check-circle me-1"></i>Salva
                </button>
                <button type="reset" class="btn btn-outline-secondary">
                  <i class="bi bi-arrow-counterclockwise me-1"></i>Reset
                </button>
                <a href="Studente" class="btn btn-outline-danger ms-auto">
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
  <script>
    // Client-side validation
    document.querySelector('form').addEventListener('submit', function(e) {
      const fields = ['nome','cognome','classe'];
      let valid = true;
      fields.forEach(f => {
        const el = document.getElementById(f);
        if (!el.value.trim()) {
          el.classList.add('is-invalid');
          valid = false;
        } else {
          el.classList.remove('is-invalid');
        }
      });
      if (!valid) e.preventDefault();
    });
  </script>
</body>
</html>
