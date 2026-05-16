package dao;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.jdom2.JDOMException;

import model.Docente;

public class DocenteDAO extends AbstractDAO {

    private static final String SQL_GET_ALL  = "SELECT * FROM docenti ORDER BY cognome, nome";
    private static final String SQL_GET_BY_ID= "SELECT * FROM docenti WHERE id = ?";
    private static final String SQL_INSERT   = "INSERT INTO docenti (nome, cognome, materia) VALUES (?, ?, ?)";
    private static final String SQL_UPDATE   = "UPDATE docenti SET nome=?, cognome=?, materia=? WHERE id=?";
    private static final String SQL_DELETE   = "DELETE FROM docenti WHERE id=?";

    public DocenteDao(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
        super(xml);
    }
    
    public List<Docente> getAll() throws Exception {
        List<Docente> list = new ArrayList<>();
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(SQL_GET_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { printException(e); }
        return list;
    }
    public Docente getByID(int id) throws Exception {
        Docente d = null;
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(SQL_GET_BY_ID)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) d = map(rs);
            }
        } catch (Exception e) {
            printException(e);
            throw new Exception(e.getMessage());
        }
        return d;
    }
    public boolean insert(String nome, String cognome, String materia) throws Exception {
        boolean ok = false;
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(SQL_INSERT)) {
            ps.setString(1, nome);
            ps.setString(2, cognome);
            ps.setString(3, materia);
            ok = ps.executeUpdate() > 0;
        } catch (Exception e) {
            printException(e);
            throw new Exception(e.getMessage());
        }
        return ok;
    }
    
    public boolean update(String nome, String cognome, String materia, int id) throws Exception {
        boolean ok = false;
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(SQL_UPDATE)) {
            ps.setString(1, nome);
            ps.setString(2, cognome);
            ps.setString(3, materia);
            ps.setInt(4, id);
            ok = ps.executeUpdate() > 0;
        } catch (Exception e) {
            printException(e);
            throw new Exception(e.getMessage());
        }
        return ok;
    }
    
    public boolean delete(int id) throws Exception {
        boolean ok = false;
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(SQL_DELETE)) {
            ps.setInt(1, id);
            ok = ps.executeUpdate() > 0;
        } catch (Exception e) {
            printException(e);
            throw new Exception(e.getMessage());
        }
        return ok;
    }
    //ciao
    private Docente map(ResultSet rs) throws SQLException {
        Docente d = new Docente();
        d.setId(rs.getInt("id"));
        d.setNome(rs.getString("nome"));
        d.setCognome(rs.getString("cognome"));
        d.setMateria(rs.getString("materia"));
        return d;
    }

}
