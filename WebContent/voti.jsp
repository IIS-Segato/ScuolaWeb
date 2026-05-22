<%@ page import="java.util.ArrayList, java.util.LinkedHashMap, java.util.List, java.util.Map" %>
<%@ page import="model.Voto, model.User, model.Studente, model.Docente, model.Classe" %>

<%
    List<Voto> voti = (List<Voto>) request.getAttribute("voti");
    List<Studente> studentiDocente = (List<Studente>) request.getAttribute("studentiDocente");
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
        sottotitolo = "Elenco per classi con studenti, voti registrati e media.";
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
        .page-header, .table-card, .class-panel {
            background: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
        }
        .page-header { padding: 24px; }
        .class-panel { overflow: hidden; }
        .class-title {
            background: #212529;
            color: #ffffff;
            padding: 14px 18px;
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
        .vote-chip {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 8px;
            margin: 0 8px 8px 0;
            background: #ffffff;
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

        <% if (u.getRoleId() == 2) { %>
            <%
                Map<Integer, List<Voto>> votiPerStudente = new LinkedHashMap<>();
                if (voti != null) {
                    for (Voto votoItem : voti) {
                        if (votoItem == null) {
                            continue;
                        }
                        Integer idStudente = votoItem.getIdStudente();
                        if (!votiPerStudente.containsKey(idStudente)) {
                            votiPerStudente.put(idStudente, new ArrayList<Voto>());
                        }
                        votiPerStudente.get(idStudente).add(votoItem);
                    }
                }

                Map<String, List<Studente>> studentiPerClasse = new LinkedHashMap<>();
                if (studentiDocente != null) {
                    for (Studente s : studentiDocente) {
                        Classe c = s.getClasse();
                        String nomeClasse = c != null && c.getNome() != null ? c.getNome() : "Classe non disponibile";
                        if (!studentiPerClasse.containsKey(nomeClasse)) {
                            studentiPerClasse.put(nomeClasse, new ArrayList<Studente>());
                        }
                        studentiPerClasse.get(nomeClasse).add(s);
                    }
                }
            %>

            <% if (studentiPerClasse.isEmpty()) { %>
                <div class="alert alert-info">Nessuna classe assegnata.</div>
            <% } else {
                for (Map.Entry<String, List<Studente>> entryClasse : studentiPerClasse.entrySet()) {
            %>
                <div class="class-panel mb-4">
                    <div class="class-title">
                        <h4 class="mb-0">Classe <%= entryClasse.getKey() %></h4>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th style="width: 24%;">Studente</th>
                                    <th>Voti</th>
                                    <th style="width: 120px;">Media</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Studente s : entryClasse.getValue()) {
                                    List<Voto> votiStudente = votiPerStudente.get(s.getId());
                                    double sommaStudente = 0;
                                    if (votiStudente != null) {
                                        for (Voto votoStudente : votiStudente) {
                                            sommaStudente += votoStudente.getVoto();
                                        }
                                    }
                                    double mediaStudente = votiStudente != null && !votiStudente.isEmpty() ? sommaStudente / votiStudente.size() : 0;
                                    String classeMedia = mediaStudente >= 6 ? "mark-ok" : (mediaStudente >= 5 ? "mark-mid" : "mark-low");
                                %>
                                    <tr>
                                        <td>
                                            <div class="fw-semibold"><%= s.getCognome() %> <%= s.getNome() %></div>
                                        </td>
                                        <td>
                                            <% if (votiStudente == null || votiStudente.isEmpty()) { %>
                                                <span class="text-muted">Nessun voto registrato.</span>
                                            <% } else {
                                                for (Voto votoStudente : votiStudente) {
                                                    double valore = votoStudente.getVoto();
                                                    String classeVoto = valore >= 6 ? "mark-ok" : (valore >= 5 ? "mark-mid" : "mark-low");
                                            %>
                                                <span class="vote-chip">
                                                    <span class="fw-semibold"><%= votoStudente.getMateria() %></span>
                                                    <span class="mark-badge <%= classeVoto %>"><%= String.format("%.2f", valore) %></span>
                                                    <span class="text-muted small"><%= votoStudente.getData() != null ? votoStudente.getData().toString() : "-" %></span>
                                                    <a href="VotoServlet?action=edit&id=<%= votoStudente.getId() %>" class="btn btn-outline-primary btn-sm">Modifica</a>
                                                    <a href="VotoServlet?action=delete&id=<%= votoStudente.getId() %>"
                                                       class="btn btn-outline-danger btn-sm"
                                                       onclick="return confirm('Eliminare questo voto?');">Elimina</a>
                                                </span>
                                            <%  }
                                            } %>
                                        </td>
                                        <td>
                                            <% if (votiStudente == null || votiStudente.isEmpty()) { %>
                                                <span class="text-muted">-</span>
                                            <% } else { %>
                                                <span class="mark-badge <%= classeMedia %>"><%= String.format("%.2f", mediaStudente) %></span>
                                            <% } %>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            <%  }
            } %>

        <% } else { %>
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
                                <th>Professore</th>
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
                                    <td>
                                        <% if (d != null) { %>
                                            <div class="fw-semibold"><%= d.getCognome() != null ? d.getCognome() : "" %> <%= d.getNome() != null ? d.getNome() : "" %></div>
                                        <% } else { %>
                                            <em>Docente non disponibile</em>
                                        <% } %>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        <% } %>

    <% } %>
</div>
</body>
</html>
