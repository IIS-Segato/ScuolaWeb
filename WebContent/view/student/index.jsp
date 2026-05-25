<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Student" %>
<!DOCTYPE html>
<html lang="it">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Studenti</title>
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

		List<Student> students = (List<Student>) request.getAttribute("students");
		if (students == null) {
		students = java.util.Collections.emptyList();
		}
		%>

		<div class="container mt-5">
			<div class="d-flex justify-content-between align-items-center mb-3">
				<h2 class="mb-0">Lista Studenti</h2>

				<% if (isAdmin) { %>
				<a href="${pageContext.request.contextPath}/Student?action=INSERT" class="btn btn-success">
					Nuovo Studente
				</a>
				<% } %>
			</div>

			<form class="row g-2 mb-4" method="get" action="${pageContext.request.contextPath}/Student">
				<input type="hidden" name="action" value="SEARCH">

				<div class="col-md-4">
					<input type="text" name="name" class="form-control" placeholder="Nome">
				</div>

				<div class="col-md-4">
					<input type="text" name="surname" class="form-control" placeholder="Cognome">
				</div>

				<div class="col-md-4">
					<input type="text" name="className" class="form-control" placeholder="Classe">
				</div>

				<div class="col-12">
					<button type="submit" class="btn btn-primary">Cerca</button>
					<a href="${pageContext.request.contextPath}/Student" class="btn btn-secondary">Reset</a>
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
									<th>Classe</th>
									<% if (isAdmin) { %><th>Azioni</th><% } %>
								</tr>
							</thead>
							<tbody>
								<%
								for (Student student : students) {
								%>
								<tr>
									<td><%= student.getId() %></td>
									<td><%= student.getName() == null ? "" : student.getName() %></td>
									<td><%= student.getSurname() == null ? "" : student.getSurname() %></td>
									<td><%= student.getClassName() == null ? "" : student.getClassName() %></td>
									<% if (isAdmin) { %>
									<td>
										<a href="${pageContext.request.contextPath}/Student?action=EDIT&id=<%= student.getId() %>"
										   class="btn btn-sm btn-warning">Modifica</a>
										<a href="${pageContext.request.contextPath}/Student?action=DELETE&id=<%= student.getId() %>"
										   class="btn btn-sm btn-danger"
										   onclick="return confirm('Vuoi eliminare questo studente?')">Elimina</a>
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
