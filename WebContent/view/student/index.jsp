<%@ page import="java.util.List" %>
<%@ page import="model.Student" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Studenti</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	</head>
	<body>

		<jsp:include page="/view/navbar.jsp" />

		<div class="container mt-5">
			<div class="d-flex justify-content-between align-items-center mb-3">
				<h2>Studenti</h2>
				<a href="${pageContext.request.contextPath}/Student?action=INSERT" class="btn btn-primary">
					Aggiungi Studente
				</a>
			</div>

			<table class="table table-bordered table-striped shadow">
				<thead class="table-dark">
					<tr>
						<th>ID</th>
						<th>Nome</th>
						<th>Cognome</th>
						<th>Classe</th>
						<th>Azioni</th>
					</tr>
				</thead>

				<tbody>
					<%
					List<Student> lista = (List<Student>) request.getAttribute("students");
					if (lista != null && !lista.isEmpty()) {
					for (Student s : lista) {
					%>
					<tr>
						<td><%= s.getId() %></td>
						<td><%= s.getName() %></td>
						<td><%= s.getSurname() %></td>
						<td><%= s.getClassName() %></td>
						<td>
							<a href="${pageContext.request.contextPath}/Student?action=EDIT&id=<%= s.getId() %>" class="btn btn-warning btn-sm">
								Modifica
							</a>
							<a href="${pageContext.request.contextPath}/Student?action=DELETE&id=<%= s.getId() %>" class="btn btn-danger btn-sm"
																	       onclick="return confirm('Eliminare questo studente?');">
																	       Elimina
							</a>
						</td>
					</tr>
					<%
					}
					} else {
					%>
					<tr>
						<td colspan="5" class="text-center">Nessuno studente presente.</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>

	</body>
</html>
