package dao;

import model.Aula;
import model.Orario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrarioDAO {

    private static final String URL = "jdbc:mysql://localhost:3306/progetto_scuola?serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    private static final String SQL_AULE = "SELECT NOME, CAPIENZA FROM AULE";

    private static final String SQL_ORARIO_PER_AULA =
        "SELECT O.GIORNO, O.ORA_INI, O.ORA_FIN, " +
        "       D.NOME AS NOME_DOCENTE, D.COGNOME AS COGNOME_DOCENTE, D.MATERIA, " +
        "       C.SEZIONE, C.ANNO " +
        "FROM ORARIO O " +
        "JOIN DOCENTI D ON O.ID_D = D.ID_D " +
        "JOIN CLASSI C ON O.ID_C = C.ID_C " +
        "WHERE O.NOME_AULA = ? " +
        "ORDER BY FIELD(O.GIORNO,'Lunedi','Martedi','Mercoledi','Giovedi','Venerdi'), O.ORA_INI";

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver MySQL non trovato!", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public List<Aula> trovaAule() {
        List<Aula> lista = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_AULE);
             ResultSet rs = ps.executeQuery()) {
            System.out.println("Connessione OK");
            while (rs.next()) {
                System.out.println("Aula trovata: " + rs.getString("NOME"));
                Aula a = new Aula();
                a.setNome(rs.getString("NOME"));
                a.setCapienza(rs.getInt("CAPIENZA"));
                a.setOrari(trovaOrariPerAula(rs.getString("NOME")));
                lista.add(a);
            }
            System.out.println("Totale aule: " + lista.size());
        } catch (SQLException e) {
            System.out.println("ERRORE SQL: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }

    public List<Orario> trovaOrariPerAula(String nomeAula) {
        List<Orario> lista = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_ORARIO_PER_AULA)) {
            ps.setString(1, nomeAula);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Orario o = new Orario();
                    o.setGiorno(rs.getString("GIORNO"));
                    o.setOraIni(rs.getString("ORA_INI"));
                    o.setOraFin(rs.getString("ORA_FIN"));
                    o.setClasse(rs.getString("MATERIA") + " - " + rs.getString("NOME_DOCENTE") + " " + rs.getString("COGNOME_DOCENTE"));
                    lista.add(o);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}