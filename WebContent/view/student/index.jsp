<%@ page import="java.util.List" %>
<%@ page import="model.Student" %>
<%@ page import="model.Role" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Student> students = (List<Student>) request.getAttribute("students");

    Object roleObj = session.getAttribute("role");

    if (roleObj == null) {
        roleObj = session.getAttribute("ruolo");
    }

    if (roleObj == null) {
        roleObj = session.getAttribute("role_name");
    }

    String roleName = null;

    if (roleObj instanceof Role) {
        roleName = ((Role) roleObj).getRole_name();
    } else if (roleObj instanceof String) {
        roleName = (String) roleObj;
    }

    boolean isAdmin = false;

    if (roleName != null) {
        isAdmin = roleName.equalsIgnoreCase("admin")
                || roleName.equalsIgnoreCase("administrator")
                || roleName.equalsIgnoreCase("amministratore");
    }

    String context = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestione Studenti</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1>Gestione Studenti</h1>

        <div>
            <a href="<%= context %>/index.jsp" class="btn btn-secondary">Home</a>

            <% if (isAdmin) { %>
                <a href="<%= context %>/Student?action=INSERT" class="btn btn-primary">
                    Aggiungi studente
                </a>
            <% } %>
        </div>
    </div>

    <div class="alert alert-info">
        Ruolo utente:
        <strong>
            <%= roleName != null ? roleName : "non riconosciuto" %>
        </strong>
    </div>

    <div class="card shadow">
        <div class="card-body">

            <table class="table table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>Cognome</th>
                        <th>Classe</th>

                        <% if (isAdmin) { %>
                            <th>Azioni</th>
                        <% } %>
                    </tr>
                </thead>

                <tbody>
                <%
                    if (students != null && !students.isEmpty()) {
                        for (Student s : students) {
                %>

                    <tr>
                        <td><%= s.getId() %></td>
                        <td><%= s.getName() %></td>
                        <td><%= s.getSurname() %></td>
                        <td><%= s.getClassName() %></td>

                        <% if (isAdmin) { %>
                            <td>
                                <a href="<%= context %>/Student?action=EDIT&id=<%= s.getId() %>"
                                   class="btn btn-warning btn-sm">
                                    Modifica
                                </a>

                                <a href="<%= context %>/Student?action=DELETE&id=<%= s.getId() %>"
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('Sei sicuro di voler eliminare questo studente?')">
                                    Elimina
                                </a>
                            </td>
                        <% } %>
                    </tr>

                <%
                        }
                    } else {
                %>

                    <tr>
                        <td colspan="<%= isAdmin ? 5 : 4 %>" class="text-center">
                            Nessuno studente presente.
                        </td>
                    </tr>

                <%
                    }
                %>
                </tbody>
            </table>

        </div>
    </div>

</div>

</body>
</html>