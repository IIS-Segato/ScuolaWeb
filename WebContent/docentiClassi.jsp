<%@ page import="java.util.List" %>
<%@ page import="model.Docente" %>
<%@ page import="model.Classe" %>

<%
    List<Docente> docenti = (List<Docente>) request.getAttribute("docenti");
    List<Classe> classi = (List<Classe>) request.getAttribute("classi");
%>

<h2 class="mb-4">Assegna Docenti alle Classi</h2>

<form action="ClasseServlet" method="post">

    <input type="hidden" name="action" value="assegna">

    <div class="mb-3">
        <label>Docente</label>
        <select name="idDocente" class="form-control">
            <% for (Docente d : docenti) { %>
                <option value="<%= d.getId() %>">
                    <%= d.getCognome() %> <%= d.getNome() %>
                </option>
            <% } %>
        </select>
    </div>

    <div class="mb-3">
        <label>Classe</label>
        <select name="idClasse" class="form-control">
            <% for (Classe c : classi) { %>
                <option value="<%= c.getId() %>">
                    <%= c.getNome() %>
                </option>
            <% } %>
        </select>
    </div>

    <button class="btn btn-success">Assegna</button>
</form>
