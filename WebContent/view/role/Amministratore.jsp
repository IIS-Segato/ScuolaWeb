<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="model.*" %>
<%@ page import="dao.AmministratoreDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	int aid = (int) session.getAttribute("aid");
%>

<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Dashboard Amministratore</title>

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
  max-width:1200px;
  margin:auto;
  display:flex;
  flex-direction:column;
  gap:28px;
}

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

.section{
  background:#161b22;
  border:0.5px solid #2a3a2e;
  border-radius:14px;
  padding:22px;
}

.section-header{
  display:flex;
  flex-direction:column;
  justify-content:center;
  align-items:center;
  gap:18px;
  margin-bottom:20px;
}

.section-title{
  font-size:20px;
  font-weight:500;
  color:#c8e6c9;
}

.form-grid{
  display:grid;
  grid-template-columns:1fr 1fr;
  gap:18px;
  width:100%;
}

.field{
  display:flex;
  flex-direction:column;
  gap:6px;
}

.field label{
  font-size:11px;
  font-weight:500;
  color:#6a9a72;
  letter-spacing:0.07em;
  text-transform:uppercase;
}

.field input,
.field select{
  background:#0d1117;
  border:0.5px solid #2a3a2e;
  border-radius:8px;
  color:#c8e6c9;
  font-size:14px;
  padding:11px 12px;
  outline:none;
  transition:0.2s ease;
}

.field input:focus,
.field select:focus{
  border-color:#2d6a3a;
  box-shadow:0 0 0 3px rgba(45,106,58,0.18);
}

.search-input{
  width:320px;
  max-width:100%;
  background:#0d1117;
  border:0.5px solid #2a3a2e;
  border-radius:8px;
  color:#c8e6c9;
  padding:12px;
  font-size:14px;
  outline:none;
  text-align:center;
}

.search-input:focus{
  border-color:#2d6a3a;
  box-shadow:0 0 0 3px rgba(45,106,58,0.18);
}

.submit-btn{
  margin-top:20px;
  width:100%;
  background:#1e4d28;
  border:0.5px solid #2d6a3a;
  color:#a5d6a7;
  padding:12px;
  border-radius:8px;
  cursor:pointer;
  transition:0.2s ease;
  font-size:13px;
  text-transform:uppercase;
  letter-spacing:0.06em;
}

.submit-btn:hover{
  background:#2d6a3a;
  transform:translateY(-1px);
  box-shadow:0 4px 14px rgba(45,106,58,0.25);
}

.delete-btn{
  background:#4d1e1e;
  border:0.5px solid #6a2d2d;
  color:#ffb3b3;
  padding:8px 12px;
  border-radius:8px;
  cursor:pointer;
  transition:0.2s ease;
  font-size:12px;
  text-transform:uppercase;
}

.delete-btn:hover{
  background:#6a2d2d;
}

.custom-table{
  width:100%;
  border-collapse:collapse;
  overflow:hidden;
  border-radius:10px;
  margin-top:20px;
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

.name{
  font-size:14px;
  color:#d7f5da;
}

.email{
  font-size:13px;
  color:#6f8d75;
}

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

@media(max-width:850px){

  body{
    padding:20px;
  }

  .topbar{
    flex-direction:column;
    align-items:flex-start;
    gap:14px;
  }

  .form-grid{
    grid-template-columns:1fr;
  }

}

</style>
</head>

<body>

<div class="container">

  <!-- HEADER -->
  <div class="topbar">

    <div class="title-area">
      <h1>Pannello amministratore</h1>
      <p>Gestione docenti, studenti e classi</p>
    </div>

    <button class="logout-btn">
      Esci
    </button>

  </div>

  <!-- CREA CLASSE -->
  <div class="section">

    <div class="section-header">

      <div class="section-title">
        Crea Classe
      </div>

      <form action="CreaClasseServlet" method="post" style="width:100%;">

        <div class="form-grid">

          <div class="field">
            <label>Nome Classe</label>

            <input
              type="text"
              name="classe"
              placeholder="Es. 3A"
              required>
          </div>

        </div>

        <button type="submit" class="submit-btn">
          Crea Classe
        </button>

      </form>

    </div>

  </div>

  <!-- DOCENTI -->
  <div class="section">

    <div class="section-header">

      <div class="section-title">
        Docenti
      </div>

      <!-- FORM DOCENTE -->
      <form action="AggiungiDocenteServlet"
            method="post"
            style="width:100%;">

        <div class="form-grid">

          <div class="field">
            <label>Email</label>

            <input
              type="email"
              name="email"
              required>
          </div>

          <div class="field">
            <label>Password</label>

            <input
              type="password"
              name="password"
              required>
          </div>

          <div class="field">
            <label>Nome</label>

            <input
              type="text"
              name="nome"
              required>
          </div>

          <div class="field">
            <label>Cognome</label>

            <input
              type="text"
              name="cognome"
              required>
          </div>

          <div class="field">
            <label>Materia</label>

            <input
              type="text"
              name="materia"
              required>
          </div>

        </div>

        <button type="submit" class="submit-btn">
          Aggiungi Docente
        </button>

      </form>

      <!-- SEARCH -->
      <input
        type="text"
        class="search-input"
        placeholder="Cerca docente...">

    </div>

    <!-- TABELLA DOCENTI -->
    <table class="custom-table">

      <thead>
        <tr>
          <th>Nome</th>
          <th>Email</th>
          <th>Materia</th>
          <th>Azione</th>
        </tr>
      </thead>

      <tbody>

        <tr>

          <td class="name">
            Marco Rossi
          </td>

          <td class="email">
            marco.rossi@scuola.it
          </td>

          <td>
            <span class="badge">
              Matematica
            </span>
          </td>

          <td>

            <form action="EliminaDocenteServlet"
                  method="post">

              <input
                type="hidden"
                name="id"
                value="1">

              <button
                type="submit"
                class="delete-btn">

                Elimina

              </button>

            </form>

          </td>

        </tr>

        <tr>

          <td class="name">
            Laura Bianchi
          </td>

          <td class="email">
            laura.bianchi@scuola.it
          </td>

          <td>
            <span class="badge">
              Italiano
            </span>
          </td>

          <td>

            <form action="EliminaDocenteServlet"
                  method="post">

              <input
                type="hidden"
                name="id"
                value="2">

              <button
                type="submit"
                class="delete-btn">

                Elimina

              </button>

            </form>

          </td>

        </tr>

      </tbody>

    </table>

  </div>

  <!-- STUDENTI -->
  <div class="section">

    <div class="section-header">

      <div class="section-title">
        Studenti
      </div>

      <!-- FORM STUDENTE -->
      <form action="AggiungiStudenteServlet"
            method="post"
            style="width:100%;">

        <div class="form-grid">

          <div class="field">
            <label>Email</label>

            <input
              type="email"
              name="email"
              required>
          </div>

          <div class="field">
            <label>Password</label>

            <input
              type="password"
              name="password"
              required>
          </div>

          <div class="field">
            <label>Nome</label>

            <input
              type="text"
              name="nome"
              required>
          </div>

          <div class="field">
            <label>Cognome</label>

            <input
              type="text"
              name="cognome"
              required>
          </div>

          <div class="field">
            <label>Data di nascita</label>

            <input
              type="date"
              name="dataNascita"
              required>
          </div>

          <div class="field">
            <label>Classe</label>

            <select name="classe">

              <option value="1A">1A</option>
              <option value="2A">2A</option>
              <option value="3A">3A</option>
              <option value="4A">4A</option>

            </select>

          </div>

        </div>

        <button type="submit" class="submit-btn">
          Aggiungi Studente
        </button>

      </form>

      <!-- SEARCH -->
      <input
        type="text"
        class="search-input"
        placeholder="Cerca studente...">

    </div>

    <!-- TABELLA STUDENTI -->
    <table class="custom-table">

      <thead>
        <tr>
          <th>Nome</th>
          <th>Email</th>
          <th>Classe</th>
          <th>Azione</th>
        </tr>
      </thead>

      <tbody>

        <tr>

          <td class="name">
            Andrea Ferri
          </td>

          <td class="email">
            andrea.ferri@studenti.it
          </td>

          <td>
            <span class="badge">
              3A
            </span>
          </td>

          <td>

            <form action="EliminaStudenteServlet"
                  method="post">

              <input
                type="hidden"
                name="id"
                value="1">

              <button
                type="submit"
                class="delete-btn">

                Elimina

              </button>

            </form>

          </td>

        </tr>

        <tr>

          <td class="name">
            Sofia Romano
          </td>

          <td class="email">
            sofia.romano@studenti.it
          </td>

          <td>
            <span class="badge">
              4B
            </span>
          </td>

          <td>

            <form action="EliminaStudenteServlet"
                  method="post">

              <input
                type="hidden"
                name="id"
                value="2">

              <button
                type="submit"
                class="delete-btn">

                Elimina

              </button>

            </form>

          </td>

        </tr>

      </tbody>

    </table>

  </div>

</div>

</body>
</html>