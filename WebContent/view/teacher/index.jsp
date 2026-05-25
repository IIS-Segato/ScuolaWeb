<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Teacher" %>
<!DOCTYPE html>
<html lang="it">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Docenti</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	</head>
	<body>

		<jsp:include page="/view/navbar.jsp" />

		<%
		String role = (String) session.getAttribute("role");
		boolean isAdmin = role != null && (role.equalsIgnoreCase("admin")
		|| role.equalsIgnoreCase("administrator")
		|| role.equalsIgnoreCase("amministratore"));

		List<Teacher> teachers = (List<Teacher>) request.getAttribute("teachers");
		if (teachers == null) {
		teachers = java.util.Collections.emptyList();
		}
		%>

		<div class="container mt-5">
			<div class="d-flex justify-content-between align-items-center mb-3">
				<h2 class="mb-0">Lista Docenti</h2>

				<% if (isAdmin) { %>
				<a href="${pageContext.request.contextPath}/Teacher?action=INSERT" class="btn btn-success">
					Nuovo Docente
				</a>
				<% } %>
			</div>

			<form class="row g-2 mb-4" method="get" action="${pageContext.request.contextPath}/Teacher">
				<input type="hidden" name="action" value="SEARCH">

				<div class="col-md-4">
					<input type="text" name="name" class="form-control" placeholder="Nome">
				</div>

				<div class="col-md-4">
					<input type="text" name="surname" class="form-control" placeholder="Cognome">
				</div>

				<div class="col-md-4">
					<input type="text" name="subject" class="form-control" placeholder="Materia">
				</div>

				<div class="col-12">
					<button type="submit" class="btn btn-primary">Cerca</button>
					<a href="${pageContext.request.contextPath}/Teacher" class="btn btn-secondary">Reset</a>
				</div>
			</form>

			<div class="card shadow">
				<div class="card-body p-0">
					<div class="table-responsive">
						<table class="table table-striped mb-0">
							<thead class="table-dark">
								<tr>
									<th>ID</th>
									<th>Nome</th>
									<th>Cognome</th>
									<th>Materia</th>
									<% if (isAdmin) { %><th>Azioni</th><% } %>
								</tr>
							</thead>
							<tbody>
								<%
								for (Teacher teacher : teachers) {
								%>
								<tr>
									<td><%= teacher.getId() %></td>
									<td><%= teacher.getName() == null ? "" : teacher.getName() %></td>
									<td><%= teacher.getSurname() == null ? "" : teacher.getSurname() %></td>
									<td><%= teacher.getSubject() == null ? "" : teacher.getSubject() %></td>
									<% if (isAdmin) { %>
									<td>
										<a href="${pageContext.request.contextPath}/Teacher?action=EDIT&id=<%= teacher.getId() %>"
										   class="btn btn-sm btn-warning">Modifica</a>
										<a href="${pageContext.request.contextPath}/Teacher?action=DELETE&id=<%= teacher.getId() %>"
										   class="btn btn-sm btn-danger"
										   onclick="return confirm('Vuoi eliminare questo docente?')">Elimina</a>
									</td>
									<% } %>
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	</body>
</html>
