package dao;

import model.Classe;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClassiDAO {

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

    // 🔹 Trova una classe tramite ID_C
    public Classe trovaPerId(int idC) {
        Classe c = null;
        String sql = "SELECT * FROM CLASSI WHERE ID_C = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idC);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                c = new Classe();
                c.setId(rs.getInt("ID_C"));
                c.setSezione(rs.getString("SEZIONE"));
                c.setAnno(rs.getInt("ANNO"));
                c.setNumeroStudenti(rs.getInt("N_STUDENTI"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return c;
    }

    // 🔹 Restituisce tutte le classi
    public List<Classe> trovaTutte() {
        List<Classe> lista = new ArrayList<>();
        String sql = "SELECT * FROM CLASSI ORDER BY ANNO, SEZIONE";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Classe c = new Classe();
                c.setId(rs.getInt("ID_C"));
                c.setSezione(rs.getString("SEZIONE"));
                c.setAnno(rs.getInt("ANNO"));
                c.setNumeroStudenti(rs.getInt("N_STUDENTI"));
                lista.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    // 🔹 Trova tutte le classi in cui insegna un docente
    public List<Classe> trovaClassiPerDocente(int idDocente) {
        List<Classe> lista = new ArrayList<>();

        String sql =
            "SELECT DISTINCT C.ID_C, C.SEZIONE, C.ANNO, C.N_STUDENTI " +
            "FROM ORARIO O " +
            "JOIN CLASSI C ON O.ID_C = C.ID_C " +
            "WHERE O.ID_D = ? " +
            "ORDER BY C.ANNO, C.SEZIONE";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idDocente);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Classe c = new Classe();
                c.setId(rs.getInt("ID_C"));
                c.setSezione(rs.getString("SEZIONE"));
                c.setAnno(rs.getInt("ANNO"));
                c.setNumeroStudenti(rs.getInt("N_STUDENTI"));
                lista.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }
}
