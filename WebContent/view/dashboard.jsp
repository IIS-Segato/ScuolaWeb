<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Dashboard</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	</head>
	<body>

		<jsp:include page="/view/navbar.jsp" />

		<div class="container mt-5">
			<h2 class="mb-4">Dashboard</h2>

			<div class="row g-4">
				<div class="col-md-6">
					<div class="card bg-primary text-white shadow h-100">
						<div class="card-body">
							<h3>Gestione Studenti</h3>
							<p>Visualizza, aggiungi, modifica ed elimina gli studenti.</p>
							<a href="${pageContext.request.contextPath}/Student" class="btn btn-light">
								Vai agli studenti
							</a>
						</div>
					</div>
				</div>

				<div class="col-md-6">
					<div class="card bg-success text-white shadow h-100">
						<div class="card-body">
							<h3>Gestione Ruoli</h3>
							<p>Visualizza, aggiungi, modifica ed elimina i ruoli.</p>
							<a href="${pageContext.request.contextPath}/Role" class="btn btn-light">
								Vai ai ruoli
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>

		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	</body>
</html>
