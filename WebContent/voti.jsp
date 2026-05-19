<%@ page import="java.util.List" %>
<%@ page import="model.Voto" %>
<%@ page import="model.User" %> 

<%
    List<Voto> voti = (List<Voto>) request.getAttribute("voti");
    User user = (User) session.getAttribute("user");
    int roleId = user.getRoleId();
%>

<h2 class="mb-4">
    <% if(roleId == 4) { %>
        I miei voti
    <% } else { %>
        Elenco voti
    <% } %>
</h2>

<% if(roleId == 2) { %>
    <a href="VotoServlet?action=add" class="btn btn-primary mb-3">Aggiungi voto</a>
<% } %>

<table class="table table-striped">
    <thead>
        <tr>
            <th>ID Studente</th>
            <th>ID Docente</th>
            <th>Materia</th>
            <th>Voto</th>
            <th>Data</th>
            <% if(roleId == 2) { %><th>Azioni</th><% } %>
        </tr>
    </thead>

    <tbody>
        <% for (Voto v : voti) { %>
            <tr>
                <td><%= v.getIdStudente() %></td>
                <td><%= v.getIdDocente() %></td>
                <td><%= v.getMateria() %></td>
                <td><%= v.getVoto() %></td>
                <td><%= v.getData() %></td>

                <% if(roleId == 2) { %>
                <td>
                    <a href="VotoServlet?action=edit&id=<%= v.getId() %>" class="btn btn-warning btn-sm">Modifica</a>
                    <a href="VotoServlet?action=delete&id=<%= v.getId() %>" class="btn btn-danger btn-sm">Elimina</a>
                </td>
                <% } %>
            </tr>
        <% } %>
    </tbody>
</table>

