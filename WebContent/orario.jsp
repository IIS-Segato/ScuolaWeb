<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Recuperiamo la lista degli orari passata dal controller
    java.util.List<model.Orario> orari = (java.util.List<model.Orario>) request.getAttribute("orari");

    String[] giorni = {"LUN","MAR","MER","GIO","VEN"};
    
    // Stringhe di controllo tarate sul formato TIME del database (8 caratteri)
    String[] oreDb = {"08:00:00","09:00:00","10:00:00","11:00:00","12:00:00","13:00:00"};
    
    // Stringhe semplificate per la visualizzazione a schermo della prima colonna
    String[] oreVisualizzate = {"08:00","09:00","10:00","11:00","12:00","13:00"};
%>

<!DOCTYPE html>
<html lang="it">

<head>
    <meta charset="UTF-8">
    <title>Orario Settimanale</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">

    <style>
        .timetable {
            display: grid;
            grid-template-columns: 120px repeat(5, 1fr);
            gap: 10px;
        }

        .cell {
            background: white;
            padding: 12px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 80px;
        }

        .header {
            background: #146c5c;
            color: white;
            font-weight: bold;
            min-height: auto;
            padding: 15px;
        }

        .time {
            background: #dff7ef;
            font-weight: bold;
        }
        
        .subject-name {
            font-weight: bold;
            color: #146c5c;
            font-size: 14px;
        }
        
        .prof-name {
            font-size: 12px;
            color: #444;
            margin-top: 2px;
            font-style: italic;
        }
        
        .classroom-name {
            font-size: 11px;
            color: #777;
            margin-top: 4px;
            background: #f0f0f0;
            padding: 2px 8px;
            border-radius: 8px;
        }
    </style>
</head>

<body>

<div id="banner">
    <div id="logo">
        <img src="${pageContext.request.contextPath}/imgs/default.png" alt="avatar">
        <h2>Orario</h2>
    </div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/LoginController">Home</a>
        <a href="${pageContext.request.contextPath}/VotoController">Voti</a>
        <a href="notizie.html">Notizie</a>
        <a href="${pageContext.request.contextPath}/OrarioController">Orario</a>
        <a href="${pageContext.request.contextPath}/logout.jsp">Logout</a>
    </div>
</div>

<a href="#" onclick="history.back(); return false;" style="
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
        Orario delle Lezioni
    </div>

    <div class="timetable">

        <div class="cell header">Ora</div>
        <div class="cell header">Lun</div>
        <div class="cell header">Mar</div>
        <div class="cell header">Mer</div>
        <div class="cell header">Gio</div>
        <div class="cell header">Ven</div>

        <%
        for (int i = 0; i < oreDb.length; i++) {
            String oraCercata = oreDb[i];
            String oraDisplay = oreVisualizzate[i];
        %>
            <div class="cell time"><%= oraDisplay %></div>

            <%
            for (String giorno : giorni) {
                String contenuto = "<span class='text-muted'>-</span>";

                if (orari != null) {
                    for (model.Orario o : orari) {
                        
                        // Confronto incrociato tra Giorno ed Ora Inizio (escludendo i secondi superflui nel check)
                        if (o.getGiorno().trim().equalsIgnoreCase(giorno.trim())
                            && o.getOra_inizio().toString().substring(0, 5).equals(oraCercata.substring(0, 5))) {

                            // Estraiamo l'iniziale del nome del docente (es: "M. Rossi")
                            String inizialeNome = (o.getNomeDocente() != null && !o.getNomeDocente().isEmpty()) 
                                                ? o.getNomeDocente().substring(0, 1) + "." 
                                                : "";
                            
                            // Composizione HTML della materia reale con docente e aula
                            contenuto = "<span class='subject-name'>" + o.getNomeMateria() + "</span>" +
                                        "<span class='prof-name'>" + inizialeNome + " " + o.getCognomeDocente() + "</span>" +
                                        "<span class='classroom-name'>" + o.getNomeAula() + "</span>";
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