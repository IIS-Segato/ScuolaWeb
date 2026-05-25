<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="it">

<head>

<meta charset="UTF-8">

<title>Le mie classi</title>

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body class="bg-light">

<%@ include file="../navbar.jsp" %>

<div class="container mt-4">

<h2 class="fw-bold mb-4">
Le mie classi
</h2>

<div class="row">

<%

List<String> classi =
(List<String>) request.getAttribute("classiDocente");

for(String classe : classi) {

%>

<div class="col-md-3 mb-3">

<div class="card shadow-sm">

<div class="card-body text-center">

<h4>
<%= classe %>
</h4>

</div>

</div>

</div>

<%

}

%>

</div>

</div>

</body>

</html>