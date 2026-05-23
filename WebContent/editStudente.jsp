<%@ page import="java.util.List" %>
<%@ page import="model.Studente, model.Classe" %>
<%
    Studente studente = (Studente) request.getAttribute("studente");
    if (studente == null) {
        studente = (Studente) request.getAttribute("studenteEdit");
    }
    List<Classe> classi = (List<Classe>) request.getAttribute("classi");
    Classe classeAttuale = studente != null ? studente.getClasse() : null;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifica Studente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">Modifica Studente</h2>
        <a href="StudenteServlet?action=list" class="btn btn-outline-secondary">Torna agli studenti</a>
    </div>

    <% if (studente == null) { %>
        <div class="alert alert-warning">Studente non trovato</div>
    <% } else { %>
        <form action="StudenteServlet" method="post" class="bg-white border rounded p-4">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= studente.getId() %>">

            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label">Cognome</label>
                    <input type="text" name="cognome" class="form-control" value="<%= studente.getCognome() %>" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Nome</label>
                    <input type="text" name="nome" class="form-control" value="<%= studente.getNome() %>" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Classe</label>
                    <select name="idClasse" class="form-select" required>
                        <% if (classi != null) {
                            for (Classe classe : classi) {
                                boolean selected = classeAttuale != null && classeAttuale.getId() == classe.getId();
                        %>
                            <option value="<%= classe.getId() %>" <%= selected ? "selected" : "" %>>
                                <%= classe.getNome() %>
                            </option>
                        <%  }
                        } %>
                    </select>
                </div>
            </div>

            <div class="mt-4 d-flex gap-2">
                <button type="submit" class="btn btn-success">Salva modifiche</button>
                <a href="StudenteServlet?action=list" class="btn btn-outline-secondary">Annulla</a>
            </div>
        </form>
    <% } %>
</div>
</body>
</html>
