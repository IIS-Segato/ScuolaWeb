<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="it">

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1">

<title>Le mie classi</title>

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
rel="stylesheet">

</head>

<body class="bg-light">

<%@ include file="../navbar.jsp" %>

<div class="container mt-4">

<h2 class="fw-bold mb-4">

<i class="bi bi-easel-fill text-primary me-2"></i>

Le mie classi

</h2>

<div class="row">

<%

List<String> classi =
(List<String>) request.getAttribute("classiDocente");

for(String classe : classi) {

%>

<div class="col-md-3 mb-3">

<a
href="<%= request.getContextPath() %>/Docente?classe=<%= classe %>"
class="text-decoration-none">

<div class="card shadow-sm border-0 h-100">

<div class="card-body text-center">

<i class="bi bi-people-fill text-primary"
style="font-size: 2rem;"></i>

<h4 class="mt-3 text-dark">

<%= classe %>

</h4>

<p class="text-muted small">

Visualizza studenti

</p>

</div>

</div>

</a>

</div>

<%

}

%>

</div>

</div>

</body>

</html>