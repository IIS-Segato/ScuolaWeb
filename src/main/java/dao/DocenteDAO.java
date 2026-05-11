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
    
}
