<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Docente"%>
<%@ page import="model.Orario"%>
<%@ page import="model.Voto"%>
<%@ page import="model.Studente"%>
<%@ page import="java.util.List"%>
<%
Docente d = (Docente) request.getAttribute("docente");
List<Orario> orari = (List<Orario>) request.getAttribute("orari");
List<Voto> voti = (List<Voto>) request.getAttribute("voti");
List<Studente> studenti = (List<Studente>) request.getAttribute("studenti");

if (d == null) {
	response.sendRedirect("login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard Docente | <%=d.getNome()%></title>
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

.badge-voto {
	font-size: 0.95rem;
	min-width: 38px;
	display: inline-block;
	text-align: center;
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
				class="nav-link text-white active"> <i class="fas fa-home me-2"></i>
					Dashboard
			</a></li>
			<li class="nav-item mb-2"><a href="#sezione-comunicati"
				class="nav-link text-white"><i class="fas fa-bullhorn me-2"></i>
					Comunicati</a></li>
			<li class="nav-item mt-4"><a href="LogoutServlet"
				class="nav-link text-warning"> <i
					class="fas fa-sign-out-alt me-2"></i> Esci
			</a></li>
		</ul>
	</div>

	<div class="main-content">

		<% if("voto_inserito".equals(request.getParameter("successo"))) { %>
			<div class="alert alert-success alert-dismissible fade show" role="alert">
				<i class="fas fa-check-circle me-2"></i> Voto registrato con successo!
				<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		<% } %>
		<% if("voto_eliminato".equals(request.getParameter("successo"))) { %>
			<div class="alert alert-success alert-dismissible fade show" role="alert">
				<i class="fas fa-check-circle me-2"></i> Voto rimosso con successo dal registro.
				<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		<% } %>
		<% if(request.getParameter("errore") != null) { %>
			<div class="alert alert-danger alert-dismissible fade show" role="alert">
				<i class="fas fa-exclamation-triangle me-2"></i> 
				<% 
					String err = request.getParameter("errore");
					if("errore_eliminazione".equals(err)) out.print("Impossibile eliminare il voto.");
					else if("errore_inserimento".equals(err)) out.print("Errore durante l'inserimento. Controlla l'ID Studente.");
					else out.print("I dati inseriti non sono validi.");
				%>
				<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		<% } %>

		<div
			class="profile-header d-flex justify-content-between align-items-center">
			<div>
				<h2 class="mb-0 text-gray-800">
					Bentornato,
					<%=d.getNome()%>
					<%=d.getCognome()%>!
				</h2>
				<span class="text-muted">Materia: <strong><%=d.getNomeMateria()%></strong></span>
			</div>
			<div class="text-end">
				<div class="badge bg-primary p-2">
					Docente ID: #<%=d.getId()%></div>
			</div>
		</div>

		<div class="card shadow mb-4">
			<div
				class="card-header py-3 d-flex justify-content-between align-items-center bg-white">
				<h6 class="m-0 font-weight-bold text-primary">
					<i class="fas fa-clock me-2"></i> Il tuo Orario -
					<%=d.getNomeMateria()%>
				</h6>
			</div>
			<div class="card-body">
				<%
				if (orari != null && !orari.isEmpty()) {
				%>
				<div class="table-responsive">
					<table class="table table-hover align-middle table-bordered">
						<thead class="table-light">
							<tr>
								<th>Giorno</th>
								<th>Orario Inizio</th>
								<th>Orario Fine</th>
								<th>Classe</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (Orario o : orari) {
							%>
							<tr>
								<td><strong><%=o.getNome_giorno()%></strong></td>
								<td><%=o.getOrario_inizio()%></td>
								<td><%=o.getOrario_fine()%></td>
								<td><%=o.getClasse()%></td>
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
					disponibile.</div>
				<%
				}
				%>
			</div>
		</div>

		<div class="card shadow mb-4">
			<div
				class="card-header py-3 d-flex justify-content-between align-items-center bg-white">
				<h6 class="m-0 font-weight-bold text-primary">
					<i class="fas fa-star me-2"></i> Voti da te Assegnati
				</h6>
				<span class="badge bg-secondary"> <%=(voti != null) ? voti.size() : 0%>
					voti totali
				</span>
			</div>
			<div class="card-body">
				<%
				if (voti != null && !voti.isEmpty()) {
				%>
				<div class="table-responsive">
					<table class="table table-hover align-middle table-bordered">
						<thead class="table-light">
							<tr>
								<th>ID Voto</th>
								<th>ID Studente</th>
								<th>Nome Studente</th>
								<th>Cognome Studente</th>
								<th>Voto</th>
								<th>Data</th>
								<th>Descrizione</th>
								<th class="text-center">Azioni</th> </tr>
						</thead>
						<tbody>
							<%
							for (Voto v : voti) {
								double val = v.getVoto();
								String badgeClass = val >= 6 ? "bg-success" : (val >= 5 ? "bg-warning text-dark" : "bg-danger");
							%>
							<tr>
								<td><span class="text-muted">#<%=v.getId()%></span></td>
								<td><%=v.getIdStudente()%></td>
								<td><%=v.getNomeStudente()%></td>
								<td><%=v.getCognomeStudente()%></td>
								<td><span class="badge badge-voto <%=badgeClass%>"><%=v.getVoto()%></span></td>
								<td><%=v.getData()%></td>
								<td><%=v.getDescrizione()%></td>
								<td class="text-center">
									<form action="DocenteDashboardServlet" method="POST" onsubmit="return confirm('Sei sicuro di voler eliminare questo voto?');" style="display:inline;">
										<input type="hidden" name="action" value="elimina">
										<input type="hidden" name="idVoto" value="<%=v.getId()%>">
										<button type="submit" class="btn btn-outline-danger btn-sm border-0" title="Elimina Voto">
											<i class="fas fa-trash-alt"></i>
										</button>
									</form>
								</td>
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
				<div class="alert alert-info" role="alert">Nessun voto ancora
					assegnato.</div>
				<%
				}
				%>
			</div>
		</div>

		<div class="card shadow mb-4">
			<div
				class="card-header py-3 d-flex justify-content-between align-items-center bg-white">
				<h6 class="m-0 font-weight-bold text-primary">
					<i class="fas fa-users me-2"></i> I tuoi Studenti
				</h6>
				<span class="badge bg-secondary"> <%=(studenti != null) ? studenti.size() : 0%>
					studenti
				</span>
			</div>
			<div class="card-body">
				<%
				if (studenti != null && !studenti.isEmpty()) {
				%>
				<div class="table-responsive">
					<table class="table table-hover align-middle table-bordered">
						<thead class="table-light">
							<tr>
								<th>ID</th>
								<th>Nome</th>
								<th>Cognome</th>
								<th>Classe</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (Studente s : studenti) {
							%>
							<tr>
								<td><span class="text-muted">#<%=s.getId()%></span></td>
								<td><%=s.getNome()%></td>
								<td><%=s.getCognome()%></td>
								<td><span class="badge bg-primary"><%=s.getClasse()%></span></td>
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
				<div class="alert alert-info" role="alert">Nessuno studente
					assegnato.</div>
				<%
				}
				%>
			</div>
		</div>

		<div class="col-lg-4 mb-4">
			<div class="card shadow">
				<div
					class="card-header py-3 bg-white d-flex justify-content-between align-items-center">
					<h6 class="m-0 font-weight-bold text-primary">
						<i class="fas fa-plus-circle me-2"></i>Assegna Voto
					</h6>
				</div>
				<div class="card-body p-3">
					<form action="DocenteDashboardServlet" method="POST">
						<div class="row g-2 mb-2">
							<div class="col-6">
								<label for="idStudente" class="form-label small text-muted mb-1">ID
									Studente</label> <input type="number"
									class="form-control form-control-sm" id="idStudente"
									name="idStudente" placeholder="Es: 12" required>
							</div>
							<div class="col-6">
								<label for="voto" class="form-label small text-muted mb-1">Voto</label>
								<input type="number" step="0.5" min="1" max="10"
									class="form-control form-control-sm" id="voto" name="voto"
									placeholder="1-10" required>
							</div>
						</div>
						<div class="mb-2">
							<label for="data" class="form-label small text-muted mb-1">Data
								Valutazione</label> <input type="date"
								class="form-control form-control-sm" id="data" name="data"
								required>
						</div>
						<div class="mb-3">
							<label for="descrizione" class="form-label small text-muted mb-1">Descrizione
								/ Note</label>
							<textarea class="form-control form-control-sm" id="descrizione"
								name="descrizione" rows="2" placeholder="Es: Verifica scritta"
								required></textarea>
						</div>
						<button type="submit" class="btn btn-primary btn-sm w-100">
							<i class="fas fa-save me-2"></i>Registra Voto
						</button>
					</form>
				</div>
			</div>
		</div>
		
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
	<script>
		// Imposta automaticamente la data odierna nel form se vuoto
		var dateField = document.getElementById('data');
		if(dateField && !dateField.value) {
			dateField.valueAsDate = new Date();
		}
	</script>
</body>
</html>