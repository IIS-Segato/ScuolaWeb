<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Role, model.User" %>

<!DOCTYPE html>
<html lang="it">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>ScuolaWeb – Ruoli</title>
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
        <div class="d-flex justify-content-between align-items-center mb-3">
        
            <h2 class="fw-bold">
                <i class="bi bi-shield-lock-fill text-primary me-2"></i>
                Gestione Ruoli
            </h2>

            <a
                href="<%= request.getContextPath() %>/Role?action=INSERT"
                class="btn btn-success">
                <i class="bi bi-plus-circle me-1"></i>
                Nuovo Ruolo

            </a>

        </div>

        <%
            List<Role> roles =
                    (List<Role>) request.getAttribute("roles");
        %>

        <div class="card shadow-sm">

            <div class="card-body p-0">

                <table class="table table-hover table-striped mb-0">

                    <thead class="table-primary">

                        <tr>

                            <th>#</th>
                            <th>Nome</th>
                            <th>Descrizione</th>
                            <th class="text-center">Azioni</th>

                        </tr>

                    </thead>

                    <tbody>

                        <% if (roles == null || roles.isEmpty()) { %>

                            <tr>

                                <td colspan="4"
                                    class="text-center text-muted py-3">

                                    Nessun ruolo presente.

                                </td>

                            </tr>

                        <% } else {

                            for (Role r : roles) {
                        %>

                            <tr>

                                <td><%= r.getId() %></td>

                                <td>

                                    <span class="badge bg-primary">

                                        <%= r.getRole_name() %>

                                    </span>

                                </td>

                                <td><%= r.getDescription() %></td>

                                <td class="text-center">

                                    <a
                                        href="<%= request.getContextPath() %>/Role?action=EDIT&id=<%= r.getId() %>"
                                        class="btn btn-warning btn-sm me-1">

                                        <i class="bi bi-pencil"></i>

                                    </a>

                                    <a
                                        href="<%= request.getContextPath() %>/Role?action=DELETE&id=<%= r.getId() %>"
                                        class="btn btn-danger btn-sm"
                                        onclick="return confirm('Eliminare il ruolo <%= r.getRole_name() %>?')">

                                        <i class="bi bi-trash"></i>

                                    </a>

                                </td>

                            </tr>

                        <%
                            }
                        }
                        %>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>