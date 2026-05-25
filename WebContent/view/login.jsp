<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>ScuolaWeb – Accesso</title>
  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <style>
    body {
      min-height: 100vh;
      background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .login-card {
      width: 100%;
      max-width: 420px;
      border-radius: 1rem;
      border: none;
      box-shadow: 0 20px 60px rgba(0,0,0,0.4);
    }
    .login-header {
      background: linear-gradient(135deg, #0f3460 0%, #533483 100%);
      border-radius: 1rem 1rem 0 0;
      padding: 2rem;
      text-align: center;
      color: white;
    }
    .login-header .icon {
      font-size: 3rem;
      margin-bottom: .5rem;
    }
    .form-control:focus {
      border-color: #0f3460;
      box-shadow: 0 0 0 .2rem rgba(15,52,96,.25);
    }
    .btn-login {
      background: linear-gradient(135deg, #0f3460, #533483);
      border: none;
      color: white;
      letter-spacing: .03em;
    }
    .btn-login:hover {
      opacity: .9;
      color: white;
    }
  </style>
</head>
<body>
  <div class="login-card card">
    <div class="login-header">
      <div class="icon"><i class="bi bi-mortarboard-fill"></i></div>
      <h4 class="fw-bold mb-0">ScuolaWeb</h4>
      <p class="mb-0 opacity-75 small">Gestione Scolastica</p>
    </div>
    <div class="card-body p-4">
      <% String errore = (String) request.getAttribute("errore"); %>
      <% if (errore != null) { %>
      <div class="alert alert-danger d-flex align-items-center" role="alert">
        <i class="bi bi-exclamation-triangle-fill me-2"></i>
        <%= errore %>
      </div>
      <% } %>

      <form action="Login" method="post" novalidate>
        <div class="mb-3">
          <label for="username" class="form-label fw-semibold">
            <i class="bi bi-person me-1"></i>Username
          </label>
          <input type="text" class="form-control" id="username"
                 name="username" placeholder="Inserisci username"
                 required autofocus>
        </div>
        <div class="mb-4">
          <label for="password" class="form-label fw-semibold">
            <i class="bi bi-lock me-1"></i>Password
          </label>
          <div class="input-group">
            <input type="password" class="form-control" id="password"
                   name="password" placeholder="Inserisci password" required>
            <button class="btn btn-outline-secondary" type="button"
                    onclick="togglePwd()" title="Mostra/nascondi password">
              <i class="bi bi-eye" id="eyeIcon"></i>
            </button>
          </div>
        </div>
        <div class="d-grid">
          <button type="submit" class="btn btn-login btn-lg fw-semibold">
            <i class="bi bi-box-arrow-in-right me-2"></i>Accedi
          </button>
        </div>
      </form>

      <hr class="mt-4 mb-3">
      <p class="text-center text-muted small mb-0">
        <i class="bi bi-shield-lock me-1"></i>
        Accesso riservato al personale autorizzato
      </p>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    function togglePwd() {
      const p = document.getElementById('password');
      const e = document.getElementById('eyeIcon');
      if (p.type === 'password') {
        p.type = 'text';
        e.classList.replace('bi-eye', 'bi-eye-slash');
      } else {
        p.type = 'password';
        e.classList.replace('bi-eye-slash', 'bi-eye');
      }
    }
  </script>
</body>
</html>
