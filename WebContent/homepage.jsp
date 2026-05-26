<!DOCTYPE html>
<html lang="it">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Istituto Tecnico Segato-Brustolon</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">

    <style>
        /* Ripristino dello stile e dello sfondo originale dell'applicazione */
        body { 
            background: linear-gradient(to bottom, #dff7ef, #f7fffc); 
            font-family: Arial, Helvetica, sans-serif; 
            margin: 0; 
        }
        #banner { 
            background-color: #146c5c; 
            padding: 15px 30px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
        }
        #logo { 
            display: flex; 
            align-items: center; 
            gap: 15px; 
        }
        #logoscuola { 
            width: 55px; 
            height: 55px; 
            border-radius: 50%; 
            border: 2px solid white; 
        }
        #logo h2 { 
            color: white; 
            margin: 0; 
        }
        .nav-links a { 
            color: white; 
            margin-left: 15px; 
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
        .grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); 
            gap: 20px; 
        }
        .card { 
            background: white; 
            padding: 20px; 
            border-radius: 18px; 
            box-shadow: 0 3px 12px rgba(0,0,0,0.1); 
            border: none;
        }
        .subject { 
            font-size: 20px; 
            font-weight: bold; 
            color: #146c5c; 
        }
    </style>
</head>

<body>

    <div id="banner">
        <div id="logo">
            <img src="imgs/logoscuola.png" alt="Logo Scuola" id="logoscuola">
            <div>
                <h2>ISTITUTO TECNICO SEGATO-BRUSTOLON</h2>
                <small style="color:white; opacity:0.85;">Belluno - BL</small>
            </div>
        </div>

        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/LoginController">Area Personale</a>
        </div>
    </div>
    
    <div class="main-container">
        <div class="title">
            I Nostri Servizi
        </div>
        <div class="grid">
            <div class="card text-center">
                <i class="bi bi-laptop" style="font-size:50px; color:#146c5c;"></i>
                <h4 class="subject">Registro Elettronico</h4>
                <p>Accesso rapido a voti e comunicazioni.</p>
            </div>

            <div class="card text-center">
                <i class="bi bi-book" style="font-size:50px; color:#146c5c;"></i>
                <h4 class="subject">Didattica Innovativa</h4>
                <p>Laboratori moderni e digitali.</p>
            </div>

            <div class="card text-center">
                <i class="bi bi-people" style="font-size:50px; color:#146c5c;"></i>
                <h4 class="subject">Inclusione</h4>
                <p>Crescita e benessere studenti.</p>
            </div>
        </div>
    </div>
    
    <div class="main-container mb-5">
        <div class="title">
            La Scuola in Numeri
        </div>

        <div class="grid text-center">
            <div class="card">
                <div class="counter fw-bold display-4" style="color: #146c5c;" data-target="1200">0</div>
                <p>Studenti</p>
            </div>

            <div class="card">
                <div class="counter fw-bold display-4" style="color: #146c5c;" data-target="85">00</div>
                <p>Docenti</p>
            </div>

            <div class="card">
                <div class="counter fw-bold display-4" style="color: #146c5c;" data-target="40">00</div>
                <p>Aule</p>
            </div>

            <div class="card">
                <div class="counter fw-bold display-4" style="color: #146c5c;" data-target="15">00</div>
                <p>Laboratori</p>
            </div>
        </div>
    </div>
    
    <footer class="text-center p-4" style="background:#146c5c; color:white;">
        <h5>Istituto Tecnico Segato-Brustolon</h5>
        <p>Via Roma 25 - BL</p>
        <p>info@istituto.it</p>
    </footer>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener("DOMContentLoaded", () => {
            const counters = document.querySelectorAll('.counter');
            counters.forEach(counter => {
                counter.innerText = '0';
                const updateCounter = () => {
                    const target = +counter.getAttribute('data-target');
                    const current = +counter.innerText;
                    const increment = target / 100;
        
                    if(current < target){
                        counter.innerText = `${Math.ceil(current + increment)}`;
                        setTimeout(updateCounter, 20);
                    } else {
                        counter.innerText = target;
                    }
                };
                updateCounter();
            });
        });
    </script>
    
</body>
</html>