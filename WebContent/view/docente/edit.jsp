<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Docente, utils.StringUtils" %>
<%
    Docente docente = (Docente) request.getAttribute("docente");
    if (docente == null) docente = new Docente();
    String action = (String) request.getAttribute("action");
    boolean isInsert = "INSERT".equals(action);
    String errore = (String) request.getAttribute("errore");
    String pageTitle = isInsert ? "Nuovo Docente" : "Modifica Docente";
    String[] materie = {
        "Italiano","Storia","Geografia","Matematica","Scienze","Fisica","Chimica",
        "Inglese","Francese","Spagnolo","Tedesco","Arte","Musica","Educazione Fisica",
        "Informatica","Filosofia","Latino","Greco","Economia","Diritto","Tecnologia"
    };
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
          <a href="Docente" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i>Torna all'elenco
          </a>
        </div>

        <div class="card border-0 shadow-sm">
          <div class="card-header bg-primary text-white py-3">
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

            <form action="Docente" method="post" novalidate>
              <input type="hidden" name="id" value="<%= docente.getId() %>">
              <input type="hidden" name="action" value="<%= action %>">

              <div class="mb-3">
                <label for="nome" class="form-label fw-semibold">
                  <i class="bi bi-person me-1"></i>Nome <span class="text-danger">*</span>
                </label>
                <input type="text" class="form-control" id="nome" name="nome"
                       value="<%= docente.getNome() != null ? docente.getNome() : StringUtils.STRING_EMPTY %>"
                       placeholder="Inserisci il nome" required>
              </div>

              <div class="mb-3">
                <label for="cognome" class="form-label fw-semibold">
                  <i class="bi bi-person me-1"></i>Cognome <span class="text-danger">*</span>
                </label>
                <input type="text" class="form-control" id="cognome" name="cognome"
                       value="<%= docente.getCognome() != null ? docente.getCognome() : StringUtils.STRING_EMPTY %>"
                       placeholder="Inserisci il cognome" required>
              </div>

              <div class="mb-4">
                <label for="materia" class="form-label fw-semibold">
                  <i class="bi bi-book me-1"></i>Materia <span class="text-danger">*</span>
                </label>
                <input type="text" class="form-control" id="materiaInput" name="materia"
                       value="<%= docente.getMateria() != null ? docente.getMateria() : StringUtils.STRING_EMPTY %>"
                       placeholder="es. Matematica, Italiano..." required list="materieList">
                <datalist id="materieList">
                  <% for (String m : materie) { %>
                  <option value="<%= m %>">
                  <% } %>
                </datalist>
                <div class="form-text">Seleziona dall'elenco o digita liberamente</div>
              </div>

              <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary fw-semibold">
                  <i class="bi bi-check-circle me-1"></i>Salva
                </button>
                <button type="reset" class="btn btn-outline-secondary">
                  <i class="bi bi-arrow-counterclockwise me-1"></i>Reset
                </button>
                <a href="Docente" class="btn btn-outline-danger ms-auto">
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
    document.querySelector('form').addEventListener('submit', function(e) {
      const fields = ['nome','cognome','materiaInput'];
      let valid = true;
      fields.forEach(id => {
        const el = document.getElementById(id);
        if (!el.value.trim()) { el.classList.add('is-invalid'); valid = false; }
        else el.classList.remove('is-invalid');
      });
      if (!valid) e.preventDefault();
    });
  </script>
</body>
</html>
