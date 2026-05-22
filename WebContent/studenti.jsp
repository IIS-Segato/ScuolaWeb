<%@ page import="java.util.List" %>
<%@ page import="model.Studente, model.Classe" %>
<%
    List<Studente> studenti = (List<Studente>) request.getAttribute("studenti");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestione Studenti</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">Studenti</h2>
        <div>
            <a href="dashboard.jsp" class="btn btn-outline-secondary">Home</a>
            <a href="StudenteServlet?action=add" class="btn btn-primary">Aggiungi studente</a>
        </div>
    </div>

    <% if (studenti == null || studenti.isEmpty()) { %>
        <div class="alert alert-info">Nessuno studente disponibile.</div>
    <% } else { %>
        <table class="table table-bordered table-hover bg-white align-middle">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Cognome</th>
                    <th>Nome</th>
                    <th>Classe</th>
                </tr>
            </thead>
            <tbody>
            <% for (Studente s : studenti) {
                Classe c = s.getClasse();
            %>
                <tr>
                    <td><%= s.getId() %></td>
                    <td><%= s.getCognome() %></td>
                    <td><%= s.getNome() %></td>
                    <td><%= c != null && c.getNome() != null ? c.getNome() : "-" %></td>
                </tr>
            <% } %>
            </tbody>
        </table>
    <% } %>
</div>
</body>
</html>
