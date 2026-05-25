<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List, model.Orario" %>

<!DOCTYPE html>
<html lang="it">

<head>

<meta charset="UTF-8">

<title>Orario</title>

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

<div class="card shadow-sm">

<div class="card-header bg-primary text-white fw-bold">

<i class="bi bi-calendar-week me-2"></i>

<%= request.getAttribute("titolo") %>

</div>

<div class="card-body p-0">

<table class="table table-striped table-hover mb-0">

<thead class="table-light">

<tr>

<th>Giorno</th>

<th>Ora</th>

<th>Classe</th>

<th>Materia</th>

<th>Docente</th>

</tr>

</thead>

<tbody>

<%

List<Orario> orario =
(List<Orario>) request.getAttribute("orario");

for(Orario o : orario) {

%>

<tr>

<td>
<%= o.getGiorno() %>
</td>

<td>
<%= o.getOra() %>
</td>

<td>
<%= o.getClasse() %>
</td>

<td>

<span class="badge bg-primary">

<%= o.getMateria() %>

</span>

</td>

<td>
Prof.
<%= o.getDocente() %>
</td>

</tr>

<%

}

%>

</tbody>

</table>

</div>

</div>

</div>

</body>

</html>