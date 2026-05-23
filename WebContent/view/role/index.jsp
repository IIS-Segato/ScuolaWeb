<%@ page import="java.util.List" %>
<%@ page import="model.Role" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Ruoli</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	</head>
	<body>

		<jsp:include page="/view/navbar.jsp" />

		<div class="container mt-5">
			<div class="d-flex justify-content-between align-items-center mb-3">
				<h2>Ruoli</h2>
				<a href="${pageContext.request.contextPath}/Role?action=INSERT" class="btn btn-primary">
					Aggiungi Ruolo
				</a>
			</div>

			<table class="table table-bordered table-striped shadow">
				<thead class="table-dark">
					<tr>
						<th>ID</th>
						<th>Nome</th>
						<th>Descrizione</th>
						<th>Azioni</th>
					</tr>
				</thead>

				<tbody>
					<%
					List<Role> lista = (List<Role>) request.getAttribute("roles");
					if (lista != null && !lista.isEmpty()) {
					for (Role r : lista) {
					%>
					<tr>
						<td><%= r.getId() %></td>
						<td><%= r.getRole_name() %></td>
						<td><%= r.getDescription() %></td>
						<td>
							<a href="${pageContext.request.contextPath}/Role?action=EDIT&id=<%= r.getId() %>" class="btn btn-warning btn-sm">
								Modifica
							</a>
							<a href="${pageContext.request.contextPath}/Role?action=DELETE&id=<%= r.getId() %>" class="btn btn-danger btn-sm"
																	    onclick="return confirm('Eliminare questo ruolo?');">
																	    Elimina
							</a>
						</td>
					</tr>
					<%
					}
					} else {
					%>
					<tr>
						<td colspan="4" class="text-center">Nessun ruolo presente.</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>

	</body>
</html>
