<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Aggiungi Studente</title>

<link href=
"https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container mt-5">

    <div class="card shadow">

        <div class="card-header">

            <h3>Aggiungi Studente</h3>

        </div>

        <div class="card-body">

            <!-- Form invio dati studente -->
            <form action="../studenti"
                  method="post">

                <div class="mb-3">

                    <label>Nome</label>

                    <input type="text"
                           name="nome"
                           class="form-control"
                           required>

                </div>

                <div class="mb-3">

                    <label>Cognome</label>

                    <input type="text"
                           name="cognome"
                           class="form-control"
                           required>

                </div>

                <div class="mb-3">

                    <label>Classe</label>

                    <input type="text"
                           name="classe"
                           class="form-control"
                           required>

                </div>

                <button class="btn btn-success">

                    Salva

                </button>

            </form>

        </div>

    </div>

</div>

</body>

</html>