package dao;

import model.Orario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrarioDAO extends AbstractDAO {

    private static final String SQL_GET_ALL =
            "SELECT * FROM orario";

    private static final String SQL_GET_BY_ID =
            "SELECT * FROM orario WHERE id_orario=?";

    private static final String SQL_INSERT =
            "INSERT INTO orario (id_insegnamento,id_aula,giorno,ora_inizio,ora_fine) VALUES (?,?,?,?,?)";

    private static final String SQL_UPDATE =
            "UPDATE orario SET id_insegnamento=?,id_aula=?,giorno=?,ora_inizio=?,ora_fine=? WHERE id_orario=?";

    private static final String SQL_DELETE =
            "DELETE FROM orario WHERE id_orario=?";
    
    // Modifica la query SQL nel tuo OrarioDAO
    private static final String SQL_GET_BY_DOCENTE = 
    	    "SELECT o.id_orario, o.giorno, o.ora_inizio, o.ora_fine, m.nome AS nome_materia, " +
    	    "p.nome AS nome_docente, p.cognome AS cognome_docente, a.nome AS nome_aula, " +
    	    "CONCAT(c.anno, c.sezione) AS nome_classe " +
    	    "FROM orario o " +
    	    "INNER JOIN insegnamenti i ON o.id_insegnamento = i.id_insegnamento " +
    	    "INNER JOIN materie m ON i.id_materia = m.id_materia " +
    	    "INNER JOIN docenti d ON i.id_docente = d.id_docente " +
    	    "INNER JOIN persone p ON d.id_persona = p.id_persona " +
    	    "INNER JOIN aule a ON o.id_aula = a.id_aula " +
    	    "INNER JOIN classi c ON i.id_classe = c.id_classe " +
    	    "INNER JOIN utenti u ON d.id_persona = u.id_persona " +
    	    "WHERE u.id_utente = ?";
    
    private static final String SQL_GET_ALL_WITH_DETAILS = "SELECT o.id_orario, o.giorno, o.ora_inizio, o.ora_fine, m.nome AS nome_materia, p.nome AS nome_docente, p.cognome AS cognome_docente, a.nome AS nome_aula FROM orario o INNER JOIN insegnamenti i ON o.id_insegnamento = i.id_insegnamento INNER JOIN materie m ON i.id_materia = m.id_materia INNER JOIN docenti d ON i.id_docente = d.id_docente INNER JOIN persone p ON d.id_persona = p.id_persona INNER JOIN aule a ON o.id_aula = a.id_aula";

    public OrarioDAO(String xml) throws Exception {
        super(xml);
    }

    public List<Orario> getAll() {

        List<Orario> list = new ArrayList<>();

        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(SQL_GET_ALL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Orario o = new Orario();

                o.setId(rs.getInt("id_orario"));
                o.setId_insegnamento(rs.getInt("id_insegnamento"));
                o.setId_aula(rs.getInt("id_aula"));
                o.setGiorno(rs.getString("giorno"));
                o.setOra_inizio(rs.getString("ora_inizio"));
                o.setOra_fine(rs.getString("ora_fine"));

                list.add(o);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public List<Orario> getByDocente(int idDocente) {
        List<Orario> lista = new ArrayList<>();
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_DOCENTE)) {
            
            ps.setInt(1, idDocente);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Orario o = new Orario();
                    o.setId(rs.getInt("id_orario"));
                    o.setGiorno(rs.getString("giorno"));
                    o.setOra_inizio(rs.getString("ora_inizio"));
                    o.setOra_fine(rs.getString("ora_fine"));
                   
                    o.setNomeMateria(rs.getString("nome_materia"));
                    o.setNomeDocente(rs.getString("nome_docente"));
                    o.setCognomeDocente(rs.getString("cognome_docente"));
                    o.setNomeAula(rs.getString("nome_aula"));
                    o.setNomeClasse(rs.getString("nome_classe")); 
                    
                    lista.add(o);
                }
            }
        } catch (Exception e) {
            printException(e);
        }
        return lista;
    }

    public Orario getById(int id) {

        Orario o = new Orario();

        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(SQL_GET_BY_ID)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                o.setId(rs.getInt("id_orario"));
                o.setId_insegnamento(rs.getInt("id_insegnamento"));
                o.setId_aula(rs.getInt("id_aula"));
                o.setGiorno(rs.getString("giorno"));
                o.setOra_inizio(rs.getString("ora_inizio"));
                o.setOra_fine(rs.getString("ora_fine"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return o;
    }

    public boolean insert(int ins, int aula, String g, String in, String fin) {

        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(SQL_INSERT)) {

            ps.setInt(1, ins);
            ps.setInt(2, aula);
            ps.setString(3, g);
            ps.setString(4, in);
            ps.setString(5, fin);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean update(int ins, int aula, String g, String in, String fin, int id) {

        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(SQL_UPDATE)) {

            ps.setInt(1, ins);
            ps.setInt(2, aula);
            ps.setString(3, g);
            ps.setString(4, in);
            ps.setString(5, fin);
            ps.setInt(6, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean delete(int id) {

        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(SQL_DELETE)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
    public List<Orario> getAllWithDetails() {
        List<Orario> lista = new ArrayList<>();
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL_WITH_DETAILS);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Orario o = new Orario();
                o.setId(rs.getInt("id_orario"));
                o.setGiorno(rs.getString("giorno"));
                o.setOra_inizio(rs.getString("ora_inizio"));
                o.setOra_fine(rs.getString("ora_fine"));
                
                // Campi testuali avanzati estratti dalle tabelle collegate
                o.setNomeMateria(rs.getString("nome_materia"));
                o.setNomeDocente(rs.getString("nome_docente"));
                o.setCognomeDocente(rs.getString("cognome_docente"));
                o.setNomeAula(rs.getString("nome_aula"));
                
                lista.add(o);
            }
        } catch (Exception e) {
            printException(e);
        }
        return lista;
    }
} 