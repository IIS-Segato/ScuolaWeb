<%@ page import="model.Studente, model.Classe, model.Docente, model.Voto, java.util.List" %>
<%
    Studente studente = (Studente) request.getAttribute("studente");
    Classe classe = (Classe) request.getAttribute("classe");
    List<Docente> professori = (List<Docente>) request.getAttribute("professori");
    List<Voto> voti = (List<Voto>) request.getAttribute("voti");
    List<Studente> compagni = (List<Studente>) request.getAttribute("compagni");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Area Studente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f3f5f8; }
        .section-panel {
            background: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 24px;
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
        .summary-box {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 16px;
            background: #ffffff;
        }
    </style>
</head>
<body>

<div class="container mt-4 mb-5">
    <div class="d-flex justify-content-end mb-3">
        <a href="dashboard.jsp" class="btn btn-outline-secondary">Home</a>
    </div>

    <% if (studente == null) { %>
        <div class="alert alert-warning">Studente non trovato.</div>
    <% } else { %>
        <div class="section-panel mb-4">
            <h2 class="fw-bold text-primary mb-1">
                Benvenuto <%= studente.getNome() != null ? studente.getNome() : "" %> <%= studente.getCognome() != null ? studente.getCognome() : "" %>
            </h2>
            <p class="text-muted mb-0">Classe, compagni, professori e voti in un unico riepilogo.</p>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="section-panel h-100">
                    <h4 class="fw-bold">Classe</h4>
                    <% if (classe != null && classe.getNome() != null && !classe.getNome().isEmpty()) { %>
                        <p class="fs-4 mb-0"><%= classe.getNome() %></p>
                    <% } else { %>
                        <p class="mb-0"><em>Classe non disponibile</em></p>
                    <% } %>
                </div>
            </div>

            <div class="col-md-4">
                <div class="section-panel h-100">
                    <h4 class="fw-bold mb-3">Compagni</h4>
                    <ul class="list-group list-group-flush">
                        <% if (compagni != null && !compagni.isEmpty()) {
                               for (Studente s : compagni) { %>
                            <li class="list-group-item px-0">
                                <%= s.getCognome() != null ? s.getCognome() : "" %> <%= s.getNome() != null ? s.getNome() : "" %>
                            </li>
                        <%   }
                           } else { %>
                            <li class="list-group-item px-0"><em>Nessun compagno disponibile</em></li>
                        <% } %>
                    </ul>
                </div>
            </div>

            <div class="col-md-4">
                <div class="section-panel h-100">
                    <h4 class="fw-bold mb-3">Professori</h4>
                    <ul class="list-group list-group-flush">
                        <% if (professori != null && !professori.isEmpty()) {
                               for (Docente d : professori) { %>
                            <li class="list-group-item px-0">
                                <%= d.getCognome() != null ? d.getCognome() : "" %> <%= d.getNome() != null ? d.getNome() : "" %>
                            </li>
                        <%   }
                           } else { %>
                            <li class="list-group-item px-0"><em>Nessun docente assegnato</em></li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </div>

        <div class="section-panel">
            <h4 class="fw-bold mb-3">I miei voti</h4>

            <% if (voti != null && !voti.isEmpty()) { %>
                <%
                    double sommaVoti = 0;
                    for (Voto votoItem : voti) {
                        if (votoItem != null) {
                            sommaVoti += votoItem.getVoto();
                        }
                    }
                    double mediaVoti = sommaVoti / voti.size();
                %>

                <div class="row g-3 mb-3">
                    <div class="col-md-4">
                        <div class="summary-box">
                            <div class="text-muted small">Voti registrati</div>
                            <div class="fs-3 fw-bold"><%= voti.size() %></div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="summary-box">
                            <div class="text-muted small">Media</div>
                            <div class="fs-3 fw-bold"><%= String.format("%.2f", mediaVoti) %></div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="summary-box">
                            <div class="text-muted small">Esito generale</div>
                            <div class="fs-5 fw-semibold"><%= mediaVoti >= 6 ? "Sufficiente" : "Da recuperare" %></div>
                        </div>
                    </div>
                </div>

                <table class="table table-hover align-middle mb-0">
                    <thead class="table-primary">
                        <tr>
                            <th>Materia</th>
                            <th>Voto</th>
                            <th>Data</th>
                            <th>Professore</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Voto v : voti) {
                               double votoVal = v != null ? v.getVoto() : 0;
                               String colore = votoVal >= 6 ? "mark-ok" : (votoVal >= 5 ? "mark-mid" : "mark-low");
                               Docente d = v != null ? v.getDocente() : null;
                        %>
                            <tr>
                                <td class="fw-semibold"><%= v != null && v.getMateria() != null ? v.getMateria() : "-" %></td>
                                <td>
                                    <span class="mark-badge <%= colore %>">
                                        <%= String.format("%.2f", votoVal) %>
                                    </span>
                                </td>
                                <td><%= v != null && v.getData() != null ? v.getData().toString() : "-" %></td>
                                <td><%= d != null ? (d.getCognome() + " " + (d.getNome() != null ? d.getNome() : "")) : "<em>N/D</em>" %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <p class="mb-0"><em>Non ci sono voti disponibili.</em></p>
            <% } %>
        </div>
    <% } %>

</div>

</body>
</html>
