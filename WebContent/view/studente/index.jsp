<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Studente, model.User" %>

<!DOCTYPE html>
<html lang="it">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>ScuolaWeb – Studenti</title>

    <!-- Bootstrap CSS -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
        rel="stylesheet">

</head>

<body class="bg-light">

    <%@ include file="../navbar.jsp" %>

    <div class="container mt-4">
		<% if(request.getAttribute("classeCorrente") != null) { %>

<div class="alert alert-info">

	Stai visualizzando la classe:
	<b>
		<%= request.getAttribute("classeCorrente") %>
	</b>

</div>

<% } %>
        <div class="d-flex justify-content-between align-items-center mb-3">

            <h2 class="fw-bold">
                <i class="bi bi-people-fill text-primary me-2"></i>
                Elenco Studenti
            </h2>

            <% if (loggedUser != null && loggedUser.isAdmin()) { %>

                <a
                    href="<%= request.getContextPath() %>/Studente?action=INSERT"
                    class="btn btn-success">

                    <i class="bi bi-plus-circle me-1"></i>
                    Nuovo Studente

                </a>

            <% } %>

        </div>

        <%
            List<Studente> studenti =
                    (List<Studente>) request.getAttribute("studenti");
        %>

        <div class="card shadow-sm">

            <div class="card-body p-0">

                <table class="table table-hover table-striped mb-0">

                    <thead class="table-primary">

                        <tr>

                            <th>#</th>
                            <th>Cognome</th>
                            <th>Nome</th>
                            <th>Classe</th>

                            <% if (loggedUser != null && loggedUser.isAdmin()) { %>

                                <th class="text-center">Azioni</th>

                            <% } %>

                        </tr>

                    </thead>

                    <tbody>

                        <% if (studenti == null || studenti.isEmpty()) { %>

                            <tr>

                                <td colspan="5" class="text-center text-muted py-3">

                                    <i class="bi bi-inbox me-1"></i>
                                    Nessuno studente presente.

                                </td>

                            </tr>

                        <% } else {

                            for (Studente s : studenti) {
                        %>

                            <tr>

                                <td><%= s.getId() %></td>

                                <td><%= s.getCognome() %></td>

                                <td><%= s.getNome() %></td>

                                <td>
                                    <span class="badge bg-secondary">
                                        <%= s.getNomeClasse() %>
                                    </span>
                                </td>

                                <% if (loggedUser != null && loggedUser.isAdmin()) { %>

                                    <td class="text-center">

                                        <a
                                            href="<%= request.getContextPath() %>/Studente?action=EDIT&id=<%= s.getId() %>"
                                            class="btn btn-warning btn-sm me-1">

                                            <i class="bi bi-pencil"></i>

                                        </a>

                                        <a
                                            href="<%= request.getContextPath() %>/Studente?action=DELETE&id=<%= s.getId() %>"
                                            class="btn btn-danger btn-sm"
                                            onclick="return confirm('Eliminare lo studente <%= s.getNome() %> <%= s.getCognome() %>?')">

                                            <i class="bi bi-trash"></i>

                                        </a>

                                    </td>

                                <% } %>

                            </tr>

                        <% 
                            }
                        } 
                        %>

                    </tbody>

                </table>

            </div>

        </div>

        <p class="text-muted small mt-2">
            Totale:
            <%= studenti != null ? studenti.size() : 0 %>
            studenti
        </p>

    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>