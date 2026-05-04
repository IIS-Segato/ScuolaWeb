package dao;

import model.Utente;
import model.Classe;
import model.Orario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudenteDAO {

    private static final String URL = "jdbc:mysql://localhost:3306/progetto_scuola?serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    private static final String SQL_CLASSE_STUDENTE =
        "SELECT C.ID_C, C.SEZIONE, C.ANNO, C.N_STUDENTI " +
        "FROM STUDENTI S " +
        "JOIN CLASSI C ON S.ID_C = C.ID_C " +
        "WHERE S.ID_S = ?";

    private static final String SQL_ORARIO_STUDENTE =
        "SELECT O.GIORNO, O.ORA_INI, O.ORA_FIN, " +
        "       D.NOME AS NOME_DOCENTE, D.COGNOME AS COGNOME_DOCENTE, " +
        "       D.MATERIA, A.NOME AS AULA " +
        "FROM ORARIO O " +
        "JOIN DOCENTI D ON O.ID_D = D.ID_D " +
        "JOIN AULE A ON O.NOME_AULA = A.NOME " +
        "JOIN STUDENTI S ON O.ID_C = S.ID_C " +
        "WHERE S.ID_S = ? " +
        "ORDER BY FIELD(O.GIORNO,'Lunedi','Martedi','Mercoledi','Giovedi','Venerdi'), O.ORA_INI";

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver MySQL non trovato!", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // Restituisce la classe dello studente
    public Classe trovaClasseStudente(int idStudente) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_CLASSE_STUDENTE)) {
            ps.setInt(1, idStudente);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Classe c = new Classe();
                    c.setId(rs.getInt("ID_C"));
                    c.setSezione(rs.getString("SEZIONE"));
                    c.setAnno(rs.getInt("ANNO"));
                    c.setNumeroStudenti(rs.getInt("N_STUDENTI"));
                    return c;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Restituisce l'orario della classe dello studente
    public List<Orario> trovaOrarioStudente(int idStudente) {
        List<Orario> lista = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_ORARIO_STUDENTE)) {
            ps.setInt(1, idStudente);
            try (ResultSet rs = ps.executeQuery()) {
            	while (rs.next()) {
            	    Orario o = new Orario();
            	    o.setGiorno(rs.getString("GIORNO"));
            	    o.setOraIni(rs.getString("ORA_INI"));
            	    o.setOraFin(rs.getString("ORA_FIN"));
            	    o.setClasse(rs.getString("MATERIA") + " - " + rs.getString("NOME_DOCENTE") + " " + rs.getString("COGNOME_DOCENTE"));
            	    o.setAula(rs.getString("AULA"));
            	    lista.add(o);
            	}
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}