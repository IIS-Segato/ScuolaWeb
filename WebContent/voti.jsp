<%@ page import="java.util.List" %>
<%@ page import="model.Voto" %>
<%@ page import="model.User" %>

<%
    List<Voto> voti = (List<Voto>) request.getAttribute("voti");
    User u = (User) session.getAttribute("user");
%>

<h2 class="mb-4">Elenco Voti</h2>

<% if (u.getRoleId() == 2) { %>
    <a href="VotoServlet?action=add" class="btn btn-primary mb-3">Aggiungi Voto</a>
<% } %>

<table class="table table-hover table-bordered align-middle">
    <thead class="table-dark">
        <tr>
            <th>Studente</th>
            <th>Materia</th>
            <th>Voto</th>
            <th>Data</th>

            <% if (u.getRoleId() == 2) { %>
                <th style="width: 160px;">Azioni</th>
            <% } %>
        </tr>
    </thead>

    <tbody>
        <% for (Voto v : voti) { %>
            <tr>
                <td>
                    <strong><%= v.getStudente().getCognome() %></strong>
                    <%= v.getStudente().getNome() %>
                </td>
                <td><%= v.getMateria() %></td>
                <td>
                    <span class="badge bg-primary fs-6">
                        <%= v.getVoto() %>
                    </span>
                </td>
                <td><%= v.getData() %></td>

                <% if (u.getRoleId() == 2) { %>
                    <td>
                        <a href="VotoServlet?action=edit&id=<%= v.getId() %>"
                           class="btn btn-warning btn-sm me-1">Modifica</a>

                        <a href="VotoServlet?action=delete&id=<%= v.getId() %>"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Eliminare questo voto?');">
                           Elimina
                        </a>
                    </td>
                <% } %>
            </tr>
        <% } %>
    </tbody>
</table>

