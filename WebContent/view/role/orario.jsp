<%@ page import="model.Aula" %>
<%@ page import="model.Orario" %>
<%@ page import="java.util.List" %>

<%
List<Aula> listaAule = (List<Aula>) request.getAttribute("listaAule");
%>
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Orario Aule Portale Scolastico</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/style.css">
</head>
<body style="background: var(--bg);">

  <div class="orario-page">

    <div class="page-header">
      <a href="<%=request.getContextPath()%>/index.html" class="btn btn-ghost btn-sm" style="margin-bottom:24px;">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="15 18 9 12 15 6"/></svg>
        Torna alla Login
      </a>
      <h1>Orario delle Aule</h1>
      <p>Visualizzazione pubblica degli orari per aula</p>
    </div>

    <%
      if (listaAule != null) {
        int i = 0;
        for (Aula a : listaAule) {
          i++;
    %>
    <div class="aula-block" style="animation-delay: <%= i * 0.08 %>s;">
      <div class="aula-header">
        <div class="aula-icon"><%= a.getNome().length() > 0 ? String.valueOf(a.getNome().charAt(0)) : "A" %></div>
        <div>
          <div class="aula-name">Aula <%= a.getNome() %></div>
        </div>
        <span class="aula-cap">Capienza: <%= a.getCapienza() %></span>
      </div>
      <div class="table-wrap">
        <table>
          <thead>
            <tr>
              <th>Giorno</th>
              <th>Ora inizio</th>
              <th>Ora fine</th>
              <th>Materia / Docente</th>
            </tr>
          </thead>
          <tbody>
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
            <tr><td colspan="4" style="color:var(--text-muted);text-align:center;padding:24px;">Nessun orario per questa aula</td></tr>
            <% } %>
          </tbody>
        </table>
      </div>
    </div>
    <%
        }
      }
    %>

  </div>

</body>
</html>
