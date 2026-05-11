<!DOCTYPE html>
<html lang="it">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro Voti</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to bottom, #dff7ef, #f7fffc);
            font-family: Arial, Helvetica, sans-serif;
            margin: 0;
        }

        #upBar {
            background-color: #146c5c;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        #logoSection {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        #logoSection img {
            width: 55px;
            height: 55px;
            border-radius: 50%;
            border: 2px solid white;
        }

        #logoSection h2 {
            color: white;
            margin: 0;
        }

        .nav-links a {
            color: white;
            margin-left: 15px;
            text-decoration: none;
        }

        #backPage {
            display: inline-block;
            margin: 20px;
            padding: 10px 18px;
            background: #146c5c;
            color: white;
            border-radius: 10px;
            text-decoration: none;
        }

        .main-container {
            width: 90%;
            max-width: 1100px;
            margin: auto;
        }

        .title {
            font-size: 32px;
            color: #146c5c;
            margin: 25px 0;
            font-weight: bold;
        }

        .votes-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
        }

        .vote-card {
            background: white;
            padding: 20px;
            border-radius: 18px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.1);
        }

        .subject {
            font-size: 20px;
            font-weight: bold;
            color: #146c5c;
        }

        .vote {
            font-size: 40px;
            font-weight: bold;
            margin-top: 10px;
        }

        .good { color: green; }
        .medium { color: orange; }
        .bad { color: red; }

        .date {
            color: gray;
            margin-top: 8px;
        }
    </style>
</head>

<body>

<!-- BACK -->
<a id="backPage" href="#" onclick="history.back(); return false;">← Indietro</a>

<!-- NAVBAR -->
<div id="upBar">

    <div id="logoSection">
        <img src="default_avatar.webp" alt="avatar">
        <h2>Registro Studente</h2>
    </div>

    <div class="nav-links">
        <a href="index.html">Home</a>
        <a href="notizie.html">Notizie</a>
        <a href="orario.html">Orario</a>
        <a href="homepage.jsp">Logout</a>
    </div>

</div>

<!-- MAIN -->
<div class="main-container">

    <div class="title">
        Ultimi 4 voti ricevuti
    </div>

    <div class="votes-grid">

        <!-- VOTO 1 -->
        <div class="vote-card">
            <div class="subject">Matematica</div>
            <div class="vote good">6</div>
            <div class="date">12/05/2026</div>
        </div>

        <!-- VOTO 2 -->
        <div class="vote-card">
            <div class="subject">Informatica</div>
            <div class="vote good">10</div>
            <div class="date">10/05/2026</div>
        </div>

        <!-- VOTO 3 -->
        <div class="vote-card">
            <div class="subject">Italiano</div>
            <div class="vote medium">6</div>
            <div class="date">08/05/2026</div>
        </div>

        <!-- VOTO 4 -->
        <div class="vote-card">
            <div class="subject">Storia</div>
            <div class="vote bad">4</div>
            <div class="date">06/05/2026</div>
        </div>

    </div>
<!-- SEZIONE MATERIE -->
<div class="main-container" style="margin-top: 60px;">

    <div class="title">
        Materie
    </div>

    <div id="subjects" class="d-flex flex-wrap gap-2"></div>

</div>

<!-- SEZIONE VOTI FILTRATI -->
<div class="main-container" style="margin-top: 40px;">

    <div class="title" id="selectedTitle">
        Tutti i voti
    </div>

    <div id="votesGrid" class="votes-grid"></div>

</div>

<script>
    // 📦 dati simulati (poi arrivano dal backend Java)
    const voti = [
        { materia: "Matematica", voto: 6, data: "12/05/2026" },
        { materia: "Matematica", voto: 7, data: "10/05/2026" },
        { materia: "Informatica", voto: 10, data: "09/05/2026" },
        { materia: "Italiano", voto: 6, data: "08/05/2026" },
        { materia: "Storia", voto: 4, data: "06/05/2026" },
        { materia: "Inglese", voto: 6, data: "05/05/2026" },
        { materia: "Sistemi e Reti", voto: 8, data: "03/05/2026" },
        { materia: "TPSIT", voto: 7, data: "02/05/2026" },
        { materia: "Educazione Fisica", voto: 10, data: "01/05/2026" }
    ];

    const materie = [
        "Educazione Civica",
        "Italiano",
        "Storia",
        "Matematica",
        "Sistemi e Reti",
        "GPOI",
        "Inglese",
        "Informatica",
        "Educazione Fisica",
        "TPSIT"
    ];

    const subjectsDiv = document.getElementById("subjects");
    const votesGrid = document.getElementById("votesGrid");
    const title = document.getElementById("selectedTitle");

    // 🎯 render materie
    materie.forEach(m => {
        const btn = document.createElement("button");
        btn.className = "btn btn-outline-success";
        btn.innerText = m;

        btn.onclick = () => showSubject(m);

        subjectsDiv.appendChild(btn);
    });

    // 🎯 mostra voti
    function showSubject(materia) {

        title.innerText = "Voti: " + materia;

        votesGrid.innerHTML = "";

        const filtered = voti.filter(v => v.materia === materia);

        if (filtered.length === 0) {
            votesGrid.innerHTML = "<p>Nessun voto disponibile</p>";
            return;
        }

        filtered.forEach(v => {

            let classe = "";

            if (v.voto >= 6) classe = "good";
            else if (v.voto >= 5) classe = "medium";
            else classe = "bad";

            votesGrid.innerHTML += `
                <div class="vote-card">
                    <div class="subject">${v.materia}</div>
                    <div class="vote ${classe}">${v.voto}</div>
                    <div class="date">${v.data}</div>
                </div>
            `;
        });
    }

    // 🔥 default: mostra tutti
    function showAll() {

        title.innerText = "Tutti i voti";

        votesGrid.innerHTML = "";

        voti.forEach(v => {

            let classe = "";

            if (v.voto >= 6) classe = "good";
            else if (v.voto >= 5) classe = "medium";
            else classe = "bad";

            votesGrid.innerHTML += `
                <div class="vote-card">
                    <div class="subject">${v.materia}</div>
                    <div class="vote ${classe}">${v.voto}</div>
                    <div class="date">${v.data}</div>
                </div>
            `;
        });
    }

    showAll();
</script>
</div>

</body>

</html>