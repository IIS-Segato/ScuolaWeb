<%@ page import="java.util.List" %>
<%@ page import="model.Studente, model.Classe" %>
<%
    List<Studente> studenti = (List<Studente>) request.getAttribute("studenti");
    Studente studenteEdit = (Studente) request.getAttribute("studenteEdit");
    List<Classe> classi = (List<Classe>) request.getAttribute("classi");
    Classe classeEdit = studenteEdit != null ? studenteEdit.getClasse() : null;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestione Studenti</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">Gestione Studenti</h2>
        <div>
            <a href="dashboard.jsp" class="btn btn-outline-secondary">Home</a>
            <a href="StudenteServlet?action=add" class="btn btn-primary">Aggiungi studente</a>
        </div>
    </div>

    <% if (studenteEdit != null) { %>
        <form action="StudenteServlet" method="post" class="bg-white border rounded p-4">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= studenteEdit.getId() %>">

            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label">Cognome</label>
                    <input type="text" name="cognome" class="form-control" value="<%= studenteEdit.getCognome() %>" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Nome</label>
                    <input type="text" name="nome" class="form-control" value="<%= studenteEdit.getNome() %>" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Classe</label>
                    <select name="idClasse" class="form-select" required>
                        <% if (classi != null) {
                            for (Classe classe : classi) {
                                boolean selected = classeEdit != null && classeEdit.getId() == classe.getId();
                        %>
                            <option value="<%= classe.getId() %>" <%= selected ? "selected" : "" %>>
                                <%= classe.getNome() %>
                            </option>
                        <%  }
                        } %>
                    </select>
                </div>
            </div>

            <div class="mt-4 d-flex gap-2">
                <button type="submit" class="btn btn-success">Salva modifiche</button>
                <a href="StudenteServlet?action=list" class="btn btn-outline-secondary">Annulla</a>
            </div>
        </form>
    <% } else if (studenti == null || studenti.isEmpty()) { %>
        <div class="alert alert-info">Nessuno studente disponibile.</div>
    <% } else { %>
        <% if (classi != null) {
            for (Classe classe : classi) {
                boolean classeConStudenti = false;
                for (Studente s : studenti) {
                    Classe c = s.getClasse();
                    if (c != null && c.getId() == classe.getId()) {
                        classeConStudenti = true;
                        break;
                    }
                }
        %>
            <div class="card mb-4 shadow-sm">
                <div class="card-header bg-dark text-white">
                    <strong>Classe <%= classe.getNome() %></strong>
                </div>
                <div class="card-body p-0">
                    <% if (!classeConStudenti) { %>
                        <p class="m-3"><em>Nessuno studente in questa classe.</em></p>
                    <% } else { %>
                        <table class="table table-bordered table-hover mb-0 align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Cognome</th>
                                    <th>Nome</th>
                                    <th class="text-center">Azioni</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% for (Studente s : studenti) {
                                Classe c = s.getClasse();
                                if (c != null && c.getId() == classe.getId()) {
                            %>
                                <tr>
                                    <td><%= s.getCognome() %></td>
                                    <td><%= s.getNome() %></td>
                                    <td class="text-center">
                                        <a href="StudenteServlet?action=edit&id=<%= s.getId() %>"
                                           class="btn btn-sm btn-outline-primary"
                                           title="Modifica studente">
                                            <i class="bi bi-pencil-square"></i>
                                            <span class="visually-hidden">Modifica</span>
                                        </a>
                                    </td>
                                </tr>
                            <%  }
                            } %>
                            </tbody>
                        </table>
                    <% } %>
                </div>
            </div>
        <%  }
        } %>
    <% } %>
</div>
</body>
</html>
