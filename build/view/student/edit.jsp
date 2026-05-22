<%@ page import="model.Student" %>
<%@ page import="model.Role" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Student student = (Student) request.getAttribute("student");
    String action = (String) request.getAttribute("action");
    String error = (String) request.getAttribute("error");

    if (student == null) {
        student = new Student();
    }

    boolean isUpdate = "UPDATE".equals(action);

    String title = isUpdate ? "Modifica studente" : "Aggiungi studente";

    String name = student.getName() != null ? student.getName() : "";
    String surname = student.getSurname() != null ? student.getSurname() : "";
    String className = student.getClassName() != null ? student.getClassName() : "";

    String context = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= title %></title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow">
        <div class="card-body">

            <h1 class="mb-4"><%= title %></h1>

            <% if (error != null) { %>
                <div class="alert alert-danger">
                    <%= error %>
                </div>
            <% } %>

            <form action="<%= context %>/Student" method="post">

                <input type="hidden" name="action" value="<%= action %>">

                <% if (isUpdate) { %>
                    <input type="hidden" name="id" value="<%= student.getId() %>">
                <% } %>

                <div class="mb-3">
                    <label class="form-label">Nome</label>
                    <input type="text"
                           name="name"
                           class="form-control"
                           value="<%= name %>"
                           required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Cognome</label>
                    <input type="text"
                           name="surname"
                           class="form-control"
                           value="<%= surname %>"
                           required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Classe</label>
                    <input type="text"
                           name="className"
                           class="form-control"
                           value="<%= className %>"
                           required>
                </div>

                <button type="submit" class="btn btn-success">
                    Salva
                </button>

                <a href="<%= context %>/Student" class="btn btn-secondary">
                    Annulla
                </a>

            </form>

        </div>
    </div>

</div>

</body>
</html>