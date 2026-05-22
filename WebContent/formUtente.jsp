<%@ page import="java.util.List" %>
<%@ page import="model.Studente, model.Docente" %>
<%
    List<Studente> studenti = (List<Studente>) request.getAttribute("studenti");
    List<Docente> docenti = (List<Docente>) request.getAttribute("docenti");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Aggiungi Utente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">Aggiungi Utente</h2>
        <a href="dashboard.jsp" class="btn btn-outline-secondary">Home</a>
    </div>

    <form action="UserServlet" method="post" class="bg-white border rounded p-4">
        <input type="hidden" name="action" value="insert">

        <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text" name="username" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="text" name="password" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Ruolo</label>
            <select name="roleId" class="form-select" required>
                <option value="1">Preside</option>
                <option value="2">Insegnante</option>
                <option value="3">Segreteria</option>
                <option value="4">Studente</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Studente collegato</label>
            <select name="idStudente" class="form-select">
                <option value="">Nessuno</option>
                <% if (studenti != null) {
                    for (Studente s : studenti) { %>
                        <option value="<%= s.getId() %>"><%= s.getCognome() %> <%= s.getNome() %></option>
                <%  }
                } %>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Docente collegato</label>
            <select name="idDocente" class="form-select">
                <option value="">Nessuno</option>
                <% if (docenti != null) {
                    for (Docente d : docenti) { %>
                        <option value="<%= d.getId() %>"><%= d.getCognome() %> <%= d.getNome() %></option>
                <%  }
                } %>
            </select>
        </div>

        <button class="btn btn-success">Salva</button>
        <a href="UserServlet?action=list" class="btn btn-outline-secondary">Annulla</a>
    </form>
</div>
</body>
</html>
