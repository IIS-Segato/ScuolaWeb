<%@page import="java.util.ArrayList"%>
<%@ page import="model.*" %>
<%@ page language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	Docente docente =
		(Docente) session.getAttribute("docente");

	ArrayList<Classe> classi =
		docente.getClassi();
%>

<!DOCTYPE html>
<html lang="it">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Dashboard Docente</title>

<style>

*{
  box-sizing:border-box;
  margin:0;
  padding:0;
}

body{
  font-family:Arial,sans-serif;
  background:#0d1117;
  color:#c8e6c9;
  min-height:100vh;
  padding:40px;
}

.container{
  max-width:1300px;
  margin:auto;
  display:flex;
  flex-direction:column;
  gap:28px;
}

/* HEADER */

.topbar{
  display:flex;
  justify-content:space-between;
  align-items:center;
}

.title-area h1{
  font-size:26px;
  font-weight:500;
  color:#d7f5da;
}

.title-area p{
  font-size:13px;
  color:#58705d;
  margin-top:4px;
}

.logout-btn{
  background:#1a2029;
  border:0.5px solid #2a3a2e;
  color:#86c28d;
  padding:10px 16px;
  border-radius:8px;
  cursor:pointer;
  transition:0.2s ease;
  font-size:12px;
  text-transform:uppercase;
  letter-spacing:0.06em;
}

.logout-btn:hover{
  background:#222a34;
  border-color:#3a6b44;
}

/* SECTION */

.section{
  background:#161b22;
  border:0.5px solid #2a3a2e;
  border-radius:14px;
  padding:22px;
}

.section-title{
  font-size:20px;
  font-weight:500;
  color:#c8e6c9;
  margin-bottom:24px;
}

/* DOCENTE */

.docente-card{
  display:flex;
  justify-content:space-between;
  align-items:center;
}

.docente-info h2{
  font-size:24px;
  color:#d7f5da;
  font-weight:500;
}

.docente-info p{
  color:#6f8d75;
  margin-top:6px;
  font-size:14px;
}

.docente-badge{
  display:inline-block;
  background:rgba(45,106,58,0.16);
  border:0.5px solid #2d6a3a;
  color:#8fd49b;
  padding:10px 14px;
  border-radius:999px;
  font-size:12px;
  text-transform:uppercase;
}

/* CLASSI GRID */

.class-grid{
  display:grid;
  grid-template-columns:repeat(auto-fill,minmax(260px,1fr));
  gap:20px;
}

/* CARD CLASSE */

.class-card{
  background:#0d1117;
  border:0.5px solid #2a3a2e;
  border-radius:14px;
  padding:24px;
  text-decoration:none;
  transition:0.2s ease;
  display:flex;
  flex-direction:column;
  gap:16px;
}

.class-card:hover{
  transform:translateY(-3px);
  border-color:#3a6b44;
  box-shadow:0 6px 18px rgba(45,106,58,0.18);
  background:#111822;
}

.class-top{
  display:flex;
  justify-content:space-between;
  align-items:center;
}

.class-name{
  font-size:24px;
  color:#d7f5da;
  font-weight:500;
}

.class-badge{
  background:rgba(45,106,58,0.16);
  border:0.5px solid #2d6a3a;
  color:#8fd49b;
  padding:6px 10px;
  border-radius:999px;
  font-size:11px;
  text-transform:uppercase;
}

.class-info{
  display:flex;
  flex-direction:column;
  gap:8px;
}

.class-info p{
  font-size:14px;
  color:#6f8d75;
}

.class-arrow{
  margin-top:10px;
  color:#8fd49b;
  font-size:13px;
  text-transform:uppercase;
  letter-spacing:0.06em;
}

/* EMPTY */

.empty-box{
  padding:30px;
  border:1px dashed #2a3a2e;
  border-radius:10px;
  text-align:center;
  color:#58705d;
}

/* RESPONSIVE */

@media(max-width:850px){

  body{
    padding:20px;
  }

  .topbar{
    flex-direction:column;
    align-items:flex-start;
    gap:14px;
  }

  .docente-card{
    flex-direction:column;
    align-items:flex-start;
    gap:18px;
  }

}

</style>

</head>

<body>

<div class="container">

  <!-- HEADER -->

  <div class="topbar">

    <div class="title-area">

      <h1>Pannello docente</h1>

      <p>
        Seleziona una classe per gestire i voti
      </p>

    </div>

    <button class="logout-btn">
      Esci
    </button>

  </div>

  <!-- DATI DOCENTE -->

  <div class="section">

    <div class="docente-card">

      <div class="docente-info">

        <h2>
          <%= docente.getNome() %>
          <%= docente.getCognome() %>
        </h2>

        <p>
          ID docente:
          <%= docente.getDid() %>
        </p>

      </div>

      <div class="docente-badge">

        Docente

      </div>

    </div>

  </div>

  <!-- CLASSI -->

  <div class="section">

    <div class="section-title">

      Le tue classi

    </div>

    <%
      if(classi == null || classi.isEmpty()){
    %>

      <div class="empty-box">

        Nessuna classe assegnata.

      </div>

    <% } else { %>

      <div class="class-grid">

        <% for(Classe c : classi){ %>

          <a
            href="ClasseDocenteServlet?cid=<%= "cid" %>"
            class="class-card">

            <div class="class-top">

              <div class="class-name">

                <%= c.getAnno() + c.getSezione() %>

              </div>

              <div class="class-badge">

                Classe

              </div>

            </div>

            <div class="class-info">

              <p>

                Materia:
                <%= "materia" %>

              </p>

              <p>

                Visualizza studenti e voti

              </p>

            </div>

            <div class="class-arrow">

              Apri classe →

            </div>

          </a>

        <% } %>

      </div>

    <% } %>

  </div>

</div>

</body>

</html>