<%@ page import="model.User" %>

<%
    User loggedUser = (User) session.getAttribute("user");
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

        <div class="collapse navbar-collapse" id="navMenu">

            <!-- MENU -->

            <ul class="navbar-nav me-auto">

                <!-- ADMIN -->

                <% if(loggedUser != null && loggedUser.isAdmin()) { %>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/Studente">

                            <i class="bi bi-people me-1"></i>

                            Studenti

                        </a>

                    </li>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/Docente">

                            <i class="bi bi-person-workspace me-1"></i>

                            Docenti

                        </a>

                    </li>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/Role">

                            <i class="bi bi-shield-lock me-1"></i>

                            Ruoli

                        </a>

                    </li>

                <% } %>

                <!-- STUDENTE -->

                <% if(loggedUser != null && loggedUser.isStudente()) { %>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/Studente">

                            <i class="bi bi-people me-1"></i>

                            La mia classe

                        </a>

                    </li>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/Docente">

                            <i class="bi bi-person-workspace me-1"></i>

                            Docenti

                        </a>

                    </li>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/Orario">

                            <i class="bi bi-calendar-week me-1"></i>

                            Orario

                        </a>

                    </li>

                <% } %>

                <!-- DOCENTE -->

                <% if(loggedUser != null && loggedUser.isDocente()) { %>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/Docente">

                            <i class="bi bi-easel-fill me-1"></i>

                            Le mie classi

                        </a>

                    </li>

                <% } %>

            </ul>

            <!-- DESTRA -->

            <div class="d-flex align-items-center text-white">

                <span class="me-3">

                    <i class="bi bi-person-circle me-1"></i>

                    <%= loggedUser.getUsername() %>

                    -

                    <%= loggedUser.getRoleName() %>

                </span>

                <a
                    href="<%= request.getContextPath() %>/Logout"
                    class="btn btn-outline-light btn-sm">

                    <i class="bi bi-box-arrow-right me-1"></i>

                    Logout

                </a>

            </div>

        </div>

    </div>

</nav>