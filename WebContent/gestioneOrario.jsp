<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // controllo base admin
    String utente = (String) session.getAttribute("utente");
    if (utente == null || !utente.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String msg = "";

    try {

        Class.forName("com.mysql.cj.jdbc.Driver");

        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/scuola",
            "root",
            ""
        );

        // INSERT o UPDATE ORARIO
        if (request.getParameter("azione") != null) {

            int id_insegnamento = Integer.parseInt(request.getParameter("id_insegnamento"));
            int id_aula = Integer.parseInt(request.getParameter("id_aula"));
            String giorno = request.getParameter("giorno");
            String ora_inizio = request.getParameter("ora_inizio");
            String ora_fine = request.getParameter("ora_fine");

            // controlla se esiste già
            String check = "SELECT id_orario FROM orario WHERE id_insegnamento=? AND giorno=? AND ora_inizio=?";
            ps = conn.prepareStatement(check);
            ps.setInt(1, id_insegnamento);
            ps.setString(2, giorno);
            ps.setString(3, ora_inizio);
            rs = ps.executeQuery();

            if (rs.next()) {

                String update = "UPDATE orario SET id_aula=?, ora_fine=? WHERE id_orario=?";
                ps = conn.prepareStatement(update);
                ps.setInt(1, id_aula);
                ps.setString(2, ora_fine);
                ps.setInt(3, rs.getInt(1));
                ps.executeUpdate();

                msg = "Orario aggiornato";

            } else {

                String insert = "INSERT INTO orario(id_insegnamento,id_aula,giorno,ora_inizio,ora_fine) VALUES(?,?,?,?,?)";

                ps = conn.prepareStatement(insert);
                ps.setInt(1, id_insegnamento);
                ps.setInt(2, id_aula);
                ps.setString(3, giorno);
                ps.setString(4, ora_inizio);
                ps.setString(5, ora_fine);
                ps.executeUpdate();

                msg = "Orario inserito";
            }
        }

    } catch(Exception e) {
        msg = "Errore: " + e.getMessage();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Gestione Orario</title>
    <link href="style.css" rel="stylesheet">
</head>

<body>

<div id="banner">
    <div id="logo">
        <img src="imgs/default.png">
        <h2>Gestione Orario Admin</h2>
    </div>
</div>

<a id="indietro" href="admin.html">← Indietro</a>

<div class="main-container">

    <h2 class="title">Inserisci / Modifica Orario</h2>

    <form method="post">

        <input type="hidden" name="azione" value="1">

        <!-- ID insegnamento -->
        <label>ID Insegnamento</label>
        <input type="number" name="id_insegnamento" required class="form-control">

        <!-- Aula -->
        <label>Aula</label>
        <input type="number" name="id_aula" required class="form-control">

        <!-- Giorno -->
        <label>Giorno</label>
        <select name="giorno" class="form-control">
            <option>LUN</option>
            <option>MAR</option>
            <option>MER</option>
            <option>GIO</option>
            <option>VEN</option>
            <option>SAB</option>
        </select>

        <!-- Ora -->
        <label>Ora inizio</label>
        <input type="time" name="ora_inizio" required class="form-control">

        <label>Ora fine</label>
        <input type="time" name="ora_fine" required class="form-control">

        <br>

        <button type="submit" id="submitButton">
            Salva Orario
        </button>

    </form>

    <br>

    <div style="color:green; font-weight:bold;">
        <%= msg %>
    </div>

</div>

</body>
</html>