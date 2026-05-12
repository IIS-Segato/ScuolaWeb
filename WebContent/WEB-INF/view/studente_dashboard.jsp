<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Studente"%>
<%@ page import="model.Orario"%>
<%@ page import="java.util.List"%>
<%
//Recupero gli oggetti passati dalla Servlet tramite la request
Studente s = (Studente) request.getAttribute("studente");
List<Orario> orari = (List<Orario>) request.getAttribute("orari");

//Sicurezza minima nel caso si provi ad accedere direttamente alla JSP saltando la Servlet
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
<title>Dashboard Studente | <%=s.getNome()%></title>
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
		</ul>
	</div>

	<div class="main-content">
		<div
			class="profile-header d-flex justify-content-between align-items-center">
			<div>
				<h2 class="mb-0 text-gray-800">
					Bentornato,
					<%=s.getNome()%>
					<%=s.getCognome()%>!
				</h2>
				<span class="text-muted">Classe: <strong><%=s.getClasse()%></strong></span>
			</div>
			<div class="text-end">
				<div class="badge bg-primary p-2">
					Studente ID: #<%=s.getId()%></div>
			</div>
		</div>

		<div class="row">
		</div>

		<!-- ORARIO -->
		<div class="card shadow mb-4">
			<div
				class="card-header py-3 d-flex justify-content-between align-items-center bg-white">
				<h6 class="m-0 font-weight-bold text-primary">
					<i class="fas fa-clock me-2"></i> Il tuo Orario - Classe
					<%=s.getClasse()%></h6>
			</div>
			<div class="card-body">
				<%
				if (orari != null && !orari.isEmpty()) {
				%>
				<div class="table-responsive">
					<table class="table table-hover align-middle table-bordered">
						<thead class="table-light">
							<tr>
								<th><i class="fas fa-calendar-day me-1"></i> Giorno</th>
								<th><i class="fas fa-hourglass-start me-1"></i> Inizio</th>
								<th><i class="fas fa-hourglass-end me-1"></i> Fine</th>
								<th><i class="fas fa-user-tie me-1"></i> Docente</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (Orario o : orari) {
							%>
							<tr>
								<td><strong><%=o.getNome_giorno()%></strong></td>
								<td><span class="badge btn-outline-primary text-dark"><%=o.getOrario_inizio()%></span></td>
								<td><span class="badge btn-outline-secondary text-dark"><%=o.getOrario_fine()%></span></td>
								<!-- Visualizzazione Nome e Cognome -->
								<td><i class="fas fa-user-circle text-muted me-2"></i> <%=o.getNomeDocente()%>
									<%=o.getCognomeDocente()%></td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
				<%
				} else {
				%>
				<div class="alert alert-info" role="alert">Nessun orario
					disponibile al momento per la tua classe.</div>
				<%
				}
				%>
			</div>
		</div>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>