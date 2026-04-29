<%@ page import="model.Utente" %>

<%
    Utente u = (Utente) session.getAttribute("utente");

    if (u == null) {
        response.sendRedirect("../../index.html");
        return;
    }
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

        h1 {
            text-align: center;
            color: #333;
        }

        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 60%;
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

<table>
    <tr><th>Campo</th><th>Valore</th></tr>
    <tr><td>ID</td><td><%= u.getId() %></td></tr>
    <tr><td>Nome</td><td><%= u.getNome() %></td></tr>
    <tr><td>Cognome</td><td><%= u.getCognome() %></td></tr>
    <tr><td>Email</td><td><%= u.getEmail() %></td></tr>
    <tr><td>Ruolo</td><td><%= u.getRuolo() %></td></tr>
</table>

</body>
</html>
