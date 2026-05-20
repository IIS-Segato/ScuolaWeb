<%@page import="java.util.ArrayList"%>
<%@ page import="model.*" %>
<%@ page language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	ArrayList<Studente> studenti =
		(ArrayList<Studente>) request.getAttribute("studenti");

	String materia = (String) request.getAttribute("materia");
%>

<!DOCTYPE html>
<html lang="it">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Classe</title>

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
  max-width:1350px;
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
  font-size:28px;
  font-weight:500;
  color:#d7f5da;
}

.title-area p{
  font-size:13px;
  color:#58705d;
  margin-top:4px;
}

.back-btn{
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
  text-decoration:none;
}

.back-btn:hover{
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
  margin-bottom:22px;
}

/* TABLE */

.custom-table{
  width:100%;
  border-collapse:collapse;
  overflow:hidden;
  border-radius:10px;
}

.custom-table thead{
  background:#111822;
}

.custom-table th{
  padding:14px;
  text-align:left;
  font-size:12px;
  color:#6a9a72;
  text-transform:uppercase;
  letter-spacing:0.06em;
}

.custom-table td{
  padding:16px 14px;
  border-top:1px solid #2a3a2e;
  background:#0d1117;
}

.custom-table tr:hover td{
  background:#111822;
}

.student-name{
  font-size:14px;
  color:#d7f5da;
}

.student-email{
  font-size:13px;
  color:#6f8d75;
}

/* FORM */

.vote-form{
  display:flex;
  align-items:center;
  gap:12px;
}

.vote-input{
  width:90px;
  background:#161b22;
  border:0.5px solid #2a3a2e;
  border-radius:8px;
  color:#c8e6c9;
  padding:10px;
  outline:none;
  transition:0.2s ease;
}

.vote-input:focus{
  border-color:#2d6a3a;
  box-shadow:0 0 0 3px rgba(45,106,58,0.18);
}

.submit-btn{
  background:#1e4d28;
  border:0.5px solid #2d6a3a;
  color:#a5d6a7;
  padding:10px 14px;
  border-radius:8px;
  cursor:pointer;
  transition:0.2s ease;
  font-size:12px;
  text-transform:uppercase;
  letter-spacing:0.06em;
}

.submit-btn:hover{
  background:#2d6a3a;
  transform:translateY(-1px);
  box-shadow:0 4px 14px rgba(45,106,58,0.25);
}

/* BADGE */

.badge{
  display:inline-block;
  background:rgba(45,106,58,0.16);
  border:0.5px solid #2d6a3a;
  color:#8fd49b;
  padding:7px 10px;
  border-radius:999px;
  font-size:11px;
  text-transform:uppercase;
  letter-spacing:0.05em;
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

@media(max-width:950px){

  body{
    padding:20px;
  }

  .topbar{
    flex-direction:column;
    align-items:flex-start;
    gap:14px;
  }

  .custom-table{
    display:block;
    overflow-x:auto;
  }

}

</style>

</head>

<body>

<div class="container">

  <!-- HEADER -->

  <div class="topbar">

    <div class="title-area">

      <h1>

        Classe
        <%= "classe" %>

      </h1>

      <p>

        Gestione studenti e voti

      </p>

    </div>

    <a href="DocenteServlet"
       class="back-btn">

      ← Torna alle classi

    </a>

  </div>

  <!-- INFO CLASSE -->

  <div class="section">

    <div class="section-title">

      Informazioni classe

    </div>

    <span class="badge">

      Materia:
      <%= "classe" %>

    </span>

  </div>

  <!-- STUDENTI -->

  <div class="section">

    <div class="section-title">

      Studenti

    </div>

    <%
      if(studenti == null || studenti.isEmpty()){
    %>

      <div class="empty-box">

        Nessuno studente trovato.

      </div>

    <% } else { %>

    <table class="custom-table">

      <thead>

        <tr>

          <th>Studente</th>
          <th>Email</th>
          <th>Nuovo voto</th>
          <th>Azione</th>

        </tr>

      </thead>

      <tbody>

      <% for(Studente s : studenti){ %>

        <tr>

          <td class="student-name">

            <%= s.getNome() %>
            <%= s.getCognome() %>

          </td>

          <td class="student-email">

            <%= s.getEmail() %>

          </td>

          <td>

            <form action="AggiungiVotoServlet"
                  method="post"
                  class="vote-form">

              <input
                type="hidden"
                name="sid"
                value="<%= s.getSid() %>">

              <input
                type="hidden"
                name="cid"
                value="<%= "cid" %>">

              <input
                type="number"
                name="voto"
                min="1"
                max="10"
                step="0.1"
                required
                class="vote-input"
                placeholder="8">

          </td>

          <td>

              <button
                type="submit"
                class="submit-btn">

                Salva voto

              </button>

            </form>

          </td>

        </tr>

      <% } %>

      </tbody>

    </table>

    <% } %>

  </div>

</div>

</body>

</html>