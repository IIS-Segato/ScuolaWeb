<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
model.Teacher teacher = (model.Teacher) request.getAttribute("teacher");
String action = (String) request.getAttribute("action");
String error = (String) request.getAttribute("error");

if (teacher == null) {
teacher = new model.Teacher();
}

if (action == null) {
action = "INSERT";
}
%>
<!DOCTYPE html>
<html lang="it">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title><%= "UPDATE".equalsIgnoreCase(action) ? "Modifica Docente" : "Nuovo Docente" %></title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	</head>
	<body>

		<jsp:include page="/view/navbar.jsp" />

		<div class="container mt-5">
			<div class="row justify-content-center">
				<div class="col-md-6">

					<div class="card shadow">
						<div class="card-header">
							<h3 class="mb-0">
								<%= "UPDATE".equalsIgnoreCase(action) ? "Modifica Docente" : "Aggiungi Docente" %>
							</h3>
						</div>

						<div class="card-body">
							<form method="post" action="${pageContext.request.contextPath}/Teacher">
								<input type="hidden" name="action" value="<%= action %>">
								<input type="hidden" name="id" value="<%= teacher.getId() %>">

								<div class="mb-3">
									<label for="name" class="form-label">Nome</label>
									<input type="text"
									       id="name"
									       name="name"
									       class="form-control"
									       value="<%= teacher.getName() == null ? "" : teacher.getName() %>"
									       required>
								</div>

								<div class="mb-3">
									<label for="surname" class="form-label">Cognome</label>
									<input type="text"
									       id="surname"
									       name="surname"
									       class="form-control"
									       value="<%= teacher.getSurname() == null ? "" : teacher.getSurname() %>"
									       required>
								</div>

								<div class="mb-3">
									<label for="subject" class="form-label">Materia</label>
									<input type="text"
									       id="subject"
									       name="subject"
									       class="form-control"
									       value="<%= teacher.getSubject() == null ? "" : teacher.getSubject() %>"
									       required>
								</div>

								<% if (error != null) { %>
								<div class="alert alert-danger" role="alert">
									<%= error %>
								</div>
								<% } %>

								<div class="d-flex gap-2">
									<button type="submit" class="btn btn-primary">
										<%= "UPDATE".equalsIgnoreCase(action) ? "Salva modifiche" : "Salva docente" %>
									</button>
									<a href="${pageContext.request.contextPath}/Teacher" class="btn btn-secondary">
										Annulla
									</a>
								</div>
							</form>
						</div>
					</div>

				</div>
			</div>
		</div>

		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	</body>
</html>
