<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Login</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	</head>
	<body>

		<div class="container mt-5">
			<div class="row justify-content-center">
				<div class="col-md-4">
					<div class="card shadow">
						<div class="card-header text-center">
							<h3 class="mb-0">School Manager</h3>
						</div>

						<div class="card-body">
							<form action="${pageContext.request.contextPath}/login" method="post">
								<div class="mb-3">
									<label for="username" class="form-label">Username</label>
									<input type="text" id="username" name="username" class="form-control" required autofocus>
								</div>

								<div class="mb-3">
									<label for="password" class="form-label">Password</label>
									<input type="password" id="password" name="password" class="form-control" required>
								</div>

								<button type="submit" class="btn btn-primary w-100">Login</button>
							</form>

							<%
							String errore = request.getParameter("errore");
							if (errore != null) {
							%>
							<div class="alert alert-danger mt-3 mb-0" role="alert">
								Credenziali errate
							</div>
							<%
							}
							%>
						</div>
					</div>
				</div>
			</div>
		</div>

	</body>
</html>
