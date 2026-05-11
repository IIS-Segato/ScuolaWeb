<!DOCTYPE html>
<html lang="it">

<head>

    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Istituto Tecnico Segato-Brustolon</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">
          
    <!-- CSS -->
    <link rel="stylesheet" href="style.css">

</head>

<body>

	<!-- BANNER -->
	<div id="upBar">
	    <div id="logoSection">
	        <img src="imgs/logoscuola.png"
	             alt="Logo Scuola"
	             id="logoscuola">
	        <div>
	
	            <h2>ISTITUTO TECNICO SEGATO-BRUSTOLON</h2>
				<small style="color:white; opacity:0.85;">
	                Belluno - BL
	            </small>
	        </div>
	    </div>
	
	    <div class="nav-links">
	        <a href="#">Home</a>
	        <a href="#">Scuola</a>
	        <a href="#">Notizie</a>
	        <a href="login.jsp">Area Personale</a>
	    </div>
	</div>
	
	<!-- PAGINA -->
	<div class="main-container">
	
	    <div class="title">
	        Benvenuti nel nostro Istituto
	    </div>
	
	    <div class="vote-card">
	
	        <h4>
	            Formiamo il futuro attraverso innovazione,
	            inclusione e qualità dell'insegnamento.
	        </h4>
	
	        <br>
	
	        <button class="btn btn-success btn-lg">
	            Scopri la Scuola
	        </button>
	
	    </div>
	
	</div>
	
	<!-- ================= SERVIZI ================= -->
	<div class="main-container">
	
	    <div class="title">
	        I Nostri Servizi
	    </div>
	
	    <div class="votes-grid">
	
	        <div class="vote-card text-center">
	
	            <i class="bi bi-laptop"
	               style="font-size:50px;color:#146c5c;"></i>
	
	            <h4 class="subject">Registro Elettronico</h4>
	
	            <p>Accesso rapido a voti e comunicazioni.</p>
	
	        </div>
	
	        <div class="vote-card text-center">
	
	            <i class="bi bi-book"
	               style="font-size:50px;color:#146c5c;"></i>
	
	            <h4 class="subject">Didattica Innovativa</h4>
	
	            <p>Laboratori moderni e digitali.</p>
	
	        </div>
	
	        <div class="vote-card text-center">
	
	            <i class="bi bi-people"
	               style="font-size:50px;color:#146c5c;"></i>
	
	            <h4 class="subject">Inclusione</h4>
	
	            <p>Crescita e benessere studenti.</p>
	
	        </div>
	
	    </div>
	
	</div>
	
	<!-- ================= NOTIZIE E CIRCOLARI ================= -->
	<div class="main-container">
	
	    <div class="title">
	        Notizie e Circolari
	    </div>
	
	    <div class="votes-grid">
	
	        <!-- NOTIZIE -->
	        <div class="vote-card">
	
	            <h3 class="subject">
	                <i class="bi bi-newspaper"></i>
	                Ultime Notizie
	            </h3>
	
	            <hr>
	
	            <h5>Open Day 2026</h5>
	            <p>Presentazione scuola per nuovi iscritti.</p>
	
	            <div class="date">12/05/2026</div>
	
	            <hr>
	
	            <h5>Nuovi Laboratori</h5>
	            <p>Aule informatiche completamente rinnovate.</p>
	
	            <div class="date">08/05/2026</div>
	
	        </div>
	
	        <!-- CIRCOLARI -->
	        <div class="vote-card">
	
	            <h3 class="subject">
	                <i class="bi bi-file-earmark-text"></i>
	                Circolari
	            </h3>
	
	            <hr>
	
	            <div>
	                <strong>Circolare n.12</strong>
	                <p>Sospensione lezioni 20 Maggio</p>
	
	                <button class="btn btn-success btn-sm"
	                        onclick="apriCircolare(12)">
	                    Apri
	                </button>
	            </div>
	
	            <hr>
	
	            <div>
	                <strong>Circolare n.13</strong>
	                <p>Consegna pagelle online</p>
	
	                <button class="btn btn-success btn-sm"
	                        onclick="apriCircolare(13)">
	                    Apri
	                </button>
	            </div>
	
	        </div>
	
	    </div>
	
	</div>
	
	<!-- ================= NUMERI ================= -->
	<div class="main-container">
	
	    <div class="title">
	        La Scuola in Numeri
	    </div>
	
	    <div class="votes-grid text-center">
	
	        <div class="vote-card">
	            <div class="vote good counter" data-target="1200">0</div>
	            <p>Studenti</p>
	        </div>
	
	        <div class="vote-card">
	            <div class="vote medium counter" data-target="85">0</div>
	            <p>Docenti</p>
	        </div>
	
	        <div class="vote-card">
	            <div class="vote good counter" data-target="40">0</div>
	            <p>Aule</p>
	        </div>
	
	        <div class="vote-card">
	            <div class="vote bad counter" data-target="15">0</div>
	            <p>Laboratori</p>
	        </div>
	
	    </div>
	
	</div>
	
	<!-- ================= FOOTER ================= -->
	<footer class="text-center mt-5 p-4"
	        style="background:#146c5c;color:white;">
	
	    <h5>Istituto Tecnico Segato-Brustolon</h5>
	
	    <p>Via Roma 25 - Vicenza</p>
	
	    <p>info@istituto.it</p>
	
	</footer>
	
	<!-- ================= SCRIPT ================= -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	
	<script>
	
	    // CONTATORI ANIMATI
	    const counters = document.querySelectorAll('.counter');
	
	    counters.forEach(counter => {
	
	        counter.innerText = '0';
	
	        const updateCounter = () => {
	
	            const target = +counter.getAttribute('data-target');
	            const current = +counter.innerText;
	
	            const increment = target / 100;
	
	            if(current < target){
	
	                counter.innerText =
	                    `${Math.ceil(current + increment)}`;
	
	                setTimeout(updateCounter, 20);
	
	            } else {
	
	                counter.innerText = target;
	
	            }
	
	        };
	
	        updateCounter();
	
	    });
	
	    // CIRCOLARI
	    function apriCircolare(numero){
	
	        alert("Apertura circolare n. " + numero);
	
	    }
	
	</script>
	
</body>
</html>