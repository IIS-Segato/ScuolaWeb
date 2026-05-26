<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="java.util.ArrayList" %>

<%
    // Recupero dell'amministratore dalla sessione
    Amministratore amministratore = (Amministratore) session.getAttribute("amministratore");
    if (amministratore == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    ArrayList<Docente> docenti = amministratore.getDocenti();
    ArrayList<Classe> classi = amministratore.getClassi();
%>

<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Gestione Docenti</title>

<link rel="preconnect" href="[fonts.googleapis.com](https://fonts.googleapis.com)">
<link rel="preconnect" href="[fonts.gstatic.com](https://fonts.gstatic.com)" crossorigin>
<link href="[fonts.googleapis.com](https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500&family=DM+Mono:wght@400;500&display=swap)" rel="stylesheet">

<style>
/* Stile coerente con la versione base */
:root {
  --bg:#0b0f14; --surface:#111820; --surface2:#161e28; --border:rgba(255,255,255,0.07);
  --border-hi:rgba(99,190,140,0.35); --accent:#63be8c; --accent-bg:rgba(99,190,140,0.08);
  --text-1:#e8f0ec; --text-2:#8a9fa4; --text-3:#4d6168;
  --mono:'DM Mono', monospace; --sans:'DM Sans', sans-serif;
  --radius-sm:8px; --radius-md:12px; --radius-lg:18px;
}
body{background:var(--bg);color:var(--text-1);font-family:var(--sans);font-size:15px;line-height:1.6;}
.page{max-width:1200px;margin:0 auto;padding:36px 28px 64px;display:flex;flex-direction:column;gap:20px;}
.topbar{display:flex;align-items:center;justify-content:space-between;}
.brand{display:flex;align-items:center;gap:10px;}
.brand-icon{width:34px;height:34px;border-radius:8px;background:var(--accent-bg);
display:flex;align-items:center;justify-content:center;border:0.5px solid var(--border-hi);}
.brand-icon svg{width:17px;height:17px;stroke:var(--accent);fill:none;stroke-width:1.8;}
.brand-name{font-size:13px;font-weight:500;color:var(--text-2);text-transform:uppercase;}
.back-btn{background:var(--surface);border:0.5px solid var(--border);color:var(--text-2);
padding:9px 16px;border-radius:var(--radius-sm);text-decoration:none;font-size:13px;}
.back-btn:hover{border-color:rgba(255,255,255,0.15);color:var(--text-1);background:var(--surface2);}
.section{background:var(--surface);border:0.5px solid var(--border);
border-radius:var(--radius-lg);padding:28px 32px;}
.section-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;}
.section-title{font-size:17px;font-weight:500;}
.table-wrap{overflow-x:auto;border-radius:var(--radius-md);border:0.5px solid var(--border);}
table{width:100%;border-collapse:collapse;}
thead tr{background:var(--surface2);}
th,td{padding:14px 16px;text-align:left;}
th{font-size:12px;text-transform:uppercase;color:var(--text-3);letter-spacing:0.06em;}
tbody tr{border-top:0.5px solid var(--border);transition:background .15s;}
tbody tr:hover{background:var(--surface2);}
.action-btn{padding:7px 12px;border-radius:6px;font-size:12px;text-transform:uppercase;
font-weight:500;border:none;cursor:pointer;transition:all .2s;}
.add-btn{background:var(--accent-bg);border:0.5px solid var(--border-hi);color:var(--accent);}
.add-btn:hover{background:rgba(99,190,140,0.15);}
.del-btn{background:rgba(248,113,113,0.1);border:0.5px solid rgba(248,113,113,0.35);color:#f87171;}
.del-btn:hover{background:rgba(248,113,113,0.18);}
.empty-box{padding:40px;text-align:center;color:var(--text-3);border:0.5px dashed var(--border);
border-radius:var(--radius-md);}
.add-form{display:flex;gap:10px;margin-top:22px;flex-wrap:wrap;}
.add-form input, .add-form select{background:var(--surface2);border:0.5px solid var(--border);
border-radius:var(--radius-sm);color:var(--text-1);padding:9px 12px;font-family:var(--mono);}
.add-form select[multiple]{height:80px;}
</style>
</head>

<body>
<div class="page">

  <!-- TOPBAR -->
  <div class="topbar">
    <div class="brand">
      <div class="brand-icon">
        <svg viewBox="0 0 24 24"><path d="M3 9l9-7 9 7v11a2 2 0 01-2 2H5a2 2 0 01-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
      </div>
      <span class="brand-name">Registro Elettronico</span>
    </div>
    <a href="/ScuolaWeb/login" class="back-btn">← Torna alla Dashboard</a>
  </div>

  <!-- SEZIONE GESTIONE DOCENTI -->
  <div class="section">
    <div class="section-header">
      <div class="section-title">Gestione Docenti</div>
      <span style="font-family:var(--mono);font-size:12px;color:var(--text-3)">
        Totale: <%= docenti != null ? docenti.size() : 0 %>
      </span>
    </div>

    <!-- FORM AGGIUNTA NUOVO DOCENTE -->
    <form action="AggiungiDocenteController" method="post" class="add-form">
      <input type="text" name="nome" placeholder="Nome" required>
      <input type="text" name="cognome" placeholder="Cognome" required>
      <input type="email" name="email" placeholder="Email" required>
      <input type="password" name="password" placeholder="Password temporanea" required>
	  <input type="text" name="materia" placeholder="Materia" required>
	  <br>
      <select name="classi[]" multiple required>
        <% if (classi != null && !classi.isEmpty()) { 
              for(Classe c : classi){ %>
              <option value="<%= c.getCid() %>">
                <%= c.getAnno() %>ª <%= c.getSezione() %>
              </option>
        <%   } 
           } else { %>
           <option disabled>Nessuna classe disponibile</option>
        <% } %>
      </select>

      <button type="submit" class="action-btn add-btn">Aggiungi Docente</button>
    </form>
    <br>

    <% if(docenti == null || docenti.isEmpty()){ %>
      <div class="empty-box">Nessun docente presente.</div>
    <% } else { %>
      <div class="table-wrap">
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Nome</th>
              <th>Cognome</th>
              <th>Email</th>
              <th>Materia</th>
              <th>Azioni</th>
            </tr>
          </thead>
          <tbody>
          <% for(Docente d : docenti){ %>
            <tr>
              <td><%= d.getDid() %></td>
              <td><%= d.getNome() %></td>
              <td><%= d.getCognome() %></td>
              <td><%= d.getEmail() %></td>
              <td></td>
              <td>
                <form action="RimuoviDocenteController" method="post" style="display:inline;">
                  <input type="hidden" name="did" value="<%= d.getDid() %>">
                  <button type="submit" class="action-btn del-btn">Rimuovi</button>
                </form>
              </td>
            </tr>
          <% } %>
          </tbody>
        </table>
      </div>
    <% } %>

  </div>

</div>
</body>
</html>
