<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Studente" %>

<!DOCTYPE html>
<html lang="it">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>ScuolaWeb – Studente</title>

    <!-- Bootstrap CSS -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
        rel="stylesheet">

</head>

<body class="bg-light">

    <%@ include file="../navbar.jsp" %>

    <%
        Studente s = (Studente) request.getAttribute("studente");

        String action =
                (String) request.getAttribute("action");

        boolean isInsert =
                "INSERT".equals(action);

        String titolo =
                isInsert ? "Nuovo Studente" : "Modifica Studente";
    %>

    <div class="container mt-4">

        <div class="row justify-content-center">

            <div class="col-md-6">

                <div class="card shadow-sm">

                    <div class="card-header bg-primary text-white fw-bold">

                        <i class="bi bi-person-<%= isInsert ? "plus" : "gear" %> me-2"></i>

                        <%= titolo %>

                    </div>

                    <div class="card-body">

                        <form
                            method="post"
                            action="<%= request.getContextPath() %>/Studente">

                            <input
                                type="hidden"
                                name="action"
                                value="<%= action %>">

                            <input
                                type="hidden"
                                name="id"
                                value="<%= s.getId() %>">

                            <!-- NOME -->

                            <div class="mb-3">

                                <label class="form-label fw-semibold">

                                    Nome

                                </label>

                                <input
                                    type="text"
                                    name="nome"
                                    class="form-control"
                                    value="<%= s.getNome() != null ? s.getNome() : "" %>"
                                    required
                                    placeholder="Es. Mario">

                            </div>

                            <!-- COGNOME -->

                            <div class="mb-3">

                                <label class="form-label fw-semibold">

                                    Cognome

                                </label>

                                <input
                                    type="text"
                                    name="cognome"
                                    class="form-control"
                                    value="<%= s.getCognome() != null ? s.getCognome() : "" %>"
                                    required
                                    placeholder="Es. Rossi">

                            </div>

                            <!-- CLASSE -->

                            <div class="mb-4">

                                <label class="form-label fw-semibold">

                                    Classe

                                </label>

                                <select
                                    name="classeId"
                                    class="form-select"
                                    required>

                                    <option value="1"
                                        <%= s.getClasseId() == 1 ? "selected" : "" %>>

                                        5IA

                                    </option>

                                    <option value="2"
                                        <%= s.getClasseId() == 2 ? "selected" : "" %>>

                                        5IB

                                    </option>

                                    <option value="3"
                                        <%= s.getClasseId() == 3 ? "selected" : "" %>>

                                        4IA

                                    </option>

                                    <option value="4"
                                        <%= s.getClasseId() == 4 ? "selected" : "" %>>

                                        4IB

                                    </option>

                                </select>

                            </div>

                            <!-- BOTTONI -->

                            <div class="d-flex gap-2">

                                <button
                                    type="submit"
                                    class="btn btn-primary">

                                    <i class="bi bi-save me-1"></i>

                                    Salva

                                </button>

                                <a
                                    href="<%= request.getContextPath() %>/Studente"
                                    class="btn btn-outline-secondary">

                                    <i class="bi bi-arrow-left me-1"></i>

                                    Annulla

                                </a>

                            </div>

                        </form>

                    </div>

                </div>

            </div>

        </div>

    </div>

    <!-- Bootstrap JS -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>