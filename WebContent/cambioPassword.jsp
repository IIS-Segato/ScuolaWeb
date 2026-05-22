<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ScuolaFacile - Cambia password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="mb-1">Cambia password</h2>
            <p class="text-muted mb-0">Aggiorna la password del tuo account ScuolaFacile.</p>
        </div>
        <a href="dashboard.jsp" class="btn btn-outline-secondary">Home</a>
    </div>

    <form action="CambioPasswordServlet" method="post" class="bg-white border rounded p-4">
        <%
            String error = (String) request.getAttribute("error");
            String success = (String) request.getAttribute("success");
            if (error != null) {
        %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>
        <% if (success != null) { %>
            <div class="alert alert-success"><%= success %></div>
        <% } %>

        <div class="mb-3">
            <label class="form-label">Password attuale</label>
            <input type="password" name="passwordAttuale" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Nuova password</label>
            <input type="password" name="nuovaPassword" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Conferma nuova password</label>
            <input type="password" name="confermaPassword" class="form-control" required>
        </div>

        <button class="btn btn-success">Salva password</button>
        <a href="StudenteServlet" class="btn btn-outline-secondary">Torna all'area personale</a>
    </form>
</div>
</body>
</html>
