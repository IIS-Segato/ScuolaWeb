package dao;

import model.Utente;
import java.sql.*;

public class UtenteDAO {
	
	// Parametri di connessione al database MySQL
    private static final String URL = "jdbc:mysql://localhost:3306/progetto_scuola?serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver MySQL non trovato nel progetto!", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public Utente trovaPerEmail(String email) {
        String sql = "SELECT ID_D AS id, NOME, COGNOME, EMAIL, PWD AS password, 'DOCENTE' AS ruolo FROM DOCENTI WHERE EMAIL = ? " +
                     "UNION " +
                     "SELECT ID_S AS id, NOME, COGNOME, EMAIL, PWD AS password, 'STUDENTE' AS ruolo FROM STUDENTI WHERE EMAIL = ? " +
                     "UNION " +
                     "SELECT ID_A AS id, NOME, COGNOME, EMAIL, PWD AS password, 'AMMINISTRATORE' AS ruolo FROM AMMINISTRATORI WHERE EMAIL = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, email);
            ps.setString(3, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Utente u = new Utente();
                    u.setId(rs.getInt("id"));
                    u.setNome(rs.getString("NOME"));
                    u.setCognome(rs.getString("COGNOME"));
                    u.setEmail(rs.getString("EMAIL"));
                    u.setPassword(rs.getString("password"));
                    u.setRuolo(rs.getString("ruolo"));
                    return u;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}