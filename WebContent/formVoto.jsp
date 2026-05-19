<%@ page import="java.util.List" %>
<%@ page import="model.Voto" %>
<%@ page import="model.Studente" %>
<%@ page import="model.Docente" %>

<%
    Voto v = (Voto) request.getAttribute("voto");
    List<Studente> studenti = (List<Studente>) request.getAttribute("studenti");
    List<Docente> docenti = (List<Docente>) request.getAttribute("docenti");

    boolean editing = (v != null);
%>

<h2><%= editing ? "Modifica voto" : "Aggiungi voto" %></h2>

<form action="VotoServlet" method="post">

    <input type="hidden" name="action" value="<%= editing ? "update" : "insert" %>">

    <% if (editing) { %>
        <input type="hidden" name="id" value="<%= v.getId() %>">
    <% } %>

    <div class="mb-3">
        <label>Studente</label>
        <select name="idStudente" class="form-control" required>
            <% for (Studente s : studenti) { %>
                <option value="<%= s.getId() %>"
                    <%= editing && v.getIdStudente() == s.getId() ? "selected" : "" %>>
                    <%= s.getCognome() %> <%= s.getNome() %>
                </option>
            <% } %>
        </select>
    </div>

    <div class="mb-3">
        <label>Docente</label>
        <select name="idDocente" class="form-control" required>
            <% for (Docente d : docenti) { %>
                <option value="<%= d.getId() %>"
                    <%= editing && v.getIdDocente() == d.getId() ? "selected" : "" %>>
                    <%= d.getCognome() %> <%= d.getNome() %>
                </option>
            <% } %>
        </select>
    </div>

    <div class="mb-3">
        <label>Materia</label>
        <input type="text" name="materia" class="form-control"
               value="<%= editing ? v.getMateria() : "" %>" required>
    </div>

    <div class="mb-3">
        <label>Voto</label>
        <input type="number" step="0.1" name="voto" class="form-control"
               value="<%= editing ? v.getVoto() : "" %>" required>
    </div>

    <div class="mb-3">
        <label>Data</label>
        <input type="date" name="data" class="form-control"
               value="<%= editing ? v.getData() : "" %>" required>
    </div>

    <button type="submit" class="btn btn-success">Salva</button>
</form>
