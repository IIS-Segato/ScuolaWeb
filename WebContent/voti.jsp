<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Voto" %>
<!DOCTYPE html>
<html lang="it">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro Voti</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">

    <style>
        body { background: linear-gradient(to bottom, #dff7ef, #f7fffc); font-family: Arial, Helvetica, sans-serif; margin: 0; }
        #upBar { background-color: #146c5c; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        #logoSection { display: flex; align-items: center; gap: 15px; }
        #logoSection img { width: 55px; height: 55px; border-radius: 50%; border: 2px solid white; }
        #logoSection h2 { color: white; margin: 0; }
        .nav-links a { color: white; margin-left: 15px; text-decoration: none; }
        .main-container { width: 90%; max-width: 1100px; margin: auto; }
        .title { font-size: 32px; color: #146c5c; margin: 25px 0; font-weight: bold; }
        .votes-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 20px; }
        .vote-card { background: white; padding: 20px; border-radius: 18px; box-shadow: 0 3px 12px rgba(0,0,0,0.1); }
        .subject { font-size: 20px; font-weight: bold; color: #146c5c; }
        .vote { font-size: 40px; font-weight: bold; margin-top: 10px; }
        .good { color: green; }
        .medium { color: orange; }
        .bad { color: red; }
        .date { color: gray; margin-top: 8px; }
    </style>
</head>

<body>

<div id="upBar">
    <div id="logoSection">
        <img src="${pageContext.request.contextPath}/imgs/default.png" alt="avatar">
        <h2>Registro Studente</h2>
    </div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/LoginController">Home</a>
        <a href="${pageContext.request.contextPath}/VotoController">Voti</a>
        <a href="notizie.html">Notizie</a>
        <a href="orario.html">Orario</a>
        <a href="${pageContext.request.contextPath}/logout.jsp">Logout</a>
    </div>
</div>

<a id="indietro" href="#" onclick="history.back(); return false;" style="display: inline-block; margin: 20px; color: #146c5c; text-decoration: none;">← Indietro</a>

<div class="main-container">

    <div class="title">
        Tutti i tuoi voti
    </div>

    <div class="votes-grid">
        <%
            // Recuperiamo la lista dei voti passata dal VotoController
            List<Voto> listaVoti = (List<Voto>) request.getAttribute("voti");
            
            if (listaVoti == null || listaVoti.isEmpty()) {
        %>
            <div class="alert alert-info w-100" role="alert">
                Nessun voto registrato nel sistema per questo studente.
            </div>
        <%
            } else {
                for (Voto v : listaVoti) {
                    // Logica di colorazione dinamica basata sul valore del voto
                    String classeColore = "bad";
                    if (v.getVoto() >= 6) {
                        classeColore = "good";
                    } else if (v.getVoto() >= 5) {
                        classeColore = "medium";
                    }
        %>
            <div class="vote-card">
                <div class="subject"><%= v.getNomeMateria() != null ? v.getNomeMateria() : "Materia sconosciuta" %></div>
                <div class="vote <%= classeColore %>"><%= v.getVoto() %></div>
                <div class="date"><%= v.getData_voto() %></div>
                <small style="color: gray; display: block; margin-top: 5px;">
                    <%= v.getDescrizione() != null ? v.getDescrizione() : "" %>
                </small>
            </div>
        <%
                }
            }
        %>
    </div>

</div>

</body>
</html>