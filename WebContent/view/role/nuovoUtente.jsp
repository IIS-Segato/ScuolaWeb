<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inserimento Nuovo Utente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-5 bg-light">
    <div class="container bg-white p-4 shadow-sm rounded" style="max-width: 600px;">
        <h1 class="fw-bold text-success mb-3">NUOVO UTENTE</h1>
        <hr>

        <form action="../../Utente" method="post">
            <input type="hidden" name="action" value="INSERT">
            
            <div class="mb-3">
                <label class="form-label fw-bold">Nome:</label>
                <input type="text" class="form-control" name="nome" placeholder="Es: Mario" required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Cognome:</label>
                <input type="text" class="form-control" name="cognome" placeholder="Es: Rossi" required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Email:</label>
                <input type="email" class="form-control" name="email" placeholder="mario.rossi@scuola.it" required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Password:</label>
                <input type="password" class="form-control" name="password" required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Ruolo:</label>
                <select class="form-select" name="ruolo" required>
                    <option value="" selected disabled>Scegli un ruolo...</option>
                    <option value="STUDENTE">STUDENTE</option>
                    <option value="DOCENTE">DOCENTE</option>
                    <option value="AMMINISTRATORE">AMMINISTRATORE</option>
                </select>
                <div class="form-text">In base al ruolo, l'utente verrà salvato nella tabella corretta.</div>
            </div>
            
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-success fw-bold">REGISTRA UTENTE</button>
                <a href="Utente" class="btn btn-outline-secondary">Annulla e Torna Indietro</a>
            </div>
        </form>
    </div>
</body>
</html>