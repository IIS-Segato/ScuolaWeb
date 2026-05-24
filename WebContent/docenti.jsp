<%@ page import="java.util.List, java.util.Map" %>
<%@ page import="model.Docente, model.Classe, model.Studente, model.User" %>
<%
    List<Docente> docenti = (List<Docente>) request.getAttribute("docenti");
    Docente docenteEdit = (Docente) request.getAttribute("docenteEdit");
    List<Classe> classi = (List<Classe>) request.getAttribute("classi");
    List<Classe> classiDocenteEdit = (List<Classe>) request.getAttribute("classiDocenteEdit");
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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
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

    <% if (docenteEdit != null) { %>
        <form action="DocenteServlet" method="post" class="bg-white border rounded p-4">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= docenteEdit.getId() %>">

            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label">Cognome</label>
                    <input type="text" name="cognome" class="form-control" value="<%= docenteEdit.getCognome() %>" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Nome</label>
                    <input type="text" name="nome" class="form-control" value="<%= docenteEdit.getNome() %>" required>
                </div>

                <div class="col-12">
                    <label class="form-label">Classi assegnate</label>
                    <div class="row g-2">
                        <% if (classi != null) {
                            for (Classe classe : classi) {
                                boolean checked = false;
                                if (classiDocenteEdit != null) {
                                    for (Classe assegnata : classiDocenteEdit) {
                                        if (assegnata.getId() == classe.getId()) {
                                            checked = true;
                                            break;
                                        }
                                    }
                                }
                        %>
                            <div class="col-sm-6 col-md-4 col-lg-3">
                                <div class="form-check border rounded bg-light p-3 ps-5">
                                    <input class="form-check-input" type="checkbox" name="idClassi"
                                           value="<%= classe.getId() %>" id="classe_<%= classe.getId() %>"
                                           <%= checked ? "checked" : "" %>>
                                    <label class="form-check-label" for="classe_<%= classe.getId() %>">
                                        <%= classe.getNome() %>
                                    </label>
                                </div>
                            </div>
                        <%  }
                        } %>
                    </div>
                </div>
            </div>

            <div class="mt-4 d-flex gap-2">
                <button type="submit" class="btn btn-success">Salva modifiche</button>
                <a href="DocenteServlet?action=list" class="btn btn-outline-secondary">Annulla</a>
            </div>
        </form>
    <% } else if (docenti == null || docenti.isEmpty()) { %>
        <div class="alert alert-info">Nessun docente disponibile.</div>
    <% } else {
        for (Docente d : docenti) {
            List<Classe> classiDocente = classiPerDocente != null ? classiPerDocente.get(d.getId()) : null;
    %>
        <div class="card mb-4 shadow-sm">
            <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">
                <strong><%= d.getCognome() %> <%= d.getNome() %></strong>
                <% if (user != null && (user.getRoleId() == 1 || user.getRoleId() == 3)) { %>
                    <a href="DocenteServlet?action=edit&id=<%= d.getId() %>"
                       class="btn btn-sm btn-outline-light"
                       title="Modifica docente">
                        <i class="bi bi-pencil-square"></i>
                        <span class="visually-hidden">Modifica</span>
                    </a>
                <% } %>
            </div>
            <div class="card-body">
                <% if (classiDocente == null || classiDocente.isEmpty()) { %>
                    <p class="mb-0"><em>Nessuna classe assegnata.</em></p>
                <% } else {
                    for (Classe c : classiDocente) {
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
                                        <th>Cognome</th>
                                        <th>Nome</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <% for (Studente s : studenti) { %>
                                    <tr>
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
