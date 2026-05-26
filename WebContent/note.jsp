<%@ page import="java.util.List" %>
<%@ page import="model.Nota, model.User, model.Studente, model.Docente, model.Classe" %>
<%@ page import="utils.StringUtils" %>

<%!
    private String labelTipo(String tipo) {
        return "DISCIPLINARE".equals(tipo) ? "Disciplinare" : "Generica";
    }

    private String formatOra(java.sql.Time ora) {
        if (ora == null) {
            return "-";
        }
        String value = ora.toString();
        return value.length() >= 5 ? value.substring(0, 5) : value;
    }
%>

<%
    List<Nota> note = (List<Nota>) request.getAttribute("note");
    User u = (User) session.getAttribute("user");
    int totaleNote = note != null ? note.size() : 0;
    int noteDisciplinari = 0;
    int noteGeneriche = 0;

    if (note != null) {
        for (Nota notaItem : note) {
            if (notaItem != null && "DISCIPLINARE".equals(notaItem.getTipo())) {
                noteDisciplinari++;
            } else if (notaItem != null) {
                noteGeneriche++;
            }
        }
    }

    String titolo = "Note alunni";
    String sottotitolo = "Consulta le note registrate.";

    if (u != null && u.getRoleId() == 4) {
        titolo = "Le mie note";
        sottotitolo = "Note generiche e disciplinari inserite dai professori.";
    } else if (u != null && u.getRoleId() == 2) {
        titolo = "Gestione note";
        sottotitolo = "Inserisci e controlla le note degli alunni delle tue classi.";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= titolo %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f3f5f8; }
        .page-header, .table-card, .summary-box {
            background: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
        }
        .page-header { padding: 24px; }
        .summary-box { padding: 16px; }
        .note-badge {
            display: inline-flex;
            align-items: center;
            border-radius: 6px;
            padding: 6px 10px;
            font-weight: 700;
            white-space: nowrap;
        }
        .note-disciplinary { background: #f8d7da; color: #842029; }
        .note-generic { background: #cff4fc; color: #055160; }
        .note-text {
            max-width: 520px;
            white-space: pre-wrap;
        }
    </style>
</head>
<body>
<div class="container mt-4 mb-5">

    <% if (u == null) { %>
        <div class="alert alert-warning">Sessione scaduta. Effettua il login.</div>
    <% } else { %>
        <div class="page-header mb-4">
            <div class="d-flex justify-content-between align-items-start gap-3 flex-wrap">
                <div>
                    <h2 class="mb-1"><%= titolo %></h2>
                    <p class="text-muted mb-0"><%= sottotitolo %></p>
                </div>
                <div class="d-flex gap-2">
                    <a href="dashboard.jsp" class="btn btn-outline-secondary">Home</a>
                    <% if (u.getRoleId() == 2) { %>
                        <a href="NotaServlet?action=add" class="btn btn-primary">Aggiungi nota</a>
                    <% } %>
                </div>
            </div>
        </div>

        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="summary-box">
                    <div class="text-muted small">Note totali</div>
                    <div class="fs-3 fw-bold"><%= totaleNote %></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="summary-box">
                    <div class="text-muted small">Disciplinari</div>
                    <div class="fs-3 fw-bold"><%= noteDisciplinari %></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="summary-box">
                    <div class="text-muted small">Generiche</div>
                    <div class="fs-3 fw-bold"><%= noteGeneriche %></div>
                </div>
            </div>
        </div>

        <% if (note == null || note.isEmpty()) { %>
            <div class="alert alert-info">Nessuna nota disponibile.</div>
        <% } else { %>
            <div class="table-card table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <% if (u.getRoleId() != 4) { %>
                                <th>Studente</th>
                                <th>Classe</th>
                            <% } %>
                            <th>Tipo</th>
                            <th>Data</th>
                            <th>Ora</th>
                            <th>Professore</th>
                            <th>Nota</th>
                            <% if (u.getRoleId() == 2) { %>
                                <th>Azioni</th>
                            <% } %>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Nota nota : note) {
                            Studente s = nota != null ? nota.getStudente() : null;
                            Classe c = s != null ? s.getClasse() : null;
                            Docente d = nota != null ? nota.getDocente() : null;
                            String badgeClass = nota != null && "DISCIPLINARE".equals(nota.getTipo()) ? "note-disciplinary" : "note-generic";
                        %>
                            <tr>
                                <% if (u.getRoleId() != 4) { %>
                                    <td>
                                        <% if (s != null) { %>
                                            <div class="fw-semibold"><%= StringUtils.escapeHtml(s.getCognome()) %> <%= StringUtils.escapeHtml(s.getNome()) %></div>
                                        <% } else { %>
                                            <em>Studente non disponibile</em>
                                        <% } %>
                                    </td>
                                    <td><%= c != null ? StringUtils.escapeHtml(c.getNome()) : "-" %></td>
                                <% } %>
                                <td>
                                    <span class="note-badge <%= badgeClass %>">
                                        <%= nota != null ? labelTipo(nota.getTipo()) : "-" %>
                                    </span>
                                </td>
                                <td><%= nota != null && nota.getData() != null ? nota.getData().toString() : "-" %></td>
                                <td><%= nota != null ? formatOra(nota.getOra()) : "-" %></td>
                                <td>
                                    <% if (d != null) { %>
                                        <div class="fw-semibold"><%= StringUtils.escapeHtml(d.getCognome()) %> <%= StringUtils.escapeHtml(d.getNome()) %></div>
                                    <% } else { %>
                                        <em>Docente non disponibile</em>
                                    <% } %>
                                </td>
                                <td class="note-text"><%= nota != null ? StringUtils.escapeHtml(nota.getTesto()) : "-" %></td>
                                <% if (u.getRoleId() == 2) { %>
                                    <td class="text-nowrap">
                                        <% if (nota != null && nota.getIdDocente() == u.getIdDocente()) { %>
                                            <a href="NotaServlet?action=edit&id=<%= nota.getId() %>" class="btn btn-outline-primary btn-sm">Modifica</a>
                                            <a href="NotaServlet?action=delete&id=<%= nota.getId() %>"
                                               class="btn btn-outline-danger btn-sm"
                                               onclick="return confirm('Eliminare questa nota?');">Elimina</a>
                                        <% } else { %>
                                            <span class="text-muted">Solo lettura</span>
                                        <% } %>
                                    </td>
                                <% } %>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>

    <% } %>
</div>
</body>
</html>
