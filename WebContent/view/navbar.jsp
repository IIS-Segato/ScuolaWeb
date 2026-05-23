<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	<div class="container-fluid">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/view/dashboard.jsp">
			School Manager
		</a>

		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="menu">
			<ul class="navbar-nav me-auto">
				<li class="nav-item">
					<a class="nav-link" href="${pageContext.request.contextPath}/Student">
						Studenti
					</a>
				</li>

				<li class="nav-item">
					<a class="nav-link" href="${pageContext.request.contextPath}/Role">
						Ruoli
					</a>
				</li>
			</ul>

			<a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
				Logout
			</a>
		</div>
	</div>
</nav>
