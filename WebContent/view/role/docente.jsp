<%@ page import="model.Utente" %>
<%@ page import="model.Classe" %>
<%@ page import="model.Aula" %>
<%@ page import="model.Orario" %>
<%@ page import="java.util.List" %>

<%
    Utente u = (Utente) session.getAttribute("utente");
	
    if (u == null) {
        response.sendRedirect("../../index.html");
        return;
    }

    String materia = (String) request.getAttribute("materia");
    List<Classe> classi = (List<Classe>) request.getAttribute("classiDocente");
    List<Aula> aule = (List<Aula>) request.getAttribute("auleDocente");
    List<Orario> orario = (List<Orario>) request.getAttribute("orarioDocente");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Area Docente</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            padding: 40px;
        }

        h1, h2 {
            text-align: center;
            color: #333;
        }

        table {
            margin: 20px auto;
            border-collapse: collapse;
            width: 70%;
            background: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px 18px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background: #0077cc;
            color: white;
        }
    </style>
</head>

<body>

<h1>Benvenuto docente, <%= u.getNome() %>!</h1>

<!-- DATI PERSONALI -->
<h2>Dati personali</h2>
<table>
    <tr><th>Campo</th><th>Valore</th></tr>
    <tr><td>ID</td><td><%= u.getId() %></td></tr>
    <tr><td>Nome</td><td><%= u.getNome() %></td></tr>
    <tr><td>Cognome</td><td><%= u.getCognome() %></td></tr>
    <tr><td>Email</td><td><%= u.getEmail() %></td></tr>
    <tr><td>Ruolo</td><td><%= u.getRuolo() %></td></tr>
    <tr><td>Materia</td><td><%= materia %></td></tr>
</table>

<!-- CLASSI ASSEGNATE -->
<h2>Classi in cui insegni</h2>
<table>
    <tr>
        <th>ID Classe</th>
        <th>Sezione</th>
        <th>Anno</th>
        <th>Numero Studenti</th>
    </tr>

    <%
        if (classi != null) {
            for (Classe c : classi) {
    %>
        <tr>
            <td><%= c.getId() %></td>
            <td><%= c.getSezione() %></td>
            <td><%= c.getAnno() %></td>
            <td><%= c.getNumeroStudenti() %></td>
        </tr>
    <%
            }
        }
    %>
</table>

<!-- AULE IN CUI INSEGNA -->
<h2>Aule in cui insegni</h2>
<table>
    <tr>
        <th>Nome Aula</th>
        <th>Capienza</th>
    </tr>

    <%
        if (aule != null) {
            for (Aula a : aule) {
    %>
        <tr>
            <td><%= a.getNome() %></td>
            <td><%= a.getCapienza() %></td>
        </tr>
    <%
            }
        }
    %>
</table>

<!-- ORARIO DEL DOCENTE -->
<h2>Orario delle lezioni</h2>
<table>
    <tr>
        <th>Giorno</th>
        <th>Ora Inizio</th>
        <th>Ora Fine</th>
        <th>Classe</th>
        <th>Aula</th>
    </tr>

    <%
        if (orario != null) {
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
        }
    %>
</table>

<a href= "index.html">RITORNA ALL'HOMEPAGE</a>

</body>
</html>
