	<%@ page import="model.Utente" %>
	<%@ page import="model.Classe" %>
	<%@ page import="model.Orario" %>
	<%@ page import="java.util.List" %>
	
	<%
	    Utente u = (Utente) session.getAttribute("utente");
	
	    if (u == null) {
	        response.sendRedirect("../../index.html");
	        return;
	    }
	
	    Classe classe = (Classe) request.getAttribute("classeStudente");
	    List<Orario> orario = (List<Orario>) request.getAttribute("orarioStudente");
	%>
	<!DOCTYPE html>
	<html lang="it">
	<head>
	    <meta charset="UTF-8">
	    <title>Area Studente</title>
	    <style>
	        body { font-family: Arial, sans-serif; background: #f5f5f5; padding: 40px; }
	        h1, h2 { text-align: center; color: #333; }
	        table { margin: 20px auto; border-collapse: collapse; width: 70%; background: white; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
	        th, td { padding: 12px 18px; border-bottom: 1px solid #ddd; text-align: left; }
	        th { background: #0077cc; color: white; }
	    </style>
	</head>
	<body>
	
	<h1>Benvenuto, <%= u.getNome() %>!</h1>
	
	<h2>Dati personali</h2>
	<table>
	    <tr><th>Campo</th><th>Valore</th></tr>
	    <tr><td>ID</td><td><%= u.getId() %></td></tr>
	    <tr><td>Nome</td><td><%= u.getNome() %></td></tr>
	    <tr><td>Cognome</td><td><%= u.getCognome() %></td></tr>
	    <tr><td>Email</td><td><%= u.getEmail() %></td></tr>
	    <tr><td>Ruolo</td><td><%= u.getRuolo() %></td></tr>
	</table>
	
	<h2>La tua classe</h2>
	<table>
	    <tr><th>Sezione</th><th>Anno</th><th>Numero Studenti</th></tr>
	    <% if (classe != null) { %>
	    <tr>
	        <td><%= classe.getSezione() %></td>
	        <td><%= classe.getAnno() %></td>
	        <td><%= classe.getNumeroStudenti() %></td>
	    </tr>
	    <% } else { %>
	    <tr><td colspan="3">Nessuna classe trovata</td></tr>
	    <% } %>
	</table>
	
	<h2>Orario delle lezioni</h2>
	<table>
	    <tr>
	        <th>Giorno</th>
	        <th>Ora Inizio</th>
	        <th>Ora Fine</th>
	        <th>Materia - Docente</th>
	        <th>Aula</th>
	    </tr>
	    <%
	        if (orario != null && !orario.isEmpty()) {
	            for (Orario o : orario) {
	    %>
	    <tr>
	        <td><%= o.getGiorno() %></td>
	        <td><%= o.getOraIni() %></td>
	        <td><%= o.getOraFin() %></td>
	        <td><%= o.getClasse() %></td>
	        <td><%= o.getAula() %></td>
	    </tr>
	    <%
	            }
	        } else {
	    %>
	    <tr><td colspan="5">Nessun orario trovato</td></tr>
	    <% } %>
	</table>
	<a href="index.html">RITORNA ALL'HOMEPAGE</a>
	
	</body>
	</html>