<%@ page import="model.Aula" %>
<%@ page import="model.Orario" %>
<%@ page import="java.util.List" %>

<%
//lista aule
List<Aula> listaAule = (List<Aula>) request.getAttribute("listaAule");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Orari per Aula</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; padding: 40px; }
        h1, h2 { text-align: center; color: #333; }
        table { margin: 20px auto; border-collapse: collapse; width: 70%; background: white; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        th, td { padding: 12px 18px; border-bottom: 1px solid #ddd; text-align: left; }
        th { background: #0077cc; color: white; }
        button { padding: 9px 20px; font-size: 14px; background: #2d5be3; color: #fff; border: none; border-radius: 4px; cursor: pointer; }
    </style>
</head>
<body>
<a href="<%=request.getContextPath()%>/index.html">
   <button type="button">Torna al Login</button>
</a>
<h1>Orari per Aula</h1>

<%
    if (listaAule != null) {
        for (Aula a : listaAule) {
%>
    <h2>Aula: <%= a.getNome() %> (Capienza: <%= a.getCapienza() %>)</h2>
    <table>
        <tr>
            <th>Giorno</th>
            <th>Ora Inizio</th>
            <th>Ora Fine</th>
            <th>Materia - Docente</th>
        </tr>
        <%
            if (a.getOrari() != null && !a.getOrari().isEmpty()) {
                for (Orario o : a.getOrari()) {
        %>
        <tr>
            <td><%= o.getGiorno() %></td>
            <td><%= o.getOraIni() %></td>
            <td><%= o.getOraFin() %></td>
            <td><%= o.getClasse() %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr><td colspan="4">Nessun orario per questa aula</td></tr>
        <%
            }
        %>
    </table>
<%
        }
    }
%>

</body>
</html>