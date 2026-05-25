<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List, model.Studente, model.User" %>

<!DOCTYPE html>
<html lang="it">

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1">

<title>Studenti</title>

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

<%

model.Studente mioProfilo =
(model.Studente)
request.getAttribute("studenteCorrente");

if(mioProfilo != null) {

%>

<div class="card shadow-sm border-primary mb-4">

<div class="card-body">

<h5 class="fw-bold text-primary">

<i class="bi bi-person-circle me-2"></i>

I miei dati

</h5>

<div class="row">

<div class="col-md-4">

<b>Nome:</b>

<%= mioProfilo.getNome() %>

</div>

<div class="col-md-4">

<b>Cognome:</b>

<%= mioProfilo.getCognome() %>

</div>

<div class="col-md-4">

<b>Classe:</b>

<%= mioProfilo.getNomeClasse() %>

</div>

</div>

</div>

</div>

<%

}

%>

<div class="d-flex justify-content-between align-items-center mb-3">

<h2 class="fw-bold">

<i class="bi bi-people-fill text-primary me-2"></i>

Elenco Studenti

</h2>

<% if (loggedUser != null && loggedUser.isAdmin()) { %>

<a
href="<%= request.getContextPath() %>/Studente?action=INSERT"
class="btn btn-success">

<i class="bi bi-plus-circle me-1"></i>

Nuovo Studente

</a>

<% } %>

</div>

<%

List<Studente> studenti =
(List<Studente>)
request.getAttribute("studenti");

%>

<div class="card shadow-sm">

<div class="card-body p-0">

<table class="table table-hover table-striped mb-0">

<thead class="table-primary">

<tr>

<th>#</th>

<th>Cognome</th>

<th>Nome</th>

<th>Classe</th>

<% if (loggedUser != null && loggedUser.isAdmin()) { %>

<th class="text-center">

Azioni

</th>

<% } %>

</tr>

</thead>

<tbody>

<% if(studenti == null || studenti.isEmpty()) { %>

<tr>

<td colspan="5"
class="text-center py-3 text-muted">

Nessuno studente presente

</td>

</tr>

<% }

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

<td>

<span class="badge bg-secondary">

<%= s.getNomeClasse() %>

</span>

</td>

<% if (loggedUser != null && loggedUser.isAdmin()) { %>

<td class="text-center">

<a
href="<%= request.getContextPath() %>/Studente?action=EDIT&id=<%= s.getId() %>"
class="btn btn-warning btn-sm me-1">

<i class="bi bi-pencil"></i>

</a>

<a
href="<%= request.getContextPath() %>/Studente?action=DELETE&id=<%= s.getId() %>"
class="btn btn-danger btn-sm">

<i class="bi bi-trash"></i>

</a>

</td>

<% } %>

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

</body>

</html>