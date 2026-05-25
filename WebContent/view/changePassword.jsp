<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="it">

<head>

<meta charset="UTF-8">

<title>Cambia password</title>

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body class="bg-light">

<%@ include file="navbar.jsp" %>

<div class="container mt-5">

<div class="row justify-content-center">

<div class="col-md-5">

<div class="card shadow-sm">

<div class="card-header bg-primary text-white">

Cambia password

</div>

<div class="card-body">

<% if(request.getAttribute("successo") != null) { %>

<div class="alert alert-success">

<%= request.getAttribute("successo") %>

</div>

<% } %>

<form method="post"
action="ChangePassword">

<div class="mb-3">

<label class="form-label">

Nuova password

</label>

<input
type="password"
name="nuova"
class="form-control"
required>

</div>

<button
type="submit"
class="btn btn-primary w-100">

Aggiorna password

</button>

</form>

</div>

</div>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>