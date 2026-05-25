<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="it">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>ScuolaWeb – Login</title>

    <!-- Bootstrap CSS -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
        rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #1d3557 0%, #457b9d 100%);
            min-height: 100vh;
        }

        .card {
            border-radius: 1rem;
        }
    </style>
</head>

<body class="d-flex align-items-center justify-content-center">

    <div class="card shadow-lg p-4" style="width: 380px;">

        <div class="text-center mb-4">
            <i class="bi bi-mortarboard-fill text-primary" style="font-size: 3rem;"></i>

            <h3 class="fw-bold mt-2">ScuolaWeb</h3>

            <p class="text-muted small">
                Accedi con le tue credenziali
            </p>
        </div>

        <% if (request.getAttribute("errore") != null) { %>

            <div class="alert alert-danger alert-dismissible fade show py-2" role="alert">

                <i class="bi bi-exclamation-triangle-fill me-1"></i>

                <%= request.getAttribute("errore") %>

                <button
                    type="button"
                    class="btn-close btn-sm"
                    data-bs-dismiss="alert">
                </button>

            </div>

        <% } %>

        <form method="post" action="Login">

            <div class="mb-3">

                <label class="form-label fw-semibold">
                    Username
                </label>

                <div class="input-group">

                    <span class="input-group-text">
                        <i class="bi bi-person"></i>
                    </span>

                    <input
                        type="text"
                        name="username"
                        class="form-control"
                        placeholder="Inserisci username"
                        required
                        autofocus>

                </div>
            </div>

            <div class="mb-4">

                <label class="form-label fw-semibold">
                    Password
                </label>

                <div class="input-group">

                    <span class="input-group-text">
                        <i class="bi bi-lock"></i>
                    </span>

                    <input
                        type="password"
                        name="password"
                        class="form-control"
                        placeholder="Inserisci password"
                        required>

                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100 fw-semibold">
                <i class="bi bi-box-arrow-in-right me-1"></i>
                Accedi
            </button>

        </form>

        <p class="text-center text-muted small mt-3 mb-0">
	Demo accessi disponibili nel database
</p>

    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>