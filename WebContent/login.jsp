<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.UtenteDAO" %>
<%@ page import="model.Utente" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String error = "";

    if (username != null && password != null) {

        try {

            if (username.equals("admin") && password.equals("admin4321")) {
                session.setAttribute("utente", username);
                response.sendRedirect("admin.html");
                return;
            }

            UtenteDAO dao = new UtenteDAO("config.xml");
            Utente u = dao.getByUsername(username);

            if (u != null && u.getPassword_hash().equals(password)) {
                session.setAttribute("utente", u);
                response.sendRedirect("home.jsp");
                return;
            } else {
                error = "Credenziali non valide";
            }

        } catch (Exception e) {
            error = "Errore server";
        }
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Login</title>

    <!-- BOOTSTRAP 5 CDN (IMPORTANTISSIMO) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #0f766e, #14b8a6);
            height: 100vh;
        }

        .glass {
            background: rgba(255,255,255,0.9);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.3);
        }

        .logo {
            width: 60px;
        }

        .eye-btn {
            border: none;
            background: #e5e7eb;
            border-radius: 10px;
            width: 60px;
        }
    </style>
</head>

<body>

<div class="container h-100 d-flex align-items-center justify-content-center">

    <div class="col-md-5 col-lg-4">

        <!-- CARD LOGIN -->
        <div class="card glass p-4">

            <!-- HEADER -->
            <div class="text-center mb-3">
                <img src="imgs/logoscuola.png" class="logo mb-2">
                <h4 class="fw-bold">Area Personale</h4>
                <small class="text-muted">Accesso studenti e docenti</small>
            </div>

            <!-- ERROR -->
            <% if (!error.equals("")) { %>
                <div class="alert alert-danger py-2 text-center">
                    <%= error %>
                </div>
            <% } %>

            <!-- FORM -->
            <form method="post">

                <div class="mb-3">
                    <input type="text" name="username" class="form-control form-control-lg" placeholder="Username" required>
                </div>

                <div class="input-group mb-3">
                    <input type="password" name="password" id="password" class="form-control form-control-lg" placeholder="Password" required>

                    <button type="button" class="eye-btn" id="toggle">👁</button>
                </div>

                <button type="submit" class="btn btn-success btn-lg w-100">
                    Accedi
                </button>

            </form>

        </div>

    </div>

</div>

<script>
    const input = document.getElementById("password");
    const btn = document.getElementById("toggle");

    btn.addEventListener("click", () => {
        input.type = input.type === "password" ? "text" : "password";
    });
</script>

</body>
</html>