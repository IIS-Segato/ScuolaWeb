<%@ page import="java.util.List" %>
<%@ page import="model.Studente" %>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Studenti</title>

<link href=
"https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container mt-5">

    <div class="d-flex
                justify-content-between
                mb-3">

        <h2>Studenti</h2>

        <!-- Pulsante aggiunta studente -->
        <a href="aggiungiStudente.jsp"
           class="btn btn-primary">

           Aggiungi Studente

        </a>

    </div>

    <table class="table
                  table-bordered
                  table-striped
                  shadow">

        <thead class="table-dark">

            <tr>

                <th>ID</th>
                <th>Nome</th>
                <th>Cognome</th>
                <th>Classe</th>
                <th>Azioni</th>

            </tr>

        </thead>

        <tbody>

        <%

        // Recupera la lista passata dalla servlet
        List<Studente> lista =
            (List<Studente>)
            request.getAttribute("studenti");

        // Ciclo per mostrare tutti gli studenti
        for(Studente s : lista){

        %>

        <tr>

            <td><%= s.getId() %></td>

            <td><%= s.getNome() %></td>

            <td><%= s.getCognome() %></td>

            <td><%= s.getClasse() %></td>

            <td>

                <!-- Modifica -->
                <a href="modificaStudente.jsp?id=<%= s.getId() %>"
                   class="btn btn-warning btn-sm">

                   Modifica

                </a>

                <!-- Eliminazione -->
                <a href="../studenti?action=delete&id=<%= s.getId() %>"
                   class="btn btn-danger btn-sm">

                   Elimina

                </a>

            </td>

        </tr>

        <% } %>

        </tbody>

    </table>

</div>

</body>

</html>