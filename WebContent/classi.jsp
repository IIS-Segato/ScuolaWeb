<%@ page import="java.util.List" %>
<%@ page import="model.Classe" %>

<%
    List<Classe> classi = (List<Classe>) request.getAttribute("classi");
%>

<h2 class="mb-4">Elenco Classi</h2>

<table class="table table-striped">
    <thead>
        <tr>
            <th>ID</th>
            <th>Nome Classe</th>
            <th>Azioni</th>
        </tr>
    </thead>

    <tbody>
        <% for (Classe c : classi) { %>
            <tr>
                <td><%= c.getId() %></td>
                <td><%= c.getNome() %></td>
                <td>
                    <a href="ClasseServlet?action=studenti&id=<%= c.getId() %>" 
                       class="btn btn-primary btn-sm">
                       Studenti
                    </a>
                </td>
            </tr>
        <% } %>
    </tbody>
</table>
