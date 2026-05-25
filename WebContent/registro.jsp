<%@ page import="java.util.ArrayList, java.util.LinkedHashMap, java.util.List, java.util.Map" %>
<%@ page import="model.EventoRegistro, model.User, model.Studente, model.Docente, model.Classe" %>

<%
    User u = (User) session.getAttribute("user");
    List<Classe> classi = (List<Classe>) request.getAttribute("classi");
    List<Studente> studenti = (List<Studente>) request.getAttribute("studenti");
    Map<Integer, EventoRegistro> presenze = (Map<Integer, EventoRegistro>) request.getAttribute("presenze");
    List<EventoRegistro> storico = (List<EventoRegistro>) request.getAttribute("storico");
    List<EventoRegistro> storicoStudente = (List<EventoRegistro>) request.getAttribute("storicoStudente");
    Integer numeroAssenze = (Integer) request.getAttribute("numeroAssenze");
    Integer numeroRitardi = (Integer) request.getAttribute("numeroRitardi");
    Integer numeroUscite = (Integer) request.getAttribute("numeroUscite");
    Integer idClasse = (Integer) request.getAttribute("idClasse");
    String data = (String) request.getAttribute("data");
    String mese = (String) request.getAttribute("mese");

    Map<String, List<EventoRegistro>> storicoPerGiorno = new LinkedHashMap<>();
    if (storico != null) {
        for (EventoRegistro evento : storico) {
            String giorno = evento.getData() != null ? evento.getData().toString() : "-";
            if (!storicoPerGiorno.containsKey(giorno)) {
                storicoPerGiorno.put(giorno, new ArrayList<EventoRegistro>());
            }
            storicoPerGiorno.get(giorno).add(evento);
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestione assenze</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f3f5f8; }
        .page-header, .panel, .summary-box {
            background: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
        }
        .page-header, .panel, .summary-box { padding: 20px; }
        .status-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 86px;
            border-radius: 6px;
            padding: 7px 10px;
            font-weight: 700;
        }
        .status-presente { background: #d1e7dd; color: #0f5132; }
        .status-assente { background: #f8d7da; color: #842029; }
        .status-ritardo { background: #fff3cd; color: #664d03; }
        .status-uscita { background: #cff4fc; color: #055160; }
        .day-title {
            background: #212529;
            color: #ffffff;
            border-radius: 8px 8px 0 0;
            padding: 12px 16px;
        }
        .day-body {
            border: 1px solid #dee2e6;
            border-top: 0;
            border-radius: 0 0 8px 8px;
            background: #ffffff;
            padding: 12px 16px;
        }
    </style>
</head>
<body>
<div class="container mt-4 mb-5">

    <% if (u == null) { %>
        <div class="alert alert-warning">Sessione scaduta. Effettua il login.</div>
    <% } else if (u.getRoleId() == 4) { %>
        <div class="page-header mb-4">
            <div class="d-flex justify-content-between align-items-start gap-3 flex-wrap">
                <div>
                    <h2 class="mb-1">Le mie assenze</h2>
                    <p class="text-muted mb-0">Riepilogo personale di assenze e ritardi.</p>
                </div>
                <a href="dashboard.jsp" class="btn btn-outline-secondary">Home</a>
            </div>
        </div>

        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="summary-box">
                    <div class="text-muted small">Assenze</div>
                    <div class="fs-3 fw-bold"><%= numeroAssenze != null ? numeroAssenze : 0 %></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="summary-box">
                    <div class="text-muted small">Ritardi</div>
                    <div class="fs-3 fw-bold"><%= numeroRitardi != null ? numeroRitardi : 0 %></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="summary-box">
                    <div class="text-muted small">Uscite</div>
                    <div class="fs-3 fw-bold"><%= numeroUscite != null ? numeroUscite : 0 %></div>
                </div>
            </div>
        </div>

        <% if (storicoStudente == null || storicoStudente.isEmpty()) { %>
            <div class="alert alert-info">Nessuna assenza registrata.</div>
        <% } else { %>
            <div class="panel table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>Data</th>
                            <th>Stato</th>
                            <th>Ora ingresso</th>
                            <th>Ora uscita</th>
                            <th>Docente</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (EventoRegistro evento : storicoStudente) {
                               boolean ritardo = evento.getOraIngresso() != null;
                               boolean uscita = evento.getOraUscita() != null;
                               String stato = uscita && "PRESENTE".equals(evento.getTipo()) ? "Uscita" : ("PRESENTE".equals(evento.getTipo()) ? "Presente" : (ritardo ? "Ritardo" : "Assente"));
                               String classeStato = uscita && "PRESENTE".equals(evento.getTipo()) ? "status-uscita" : ("PRESENTE".equals(evento.getTipo()) ? "status-presente" : (ritardo ? "status-ritardo" : "status-assente"));
                               Docente d = evento.getDocente();
                        %>
                            <tr>
                                <td><%= evento.getData() != null ? evento.getData().toString() : "-" %></td>
                                <td><span class="status-badge <%= classeStato %>"><%= stato %></span></td>
                                <td><%= evento.getOraIngresso() != null ? evento.getOraIngresso().toString().substring(0, 5) : "-" %></td>
                                <td><%= evento.getOraUscita() != null ? evento.getOraUscita().toString().substring(0, 5) : "-" %></td>
                                <td><%= d != null ? d.getCognome() + " " + d.getNome() : "-" %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>

    <% } else { %>
        <div class="page-header mb-4">
            <div class="d-flex justify-content-between align-items-start gap-3 flex-wrap">
                <div>
                    <h2 class="mb-1">Gestione assenze</h2>
                    <p class="text-muted mb-0">Seleziona classe e data, poi registra presenza o assenza degli studenti.</p>
                </div>
                <a href="dashboard.jsp" class="btn btn-outline-secondary">Home</a>
            </div>
        </div>

        <form action="RegistroServlet" method="get" class="panel mb-4">
            <input type="hidden" name="action" value="list">
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label">Classe</label>
                    <select name="idClasse" class="form-select" required>
                        <% if (classi != null) {
                            for (Classe c : classi) { %>
                                <option value="<%= c.getId() %>" <%= idClasse != null && idClasse == c.getId() ? "selected" : "" %>>
                                    <%= c.getNome() %>
                                </option>
                        <%  }
                        } %>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Data registro</label>
                    <input type="date" name="data" class="form-control" value="<%= data != null ? data : "" %>" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Mese storico</label>
                    <input type="month" name="mese" class="form-control" value="<%= mese != null ? mese : "" %>">
                </div>
                <div class="col-md-1 d-grid">
                    <button class="btn btn-primary">Apri</button>
                </div>
            </div>
        </form>

        <% if (studenti == null || studenti.isEmpty()) { %>
            <div class="alert alert-info">Nessuno studente in questa classe.</div>
        <% } else { %>
            <form action="RegistroServlet" method="post" class="panel mb-4">
                <input type="hidden" name="idClasse" value="<%= idClasse != null ? idClasse : 0 %>">
                <input type="hidden" name="data" value="<%= data != null ? data : "" %>">

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="mb-0">Registro del giorno</h4>
                    <% if (u.getRoleId() == 2) { %>
                        <button class="btn btn-success">Salva registro</button>
                    <% } %>
                </div>

                <% if (u.getRoleId() == 2) { %>
                    <div class="alert alert-secondary">
                        Per vedere lo storico, seleziona <strong>Assente</strong>, inserisci l'ora di ingresso per un ritardo oppure l'ora di uscita, poi premi <strong>Salva registro</strong>.
                    </div>
                <% } %>

                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>Studente</th>
                                <th style="width: 320px;">Presenza</th>
                                <th style="width: 180px;">Ora ingresso</th>
                                <th style="width: 180px;">Ora uscita</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Studente s : studenti) {
                                   EventoRegistro evento = presenze != null ? presenze.get(s.getId()) : null;
                                   String tipo = evento != null && evento.getTipo() != null ? evento.getTipo() : "PRESENTE";
                                   String ora = evento != null && evento.getOraIngresso() != null ? evento.getOraIngresso().toString().substring(0, 5) : "";
                                   String uscita = evento != null && evento.getOraUscita() != null ? evento.getOraUscita().toString().substring(0, 5) : "";
                            %>
                                <tr>
                                    <td>
                                        <div class="fw-semibold"><%= s.getCognome() %> <%= s.getNome() %></div>
                                    </td>
                                    <td>
                                        <% if (u.getRoleId() == 2) { %>
                                            <div class="btn-group" role="group">
                                                <input type="radio" class="btn-check" name="tipo_<%= s.getId() %>" id="presente_<%= s.getId() %>"
                                                       value="PRESENTE" <%= "PRESENTE".equals(tipo) ? "checked" : "" %>>
                                                <label class="btn btn-outline-success" for="presente_<%= s.getId() %>">Presente</label>

                                                <input type="radio" class="btn-check" name="tipo_<%= s.getId() %>" id="assente_<%= s.getId() %>"
                                                       value="ASSENTE" <%= "ASSENTE".equals(tipo) ? "checked" : "" %>>
                                                <label class="btn btn-outline-danger" for="assente_<%= s.getId() %>">Assente</label>
                                            </div>
                                        <% } else if (evento != null) {
                                               boolean ritardo = evento.getOraIngresso() != null;
                                               String stato = "PRESENTE".equals(tipo) ? "Presente" : (ritardo ? "Ritardo" : "Assente");
                                               String classeStato = "PRESENTE".equals(tipo) ? "status-presente" : (ritardo ? "status-ritardo" : "status-assente");
                                        %>
                                            <span class="status-badge <%= classeStato %>"><%= stato %></span>
                                        <% } else { %>
                                            <span class="text-muted">Non registrato</span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <% if (u.getRoleId() == 2) { %>
                                            <input type="time" name="ora_<%= s.getId() %>" class="form-control ora-ingresso"
                                                   data-studente="<%= s.getId() %>" value="<%= ora %>">
                                        <% } else { %>
                                            <%= ora.isBlank() ? "-" : ora %>
                                        <% } %>
                                    </td>
                                    <td>
                                        <% if (u.getRoleId() == 2) { %>
                                            <input type="time" name="uscita_<%= s.getId() %>" class="form-control ora-uscita"
                                                   data-studente="<%= s.getId() %>" value="<%= uscita %>">
                                        <% } else { %>
                                            <%= uscita.isBlank() ? "-" : uscita %>
                                        <% } %>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </form>
        <% } %>

        <div class="panel">
            <div class="d-flex justify-content-between align-items-center gap-3 flex-wrap mb-3">
                <h4 class="mb-0">Calendario storico</h4>
                <span class="text-muted">Mese visualizzato: <strong><%= mese != null ? mese : "-" %></strong></span>
            </div>
            <% if (storicoPerGiorno.isEmpty()) { %>
                <div class="alert alert-info mb-0">Nessuna assenza, ritardo o uscita registrata nel mese selezionato.</div>
            <% } else {
                for (Map.Entry<String, List<EventoRegistro>> entry : storicoPerGiorno.entrySet()) {
            %>
                <div class="mb-3">
                    <div class="day-title"><strong><%= entry.getKey() %></strong></div>
                    <div class="day-body">
                        <div class="row g-2">
                            <% for (EventoRegistro evento : entry.getValue()) {
                                   Studente s = evento.getStudente();
                                   Classe c = s != null ? s.getClasse() : null;
                                   boolean ritardo = evento.getOraIngresso() != null;
                                   boolean uscita = evento.getOraUscita() != null;
                                   String stato = uscita && "PRESENTE".equals(evento.getTipo()) ? "Uscita" : ("PRESENTE".equals(evento.getTipo()) ? "Presente" : (ritardo ? "Ritardo" : "Assente"));
                                   String classeStato = uscita && "PRESENTE".equals(evento.getTipo()) ? "status-uscita" : ("PRESENTE".equals(evento.getTipo()) ? "status-presente" : (ritardo ? "status-ritardo" : "status-assente"));
                            %>
                                <div class="col-md-6 col-lg-4">
                                    <div class="border rounded p-2 bg-light">
                                        <div class="fw-semibold">
                                            <%= s != null ? s.getCognome() + " " + s.getNome() : "Studente" %>
                                        </div>
                                        <div class="small text-muted mb-2">Classe <%= c != null ? c.getNome() : "-" %></div>
                                        <form action="RegistroServlet" method="post" class="mt-2">
                                            <input type="hidden" name="action" value="updateEvento">
                                            <input type="hidden" name="id" value="<%= evento.getId() %>">

                                            <div class="row g-2 align-items-end">
                                                <div class="col-12">
                                                    <label class="form-label small mb-1">Tipo</label>
                                                    <select name="tipo" class="form-select form-select-sm">
                                                        <option value="PRESENTE" <%= "PRESENTE".equals(evento.getTipo()) ? "selected" : "" %>>Presente / uscita</option>
                                                        <option value="ASSENTE" <%= "ASSENTE".equals(evento.getTipo()) ? "selected" : "" %>>Assente / ritardo</option>
                                                    </select>
                                                </div>
                                                <div class="col-6">
                                                    <label class="form-label small mb-1">Ingresso</label>
                                                    <input type="time" name="oraIngresso" class="form-control form-control-sm"
                                                           value="<%= evento.getOraIngresso() != null ? evento.getOraIngresso().toString().substring(0, 5) : "" %>">
                                                </div>
                                                <div class="col-6">
                                                    <label class="form-label small mb-1">Uscita</label>
                                                    <input type="time" name="oraUscita" class="form-control form-control-sm"
                                                           value="<%= evento.getOraUscita() != null ? evento.getOraUscita().toString().substring(0, 5) : "" %>">
                                                </div>
                                                <div class="col-6 d-grid">
                                                    <button class="btn btn-success btn-sm">Salva</button>
                                                </div>
                                                <div class="col-6 d-grid">
                                                    <a href="RegistroServlet?action=delete&id=<%= evento.getId() %>"
                                                       class="btn btn-outline-danger btn-sm"
                                                       onclick="return confirm('Rimuovere questa registrazione dallo storico?');">Rimuovi</a>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            <%  }
            } %>
        </div>
    <% } %>
</div>
<script>
document.querySelectorAll('.ora-ingresso').forEach(function(input) {
    input.addEventListener('change', function() {
        if (input.value) {
            var assente = document.getElementById('assente_' + input.dataset.studente);
            if (assente) {
                assente.checked = true;
            }
        }
    });
});
document.querySelectorAll('.ora-uscita').forEach(function(input) {
    input.addEventListener('change', function() {
        var ingresso = document.querySelector('[name="ora_' + input.dataset.studente + '"]');
        if (input.value && (!ingresso || !ingresso.value)) {
            var presente = document.getElementById('presente_' + input.dataset.studente);
            if (presente) {
                presente.checked = true;
            }
        }
    });
});
</script>
</body>
</html>
