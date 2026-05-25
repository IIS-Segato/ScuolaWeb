package dao;

import model.Utente;
import java.util.LinkedHashMap;
import java.util.Map;
import model.Aula;
import model.Classe;
import model.Orario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DocenteDAO {

    private static final String URL = "jdbc:mysql://localhost:3306/progetto_scuola?serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    // Query consultazione
    private static final String SQL_MATERIA =
        "SELECT MATERIA FROM DOCENTI WHERE ID_D = ?";

    private static final String SQL_CLASSI_DOCENTE =
        "SELECT DISTINCT C.ID_C, C.SEZIONE, C.ANNO " +
        "FROM ORARIO O " +
        "JOIN CLASSI C ON O.ID_C = C.ID_C " +
        "WHERE O.ID_D = ? " +
        "ORDER BY C.ANNO, C.SEZIONE";

    private static final String SQL_AULE_DOCENTE =
        "SELECT DISTINCT A.NOME, A.CAPIENZA " +
        "FROM ORARIO O " +
        "JOIN AULE A ON O.NOME_AULA = A.NOME " +
        "WHERE O.ID_D = ?";

    private static final String SQL_ORARIO_DOCENTE =
        "SELECT O.GIORNO, O.ORA_INI, O.ORA_FIN, " +
        "       C.SEZIONE, C.ANNO, A.NOME AS AULA " +
        "FROM ORARIO O " +
        "JOIN CLASSI C ON O.ID_C = C.ID_C " +
        "JOIN AULE A ON O.NOME_AULA = A.NOME " +
        "WHERE O.ID_D = ? " +
        "ORDER BY FIELD(GIORNO,'Lunedi','Martedi','Mercoledi','Giovedi','Venerdi'), O.ORA_INI";
    
    private static final String SQL_STUDENTI_DOCENTE =
    	    "SELECT DISTINCT S.ID_S, S.NOME, S.COGNOME, S.ID_C " +
    	    "FROM STUDENTI S " +
    	    "JOIN ORARIO O ON O.ID_C = S.ID_C " +
    	    "WHERE O.ID_D = ? " +
    	    "ORDER BY S.ID_C, S.COGNOME, S.NOME";

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver MySQL non trovato!", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // Converte una riga del ResultSet in un oggetto Utente
    private Utente mapRow(ResultSet rs) throws SQLException {
        Utente u = new Utente();
        u.setId(rs.getInt("id"));
        u.setNome(rs.getString("NOME"));
        u.setCognome(rs.getString("COGNOME"));
        u.setEmail(rs.getString("EMAIL"));
        u.setPassword(rs.getString("password"));
        u.setRuolo("DOCENTE");
        return u;
    }

    // Restituisce la materia insegnata dal docente
    public String trovaMateria(int idDocente) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_MATERIA)) {
            ps.setInt(1, idDocente);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getString("MATERIA");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Restituisce le classi in cui insegna il docente
    public List<Classe> trovaClassiDocente(int idDocente) {
        List<Classe> lista = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_CLASSI_DOCENTE)) {
            ps.setInt(1, idDocente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Classe c = new Classe();
                    c.setId(rs.getInt("ID_C"));
                    c.setSezione(rs.getString("SEZIONE"));
                    c.setAnno(rs.getInt("ANNO"));
                    lista.add(c);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // Restituisce le aule in cui insegna il docente
    public List<Aula> trovaAulePerDocente(int idDocente) {
        List<Aula> lista = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_AULE_DOCENTE)) {
            ps.setInt(1, idDocente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Aula a = new Aula();
                    a.setNome(rs.getString("NOME"));
                    a.setCapienza(rs.getInt("CAPIENZA"));
                    lista.add(a);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // Restituisce l'orario completo del docente ordinato per giorno e ora
    public List<Orario> trovaOrarioDocente(int idDocente) {
        List<Orario> lista = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_ORARIO_DOCENTE)) {
            ps.setInt(1, idDocente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Orario o = new Orario();
                    o.setGiorno(rs.getString("GIORNO"));
                    o.setOraIni(rs.getString("ORA_INI"));
                    o.setOraFin(rs.getString("ORA_FIN"));
                    o.setClasse(rs.getString("SEZIONE") + " " + rs.getInt("ANNO"));
                    o.setAula(rs.getString("AULA"));
                    lista.add(o);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
    
 // Restituisce tutti gli studenti delle classi del docente, raggruppati per classe
    public Map<Integer, List<Utente>> trovaStudentiDocente(int idDocente) {
        Map<Integer, List<Utente>> mappa = new LinkedHashMap<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_STUDENTI_DOCENTE)) {
            ps.setInt(1, idDocente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int idClasse = rs.getInt("ID_C");
                    Utente s = new Utente();
                    s.setId(rs.getInt("ID_S"));
                    s.setNome(rs.getString("NOME"));
                    s.setCognome(rs.getString("COGNOME"));
                    // inserisce nella lista della classe corrispondente
                    mappa.computeIfAbsent(idClasse, k -> new ArrayList<>()).add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mappa;
    }
}