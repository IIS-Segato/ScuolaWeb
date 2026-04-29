<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Studente" %>
<%
    // Recupero l'oggetto dalla sessione
    Studente s = (Studente) session.getAttribute("utenteLoggato");
    
    // Se non c'è nessuno in sessione, reindirizza (sicurezza minima)
    if (s == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Studente | <%= s.getNome() %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root { --sidebar-width: 250px; --primary-color: #4e73df; }
        body { background-color: #f8f9fc; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .sidebar { width: var(--sidebar-width); height: 100vh; position: fixed; background: var(--primary-color); color: white; padding: 20px; }
        .main-content { margin-left: var(--sidebar-width); padding: 30px; }
        .card-stat { border-left: 4px solid var(--primary-color); }
        .profile-header { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15); margin-bottom: 30px; }
    </style>
</head>
<body>

    <div class="sidebar d-none d-md-block shadow">
        <h4 class="text-center mb-4"><i class="fas fa-graduation-cap me-2"></i>ScuolaWeb</h4>
        <hr>
        <ul class="nav flex-column">
            <li class="nav-item mb-2"><a href="#" class="nav-link text-white active"><i class="fas fa-home me-2"></i> Dashboard</a></li>
            <li class="nav-item mb-2"><a href="#" class="nav-link text-white"><i class="fas fa-book me-2"></i> I miei Corsi</a></li>
            <li class="nav-item mb-2"><a href="#" class="nav-link text-white"><i class="fas fa-calendar me-2"></i> Calendario</a></li>
            <li class="nav-item mt-4"><a href="LogoutServlet" class="nav-link text-warning"><i class="fas fa-sign-out-alt me-2"></i> Esci</a></li>
        </ul>
    </div>

    <div class="main-content">
        <div class="profile-header d-flex justify-content-between align-items-center">
            <div>
                <h2 class="mb-0 text-gray-800">Bentornato, <%= s.getNome() %>!</h2>
                <span class="text-muted">Classe: <strong><%= s.getClasse() %></strong></span>
            </div>
            <div class="text-end">
                <div class="badge bg-primary p-2">Studente ID: #<%= s.getId() %></div>
            </div>
        </div>

        <div class="row">
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card card-stat shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Media Voti</div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">7.5</div>
                            </div>
                            <div class="col-auto"><i class="fas fa-chart-line fa-2x text-gray-300"></i></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-success shadow h-100 py-2" style="border-left: 4px solid #1cc88a;">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Presenze</div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">92%</div>
                            </div>
                            <div class="col-auto"><i class="fas fa-check-circle fa-2x text-gray-300"></i></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow mb-4">
            <div class="card-header py-3 d-flex justify-content-between align-items-center bg-white">
                <h6 class="m-0 font-weight-bold text-primary">Le tue materie attive</h6>
                <button class="btn btn-sm btn-primary">Dettagli</button>
            </div>
            <div class="card-body">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Materia</th>
                            <th>Insegnante</th>
                            <th>Ultimo Voto</th>
                            <th>Progresso</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Informatica e Sistemi</td>
                            <td>Prof. Bianchi</td>
                            <td><span class="badge bg-success">8.0</span></td>
                            <td style="width: 30%">
                                <div class="progress" style="height: 10px;">
                                    <div class="progress-bar bg-info" style="width: 75%"></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Matematica Applicata</td>
                            <td>Prof. Neri</td>
                            <td><span class="badge bg-warning text-dark">6.5</span></td>
                            <td style="width: 30%">
                                <div class="progress" style="height: 10px;">
                                    <div class="progress-bar bg-warning" style="width: 50%"></div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>