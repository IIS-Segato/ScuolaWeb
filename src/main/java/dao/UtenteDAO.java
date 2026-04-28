package dao;

import model.Utente;

import java.sql.*;

public class UtenteDAO {


    private static final String URL = "jdbc:mysql://localhost:3306/progetto_scuola";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    // Connessione al DB
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // LOGIN: trova utente per email
    public Utente trovaPerEmail(String email) {

        String sql = "SELECT * FROM utenti WHERE email = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    Utente u = new Utente();

                    u.setId(rs.getInt("id"));
                    u.setEmail(rs.getString("email"));
                    u.setPassword(rs.getString("password"));
                    u.setRuolo(rs.getString("ruolo"));
                    u.setNome(rs.getString("nome"));
                    u.setCognome(rs.getString("cognome"));

                    return u;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}