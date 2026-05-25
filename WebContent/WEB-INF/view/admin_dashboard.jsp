<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Admin"%>
<%@ page import="java.util.List"%>
<%
Admin a = (Admin) request.getAttribute("admin");

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
	--student-color: #1cc88a; /* Un verde per differenziare gli studenti */
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
		<%
		String messaggio = request.getParameter("messaggio");
		String errore = request.getParameter("errore");

		// Gestione dei messaggi di SUCCESSO
		if (messaggio != null) {
			String testoMessaggio = "";
			if (messaggio.equals("docente_inserito_con_successo"))
				testoMessaggio = "Docente inserito con successo!";
			else if (messaggio.equals("docente_eliminato_con_successo"))
				testoMessaggio = "Docente eliminato con successo!";
			else if (messaggio.equals("studente_inserito_con_successo"))
				testoMessaggio = "Studente inserito con successo!";
			else if (messaggio.equals("studente_eliminato_con_successo"))
				testoMessaggio = "Studente eliminato con successo!";
			else if (messaggio.equals("comunicato_inserito_con_successo"))
				testoMessaggio = "Comunicato pubblicato con successo!";
			else if (messaggio.equals("comunicato_eliminato_con_successo"))
				testoMessaggio = "Comunicato rimosso dalla bacheca con successo!";
		%>
		<div class="alert alert-success alert-dismissible fade show shadow-sm"
			role="alert">
			<i class="fas fa-check-circle me-2"></i>
			<%=testoMessaggio%>
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
		<%
		}
		// Gestione dei messaggi di ERRORE
		else if (errore != null) {
		String testoErrore = "Errore durante l'operazione richiesta.";
		if (errore.equals("errore_eliminazione"))
			testoErrore = "Errore durante l'eliminazione del docente. L'ID potrebbe non esistere.";
		else if (errore.equals("errore_eliminazione_studente"))
			testoErrore = "Errore durante l'eliminazione dello studente. L'ID potrebbe non esistere.";
		else if (errore.equals("inserimento_studente_fallito"))
			testoErrore = "Errore: impossibile inserire lo studente (controlla che la Classe esista nel Database!).";
		else if (errore.equals("errore_inserimento_comunicato"))
			testoErrore = "Errore durante la pubblicazione del comunicato.";
		else if (errore.equals("errore_eliminazione_comunicato"))
			testoErrore = "Errore: impossibile eliminare il comunicato.";
		%>
		<div class="alert alert-danger alert-dismissible fade show shadow-sm"
			role="alert">
			<i class="fas fa-exclamation-triangle me-2"></i>
			<%=testoErrore%>
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

		<h4 class="mb-3 text-gray-800 border-bottom pb-2">Gestione
			Docenti</h4>
		<div class="row mb-5">
			<div class="col-lg-8">
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">Inserisci Nuovo
							Docente</h6>
					</div>
					<div class="card-body">
						<form action="AdminDashboardServlet" method="POST">
							<input type="hidden" name="azione" value="inserisci">
							<div class="row mb-3">
								<div class="col">
									<label class="form-label">Nome</label> <input type="text"
										class="form-control" name="nome" required>
								</div>
								<div class="col">
									<label class="form-label">Cognome</label> <input type="text"
										class="form-control" name="cognome" required>
								</div>
							</div>
							<div class="row mb-3">
								<div class="col">
									<label class="form-label">Materia</label> <select
										class="form-select" name="materia" required>
										<option value="" disabled selected>Scegli una
											materia...</option>
										<option value="Matematica">Matematica</option>
										<option value="Italiano">Italiano</option>
										<option value="Sistemi e Reti">Sistemi e Reti</option>
										<option value="Inglese">Inglese</option>
										<option value="Informatica">Informatica</option>
									</select>
								</div>
								<div class="col">
									<label class="form-label">Password Provvisoria</label> <input
										type="password" class="form-control" name="password" required>
								</div>
							</div>
							<button type="submit" class="btn btn-primary">
								<i class="fas fa-plus"></i> Aggiungi Docente
							</button>
						</form>
					</div>
				</div>
			</div>

			<div class="col-lg-4">
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-danger">
							<i class="fas fa-user-times"></i> Elimina Docente
						</h6>
					</div>
					<div class="card-body">
						<form action="AdminDashboardServlet" method="POST">
							<input type="hidden" name="azione" value="elimina">
							<div class="mb-3">
								<label class="form-label">ID del Docente</label> <input
									type="number" class="form-control" name="id_docente"
									placeholder="Es: 12" required>
							</div>
							<button type="submit" class="btn btn-danger w-100"
								onclick="return confirm('ATTENZIONE: Sei sicuro? L\'azione è irreversibile.');">
								<i class="fas fa-trash"></i> Conferma Eliminazione
							</button>
						</form>
					</div>
				</div>
			</div>
		</div>


		<h4 class="mb-3 text-gray-800 border-bottom pb-2">Gestione
			Studenti</h4>
		<div class="row mb-5">
			<div class="col-lg-8">
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold"
							style="color: var(--student-color);">Inserisci Nuovo
							Studente</h6>
					</div>
					<div class="card-body">
						<form action="AdminDashboardServlet" method="POST">
							<input type="hidden" name="azione" value="inserisci_studente">
							<div class="row mb-3">
								<div class="col">
									<label class="form-label">Nome</label> <input type="text"
										class="form-control" name="nome" required>
								</div>
								<div class="col">
									<label class="form-label">Cognome</label> <input type="text"
										class="form-control" name="cognome" required>
								</div>
							</div>
							<div class="row mb-3">
								<div class="col">
									<label for="classe" class="form-label">Classe</label> <select
										class="form-select" id="classe" name="classe" required>
										<option value="" disabled selected>Scegli una
											classe...</option>
										<option value="4A INF">4A INF</option>
										<option value="5A INF">5A INF</option>
									</select>
								</div>
								<div class="col">
									<label class="form-label">Password Provvisoria</label> <input
										type="password" class="form-control" name="password" required>
								</div>
							</div>
							<button type="submit" class="btn text-white"
								style="background-color: var(--student-color);">
								<i class="fas fa-user-plus"></i> Aggiungi Studente
							</button>
						</form>
					</div>
				</div>
			</div>

			<div class="col-lg-4">
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-danger">
							<i class="fas fa-user-minus"></i> Elimina Studente
						</h6>
					</div>
					<div class="card-body">
						<form action="AdminDashboardServlet" method="POST">
							<input type="hidden" name="azione" value="elimina_studente">
							<div class="mb-3">
								<label class="form-label">ID dello Studente</label> <input
									type="number" class="form-control" name="id_studente"
									placeholder="Es: 15" required>
							</div>
							<button type="submit" class="btn btn-danger w-100"
								onclick="return confirm('ATTENZIONE: Eliminare questo studente rimuoverà anche i suoi voti. Procedere?');">
								<i class="fas fa-trash"></i> Conferma Eliminazione
							</button>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<h4 class="mb-3 text-gray-800 border-bottom pb-2" id="sezione-comunicati">Gestione Comunicati</h4>
		<div class="row">
			<div class="col-lg-8">
				<div class="card shadow mb-4">
					<div class="card-header py-3 bg-white">
						<h6 class="m-0 font-weight-bold text-warning">
							<i class="fas fa-bullhorn me-2"></i> Bacheca Comunicati Attivi
						</h6>
					</div>
					<div class="card-body p-0">
						<%@ page import="model.Comunicato"%>
						<%
						List<Comunicato> comunicati = (List<Comunicato>) request.getAttribute("comunicati");
						if (comunicati != null && !comunicati.isEmpty()) {
						%>
						<ul class="list-group list-group-flush">
							<% for (Comunicato c : comunicati) { %>
							<li class="list-group-item p-3">
								<div class="d-flex justify-content-between align-items-center mb-2">
									<h5 class="mb-0 font-weight-bold text-dark"><%= c.getTitolo() %></h5>
									<div>
										<small class="badge bg-light text-dark border me-2"><i class="far fa-calendar-alt me-1"></i> <%= c.getData() %></small>
										
										<form action="AdminDashboardServlet" method="POST" onsubmit="return confirm('Sicuro di voler eliminare questo comunicato per tutti?');" style="display:inline;">
											<input type="hidden" name="azione" value="elimina_comunicato">
											<input type="hidden" name="id_comunicato" value="<%= c.getId() %>">
											<button type="submit" class="btn btn-outline-danger btn-sm border-0" title="Elimina">
												<i class="fas fa-trash-alt"></i>
											</button>
										</form>
									</div>
								</div>
								<p class="mb-0 text-muted"><%= c.getTesto() %></p>
							</li>
							<% } %>
						</ul>
						<% } else { %>
						<div class="p-4 text-center text-muted border-0">
							<i class="fas fa-info-circle mb-2" style="font-size: 2rem;"></i>
							<p class="mb-0">Nessun comunicato in bacheca. Pubblicane uno nuovo!</p>
						</div>
						<% } %>
					</div>
				</div>
			</div>

			<div class="col-lg-4">
				<div class="card shadow mb-4 border-left-warning">
					<div class="card-header py-3 bg-white">
						<h6 class="m-0 font-weight-bold text-warning">
							<i class="fas fa-pen me-2"></i> Pubblica Comunicato
						</h6>
					</div>
					<div class="card-body">
						<form action="AdminDashboardServlet" method="POST">
							<input type="hidden" name="azione" value="inserisci_comunicato">
							
							<div class="mb-3">
								<label for="titolo" class="form-label small fw-bold">Titolo</label>
								<input type="text" class="form-control" id="titolo" name="titolo" placeholder="Es. Chiusura festiva" required>
							</div>
							
							<div class="mb-3">
								<label for="data" class="form-label small fw-bold">Data Visibile</label>
								<input type="date" class="form-control" id="data" name="data" required>
							</div>
							
							<div class="mb-3">
								<label for="testo" class="form-label small fw-bold">Testo del Messaggio</label>
								<textarea class="form-control" id="testo" name="testo" rows="4" placeholder="Scrivi qui..." required></textarea>
							</div>
							
							<button type="submit" class="btn btn-warning w-100 text-dark fw-bold">
								<i class="fas fa-paper-plane me-2"></i> Pubblica
							</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		// Script per inserire la data di oggi in automatico nel form dei comunicati
		var dateField = document.getElementById('data');
		if(dateField && !dateField.value) {
			dateField.valueAsDate = new Date();
		}
	</script>
</body>
</html>