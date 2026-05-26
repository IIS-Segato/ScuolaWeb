<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Orario" %>
<%
    List<Orario> orari = (List<Orario>) request.getAttribute("orari");
    String nomeRuolo = (String) session.getAttribute("nomeRuolo");
    boolean isDocente = "DOCENTE".equalsIgnoreCase(nomeRuolo);
    
    String titoloPagina = isDocente ? "Il tuo Orario Docente" : "Orario delle Lezioni";
    String[] giorni = {"LUN", "MAR", "MER", "GIO", "VEN"};
    String[] oreDb = {"08:00:00", "09:00:00", "10:00:00", "11:00:00", "12:00:00", "13:00:00"};
    String[] oreVisualizzate = {"08:00", "09:00", "10:00", "11:00", "12:00", "13:00"};
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Orario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f7fffc; font-family: Arial, sans-serif; min-height: 100vh; }
        .timetable { display: grid; grid-template-columns: 80px repeat(5, 1fr); gap: 10px; max-width: 950px; margin: 40px auto; }
        .cell { background: white; padding: 10px; border-radius: 12px; text-align: center; box-shadow: 0 2px 5px rgba(0,0,0,0.05); min-height: 85px; display: flex; flex-direction: column; justify-content: center; }
        .header { background: #146c5c; color: white; font-weight: bold; }
        .time { background: #dff7ef; color: #146c5c; font-weight: bold; }
        .subject-name { font-weight: bold; color: #146c5c; font-size: 12px; display: block; }
        .class-label { font-size: 11px; color: #d9534f; font-weight: bold; }
        .prof-name { font-size: 10px; color: #666; font-style: italic; }
        .classroom-name { font-size: 10px; color: #999; background: #f8f9fa; border-radius: 4px; padding: 1px 5px; margin-top: 2px; display: block; }
        .lesson-box { border-bottom: 1px solid #eee; padding-bottom: 4px; margin-bottom: 4px; }
        .lesson-box:last-child { border-bottom: none; margin-bottom: 0; }
    </style>
</head>
<body>

<div class="container mt-5">
    <h2 style="color: #146c5c;"><%= titoloPagina %></h2>
    <div class="timetable">
        <div class="cell header">Ora</div>
        <% for(String g : giorni) { %> <div class="cell header"><%= g %></div> <% } %>

        <% for (int i = 0; i < oreDb.length; i++) { %>
            <div class="cell time"><%= oreVisualizzate[i] %></div>
            <% for (String giorno : giorni) {
                String contenuto = "<span class='text-muted'>-</span>";
                boolean trovataLezione = false;
                StringBuilder buffer = new StringBuilder();

                if (orari != null) {
                    for (Orario o : orari) {
                        if (o.getGiorno().trim().equalsIgnoreCase(giorno) && o.getOra_inizio().startsWith(oreVisualizzate[i])) {
                            trovataLezione = true;
                            
                            String docente = o.getNomeDocente().substring(0, 1) + ". " + o.getCognomeDocente();
                            
                            buffer.append("<div class='lesson-box'>");
                            buffer.append("<span class='subject-name'>").append(o.getNomeMateria()).append("</span>");
                            
                            if (isDocente) {
                                buffer.append("<span class='class-label'>Cl: ").append(o.getNomeClasse()).append("</span><br>");
                            } else {
                                buffer.append("<span class='prof-name'>").append(docente).append("</span><br>");
                            }
                            
                            buffer.append("<span class='classroom-name'>").append(o.getNomeAula()).append("</span>");
                            buffer.append("</div>");
                        }
                    }
                }
                if (trovataLezione) contenuto = buffer.toString();
            %>
                <div class="cell"><%= contenuto %></div>
            <% } %>
        <% } %>
    </div>
</div>
</body>
</html>