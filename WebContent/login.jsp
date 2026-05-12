<!DOCTYPE html>
<html lang="it">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Login - Istituto Segato-Brustolon</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- CSS del sito -->
    <link rel="stylesheet" href="style.css">

</head>

<body>
	<!-- BANNER -->
	<div id="banner">
	    <div id="logo">
	        <!-- LOGO -->
	        <img src="imgs/logoscuola.png"
	             alt="Logo Scuola">
	        <div>
	            <h2>AREA PERSONALE</h2>
	            <small style="color:white; opacity:0.8;">
	                Accesso studenti e docenti
	            </small>
	        </div>
	    </div>
	</div>
	
	<!-- BLOCCO LOGIN -->
	<div class="center-block">
	    <form action="login.jsp" method="post">
	        <input type="text"
	               name="username"
	               class="form-control"
	               placeholder="Username"
	               required>
	        <div class="input-group">
	            <input type="password"
	                   name="password"
	                   class="form-control"
	                   placeholder="Password"
	                   id="passwordInput"
	                   required>
	            <button type="button" id="showPswButton">
	                <img src="imgs/closedEye.png" alt="mostra password">
	            </button>
	        </div>
	
	        <!-- BOTTONE -->
	        <button type="submit" id="submitButton">ACCEDI</button>
	
	        
	        <% String error = (String) request.getAttribute("error");
	            if(error != null){ %>
	
	            <div class="alert alert-danger mt-3 text-center">
	                <%= error %>
	            </div>
	        <% } %>
	    </form>
	</div>
	
	
	<script>
		const buttonShow = document.getElementById('showPswButton');
	    const input = document.getElementById('passwordInput');
	    const img = document.querySelector('#showPswButton img');
	
	    buttonShow.addEventListener('click', () => {
	
	        if(input.type === 'password'){
	            input.type = 'text';
	            img.src = 'imgs/openEye.png';
	        } else {
	            input.type = 'password';
	            img.src = 'imgs/closedEye.png';
	        }
	    });
	
	</script>
	</body>
</html>