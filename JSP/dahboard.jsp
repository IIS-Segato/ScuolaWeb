<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Dashboard</title>

<link href=
"https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet" href="css/style.css">

</head>

<body>

<!-- Inserisce la navbar -->
<jsp:include page="jsp/navbar.jsp" />

<div class="container mt-5">

    <h2 class="mb-4">

        Dashboard

    </h2>

    <div class="row">

        <div class="col-md-6">

            <!-- Card gestione studenti -->
            <div class="card
                        bg-primary
                        text-white
                        shadow
                        card-dashboard">

                <div class="card-body">

                    <h3>

                        Gestione Studenti

                    </h3>

                    <p>

                        Visualizza e gestisci gli studenti

                    </p>

                    <a href="studenti"
                       class="btn btn-light">

                       Vai

                    </a>

                </div>

            </div>

        </div>

        <div class="col-md-6">

            <!-- Card gestione docenti -->
            <div class="card
                        bg-success
                        text-white
                        shadow
                        card-dashboard">

                <div class="card-body">

                    <h3>

                        Gestione Docenti

                    </h3>

                    <p>

                        Visualizza e gestisci i docenti

                    </p>

                    <a href="docenti"
                       class="btn btn-light">

                       Vai

                    </a>

                </div>

            </div>

        </div>

    </div>

</div>

</body>

</html>