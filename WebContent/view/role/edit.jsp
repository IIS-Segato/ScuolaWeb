<%@ page import="model.Role" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
Role role = (Role) request.getAttribute("role");
String action = (String) request.getAttribute("action");
String error = (String) request.getAttribute("error");

if (role == null) {
role = new Role();
}

if (action == null) {
action = "INSERT";
}

String title = "INSERT".equals(action) ? "Aggiungi Ruolo" : "Modifica Ruolo";
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

					<form action="${pageContext.request.contextPath}/Role" method="post">
						<input type="hidden" name="action" value="<%= action %>">
						<input type="hidden" name="id" value="<%= role.getId() %>">

						<div class="mb-3">
							<label class="form-label">Nome</label>
							<input type="text" name="role_name" class="form-control"
											    value="<%= role.getRole_name() != null ? role.getRole_name() : "" %>" required>
						</div>

						<div class="mb-3">
							<label class="form-label">Descrizione</label>
							<textarea name="description" class="form-control" rows="4" required><%= role.getDescription() != null ? role.getDescription() : "" %></textarea>
						</div>

						<button type="submit" class="btn btn-success">Salva</button>
						<a href="${pageContext.request.contextPath}/Role" class="btn btn-secondary">Annulla</a>
					</form>
				</div>
			</div>
		</div>

	</body>
</html>
