<%@ page import="java.util.List" %>
<%@ page import="model.Voto, model.User, model.Studente, model.Docente" %>

<%
    List<Voto> voti = (List<Voto>) request.getAttribute("voti");
    User u = (User) session.getAttribute("user");
%>

<h2 class="mb-4">Elenco Voti</h2>
<div class="mb-3">
    <a href="dashboard.jsp" class="btn btn-outline-secondary">Home</a>
</div>

<% if (u == null) { %>
    <div class="alert alert-warning">Sessione scaduta. Effettua il login.</div>
<% } else { %>

    <% if (u.getRoleId() == 2) { %>
        <a href="VotoServlet?action=add" class="btn btn-primary mb-3">Aggiungi Voto</a>
    <% } %>

    <% if (voti == null || voti.isEmpty()) { %>
        <div class="alert alert-info">Nessun voto disponibile.</div>
    <% } else { %>

        <table class="table table-hover table-bordered align-middle">
            <thead class="table-dark">
                <tr>
                    <% if (u.getRoleId() != 4) { %>
                        <th>Studente</th>
                    <% } %>
                    <th>Materia</th>
                    <th>Voto</th>
                    <th>Data</th>
                    <% if (u.getRoleId() != 2) { %>
                        <th>Professore</th>
                    <% } %>
                    <% if (u.getRoleId() == 2) { %>
                        <th style="width: 160px;">Azioni</th>
                    <% } %>
                </tr>
            </thead>

            <tbody>
                <% for (Voto v : voti) {
                       Studente s = v != null ? v.getStudente() : null;
                       Docente d = v != null ? v.getDocente() : null;
                %>
                    <tr>
                        <% if (u.getRoleId() != 4) { %>
                            <td>
                                <% if (s != null) { %>
                                    <strong><%= s.getCognome() != null ? s.getCognome() : "" %></strong>
                                    <%= s.getNome() != null ? s.getNome() : "" %>
                                <% } else { %>
                                    <em>Studente non disponibile</em>
                                <% } %>
                            </td>
                        <% } %>
                        <td><%= v != null && v.getMateria() != null ? v.getMateria() : "-" %></td>
                        <td>
                            <span class="badge bg-primary fs-6">
                                <%= v != null ? v.getVoto() : "-" %>
                            </span>
                        </td>
                        <td><%= v != null && v.getData() != null ? v.getData().toString() : "-" %></td>
                        <% if (u.getRoleId() != 2) { %>
                            <td>
                                <% if (d != null) { %>
                                    <strong><%= d.getCognome() != null ? d.getCognome() : "" %></strong>
                                    <%= d.getNome() != null ? d.getNome() : "" %>
                                <% } else { %>
                                    <em>Docente non disponibile</em>
                                <% } %>
                            </td>
                        <% } %>

                        <% if (u.getRoleId() == 2) { %>
                            <td>
                                <a href="VotoServlet?action=edit&id=<%= v != null ? v.getId() : 0 %>"
                                   class="btn btn-warning btn-sm me-1">Modifica</a>

                                <a href="VotoServlet?action=delete&id=<%= v != null ? v.getId() : 0 %>"
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

    <% } %>

<% } %>
