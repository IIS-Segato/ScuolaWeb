package dao;

import model.Utente;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UtenteDAO {
	
    private static final String URL = "jdbc:mysql://localhost:3306/progetto_scuola?serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    
    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver MySQL non trovato!", e);
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
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public List<Utente> trovaTutti() {
        List<Utente> lista = new ArrayList<>();
        String sql = "SELECT ID_D AS id, NOME, COGNOME, EMAIL, PWD AS password, 'DOCENTE' AS ruolo FROM DOCENTI " +
                     "UNION " +
                     "SELECT ID_S, NOME, COGNOME, EMAIL, PWD, 'STUDENTE' FROM STUDENTI " +
                     "UNION " +
                     "SELECT ID_A, NOME, COGNOME, EMAIL, PWD, 'AMMINISTRATORE' FROM AMMINISTRATORI";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Utente u = new Utente();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("NOME"));
                u.setCognome(rs.getString("COGNOME"));
                u.setEmail(rs.getString("EMAIL"));
                u.setPassword(rs.getString("password"));
                u.setRuolo(rs.getString("ruolo"));
                lista.add(u);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }
    
    public boolean aggiorna(Utente u) {
        String tabella = "";
        if ("DOCENTE".equals(u.getRuolo())) tabella = "DOCENTI";
        else if ("STUDENTE".equals(u.getRuolo())) tabella = "STUDENTI";
        else if ("AMMINISTRATORE".equals(u.getRuolo())) tabella = "AMMINISTRATORI";

        String sql = "UPDATE " + tabella + " SET NOME=?, COGNOME=?, EMAIL=?, PWD=? WHERE EMAIL=?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getNome());
            ps.setString(2, u.getCognome());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPassword());
            ps.setString(5, u.getEmail()); 
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // --- METODO INSERISCI (SISTEMATO) ---
    public boolean inserisciNuovoUtente(Utente u) {
        String sql = "";
        if ("STUDENTE".equals(u.getRuolo())) {
            sql = "INSERT INTO STUDENTI (NOME, COGNOME, EMAIL, PWD, ID_C) VALUES (?, ?, ?, ?, 1)"; 
        } else if ("DOCENTE".equals(u.getRuolo())) {
            sql = "INSERT INTO DOCENTI (NOME, COGNOME, EMAIL, PWD, MATERIA) VALUES (?, ?, ?, ?, 'Da definire')";
        } else if ("AMMINISTRATORE".equals(u.getRuolo())) {
            sql = "INSERT INTO AMMINISTRATORI (NOME, COGNOME, EMAIL, PWD) VALUES (?, ?, ?, ?)";
        }

        try (Connection conn = getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getNome());
            ps.setString(2, u.getCognome());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPassword());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // --- NUOVO METODO ELIMINA ---
    public boolean elimina(String email, String ruolo) {
        String tabella = "";
        if ("DOCENTE".equals(ruolo)) tabella = "DOCENTI";
        else if ("STUDENTE".equals(ruolo)) tabella = "STUDENTI";
        else if ("AMMINISTRATORE".equals(ruolo)) tabella = "AMMINISTRATORI";

        if (tabella.isEmpty()) return false;

        String sql = "DELETE FROM " + tabella + " WHERE EMAIL = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}