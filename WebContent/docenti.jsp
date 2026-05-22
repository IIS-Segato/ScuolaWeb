<%@ page import="java.util.List, java.util.Map" %>
<%@ page import="model.Docente, model.Classe, model.Studente, model.User" %>
<%
    List<Docente> docenti = (List<Docente>) request.getAttribute("docenti");
    Map<Integer, List<Classe>> classiPerDocente = (Map<Integer, List<Classe>>) request.getAttribute("classiPerDocente");
    Map<Integer, List<Studente>> studentiPerClasse = (Map<Integer, List<Studente>>) request.getAttribute("studentiPerClasse");
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Docenti e Classi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">Docenti, classi e studenti</h2>
        <div>
            <a href="dashboard.jsp" class="btn btn-outline-secondary">Home</a>
            <% if (user != null && (user.getRoleId() == 1 || user.getRoleId() == 3)) { %>
                <a href="DocenteServlet?action=add" class="btn btn-primary">Aggiungi docente</a>
            <% } %>
        </div>
    </div>

    <% if (docenti == null || docenti.isEmpty()) { %>
        <div class="alert alert-info">Nessun docente disponibile.</div>
    <% } else {
        for (Docente d : docenti) {
            List<Classe> classi = classiPerDocente != null ? classiPerDocente.get(d.getId()) : null;
    %>
        <div class="card mb-4 shadow-sm">
            <div class="card-header bg-dark text-white">
                <strong><%= d.getCognome() %> <%= d.getNome() %></strong>
            </div>
            <div class="card-body">
                <% if (classi == null || classi.isEmpty()) { %>
                    <p class="mb-0"><em>Nessuna classe assegnata.</em></p>
                <% } else {
                    for (Classe c : classi) {
                        List<Studente> studenti = studentiPerClasse != null ? studentiPerClasse.get(c.getId()) : null;
                %>
                    <h5 class="mt-3">Classe <%= c.getNome() %></h5>
                    <% if (studenti == null || studenti.isEmpty()) { %>
                        <p><em>Nessuno studente in questa classe.</em></p>
                    <% } else { %>
                        <div class="table-responsive">
                            <table class="table table-sm table-striped table-bordered align-middle">
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
                        </div>
                    <% } %>
                <%  }
                } %>
            </div>
        </div>
    <%  }
    } %>
</div>
</body>
</html>
