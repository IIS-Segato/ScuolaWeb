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

            <ul class="navbar-nav me-auto">

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

                <% if (loggedUser != null && loggedUser.isAdmin()) { %>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/Role">

                            Ruoli

                        </a>

                    </li>

                <% } %>

            </ul>

            <ul class="navbar-nav ms-auto">

                <li class="nav-item dropdown">

                    <a class="nav-link dropdown-toggle"
                       href="#"
                       data-bs-toggle="dropdown">

                        <%= loggedUser.getUsername() %>

                        <span class="badge bg-warning text-dark ms-1">

                            <%= loggedUser.getRoleName() %>

                        </span>

                    </a>

                    <ul class="dropdown-menu dropdown-menu-end">

                        <li>

                            <a class="dropdown-item text-danger"
                               href="<%= request.getContextPath() %>/Logout">

                                Logout

                            </a>

                        </li>

                    </ul>

                </li>

            </ul>

        </div>

    </div>

</nav>