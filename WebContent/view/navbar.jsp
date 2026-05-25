<%@ page import="model.User" %>

<%
    User loggedUser = (User) session.getAttribute("user");
    String currentUri = request.getRequestURI();
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
            data-bs-target="#navMenu"
            aria-controls="navMenu"
            aria-expanded="false"
            aria-label="Toggle navigation">

            <span class="navbar-toggler-icon"></span>

        </button>

        <div class="collapse navbar-collapse" id="navMenu">

            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <!-- STUDENTI -->

                <li class="nav-item">

                    <a class="nav-link"
                       href="<%= request.getContextPath() %>/Studente">

                        <i class="bi bi-people me-1"></i>
                        Studenti

                    </a>

                </li>

                <!-- DOCENTI -->

                <li class="nav-item">

                    <a class="nav-link"
                       href="<%= request.getContextPath() %>/Docente">

                        <i class="bi bi-person-workspace me-1"></i>
                        Docenti

                    </a>

                </li>

                <!-- ORARIO SOLO STUDENTE -->

                <% if (loggedUser != null && loggedUser.isStudente()) { %>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/Orario">

                            <i class="bi bi-calendar-week me-1"></i>
                            Orario

                        </a>

                    </li>

                <% } %>

                <!-- RUOLI SOLO ADMIN -->

                <% if (loggedUser != null && loggedUser.isAdmin()) { %>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/Role">

                            <i class="bi bi-shield-lock me-1"></i>
                            Ruoli

                        </a>

                    </li>

                <% } %>

            </ul>

            <!-- UTENTE -->

            <ul class="navbar-nav ms-auto">

                <li class="nav-item dropdown">

                    <a class="nav-link dropdown-toggle"
                       href="#"
                       role="button"
                       data-bs-toggle="dropdown"
                       aria-expanded="false">

                        <i class="bi bi-person-circle me-1"></i>

                        <%= loggedUser != null
                                ? loggedUser.getUsername()
                                : "" %>

                        <span class="badge bg-warning text-dark ms-1">

                            <%= loggedUser != null
                                    ? loggedUser.getRoleName()
                                    : "" %>

                        </span>

                    </a>

                    <ul class="dropdown-menu dropdown-menu-end">

                        <li>

                            <a class="dropdown-item text-danger"
                               href="<%= request.getContextPath() %>/Logout">

                                <i class="bi bi-box-arrow-right me-1"></i>

                                Logout

                            </a>

                        </li>

                    </ul>

                </li>

            </ul>

        </div>

    </div>

</nav>
