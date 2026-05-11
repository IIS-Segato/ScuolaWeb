package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Persona;

public class PersonaDAO extends AbstractDAO{
	private static final String SQL_GET_ALL = "SELECT * FROM persone";
	private static final String SQL_GET_BY_ID = "SELECT * FROM persone where id_persona=?";
	private static final String SQL_INSERT = "INSERT INTO persone (nome, cognome, email, cf, nascita, img_profilo) VALUES (?, ?, ?, ?, ?, ?)";
	private static final String SQL_UPDATE = "UPDATE persone SET nome=?, cognome=?, email=?, cf=?, nascita=?, img_profilo=? WHERE id_persona=?";
	private static final String SQL_DELETE = "DELETE FROM persone WHERE id_persona=?";
	
	public PersonaDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
	}
	
	public List<Persona> getAll() throws Exception {
		List<Persona> persone = new ArrayList<>();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
	         ResultSet rs = ps.executeQuery())
		{
			while (rs.next()) {
                Persona p = new Persona();
                p.setId(rs.getInt("id"));
                p.setNome(rs.getString("nome"));
                p.setCognome(rs.getString("cognome"));
                p.setNascita(rs.getString("nascita"));
                p.setCf(rs.getString("cf"));
                p.setEmail(rs.getString("email"));
                p.setImg_profilo(rs.getBytes("img_profilo"));
                persone.add(p);
            }
			
		} catch (Exception e) {
			printException(e);
		}
		
		return persone;
	}
	
	public Persona getById(int id) {
		Persona p = new Persona();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_ID))
		{
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			p.setId(rs.getInt("id"));
            p.setNome(rs.getString("nome"));
            p.setCognome(rs.getString("cognome"));
            p.setNascita(rs.getString("nascita"));
            p.setCf(rs.getString("cf"));
            p.setEmail(rs.getString("email"));
            p.setImg_profilo(rs.getBytes("img_profilo"));
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return p;
	}
	
	public boolean insert(String nome, String cognome, String email, String cf, String nascita, byte[] img_profilo) {
		boolean isInserted = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_INSERT))
		{

			ps.setString(1, nome);
			ps.setString(2, cognome);
			ps.setString(3, email);
			ps.setString(4, cf);
			ps.setString(5, nascita);
			ps.setBytes(6, img_profilo);
			
			if(ps.executeUpdate() > 0) {
				isInserted = true;
			}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return isInserted;
	}
	
	public boolean update(int id, String nome, String cognome, String email, String cf, String nascita, byte[] img_profilo) {
		boolean isUpdated = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_UPDATE))
		{

			ps.setString(1, nome);
			ps.setString(2, cognome);
			ps.setString(3, email);
			ps.setString(4, cf);
			ps.setString(5, nascita);
			ps.setBytes(6, img_profilo);
			ps.setInt(7, id);
			
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
