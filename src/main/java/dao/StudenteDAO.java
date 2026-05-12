package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Studente;

public class StudenteDAO extends AbstractDAO{
	private static final String SQL_GET_ALL = "SELECT * FROM studenti";
	private static final String SQL_GET_BY_ID = "SELECT * FROM studenti WHERE id_studente=?";
	private static final String SQL_GET_BY_PERSONA_ID = "SELECT * FROM studenti WHERE id_persona=?";
	private static final String SQL_GET_BY_CLASSE_ID = "SELECT * FROM studenti WHERE id_classe=?";
	private static final String SQL_INSERT = "INSERT INTO studenti (id_persona, id_classe) VALUES (?, ?)";
	private static final String SQL_UPDATE = "UPDATE studenti SET id_persona=?, id_classe=? WHERE id_studente=?";
	private static final String SQL_DELETE = "DELETE FROM studenti WHERE id_studente=?";
	
	public StudenteDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
	}
	
	public List<Studente> getAll() throws Exception {
		List<Studente> studenti = new ArrayList<>();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
	         ResultSet rs = ps.executeQuery())
		{
			while (rs.next()) {
				Studente s = new Studente();
                s.setId(rs.getInt("id_utente"));
                s.setId_persona(rs.getInt("id_persona"));
                s.setId_classe(rs.getInt("id_classe"));
                studenti.add(s);
            }
			
		} catch (Exception e) {
			printException(e);
		}
		
		return studenti;
	}
	
	public Studente getById(int id) {
		Studente s = new Studente();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_ID))
		{
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			s.setId(rs.getInt("id_utente"));
            s.setId_persona(rs.getInt("id_persona"));
            s.setId_classe(rs.getInt("id_classe"));
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return s;
	}
	
	public Studente getByPersonaId(int id) {
		Studente s = new Studente();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_PERSONA_ID))
		{
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			s.setId(rs.getInt("id_utente"));
            s.setId_persona(rs.getInt("id_persona"));
            s.setId_classe(rs.getInt("id_classe"));
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return s;
	}
	
	public List<Studente> getByClasseId(int id) {
		List<Studente> studenti = new ArrayList<>();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_CLASSE_ID))
		{
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			Studente s = new Studente();
			s.setId(rs.getInt("id_utente"));
            s.setId_persona(rs.getInt("id_persona"));
            s.setId_classe(rs.getInt("id_classe"));
            studenti.add(s);
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return studenti;
	}
	
	public boolean insert(int id_persona, int id_classe) {
		boolean isInserted = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_INSERT))
		{

			ps.setInt(1, id_persona);
			ps.setInt(2, id_classe);
			
			if(ps.executeUpdate() > 0) {
				isInserted = true;
			}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return isInserted;
	}
	
	public boolean update(int id_persona, int id_classe, int id) {
		boolean isUpdated = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_UPDATE))
		{

			ps.setInt(1, id_persona);
			ps.setInt(2, id_classe);
			ps.setInt(3, id);
			
			if(ps.executeUpdate() > 0) {
				isUpdated = true;
			}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return isUpdated;
	}
	
	public boolean delete(int id) {
		boolean isDeleted = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_DELETE))
		{

			ps.setInt(1, id);
			
			if(ps.executeUpdate() > 0) {
				isDeleted = true;
			}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return isDeleted;
	}
}
