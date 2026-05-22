<%@ page import="java.util.List" %>
<%@ page import="model.Classe" %>
<%
    List<Classe> classi = (List<Classe>) request.getAttribute("classi");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Aggiungi Docente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">Aggiungi Docente</h2>
        <a href="dashboard.jsp" class="btn btn-outline-secondary">Home</a>
    </div>

    <form action="DocenteServlet" method="post" class="bg-white border rounded p-4">
        <input type="hidden" name="action" value="insert">

        <div class="mb-3">
            <label class="form-label">Nome</label>
            <input type="text" name="nome" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Cognome</label>
            <input type="text" name="cognome" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Classi assegnate</label>
            <select name="idClassi" class="form-select" multiple size="4">
                <% if (classi != null) {
                    for (Classe c : classi) { %>
                        <option value="<%= c.getId() %>"><%= c.getNome() %></option>
                <%  }
                } %>
            </select>
        </div>

        <button class="btn btn-success">Salva</button>
        <a href="DocenteServlet?action=list" class="btn btn-outline-secondary">Annulla</a>
    </form>
</div>
</body>
</html>
