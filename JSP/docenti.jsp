<%@ page import="java.util.List" %>
<%@ page import="model.Docente" %>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Docenti</title>

<link href=
"https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container mt-5">

    <h2 class="mb-4">

        Docenti

    </h2>

    <table class="table
                  table-bordered
                  table-striped
                  shadow">

        <thead class="table-success">

            <tr>

                <th>ID</th>
                <th>Nome</th>
                <th>Cognome</th>
                <th>Materia</th>

            </tr>

        </thead>

        <tbody>

        <%

        // Recupera lista docenti dalla servlet
        List<Docente> lista =
            (List<Docente>)
            request.getAttribute("docenti");

        // Ciclo stampa docenti
        for(Docente d : lista){

        %>

        <tr>

            <td><%= d.getId() %></td>

            <td><%= d.getNome() %></td>

            <td><%= d.getCognome() %></td>

            <td><%= d.getMateria() %></td>

        </tr>

        <% } %>

        </tbody>

    </table>

</div>

</body>

</html>