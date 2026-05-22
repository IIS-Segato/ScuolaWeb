<%@ page import="java.util.List" %>
<%@ page import="model.Voto, model.User, model.Studente, model.Docente" %>

<%
    List<Voto> voti = (List<Voto>) request.getAttribute("voti");
    User u = (User) session.getAttribute("user");
    int totaleVoti = voti != null ? voti.size() : 0;
    double somma = 0;

    if (voti != null) {
        for (Voto votoItem : voti) {
            if (votoItem != null) {
                somma += votoItem.getVoto();
            }
        }
    }

    double media = totaleVoti > 0 ? somma / totaleVoti : 0;
    String titolo = "Registro voti";
    String sottotitolo = "Consulta i voti registrati nel sistema.";

    if (u != null && u.getRoleId() == 4) {
        titolo = "I miei voti";
        sottotitolo = "Riepilogo dei voti assegnati dai professori.";
    } else if (u != null && u.getRoleId() == 2) {
        titolo = "Gestione voti";
        sottotitolo = "Inserisci, modifica e controlla i voti delle tue classi.";
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
        .page-header {
            background: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 24px;
        }
        .summary-box {
            background: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 16px;
        }
        .mark-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 58px;
            border-radius: 6px;
            padding: 8px 10px;
            font-weight: 700;
        }
        .mark-ok { background: #d1e7dd; color: #0f5132; }
        .mark-mid { background: #fff3cd; color: #664d03; }
        .mark-low { background: #f8d7da; color: #842029; }
        .table-card {
            background: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            overflow: hidden;
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
                        <a href="VotoServlet?action=add" class="btn btn-primary">Aggiungi voto</a>
                    <% } %>
                </div>
            </div>
        </div>

        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="summary-box">
                    <div class="text-muted small">Voti registrati</div>
                    <div class="fs-3 fw-bold"><%= totaleVoti %></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="summary-box">
                    <div class="text-muted small">Media</div>
                    <div class="fs-3 fw-bold"><%= totaleVoti > 0 ? String.format("%.2f", media) : "-" %></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="summary-box">
                    <div class="text-muted small">Esito generale</div>
                    <div class="fs-5 fw-semibold">
                        <%= totaleVoti == 0 ? "-" : (media >= 6 ? "Sufficiente" : "Da recuperare") %>
                    </div>
                </div>
            </div>
        </div>

        <% if (voti == null || voti.isEmpty()) { %>
            <div class="alert alert-info">Nessun voto disponibile.</div>
        <% } else { %>
            <div class="table-card">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <% if (u.getRoleId() != 4) { %>
                                <th>Studente</th>
                            <% } %>
                            <th>Materia</th>
                            <th>Voto</th>
                            <th>Data</th>
                            <% if (u.getRoleId() != 2) { %>
                                <th>Professore</th>
                            <% } %>
                            <% if (u.getRoleId() == 2) { %>
                                <th class="text-end">Azioni</th>
                            <% } %>
                        </tr>
                    </thead>

                    <tbody>
                        <% for (Voto v : voti) {
                               Studente s = v != null ? v.getStudente() : null;
                               Docente d = v != null ? v.getDocente() : null;
                               double valore = v != null ? v.getVoto() : 0;
                               String classeVoto = valore >= 6 ? "mark-ok" : (valore >= 5 ? "mark-mid" : "mark-low");
                        %>
                            <tr>
                                <% if (u.getRoleId() != 4) { %>
                                    <td>
                                        <% if (s != null) { %>
                                            <div class="fw-semibold"><%= s.getCognome() != null ? s.getCognome() : "" %> <%= s.getNome() != null ? s.getNome() : "" %></div>
                                        <% } else { %>
                                            <em>Studente non disponibile</em>
                                        <% } %>
                                    </td>
                                <% } %>
                                <td>
                                    <div class="fw-semibold"><%= v != null && v.getMateria() != null ? v.getMateria() : "-" %></div>
                                </td>
                                <td>
                                    <span class="mark-badge <%= classeVoto %>"><%= v != null ? String.format("%.2f", valore) : "-" %></span>
                                </td>
                                <td><%= v != null && v.getData() != null ? v.getData().toString() : "-" %></td>
                                <% if (u.getRoleId() != 2) { %>
                                    <td>
                                        <% if (d != null) { %>
                                            <div class="fw-semibold"><%= d.getCognome() != null ? d.getCognome() : "" %> <%= d.getNome() != null ? d.getNome() : "" %></div>
                                        <% } else { %>
                                            <em>Docente non disponibile</em>
                                        <% } %>
                                    </td>
                                <% } %>

                                <% if (u.getRoleId() == 2) { %>
                                    <td class="text-end">
                                        <a href="VotoServlet?action=edit&id=<%= v != null ? v.getId() : 0 %>"
                                           class="btn btn-outline-primary btn-sm">Modifica</a>

                                        <a href="VotoServlet?action=delete&id=<%= v != null ? v.getId() : 0 %>"
                                           class="btn btn-outline-danger btn-sm"
                                           onclick="return confirm('Eliminare questo voto?');">
                                           Elimina
                                        </a>
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
