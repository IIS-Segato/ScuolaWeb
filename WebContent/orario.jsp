<%@ page contentType="text/html; charset=UTF-8" %>

<%
java.util.List<model.Orario> orari =
    (java.util.List<model.Orario>) request.getAttribute("orari");

String[] giorni = {"LUN","MAR","MER","GIO","VEN"};
String[] ore = {"08:00","09:00","10:00","11:00","12:00","13:00"};
%>

<!DOCTYPE html>
<html lang="it">

<head>
    <meta charset="UTF-8">
    <title>Orario</title>

    <link href="WEB-INF/lib/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">

    <style>
        .timetable {
            display: grid;
            grid-template-columns: 120px repeat(5, 1fr);
            gap: 10px;
        }

        .cell {
            background: white;
            padding: 15px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
        }

        .header {
            background: #146c5c;
            color: white;
            font-weight: bold;
        }

        .time {
            background: #dff7ef;
            font-weight: bold;
        }
    </style>
</head>

<body>

<!-- BANNER -->
<div id="banner">

    <div id="logo">
        <img src="imgs/default.png" alt="avatar">
        <h2>Orario</h2>
    </div>

    <div class="nav-links">
        <a href="homepage_studente.html">Home</a>
        <a href="voti.html">Voti</a>
        <a href="notizie.html">Notizie</a>
        <a href="Orario?action=GETALL">Orario</a>
        <a href="logout.jsp">Logout</a>
    </div>

</div>

<!-- FRECCIA INDIETRO -->
<a href="homepage_studente.html" style="
    display:inline-block;
    margin:20px;
    text-decoration:none;
    font-size:18px;
    color:#146c5c;
">
← Indietro
</a>

<div class="main-container">

    <div class="title">
        Orario settimanale
    </div>

    <div class="timetable">

        <!-- HEADER -->
        <div class="cell header">Ora</div>
        <div class="cell header">Lun</div>
        <div class="cell header">Mar</div>
        <div class="cell header">Mer</div>
        <div class="cell header">Gio</div>
        <div class="cell header">Ven</div>

        <%
        for (String ora : ore) {
        %>

            <div class="cell time"><%= ora %></div>

            <%
            for (String giorno : giorni) {

                String contenuto = "-";

                if (orari != null) {

                    for (model.Orario o : orari) {

                        if (o.getGiorno().equalsIgnoreCase(giorno)
                            && o.getOra_inizio().equals(ora)) {

                            contenuto =
                                "Ins: " + o.getId_insegnamento() +
                                "<br>Aula: " + o.getId_aula();
                        }
                    }
                }
            %>

                <div class="cell"><%= contenuto %></div>

            <%
            }
        }
        %>

    </div>
</div>

</body>
</html>