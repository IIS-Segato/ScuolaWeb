<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List, model.Studente" %>

<!DOCTYPE html>
<html lang="it">

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1">

<title>Studenti Classe</title>

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

<div class="d-flex justify-content-between align-items-center mb-3">

<h2 class="fw-bold">

Classe

<%= request.getAttribute("classeCorrente") %>

</h2>

<a
href="<%= request.getContextPath() %>/Docente"
class="btn btn-outline-primary">

<i class="bi bi-arrow-left me-1"></i>

Torna alle classi

</a>

</div>

<div class="card shadow-sm">

<div class="card-body p-0">

<table class="table table-striped table-hover mb-0">

<thead class="table-primary">

<tr>

<th>#</th>

<th>Cognome</th>

<th>Nome</th>

</tr>

</thead>

<tbody>

<%

List<Studente> studenti =
(List<Studente>) request.getAttribute("studenti");

if(studenti == null || studenti.isEmpty()) {

%>

<tr>

<td colspan="3"
class="text-center text-muted py-3">

Nessuno studente presente

</td>

</tr>

<%

}

else {

for(Studente s : studenti) {

%>

<tr>

<td>
<%= s.getId() %>
</td>

<td>
<%= s.getCognome() %>
</td>

<td>
<%= s.getNome() %>
</td>

</tr>

<%

}

}

%>

</tbody>

</table>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>