<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }

    String ruolo = "";
    switch(user.getRoleId()) {
        case 1: ruolo = "Preside"; break;
        case 2: ruolo = "Insegnante"; break;
        case 3: ruolo = "Segreteria"; break;
        case 4: ruolo = "Studente"; break;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

<style>
body {
    background: #eef1f5;
}

.card-hover:hover {
    transform: translateY(-5px);
    transition: 0.2s;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}
</style>

</head>
<body>

<div class="container mt-5">

    <h2 class="mb-4">Benvenuto, <%= user.getUsername() %></h2>
    <p class="text-muted">Ruolo: <strong><%= ruolo %></strong></p>

    <div class="row g-4">

        <%-- PRESIDE (ADMIN COMPLETO) --%>
        <% if(user.getRoleId() == 1) { %>
        <div class="col-md-4">
            <a href="UserServlet?action=list" class="text-decoration-none text-dark">
                <div class="card card-hover p-4">
                    <h4>Gestione Utenti</h4>
                    <p class="text-muted">Crea, modifica e gestisci gli utenti del sistema.</p>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="StudenteServlet?action=list" class="text-decoration-none text-dark">
                <div class="card card-hover p-4">
                    <h4>Studenti</h4>
                    <p class="text-muted">Visualizza e gestisci gli studenti.</p>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="DocenteServlet?action=list" class="text-decoration-none text-dark">
                <div class="card card-hover p-4">
                    <h4>Docenti</h4>
                    <p class="text-muted">Gestisci l’elenco dei docenti.</p>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="VotoServlet?action=list" class="text-decoration-none text-dark">
                <div class="card card-hover p-4">
                    <h4>Voti</h4>
                    <p class="text-muted">Consulta tutti i voti della scuola.</p>
                </div>
            </a>
        </div>
        <% } %>

        <%-- INSEGNANTE --%>
        <% if(user.getRoleId() == 2) { %>
        <div class="col-md-4">
            <a href="VotoServlet?action=list" class="text-decoration-none text-dark">
                <div class="card card-hover p-4">
                    <h4>Gestione Voti</h4>
                    <p class="text-muted">Inserisci, modifica ed elimina voti.</p>
                </div>
            </a>
        </div>
        <% } %>

        <%-- SEGRETERIA --%>
        <% if(user.getRoleId() == 3) { %>
        <div class="col-md-4">
            <a href="StudenteServlet?action=list" class="text-decoration-none text-dark">
                <div class="card card-hover p-4">
                    <h4>Studenti</h4>
                    <p class="text-muted">Gestione anagrafica studenti.</p>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="DocenteServlet?action=list" class="text-decoration-none text-dark">
                <div class="card card-hover p-4">
                    <h4>Docenti</h4>
                    <p class="text-muted">Gestione anagrafica docenti.</p>
                </div>
            </a>
        </div>
        <% } %>

        <%-- STUDENTE --%>
        <% if(user.getRoleId() == 4) { %>
        <div class="col-md-4">
            <a href="VotoServlet?action=list" class="text-decoration-none text-dark">
                <div class="card card-hover p-4">
                    <h4>I miei voti</h4>
                    <p class="text-muted">Consulta i voti assegnati dai docenti.</p>
                </div>
            </a>
        </div>
        <% } %>

        <%-- LOGOUT --%>
        <div class="col-md-4">
            <a href="logout" class="text-decoration-none text-dark">
                <div class="card card-hover p-4 bg-danger text-white">
                    <h4>Logout</h4>
                    <p>Esci dal sistema</p>
                </div>
            </a>
        </div>

    </div>

</div>

</body>
</html>
