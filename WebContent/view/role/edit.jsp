<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Role"%>

<%
Role role = (Role) request.getAttribute("role");

boolean edit = role != null && role.getId() > 0;

String errore = (String) request.getAttribute("errore");
%>

<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%=edit ? "Modifica Ruolo" : "Nuovo Ruolo"%></title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
body {
	background-color: #f0f2f5;
}

.card {
	border: none;
	border-radius: 16px;
}

.card-header {
	border-radius: 16px 16px 0 0 !important;
}
</style>
</head>

<body>

	<%@ include file="../includes/navbar.jsp"%>

	<div class="container py-4">

		<div class="row justify-content-center">
			<div class="col-lg-7">

				<div class="card shadow-sm">


					<div class="card-header bg-danger text-white py-3">
						<h4 class="mb-0 fw-bold">
							<i class="bi bi-shield-lock-fill me-2"></i>

							<%=edit ? "Modifica Ruolo" : "Nuovo Ruolo"%>
						</h4>
					</div>

					<div class="card-body p-4">

						<%
						if (errore != null) {
						%>
						<div class="alert alert-danger d-flex align-items-center">
							<i class="bi bi-exclamation-triangle-fill me-2"></i>
							<%=errore%>
						</div>
						<%
						}
						%>

						<form action="Role" method="post">

							<%
							if (edit) {
							%>
							<input type="hidden" name="id" value="<%=role.getId()%>">
							<%
							}
							%>

							<div class="mb-3">
								<label class="form-label fw-semibold"> Nome ruolo </label> <input
									type="text" name="role_name"
									class="form-control form-control-lg" required
									value="<%=edit ? role.getRole_name() : ""%>">

								<div class="form-text">Inserisci un ruolo valido (es.
									admin, docente, studente)</div>
							</div>

							<div class="mb-4">
								<label class="form-label fw-semibold"> Descrizione </label>

								<textarea name="description" class="form-control" rows="3"><%=edit && role.getDescription() != null ? role.getDescription() : ""%></textarea>
							</div>


							<div class="d-flex gap-2">

								<button type="submit" class="btn btn-danger fw-semibold">

									<i class="bi bi-check-circle me-1"></i> Salva
								</button>

								<button type="reset" class="btn btn-outline-secondary">

									<i class="bi bi-arrow-counterclockwise me-1"></i> Reset
								</button>

								<a href="Role" class="btn btn-outline-secondary ms-auto"> <i
									class="bi bi-x-circle me-1"></i> Annulla
								</a>

							</div>

						</form>

					</div>
				</div>

			</div>
		</div>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>