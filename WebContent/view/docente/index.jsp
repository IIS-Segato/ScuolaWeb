<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Docente, model.User" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ScuolaWeb – Docenti</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
    <%@ include file="../navbar.jsp" %>
    
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="fw-bold"><i class="bi bi-person-workspace text-primary me-2"></i>Elenco Docenti</h2>
            <% if (loggedUser != null && loggedUser.isAdmin()) { %>
                <a href="<%= request.getContextPath() %>/Docente?action=INSERT" class="btn btn-success">
                    <i class="bi bi-plus-circle me-1"></i>Nuovo Docente
                </a>
            <% } %>
        </div>
        
        <% List<Docente> docenti = (List<Docente>) request.getAttribute("docenti"); %>
        
        <div class="card shadow-sm">
            <div class="card-body p-0">
                <table class="table table-hover table-striped mb-0">
                    <thead class="table-primary">
                        <tr>
                            <th>#</th>
                            <th>Cognome</th>
                            <th>Nome</th>
                            <th>Materia</th>
                            <% if (loggedUser != null && loggedUser.isAdmin()) { %>
                                <th class="text-center">Azioni</th>
                            <% } %>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (docenti == null || docenti.isEmpty()) { %>
                            <tr>
                                <td colspan="5" class="text-center text-muted py-3">
                                    <i class="bi bi-inbox me-1"></i>Nessun docente presente.
                                </td>
                            </tr>
                        <% } else { 
                            for (Docente d : docenti) { %>
                                <tr>
                                    <td><%= d.getId() %></td>
                                    <td><%= d.getCognome() %></td>
                                    <td><%= d.getNome() %></td>
                                    <td><span class="badge bg-info text-dark"><%= d.getMateria() %></span></td>
                                    <% if (loggedUser != null && loggedUser.isAdmin()) { %>
                                        <td class="text-center">
                                            <a href="<%= request.getContextPath() %>/Docente?action=EDIT&id=<%= d.getId() %>" class="btn btn-warning btn-sm me-1">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <a href="<%= request.getContextPath() %>/Docente?action=DELETE&id=<%= d.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Eliminare il docente <%= d.getNome() %> <%= d.getCognome() %>?')">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </td>
                                    <% } %>
                                </tr>
                            <% } 
                        } %>
                    </tbody>
                </table>
            </div>
        </div>
        <p class="text-muted small mt-2">Totale: <%= docenti != null ? docenti.size() : 0 %> docenti</p>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>