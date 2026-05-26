<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.*, dao.*" %>
<%
    // Recupero il docente dalla sessione
    Integer idDocente = (Integer) session.getAttribute("utenteId");
    
    // Supponiamo che il controller passi le liste necessarie
    List<Studente> listaStudenti = (List<Studente>) request.getAttribute("studenti");
    List<Insegnamento> listaInsegnamenti = (List<Insegnamento>) request.getAttribute("insegnamenti");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Inserisci Voto</title>
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card p-4 shadow-sm border-0">
        <h3 class="mb-4 text-success">Inserimento Nuovo Voto</h3>
        <form action="VotoController" method="POST">
            <input type="hidden" name="action" value="INSERT">
            
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Studente:</label>
                    <select name="id_studente" class="form-select" required>
                        <option value="">Seleziona studente...</option>
                        <% for(Studente s : listaStudenti) { %>
                            <option value="<%= s.getId() %>"><%= s.getNome() %> <%= s.getCognome() %></option>
                        <% } %>
                    </select>
                </div>
                
                <div class="col-md-6 mb-3">
                    <label class="form-label">Materia/Classe:</label>
                    <select name="id_insegnamento" class="form-select" required>
                        <option value="">Seleziona insegnamento...</option>
                        <% for(Insegnamento i : listaInsegnamenti) { %>
                            <option value="<%= i.getId() %>"><%= i.getNomeMateria() %> - <%= i.getNomeClasse() %></option>
                        <% } %>
                    </select>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4 mb-3">
                    <label class="form-label">Voto:</label>
                    <input type="number" step="0.1" min="1" max="10" name="voto" class="form-control" placeholder="es. 7.5" required>
                </div>
                <div class="col-md-4 mb-3">
                    <label class="form-label">Data:</label>
                    <input type="date" name="data_voto" class="form-control" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Descrizione:</label>
                <input type="text" name="descrizione" class="form-control" placeholder="es. Verifica orale su... ">
            </div>

            <button type="submit" class="btn btn-success px-4">Salva Voto</button>
            <a href="OrarioController" class="btn btn-outline-secondary">Annulla</a>
        </form>
    </div>
</div>
</body>
</html>