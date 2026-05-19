<%@ page import="java.util.List" %>
<%@ page import="model.Studente" %>

<%
    List<Studente> studenti = (List<Studente>) request.getAttribute("studenti");
    String nomeClasse = (String) request.getAttribute("nomeClasse");
%>

<h2 class="mb-4">Studenti della classe <%= nomeClasse %></h2>

<table class="table table-striped">
    <thead>
        <tr>
            <th>ID</th>
            <th>Cognome</th>
            <th>Nome</th>
        </tr>
    </thead>

    <tbody>
        <% for (Studente s : studenti) { %>
            <tr>
                <td><%= s.getId() %></td>
                <td><%= s.getCognome() %></td>
                <td><%= s.getNome() %></td>
            </tr>
        <% } %>
    </tbody>
</table>
