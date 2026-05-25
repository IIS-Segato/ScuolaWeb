<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="java.sql.*" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    boolean loginCorretto = false;
	String error = ""; 

    if(username != null && password != null){

        if(username.equals("admin") && password.equals("admin4321")){
            loginCorretto = true;

            session.setAttribute("utente", username);
			response.sendRedirect("admin.html");
        } else {
			try{

	            Class.forName("com.mysql.cj.jdbc.Driver");

	            conn = DriverManager.getConnection(
    	            "jdbc:mysql://localhost:3306/scuola",
        	        "root",
            	    "password"
            	);

            
            	String sql = "SELECT * FROM utenti WHERE username=? AND password=?";

           	 	ps = conn.prepareStatement(sql);

            	ps.setString(1, username);
            	ps.setString(2, password);

           		rs = ps.executeQuery();

	            if(rs.next()){

    	            session.setAttribute("utente", username);

        	        response.sendRedirect("home.jsp");
			
				}
    		}
		}
	} else {
		error = "
			Errore su gmail o password, 
			ricontrola di aver messo giusto i credenziali 
		";
	}
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Login - Istituto Segato-Brustolon</title>

	<!-- Stile -->
	<link href="WEB-INF/lib/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="style.css">
</head>
<body>
	<!-- Banner -->
	<div id="banner">
	    <div id="logo">
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
	
	<!-- Indietro -->
	<a id="indietro" href="homepage.html">← Indietro</a>
	
	<!-- Blocco login -->
	<div class="center-block">
		<form action="login.jsp" method="post">
	
	        <!-- Username -->
	        <input type="text"
	               name="username"
	               class="form-control"
	               placeholder="Username"
	               required>
	
	        <!-- Password -->
	        <div class="input-group">
	
	            <input type="password"
	                   name="password"
	                   class="form-control"
	                   placeholder="Password"
	                   id="passwordInput"
	                   required>
	
	            <button type="button"
	                    id="showPswButton">
	                <img src="imgs/closedEye.png"
	                     alt="mostra password">
	            </button>
	        </div>
	
	        <!-- Submit -->
	        <button type="submit"
	                id="submitButton">
	            Accedi
	        </button>
	    </form>
	</div>
	
	<!-- Footer -->
	<footer class="text-center mt-5 p-4"
	        style="background:#146c5c;color:white;">
	
	    <h5>Istituto di Istruzione Superiore</h5>
		<h5>SEGATO-BRUSTOLON</h5>
		<br>
	    <p>Via J. Tasso, 11 32100 - Belluno BL</p>
		<p>Tel: +39 0437 940159</p>
		<p>Email: blis011002@istruzione.it</p>
	</footer>
	
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