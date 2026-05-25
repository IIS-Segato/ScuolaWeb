<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="it">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notizie Scuola</title>

    <!-- Stile -->
    <link href="WEB-INF/lib/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>

<body>

    <!-- Banner -->
    <div id="banner">
        <div id="logo">
            <img src="imgs/default.png" alt="admin">
            <h2>Notizie</h2>
        </div>

        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="voti.jsp">Voti</a>
            <a href="notizie.jsp">Notizie</a>
            <a href="orario.jsp">Orario</a>
            <a href="homepage.jsp">Logout</a>
        </div>
    </div>

    <!-- Indietro -->
    <a id="indietro" href="homepage.jsp">← Indietro</a>

    <!-- Main -->
    <div class="main-container">

        <div class="title">
            Ultime notizie
        </div>

        <div class="news-grid">

            <!-- NEWS 1 -->
            <div class="news-card">
                <div class="tag">Avviso</div>
                <div class="news-title">Riunione genitori</div>
                <div class="news-text">
                    Domani alle ore 17:00 si terrà la riunione con i genitori nell’aula magna.
                </div>
                <div class="news-date">10/05/2026</div>
            </div>

            <!-- NEWS 2 -->
            <div class="news-card">
                <div class="tag">Evento</div>
                <div class="news-title">Giornata sportiva</div>
                <div class="news-text">
                    Venerdì si svolgerà la giornata sportiva nel campo esterno della scuola.
                </div>
                <div class="news-date">09/05/2026</div>
            </div>

            <!-- NEWS 3 -->
            <div class="news-card">
                <div class="tag">Comunicazione</div>
                <div class="news-title">
                    Napoli, rissa a Porta Capuana: morto un 32enne, fermato l’aggressore
                </div>
                <div class="news-text">
                    Un 32enne è morto in ospedale a seguito delle ferite riportate durante una rissa scoppiata nel pomeriggio a Napoli, nella zona di Porta Capuana. L’uomo, originario del Burkina Faso, era stato soccorso e trasferito in codice rosso all’ospedale Vecchio Pellegrini, dove le sue condizioni erano apparse subito gravi. Poco dopo è deceduto. Il presunto aggressore è stato fermato dalla polizia intervenuta sul posto.
                </div>
                <div class="news-date">08/05/2026</div>
            </div>

            <!-- NEWS 4 -->
            <div class="news-card">
                <div class="tag">Didattica</div>
                <div class="news-title">Recupero interrogazioni</div>
                <div class="news-text">
                    Gli studenti con insufficienze potranno recuperare nelle prossime settimane.
                </div>
                <div class="news-date">07/05/2026</div>
            </div>

        </div>

    </div>

</body>
</html>