package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Docente;

public class DocenteDAO extends AbstractDAO {

	private static final String SQL_GET_ALL = "SELECT * FROM docenti";
	private static final String SQL_GET_BY_ID = "SELECT * FROM docenti WHERE id_docente=?";
	private static final String SQL_GET_BY_PERSONA_ID = "SELECT * FROM docenti WHERE id_persona=?";
	private static final String SQL_INSERT = "INSERT INTO docenti (id_persona) VALUES (?)";
	private static final String SQL_UPDATE = "UPDATE docenti SET id_persona=? WHERE id_docente=?";
	private static final String SQL_DELETE = "DELETE FROM docenti WHERE id_docente=?";
	
	public DocenteDAO(String xml) throws ClassNotFoundException, JDOMException, IOException {
		super(xml);
	}
	
	public List<Docente> getAll() throws Exception {
		List<Docente> docenti = new ArrayList<>();
		
		try(Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
			ResultSet rs = ps.executeQuery()){
			
			while(rs.next()) {
				Docente d = new Docente();
				d.setId(rs.getInt("id_docente"));
				d.setId_persona(rs.getInt("id_persona"));
				docenti.add(d);
			}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return docenti;
	}
	
    public Docente getById(int id) {
        Docente d = new Docente();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_ID))
        {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                d.setId(rs.getInt("id_docente"));
                d.setId_persona(rs.getInt("id_persona"));
            }

        } catch (Exception e) {
            printException(e);
        }

        return d;
    }

}
