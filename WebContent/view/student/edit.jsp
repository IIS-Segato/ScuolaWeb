<%@ page import="model.Student" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
Student student = (Student) request.getAttribute("student");
String action = (String) request.getAttribute("action");
String error = (String) request.getAttribute("error");

if (student == null) {
student = new Student();
}

if (action == null) {
action = "INSERT";
}

String title = "INSERT".equals(action) ? "Aggiungi Studente" : "Modifica Studente";
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title><%= title %></title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	</head>
	<body>

		<jsp:include page="/view/navbar.jsp" />

		<div class="container mt-5">
			<div class="card shadow">
				<div class="card-header">
					<h3><%= title %></h3>
				</div>

				<div class="card-body">
					<% if (error != null) { %>
					<div class="alert alert-danger"><%= error %></div>
					<% } %>

					<form action="${pageContext.request.contextPath}/Student" method="post">
						<input type="hidden" name="action" value="<%= action %>">
						<input type="hidden" name="id" value="<%= student.getId() %>">

						<div class="mb-3">
							<label class="form-label">Nome</label>
							<input type="text" name="name" class="form-control"
										       value="<%= student.getName() != null ? student.getName() : "" %>" required>
						</div>

						<div class="mb-3">
							<label class="form-label">Cognome</label>
							<input type="text" name="surname" class="form-control"
											  value="<%= student.getSurname() != null ? student.getSurname() : "" %>" required>
						</div>

						<div class="mb-3">
							<label class="form-label">Classe</label>
							<input type="text" name="className" class="form-control"
											    value="<%= student.getClassName() != null ? student.getClassName() : "" %>" required>
						</div>

						<button type="submit" class="btn btn-success">Salva</button>
						<a href="${pageContext.request.contextPath}/Student" class="btn btn-secondary">Annulla</a>
					</form>
				</div>
			</div>
		</div>

	</body>
</html>
