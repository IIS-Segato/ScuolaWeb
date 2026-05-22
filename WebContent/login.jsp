<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ScuolaFacile - Login</title>

    <!-- Bootstrap (opzionale ma consigliato) -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <style>
        body {
            background: #f0f2f5;
        }
        .login-box {
            max-width: 350px;
            margin: 100px auto;
            padding: 25px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
    </style>
</head>

<body>

<div class="login-box">
    <h2 class="text-center mb-1">ScuolaFacile</h2>
    <p class="text-center text-muted mb-4">Accesso al registro scolastico</p>

    <!-- MESSAGGIO DI ERRORE -->
    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <div class="alert alert-danger text-center">
            <%= error %>
        </div>
    <%
        }
    %>

    <!-- FORM LOGIN -->
    <form action="login" method="post">

        <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text" name="username" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-primary w-100">
            Accedi
        </button>
    </form>
</div>

</body>
</html>
