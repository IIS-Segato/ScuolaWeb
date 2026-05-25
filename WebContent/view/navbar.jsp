<%@ page import="model.User" %>

<%
    User loggedUser =
    (User) session.getAttribute("user");
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">

<div class="container">

<a class="navbar-brand fw-bold"
href="<%= request.getContextPath() %>/Studente">

<i class="bi bi-mortarboard-fill me-1"></i>

ScuolaWeb

</a>

<button
class="navbar-toggler"
type="button"
data-bs-toggle="collapse"
data-bs-target="#navMenu">

<span class="navbar-toggler-icon"></span>

</button>

<div class="collapse navbar-collapse"
id="navMenu">

<ul class="navbar-nav me-auto">

<!-- ADMIN -->

<% if(loggedUser != null && loggedUser.isAdmin()) { %>

<li class="nav-item">

<a class="nav-link"
href="<%= request.getContextPath() %>/Studente">

Studenti

</a>

</li>

<li class="nav-item">

<a class="nav-link"
href="<%= request.getContextPath() %>/Docente">

Docenti

</a>

</li>

<li class="nav-item">

<a class="nav-link"
href="<%= request.getContextPath() %>/Role">

Ruoli

</a>

</li>

<% } %>

<!-- STUDENTE -->

<% if(loggedUser != null && loggedUser.isStudente()) { %>

<li class="nav-item">

<a class="nav-link"
href="<%= request.getContextPath() %>/Studente">

La mia classe

</a>

</li>

<li class="nav-item">

<a class="nav-link"
href="<%= request.getContextPath() %>/Docente">

Docenti

</a>

</li>

<li class="nav-item">

<a class="nav-link"
href="<%= request.getContextPath() %>/Orario">

Orario

</a>

</li>

<% } %>

<!-- DOCENTE -->

<% if(loggedUser != null && loggedUser.isDocente()) { %>

<li class="nav-item">

<a class="nav-link"
href="<%= request.getContextPath() %>/Docente">

Le mie classi

</a>

</li>

<li class="nav-item">

<a class="nav-link"
href="<%= request.getContextPath() %>/Orario">

Il mio orario

</a>

</li>

<% } %>

</ul>

<div class="d-flex align-items-center text-white">

<span class="me-3">

<i class="bi bi-person-circle me-1"></i>

<%= loggedUser.getUsername() %>

-

<%= loggedUser.getRoleName() %>

</span>

<a
href="<%= request.getContextPath() %>/ChangePassword"
class="btn btn-outline-light btn-sm me-2">

Password

</a>

<a
href="<%= request.getContextPath() %>/Logout"
class="btn btn-outline-light btn-sm">

Logout

</a>

</div>

</div>

</div>

</nav>