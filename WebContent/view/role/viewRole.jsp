<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>

<%
    // Recupero utente dalla sessione
    User user = (User) session.getAttribute("user");

    if (user == null) {
        // Se non loggato → torna al login
        response.sendRedirect("login.jsp");
        return;
    }

    String ruolo = "";
    switch (user.getRoleId()) {
        case 1: ruolo = "Preside"; break;
        case 2: ruolo = "Insegnante"; break;
        case 3: ruolo = "Segreteria"; break;
        case 4: ruolo = "Studente"; break;
        default: ruolo = "Sconosciuto"; break;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ruolo Utente</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow">
        <div class="card-body">

            <h3 class="mb-3">Benvenuto, <%= user.getUsername() %></h3>

            <p><strong>Il tuo ruolo:</strong> <%= ruolo %></p>

            <hr>

            <!-- MENU DINAMICO IN BASE AL RUOLO -->
            <%
                if (user.getRoleId() == 1) {
            %>
                <a href="dashboard_admin.jsp" class="btn btn-primary">Dashboard Preside</a>
            <%
                } else if (user.getRoleId() == 2) {
            %>
                <a href="dashboard_teacher.jsp" class="btn btn-success">Dashboard Insegnante</a>
            <%
                } else if (user.getRoleId() == 4) {
            %>
                <a href="dashboard_student.jsp" class="btn btn-info">Dashboard Studente</a>
            <%
                }
            %>

            <a href="logout" class="btn btn-danger float-end">Logout</a>

        </div>
    </div>

</div>

</body>
</html>
