<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%
    List<User> utenti = (List<User>) request.getAttribute("utenti");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestione Utenti</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">Gestione Utenti</h2>
        <div>
            <a href="dashboard.jsp" class="btn btn-outline-secondary">Home</a>
            <a href="UserServlet?action=add" class="btn btn-primary">Aggiungi utente</a>
        </div>
    </div>

    <% if (utenti == null || utenti.isEmpty()) { %>
        <div class="alert alert-info">Nessun utente disponibile.</div>
    <% } else { %>
        <table class="table table-bordered table-hover bg-white align-middle">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Ruolo</th>
                    <th>ID studente</th>
                    <th>ID docente</th>
                </tr>
            </thead>
            <tbody>
            <% for (User u : utenti) {
                String ruolo = "";
                switch (u.getRoleId()) {
                    case 1: ruolo = "Preside"; break;
                    case 2: ruolo = "Insegnante"; break;
                    case 3: ruolo = "Segreteria"; break;
                    case 4: ruolo = "Studente"; break;
                    default: ruolo = "Sconosciuto";
                }
            %>
                <tr>
                    <td><%= u.getId() %></td>
                    <td><%= u.getUsername() %></td>
                    <td><%= ruolo %></td>
                    <td><%= u.getIdStudente() > 0 ? u.getIdStudente() : "-" %></td>
                    <td><%= u.getIdDocente() > 0 ? u.getIdDocente() : "-" %></td>
                </tr>
            <% } %>
            </tbody>
        </table>
    <% } %>
</div>
</body>
</html>
