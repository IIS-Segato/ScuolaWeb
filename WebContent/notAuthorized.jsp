<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Accesso non autorizzato</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f3f5f8; }
        .panel {
            background: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 24px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="panel">
        <h2 class="mb-2">Accesso non autorizzato</h2>
        <p class="text-muted">Non hai i permessi per eseguire questa operazione.</p>
        <% if (user == null) { %>
            <a href="login.jsp" class="btn btn-primary">Vai al login</a>
        <% } else { %>
            <a href="dashboard.jsp" class="btn btn-primary">Torna alla dashboard</a>
        <% } %>
    </div>
</div>
</body>
</html>
