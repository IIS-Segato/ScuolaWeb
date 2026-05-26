<%@ page import="java.util.List" %>
<%@ page import="model.Nota, model.Studente, model.Classe" %>
<%@ page import="utils.StringUtils" %>

<%
    Nota nota = (Nota) request.getAttribute("nota");
    List<Studente> studenti = (List<Studente>) request.getAttribute("studenti");
    String error = (String) request.getAttribute("error");
    String dataOggi = (String) request.getAttribute("dataOggi");
    String oraAdesso = (String) request.getAttribute("oraAdesso");
    boolean editing = nota != null && nota.getId() > 0;
    String dataValue = editing && nota.getData() != null ? nota.getData().toString()
            : (nota != null && nota.getData() != null ? nota.getData().toString() : dataOggi);
    String oraValue = editing && nota.getOra() != null ? nota.getOra().toString().substring(0, 5)
            : (nota != null && nota.getOra() != null ? nota.getOra().toString().substring(0, 5) : oraAdesso);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= editing ? "Modifica nota" : "Inserisci nota" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f3f5f8; }
        .form-panel {
            background: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 24px;
        }
    </style>
</head>
<body>
<div class="container mt-4 mb-5">
    <div class="d-flex justify-content-between align-items-start gap-3 flex-wrap mb-4">
        <div>
            <h2 class="mb-1"><%= editing ? "Modifica nota" : "Inserisci nota" %></h2>
            <p class="text-muted mb-0">Seleziona alunno, tipo di nota, calendario e ora.</p>
        </div>
        <div class="d-flex gap-2">
            <a href="dashboard.jsp" class="btn btn-outline-secondary">Home</a>
            <a href="NotaServlet?action=list" class="btn btn-outline-primary">Torna alle note</a>
        </div>
    </div>

    <% if (error != null) { %>
        <div class="alert alert-danger"><%= StringUtils.escapeHtml(error) %></div>
    <% } %>

    <form action="NotaServlet" method="post" class="form-panel">
        <input type="hidden" name="action" value="<%= editing ? "update" : "insert" %>">

        <% if (editing) { %>
            <input type="hidden" name="id" value="<%= nota.getId() %>">
        <% } %>

        <div class="row g-3">
            <div class="col-md-6">
                <label class="form-label">Alunno</label>
                <select name="idStudente" class="form-select" required>
                    <option value="">Seleziona alunno</option>
                    <% if (studenti != null) {
                        for (Studente s : studenti) {
                            Classe c = s.getClasse();
                            String classe = c != null && c.getNome() != null ? c.getNome() : "Classe non disponibile";
                    %>
                            <option value="<%= s.getId() %>"
                                <%= nota != null && nota.getIdStudente() == s.getId() ? "selected" : "" %>>
                                <%= StringUtils.escapeHtml(s.getCognome()) %> <%= StringUtils.escapeHtml(s.getNome()) %> - <%= StringUtils.escapeHtml(classe) %>
                            </option>
                    <%  }
                    } %>
                </select>
            </div>

            <div class="col-md-6">
                <label class="form-label">Tipo nota</label>
                <select name="tipo" class="form-select" required>
                    <option value="GENERICA" <%= nota == null || "GENERICA".equals(nota.getTipo()) ? "selected" : "" %>>Generica</option>
                    <option value="DISCIPLINARE" <%= nota != null && "DISCIPLINARE".equals(nota.getTipo()) ? "selected" : "" %>>Disciplinare</option>
                </select>
            </div>

            <div class="col-md-6">
                <label class="form-label">Data</label>
                <input type="date" name="data" class="form-control"
                       value="<%= dataValue != null ? dataValue : "" %>" required>
            </div>

            <div class="col-md-6">
                <label class="form-label">Ora</label>
                <input type="time" name="ora" class="form-control"
                       value="<%= oraValue != null ? oraValue : "" %>" required>
            </div>

            <div class="col-12">
                <label class="form-label">Testo nota</label>
                <textarea name="testo" class="form-control" rows="6" maxlength="1000" required><%= nota != null ? StringUtils.escapeHtml(nota.getTesto()) : "" %></textarea>
            </div>
        </div>

        <% if (studenti == null || studenti.isEmpty()) { %>
            <div class="alert alert-warning mt-4 mb-0">Non hai alunni assegnati: non puoi inserire note.</div>
        <% } %>

        <div class="mt-4 d-flex gap-2">
            <button class="btn btn-success" <%= studenti == null || studenti.isEmpty() ? "disabled" : "" %>>Salva</button>
            <a href="NotaServlet?action=list" class="btn btn-outline-secondary">Annulla</a>
        </div>
    </form>
</div>
</body>
</html>
