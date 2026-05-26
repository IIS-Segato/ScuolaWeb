<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Annuncio, model.AnnuncioClasse" %>
<%
    if (session.getAttribute("utenteId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Controlliamo quale lista è stata passata dal controller
    List<Annuncio> annunci = (List<Annuncio>) request.getAttribute("annunci");
    List<AnnuncioClasse> annunciClasse = (List<AnnuncioClasse>) request.getAttribute("annunciClasse");
    boolean isClasse = (annunciClasse != null);
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Notizie e Avvisi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(to bottom, #dff7ef, #f7fffc); font-family: Arial, sans-serif; min-height: 100vh; }
        #banner { background-color: #146c5c; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        #logo { display: flex; align-items: center; gap: 15px; }
        #logo img { width: 50px; height: 50px; border-radius: 50%; border: 2px solid white; }
        #logo h2 { color: white; margin: 0; font-size: 22px; }
        .nav-links a { color: white; margin-left: 15px; text-decoration: none; font-weight: 500; }
        .main-container { width: 90%; max-width: 900px; margin: auto; padding: 40px 0; }
        .news-card { background: white; padding: 25px; border-radius: 18px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin-bottom: 20px; border-left: 6px solid #146c5c; }
        .news-title { color: #146c5c; font-weight: bold; }
        .meta-info { font-size: 13px; color: #888; border-top: 1px solid #eee; padding-top: 10px; margin-top: 10px; }
    </style>
</head>
<body>
    <div id="banner">
        <div id="logo"> <h2><%= isClasse ? "Comunicazioni Classe" : "Bacheca Avvisi" %></h2> </div>
        <div class="nav-links">
            <a href="ClasseDocentiController">Home</a>
            <a href="AnnuncioController?action=GETALL">Avvisi</a>
            <a href="AnnuncioController?action=GETALL&tipo=CLASSE">Classe</a>
        </div>
    </div>

    <div class="main-container">
        <a href="#" onclick="history.back(); return false;" class="text-success fw-bold">← Torna Indietro</a>
        <div class="h2 text-success mt-3 mb-4"><%= isClasse ? "Avvisi della tua Classe" : "Bacheca Avvisi Generali" %></div>

        <% if (isClasse) { 
            if (annunciClasse == null || annunciClasse.isEmpty()) { %> <div class="alert alert-light">Nessun avviso di classe.</div> <% } 
            else { for (AnnuncioClasse a : annunciClasse) { %>
                <div class="news-card">
                    <span class="badge bg-secondary mb-2">Classe</span>
                    <h4 class="news-title"><%= a.getTitolo() %></h4>
                    <p><%= a.getContenuto() %></p>
                    <div class="meta-info d-flex justify-content-between">
                        <span>Data: <%= a.getDataPubblicazione() %></span>
                        <span>Prof. <%= a.getCognomeDocente() %></span>
                    </div>
                </div>
            <% } } 
        } else { 
            if (annunci == null || annunci.isEmpty()) { %> <div class="alert alert-light">Nessun avviso presente.</div> <% } 
            else { for (Annuncio a : annunci) { %>
                <div class="news-card">
                    <span class="badge bg-success mb-2">Generale</span>
                    <h4 class="news-title"><%= a.getTitolo() %></h4>
                    <p><%= a.getContenuto() %></p>
                    <div class="meta-info">Data: <%= a.getData_pubblicazione() %></div>
                </div>
            <% } } 
        } %>
    </div>
</body>
</html>