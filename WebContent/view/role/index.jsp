<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.List, java.util.ArrayList, model.Role, model.Utente"%>

<%
List<Role> roles = (List<Role>) request.getAttribute("roles");
if (roles == null)
	roles = new ArrayList<>();

Utente utente = (Utente) session.getAttribute("utente");
boolean isAdmin = utente != null && utente.isAdmin();
%>

<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ScuolaWeb – Ruoli</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
body {
	background-color: #f0f2f5;
}

.table-hover tbody tr:hover {
	background-color: #fdeaea;
}
</style>
</head>

<body>

	<%@ include file="../includes/navbar.jsp"%>

	<div class="container py-4">


		<div class="d-flex justify-content-between align-items-center mb-4">
			<div>
				<h3 class="fw-bold mb-0">
					<i class="bi bi-shield-lock-fill text-danger me-2"></i> Gestione
					Ruoli
				</h3>

				<p class="text-muted small mb-0">
					<%=roles.size()%>
					ruoli configurati
				</p>
			</div>

			<%
			if (isAdmin) {
			%>
			<a href="Role?action=INSERT" class="btn btn-danger"> <i
				class="bi bi-plus-circle me-1"></i> Nuovo Ruolo
			</a>
			<%
			}
			%>
		</div>


		<div class="card border-0 shadow-sm">
			<div class="card-body p-0">

				<%
				if (roles.isEmpty()) {
				%>

				<div class="text-center py-5 text-muted">
					<i class="bi bi-inbox display-4 d-block mb-2"></i> Nessun ruolo
					trovato.

					<%
					if (isAdmin) {
					%>
					<br> <a href="Role?action=INSERT"> Aggiungi il primo ruolo
					</a>
					<%
					}
					%>
				</div>

				<%
				} else {
				%>

				<div class="table-responsive">
					<table class="table table-hover align-middle mb-0">

						<thead class="table-dark">
							<tr>
								<th scope="col" style="width: 60px">#</th>
								<th scope="col">Nome Ruolo</th>
								<th scope="col">Descrizione</th>

								<%
								if (isAdmin) {
								%>
								<th scope="col" class="text-center">Azioni</th>
								<%
								}
								%>
							</tr>
						</thead>

						<tbody>

							<%
							for (Role role : roles) {
							%>

							<tr>

								<td class="text-muted small"><%=role.getId()%></td>

								<td><span
									class="badge bg-danger bg-opacity-10 text-danger border border-danger-subtle fs-6">
										<%=role.getRole_name()%>
								</span></td>

								<td class="text-muted"><%=role.getDescription() != null ? role.getDescription() : "—"%></td>

								<%
								if (isAdmin) {
								%>
								<td class="text-center"><a
									href="Role?action=EDIT&id=<%=role.getId()%>"
									class="btn btn-sm btn-outline-primary me-1" title="Modifica">

										<i class="bi bi-pencil-fill"></i>
								</a> <a href="Role?action=DELETE&id=<%=role.getId()%>"
									class="btn btn-sm btn-outline-danger" title="Elimina"
									onclick="return confirm('Eliminare il ruolo <%=role.getRole_name()%>?')">

										<i class="bi bi-trash3-fill"></i>
								</a></td>
								<%
								}
								%>

							</tr>

							<%
							}
							%>

						</tbody>

					</table>
				</div>

				<%
				}
				%>

			</div>
		</div>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>