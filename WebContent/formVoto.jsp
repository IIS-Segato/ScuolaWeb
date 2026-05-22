<%@ page import="java.util.List" %>
<%@ page import="model.Studente" %>
<%@ page import="model.Voto" %>

<%
    Voto v = (Voto) request.getAttribute("voto");
    List<Studente> studenti = (List<Studente>) request.getAttribute("studenti");
    int idDocente = (int) request.getAttribute("idDocente");
    boolean editing = (v != null);
%>

<h2 class="mb-4"><%= editing ? "Modifica Voto" : "Inserisci Voto" %></h2>
<div class="mb-3">
    <a href="dashboard.jsp" class="btn btn-outline-secondary">Home</a>
</div>

<form action="VotoServlet" method="post">

    <input type="hidden" name="action" value="<%= editing ? "update" : "insert" %>">

    <% if (editing) { %>
        <input type="hidden" name="id" value="<%= v.getId() %>">
    <% } %>

    <!-- ID DOCENTE (nascosto) -->
    <input type="hidden" name="idDocente" value="<%= idDocente %>">

    <!-- STUDENTE -->
    <div class="mb-3">
        <label class="form-label">Studente</label>
        <select name="idStudente" class="form-control" required>
            <% for (Studente s : studenti) { %>
                <option value="<%= s.getId() %>"
                    <%= editing && v.getIdStudente() == s.getId() ? "selected" : "" %>>
                    <%= s.getCognome() %> <%= s.getNome() %>
                </option>
            <% } %>
        </select>
    </div>

    <!-- MATERIA -->
    <div class="mb-3">
        <label class="form-label">Materia</label>
        <input type="text" name="materia" class="form-control"
               value="<%= editing ? v.getMateria() : "" %>" required>
    </div>

    <!-- VOTO -->
    <div class="mb-3">
        <label class="form-label">Voto</label>
        <input type="number" step="0.1" min="0" max="10"
       name="voto" class="form-control"
       value="<%= editing ? v.getVoto() : "" %>" required>

    </div>

    <!-- DATA -->
    <div class="mb-3">
        <label class="form-label">Data</label>
        <input type="date" name="data" class="form-control"
               value="<%= editing ? v.getData() : "" %>" required>
    </div>

    <button class="btn btn-success">Salva</button>
</form>
