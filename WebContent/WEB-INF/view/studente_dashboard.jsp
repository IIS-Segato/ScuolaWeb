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
			<li class="nav-item mb-2"><a href="#sezione-comunicati"
				class="nav-link text-white"><i class="fas fa-bullhorn me-2"></i>
					Comunicati</a></li>
			<li class="nav-item mt-4"><a href="LogoutServlet"
				class="nav-link text-warning"><i
					class="fas fa-sign-out-alt me-2"></i> Esci</a></li>
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

		<div class="row"></div>

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
						<!-- Intestazione della tabella -->
						<thead class="table-light">
							<tr>
								<th><i class="fas fa-calendar-day me-1"></i> Giorno</th>
								<th><i class="fas fa-hourglass-start me-1"></i> Inizio</th>
								<th><i class="fas fa-hourglass-end me-1"></i> Fine</th>
								<th><i class="fas fa-book me-1"></i> Materia</th>
								<!-- NUOVA COLONNA -->
								<th><i class="fas fa-user-tie me-1"></i> Docente</th>
							</tr>
						</thead>

						<!-- Corpo della tabella -->
						<tbody>
							<%
							for (Orario o : orari) {
							%>
							<tr>
								<td><strong><%=o.getNome_giorno()%></strong></td>
								<td><span class="badge btn-outline-primary text-dark"><%=o.getOrario_inizio()%></span></td>
								<td><span class="badge btn-outline-secondary text-dark"><%=o.getOrario_fine()%></span></td>

								<!-- Visualizzazione Materia con un badge carino -->
								<td><span class="badge bg-info text-dark"><%=o.getNomeMateria()%></span></td>

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


		<%-- Recupero la lista voti all'inizio della JSP --%>
		<%@ page import="model.Voto"%>
		<%
		List<Voto> voti = (List<Voto>) request.getAttribute("voti");
		%>
		<div class="card shadow mb-4">
			<div class="card-header py-3 bg-white">
				<h6 class="m-0 font-weight-bold text-success">
					<i class="fas fa-star me-2"></i> I tuoi Voti
				</h6>
			</div>
			<div class="card-body">
				<%
				if (voti != null && !voti.isEmpty()) {
				%>
				<div class="table-responsive">
					<table class="table table-striped align-middle">
						<thead>
							<tr>
								<th>Data</th>
								<th>Materia</th>
								<th>Voto</th>
								<th>Docente</th>
								<th>Descrizione</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (Voto v : voti) {
							%>
							<tr>
								<td><%=v.getData()%></td>
								<td><span class="badge bg-secondary"><%=v.getNomeMateria()%></span></td>
								<td><strong
									class="<%=v.getVoto() >= 6 ? "text-success" : "text-danger"%>">
										<%=v.getVoto()%>
								</strong></td>
								<td><%=v.getNomeDocente()%></td>
								<td class="text-muted small"><%=v.getDescrizione()%></td>
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
				<p class="text-center">Non ci sono voti registrati.</p>
				<%
				}
				%>
			</div>
		</div>
		<!-- comunicati -->
		<%-- Recupero la lista dei comunicati passata dalla Servlet --%>
		<%@ page import="model.Comunicato"%>
		<%
		List<Comunicato> comunicati = (List<Comunicato>) request.getAttribute("comunicati");
		%>

		<div class="card shadow mb-4" id="sezione-comunicati">
			<div class="card-header py-3 bg-white">
				<h6 class="m-0 font-weight-bold text-warning">
					<i class="fas fa-bullhorn me-2"></i> Bacheca Comunicati d'Istituto
				</h6>
			</div>
			<div class="card-body">
				<%
				if (comunicati != null && !comunicati.isEmpty()) {
				%>
				<div class="list-group list-group-flush">
					<%
					for (Comunicato c : comunicati) {
					%>
					<div class="list-group-item py-3">
						<div
							class="d-flex w-100 justify-content-between align-items-center mb-1">
							<h5 class="text-gray-800 mb-0 font-weight-bold"
								style="font-size: 1.1rem;"><%=c.getTitolo()%></h5>
							<small class="badge bg-light text-dark border"><i
								class="far fa-calendar-alt me-1"></i> <%=c.getData()%></small>
						</div>
						<p class="mb-1 text-muted small"><%=c.getTesto()%></p>
					</div>
					<%
					}
					%>
				</div>
				<%
				} else {
				%>
				<div class="alert alert-light text-center border mb-0" role="alert">
					<i class="fas fa-info-circle me-2 text-muted"></i> Nessun
					comunicato ufficiale attivo al momento.
				</div>
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