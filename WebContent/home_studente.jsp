<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Docente" %>
<%
    // CONTROLLO DI SICUREZZA: Usiamo la chiave corretta impostata nel LoginController
    if (session.getAttribute("utenteId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="it">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Registro Studente</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    
    <style>
        /* Sfondo e font originali dell'applicazione */
        body { 
            background: linear-gradient(to bottom, #dff7ef, #f7fffc); 
            font-family: Arial, Helvetica, sans-serif; 
            margin: 0; 
            min-height: 100vh;
        }
        #banner { 
            background-color: #146c5c; 
            padding: 15px 30px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        #logo { display: flex; align-items: center; gap: 15px; }
        #logo img { width: 55px; height: 55px; border-radius: 50%; border: 2px solid white; object-fit: cover; }
        #logo h2 { color: white; margin: 0; font-size: 24px; font-weight: bold; }
        .nav-links a { color: white; margin-left: 15px; text-decoration: none; font-weight: 500; opacity: 0.9; }
        .nav-links a:hover { opacity: 1; text-decoration: underline; }
        
        .main-container { width: 90%; max-width: 1100px; margin: auto; padding-bottom: 40px; }
        .title { font-size: 28px; color: #146c5c; margin: 25px 0; font-weight: bold; }

        /* Layout principale a due colonne */
        .page-layout {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 30px;
            margin-top: 20px;
        }
        
        /* Griglia della Dashboard interna */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        /* Stile delle Card della Dashboard */
        .dash-card {
            background: white;
            padding: 25px;
            border-radius: 18px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            transition: transform 0.2s, box-shadow 0.2s;
            border: none;
            text-align: center;
        }
        .dash-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            text-decoration: none;
        }
        
        /* Icone tondeggianti all'interno delle card */
        .dash-icon {
            font-size: 32px;
            width: 70px;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            margin-bottom: 15px;
        }
        
        /* Colorazioni specifiche per le icone dello Studente */
        .dash-icon.voti { background-color: #e3f2fd; color: #1e88e5; }
        .dash-icon.orario { background-color: #fff3e0; color: #f57c00; }
        .dash-icon.news { background-color: #e8f5e9; color: #388e3c; }
        .dash-icon.logout { background-color: #ffebee; color: #d32f2f; }
        
        .dash-title {
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
        }

        /* Stile del Pannello Laterale dei Docenti */
        .docenti-panel {
            background: white;
            padding: 25px;
            border-radius: 18px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: none;
            align-self: start;
        }
        .docente-item {
            padding: 15px;
            margin-bottom: 12px;
            background-color: #f4fbf9;
            border-left: 4px solid #146c5c;
            border-radius: 8px;
            transition: background-color 0.2s;
        }
        .docente-item:hover {
            background-color: #e8f7f3;
        }
        .docente-item:last-child { margin-bottom: 0; }
        
        .docente-name {
            font-size: 16px;
            font-weight: bold;
            color: #2c3e50;
        }

        /* Responsive per Tablet e Smartphone */
        @media (max-width: 768px) {
            .page-layout { grid-template-columns: 1fr; gap: 20px; }
            #banner { flex-direction: column; text-align: center; gap: 15px; }
            .nav-links { display: flex; flex-wrap: wrap; justify-content: center; gap: 10px; }
            .nav-links a { margin: 0 5px; }
        }
    </style>
</head>

<body>

    <div id="banner">
        <div id="logo">
            <img src="imgs/default.png" alt="avatar">
            <h2>Registro Studente</h2>
        </div>
        <div class="nav-links">
            <a href="#">Home</a>
            <a href="${pageContext.request.contextPath}/VotoController">Voti</a>
            <a href="${pageContext.request.contextPath}/AnnunciController">Notizie</a>
            <a href="${pageContext.request.contextPath}/OrarioController">Orario</a>
            <a href="logout.jsp">Logout</a>
        </div>
    </div>
    
    <div class="main-container">
        <div class="page-layout">
            
            <div>
                <div class="title" style="margin-top: 0;">
                    Dashboard
                </div>
                
                <div class="dashboard-grid">
                    <a href="${pageContext.request.contextPath}/VotoController" class="dash-card">
                        <div class="dash-icon voti">&#128202;</div> 
                        <div class="dash-title">Voti</div>
                    </a>
            
                    <a href="${pageContext.request.contextPath}/OrarioController" class="dash-card">
                        <div class="dash-icon orario">&#128343;</div>
                        <div class="dash-title">Orario</div>
                    </a>
            
                    <a href="${pageContext.request.contextPath}/AnnunciController" class="dash-card">
                        <div class="dash-icon news">&#128111;</div> 
                        <div class="dash-title">Notizie</div>
                    </a>
            
                    <a href="logout.jsp" class="dash-card">
                        <div class="dash-icon logout">&#128682;</div> 
                        <div class="dash-title">Logout</div>
                    </a>
                </div>
            </div>
            
            <div class="docenti-panel">
                <h4 class="fw-bold mb-3" style="color: #146c5c;">I Tuoi Docenti</h4>
                <hr style="opacity: 0.15; margin-bottom: 20px;">
                <%
                    List<Docente> listaDocenti = (List<Docente>) request.getAttribute("listaDocenti");
                    if (listaDocenti == null || listaDocenti.isEmpty()) {
                %>
                    <div class="text-muted small text-center my-4">
                        <i class="bi bi-exclamation-circle d-block fs-3 mb-2"></i>
                        Nessun docente registrato nell'Istituto.
                    </div>
                <%
                    } else {
                        for (Docente doc : listaDocenti) {
                %>
                    <div class="docente-item">
                        <div class="docente-name">
                            Prof. <%= (doc.getCognome() != null) ? doc.getCognome() : "" %> 
                                  <%= (doc.getNome() != null) ? doc.getNome() : "" %>
                        </div>
                    </div>
                <%
                        }
                    }
                %>
            </div>
            
        </div>
    </div>
</body>
</html>