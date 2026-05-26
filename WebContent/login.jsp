<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Registro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to bottom, #dff7ef, #f7fffc);
            font-family: Arial, Helvetica, sans-serif;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            background: white;
            padding: 40px;
            border-radius: 18px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
        }
        .btn-custom {
            background-color: #146c5c;
            color: white;
        }
        .btn-custom:hover {
            background-color: #0f5246;
            color: white;
        }
        .error-msg {
            color: red;
            font-size: 14px;
            margin-bottom: 15px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="login-card">
    <h3 class="text-center mb-4" style="color: #146c5c; font-weight: bold;">Accedi al Registro</h3>

    <% 
        String errore = (String) request.getAttribute("errore");
        if (errore != null) { 
    %>
        <div class="error-msg"><%= errore %></div>
    <% 
        } 
    %>

    <form action="${pageContext.request.contextPath}/LoginController" method="POST">
        
        <input type="hidden" name="action" value="LOGIN">

        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" id="username" name="username" required placeholder="Inserisci il tuo username">
        </div>

        <div class="mb-4">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password_hash" required placeholder="Inserisci la password">
        </div>

        <div class="d-grid">
            <button type="submit" class="btn btn-custom btn-block py-2 fw-bold">Accedi</button>
        </div>
    </form>
</div>

</body>
</html>