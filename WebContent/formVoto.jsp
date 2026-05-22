<%@ page import="java.util.List" %>
<%@ page import="model.Studente" %>
<%@ page import="model.Voto" %>

<%
    Voto v = (Voto) request.getAttribute("voto");
    List<Studente> studenti = (List<Studente>) request.getAttribute("studenti");
    int idDocente = (int) request.getAttribute("idDocente");
    boolean editing = (v != null);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= editing ? "Modifica voto" : "Inserisci voto" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f3f5f8; }
        .form-panel {
            background: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 24px;
        }
    </style>
</head>
<body>
<div class="container mt-4 mb-5">
    <div class="d-flex justify-content-between align-items-start gap-3 flex-wrap mb-4">
        <div>
            <h2 class="mb-1"><%= editing ? "Modifica voto" : "Inserisci voto" %></h2>
            <p class="text-muted mb-0">Seleziona lo studente, la materia, il voto e la data della valutazione.</p>
        </div>
        <div class="d-flex gap-2">
            <a href="dashboard.jsp" class="btn btn-outline-secondary">Home</a>
            <a href="VotoServlet?action=list" class="btn btn-outline-primary">Torna ai voti</a>
        </div>
    </div>

    <form action="VotoServlet" method="post" class="form-panel">
        <input type="hidden" name="action" value="<%= editing ? "update" : "insert" %>">

        <% if (editing) { %>
            <input type="hidden" name="id" value="<%= v.getId() %>">
        <% } %>

        <input type="hidden" name="idDocente" value="<%= idDocente %>">

        <div class="row g-3">
            <div class="col-md-6">
                <label class="form-label">Studente</label>
                <select name="idStudente" class="form-select" required>
                    <% if (studenti != null) {
                        for (Studente s : studenti) { %>
                            <option value="<%= s.getId() %>"
                                <%= editing && v.getIdStudente() == s.getId() ? "selected" : "" %>>
                                <%= s.getCognome() %> <%= s.getNome() %>
                            </option>
                    <%  }
                    } %>
                </select>
            </div>

            <div class="col-md-6">
                <label class="form-label">Materia</label>
                <input type="text" name="materia" class="form-control"
                       value="<%= editing && v.getMateria() != null ? v.getMateria() : "" %>" required>
            </div>

            <div class="col-md-6">
                <label class="form-label">Voto</label>
                <input type="number" step="0.1" min="0" max="10"
                       name="voto" class="form-control"
                       value="<%= editing ? v.getVoto() : "" %>" required>
            </div>

            <div class="col-md-6">
                <label class="form-label">Data</label>
                <input type="date" name="data" class="form-control"
                       value="<%= editing && v.getData() != null ? v.getData() : "" %>" required>
            </div>
        </div>

        <div class="mt-4 d-flex gap-2">
            <button class="btn btn-success">Salva</button>
            <a href="VotoServlet?action=list" class="btn btn-outline-secondary">Annulla</a>
        </div>
    </form>
</div>
</body>
</html>
