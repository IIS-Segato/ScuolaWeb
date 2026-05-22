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
</head>
<body class="bg-light">

<div class="container mt-4">
    <div class="d-flex justify-content-end mb-3">
        <a href="dashboard.jsp" class="btn btn-outline-secondary">Home</a>
    </div>

    <% if (studente == null) { %>
        <div class="alert alert-warning">Studente non trovato.</div>
    <% } else { %>
        <h2 class="fw-bold text-primary mb-4">
            Benvenuto <%= studente.getNome() != null ? studente.getNome() : "" %> <%= studente.getCognome() != null ? studente.getCognome() : "" %>
        </h2>

        <!-- CLASSE -->
        <div class="card shadow-sm p-4 mb-4">
            <h4 class="fw-bold">Classe</h4>
            <% if (classe != null && classe.getNome() != null && !classe.getNome().isEmpty()) { %>
                <p class="fs-5"><%= classe.getNome() %></p>
            <% } else { %>
                <p class="fs-5"><em>Classe non disponibile</em></p>
            <% } %>
        </div>

        <!-- COMPAGNI -->
        <div class="card shadow-sm p-4 mb-4">
            <h4 class="fw-bold mb-3">Compagni di classe</h4>
            <ul class="list-group">
                <% if (compagni != null && !compagni.isEmpty()) {
                       for (Studente s : compagni) { %>
                    <li class="list-group-item">
                        <%= s.getCognome() != null ? s.getCognome() : "" %> <%= s.getNome() != null ? s.getNome() : "" %>
                    </li>
                <%   }
                   } else { %>
                    <li class="list-group-item"><em>Nessun compagno disponibile</em></li>
                <% } %>
            </ul>
        </div>

        <!-- PROFESSORI -->
        <div class="card shadow-sm p-4 mb-4">
            <h4 class="fw-bold mb-3">Professori</h4>
            <ul class="list-group">
                <% if (professori != null && !professori.isEmpty()) {
                       for (Docente d : professori) { %>
                    <li class="list-group-item">
                        <%= d.getCognome() != null ? d.getCognome() : "" %> <%= d.getNome() != null ? d.getNome() : "" %>
                    </li>
                <%   }
                   } else { %>
                    <li class="list-group-item"><em>Nessun docente assegnato</em></li>
                <% } %>
            </ul>
        </div>

        <!-- VOTI -->
        <div class="card shadow-sm p-4">
            <h4 class="fw-bold mb-3">I miei voti</h4>

            <% if (voti != null && !voti.isEmpty()) { %>
                <table class="table table-striped table-hover">
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
                               String colore = votoVal >= 6 ? "bg-success" : (votoVal >= 5 ? "bg-warning" : "bg-danger");
                               model.Docente d = v != null ? v.getDocente() : null;
                        %>
                            <tr>
                                <td><%= v != null && v.getMateria() != null ? v.getMateria() : "—" %></td>
                                <td>
                                    <span class="badge <%= colore %> fs-6 px-3 py-2">
                                        <%= votoVal %>
                                    </span>
                                </td>
                                <td><%= v != null && v.getData() != null ? v.getData().toString() : "—" %></td>
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
