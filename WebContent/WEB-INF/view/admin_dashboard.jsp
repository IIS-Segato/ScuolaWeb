<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Admin"%>
<%@ page import="java.util.List"%>
<%
//Recupero gli oggetti passati dalla Servlet tramite la request
Admin a = (Admin) request.getAttribute("admin");

//Sicurezza minima nel caso si provi ad accedere direttamente alla JSP saltando la Servlet
if (a == null) {
	response.sendRedirect("login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard Admin | <%=a.getUsername()%></title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
	--sidebar-width: 250px;
	--primary-color: #4e73df;
}

body {
	background-color: #f8f9fc;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.sidebar {
	width: var(--sidebar-width);
	height: 100vh;
	position: fixed;
	background: var(--primary-color);
	color: white;
	padding: 20px;
}

.main-content {
	margin-left: var(--sidebar-width);
	padding: 30px;
}

.card-stat {
	border-left: 4px solid var(--primary-color);
}

.profile-header {
	background: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
	margin-bottom: 30px;
}
</style>
</head>
<body>

	<div class="sidebar d-none d-md-block shadow">
		<h4 class="text-center mb-4">
			<i class="fas fa-graduation-cap me-2"></i>ScuolaWeb
		</h4>
		<hr>
		<ul class="nav flex-column">
			<li class="nav-item mb-2"><a href="#"
				class="nav-link text-white active"><i class="fas fa-home me-2"></i>
					Dashboard</a></li>
			<li class="nav-item mb-2"><a href="#"
				class="nav-link text-white"><i class="fas fa-book me-2"></i> I
					miei Corsi</a></li>
			<li class="nav-item mb-2"><a href="#"
				class="nav-link text-white"><i class="fas fa-calendar me-2"></i>
					Calendario</a></li>
			<li class="nav-item mt-4"><a href="LogoutServlet"
				class="nav-link text-warning"><i
					class="fas fa-sign-out-alt me-2"></i> Esci</a></li>
		</ul>
	</div>

	<div class="main-content">
		<%
		String messaggio = request.getParameter("messaggio");
		String errore = request.getParameter("errore");

		if (messaggio != null && messaggio.equals("docente_inserito_con_successo")) {
		%>
		<div class="alert alert-success alert-dismissible fade show shadow-sm"
			role="alert">
			<i class="fas fa-check-circle me-2"></i> Docente inserito con
			successo!
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
		<%
		} else if (errore != null) {
		%>
		<div class="alert alert-danger alert-dismissible fade show shadow-sm"
			role="alert">
			<i class="fas fa-exclamation-triangle me-2"></i> Errore durante
			l'inserimento del docente.
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
		<%
		}
		%>
		<div
			class="profile-header d-flex justify-content-between align-items-center">
			<div>
				<h2 class="mb-0 text-gray-800">
					Bentornato,
					<%=a.getUsername()%>!
				</h2>

			</div>
			<div class="text-end">
				<div class="badge bg-primary p-2">
					Admin ID: #<%=a.getId()%></div>
			</div>
		</div>

		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">Inserisci Nuovo
					Docente</h6>
			</div>
			<div class="card-body">
				<form action="AdminDashboardServlet" method="POST">
					<div class="row mb-3">
						<div class="col">
							<label for="nome" class="form-label">Nome</label> <input
								type="text" class="form-control" id="nome" name="nome" required>
						</div>
						<div class="col">
							<label for="cognome" class="form-label">Cognome</label> <input
								type="text" class="form-control" id="cognome" name="cognome"
								required>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col">
							<label for="materia" class="form-label">Materia</label> <input
								type="text" class="form-control" id="materia" name="materia"
								required>
						</div>
						<div class="col">
							<label for="password" class="form-label">Password
								Provvisoria</label> <input type="password" class="form-control"
								id="password" name="password" required>
						</div>
					</div>
					<button type="submit" class="btn btn-success">
						<i class="fas fa-plus"></i> Aggiungi Docente
					</button>
				</form>
			</div>
		</div>
	</div>



	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>