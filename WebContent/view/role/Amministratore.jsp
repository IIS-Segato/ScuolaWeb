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
  * {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
  }

  body {
    font-family: Arial, sans-serif;
    background: #0d1117;
    color: #c8e6c9;
    min-height: 100vh;
    padding: 40px;
  }

  .container {
    max-width: 1100px;
    margin: auto;
    display: flex;
    flex-direction: column;
    gap: 28px;
  }

  .topbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .title-area h1 {
    font-size: 26px;
    font-weight: 500;
    color: #d7f5da;
  }

  .title-area p {
    font-size: 13px;
    color: #58705d;
    margin-top: 4px;
  }

  .logout-btn {
    background: #1a2029;
    border: 0.5px solid #2a3a2e;
    color: #86c28d;
    padding: 10px 16px;
    border-radius: 8px;
    cursor: pointer;
    transition: 0.2s ease;
    font-size: 12px;
    text-transform: uppercase;
    letter-spacing: 0.06em;
  }

  .logout-btn:hover {
    background: #222a34;
    border-color: #3a6b44;
  }

  .section {
    background: #161b22;
    border: 0.5px solid #2a3a2e;
    border-radius: 14px;
    padding: 22px;
  }

  .section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }

  .section-title {
    font-size: 18px;
    font-weight: 500;
    color: #c8e6c9;
  }

  .add-btn {
    background: #1e4d28;
    border: 0.5px solid #2d6a3a;
    color: #a5d6a7;
    padding: 10px 14px;
    border-radius: 8px;
    cursor: pointer;
    transition: 0.2s ease;
    font-size: 12px;
    text-transform: uppercase;
    letter-spacing: 0.05em;
  }

  .add-btn:hover {
    background: #2d6a3a;
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(45,106,58,0.25);
  }

  .table {
    display: flex;
    flex-direction: column;
    gap: 10px;
  }

  .row {
    display: grid;
    grid-template-columns: 1fr 1fr 160px;
    gap: 12px;
    align-items: center;
    background: #0d1117;
    border: 0.5px solid #2a3a2e;
    border-radius: 10px;
    padding: 14px;
    transition: 0.2s ease;
  }

  .row:hover {
    border-color: #3a6b44;
    background: #111822;
  }

  .head {
    background: transparent;
    border: none;
    padding: 0 14px 6px;
  }

  .head div {
    font-size: 11px;
    color: #6a9a72;
    text-transform: uppercase;
    letter-spacing: 0.08em;
  }

  .name {
    font-size: 14px;
    color: #d7f5da;
  }

  .email {
    font-size: 13px;
    color: #6f8d75;
  }

  .badge {
    justify-self: start;
    background: rgba(45,106,58,0.16);
    border: 0.5px solid #2d6a3a;
    color: #8fd49b;
    padding: 7px 10px;
    border-radius: 999px;
    font-size: 11px;
    text-transform: uppercase;
    letter-spacing: 0.05em;
  }

  .form-box {
    margin-top: 22px;
    border-top: 0.5px solid #2a3a2e;
    padding-top: 22px;
  }

  .form-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 18px;
  }

  .field {
    display: flex;
    flex-direction: column;
    gap: 6px;
  }

  .field label {
    font-size: 11px;
    font-weight: 500;
    color: #6a9a72;
    letter-spacing: 0.07em;
    text-transform: uppercase;
  }

  .field input {
    background: #0d1117;
    border: 0.5px solid #2a3a2e;
    border-radius: 8px;
    color: #c8e6c9;
    font-size: 14px;
    padding: 11px 12px;
    outline: none;
    transition: 0.2s ease;
  }

  .field input::placeholder {
    color: #3a4f3e;
  }

  .field input:hover {
    border-color: #3a6b44;
  }

  .field input:focus {
    border-color: #2d6a3a;
    box-shadow: 0 0 0 3px rgba(45,106,58,0.18);
  }

  .submit-btn {
    margin-top: 20px;
    width: 100%;
    background: #1e4d28;
    border: 0.5px solid #2d6a3a;
    color: #a5d6a7;
    padding: 12px;
    border-radius: 8px;
    cursor: pointer;
    transition: 0.2s ease;
    font-size: 13px;
    text-transform: uppercase;
    letter-spacing: 0.06em;
  }

  .submit-btn:hover {
    background: #2d6a3a;
    transform: translateY(-1px);
    box-shadow: 0 4px 14px rgba(45,106,58,0.25);
  }

  @media (max-width: 850px) {
    .row {
      grid-template-columns: 1fr;
    }

    .form-grid {
      grid-template-columns: 1fr;
    }

    body {
      padding: 20px;
    }

    .topbar {
      flex-direction: column;
      align-items: flex-start;
      gap: 14px;
    }
  }
</style>
</head>
<body>

<div class="container">

  <div class="topbar">
    <div class="title-area">
      <h1>Pannello amministratore</h1>
      <p>Gestione docenti e studenti</p>
    </div>

    <button class="logout-btn">Esci</button>
  </div>

  <!-- DOCENTI -->
  <div class="section">

    <div class="section-header">
      <div class="section-title">Docenti</div>
    </div>

    <div class="table">

      <div class="row head">
        <div>Nome</div>
        <div>Email</div>
        <div>Materia</div>
      </div>

      <div class="row">
        <div class="name">Marco Rossi</div>
        <div class="email">marco.rossi@scuola.it</div>
        <div class="badge">Matematica</div>
      </div>

      <div class="row">
        <div class="name">Laura Bianchi</div>
        <div class="email">laura.bianchi@scuola.it</div>
        <div class="badge">Italiano</div>
      </div>

      <div class="row">
        <div class="name">Giuseppe Verdi</div>
        <div class="email">giuseppe.verdi@scuola.it</div>
        <div class="badge">Informatica</div>
      </div>

    </div>

  </div>

  <!-- STUDENTI -->
  <div class="section">

    <div class="section-header">
      <div class="section-title">Studenti</div>
      <button class="add-btn">+ Nuovo studente</button>
    </div>

    <div class="table">

      <div class="row head">
        <div>Nome</div>
        <div>Email</div>
        <div>Classe</div>
      </div>

      <div class="row">
        <div class="name">Andrea Ferri</div>
        <div class="email">andrea.ferri@studenti.it</div>
        <div class="badge">3A</div>
      </div>

      <div class="row">
        <div class="name">Sofia Romano</div>
        <div class="email">sofia.romano@studenti.it</div>
        <div class="badge">4B</div>
      </div>

      <div class="row">
        <div class="name">Luca Conti</div>
        <div class="email">luca.conti@studenti.it</div>
        <div class="badge">5C</div>
      </div>

    </div>

    <!-- FORM AGGIUNTA -->
    <div class="form-box">

      <div class="section-title" style="margin-bottom: 18px;">
        Aggiungi studente
      </div>

      <form>

        <div class="form-grid">

          <div class="field">
            <label>Nome completo</label>
            <input type="text" placeholder="Mario Rossi">
          </div>

          <div class="field">
            <label>Email</label>
            <input type="email" placeholder="mario@studenti.it">
          </div>

          <div class="field">
            <label>Classe</label>
            <input type="text" placeholder="1A">
          </div>

          <div class="field">
            <label>Password</label>
            <input type="password" placeholder="••••••••">
          </div>

        </div>

        <button class="submit-btn" type="button">
          Aggiungi studente
        </button>

      </form>

    </div>

  </div>

</div>

</body>
</html>