package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Aula;

public class AulaDAO extends AbstractDAO{
	private static final String SQL_GET_ALL = "SELECT * FROM aule";
	private static final String SQL_GET_BY_ID = "SELECT * FROM aule WHERE id_aula=?";
	private static final String SQL_INSERT = "INSERT INTO aule (nome, capienza) VALUES (?, ?)";
	private static final String SQL_UPDATE = "UPDATE aule SET nome=?, capienza=? WHERE id_aula=?";
	private static final String SQL_DELETE = "DELETE FROM aule WHERE id_aula=?";
	
	public AulaDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
	}
	
	public List<Aula> getAll() throws Exception {
		List<Aula> aule = new ArrayList<>();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
	         ResultSet rs = ps.executeQuery())
		{
			while (rs.next()) {
				Aula a = new Aula();
                a.setId(rs.getInt("id_utente"));
                a.setNome(rs.getString("nome"));
                a.setCapienza(rs.getInt("capienza"));
                aule.add(a);
            }
			
		} catch (Exception e) {
			printException(e);
		}
		
		return aule;
	}
	
	public Aula getById(int id) {
		Aula a = new Aula();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_ID))
		{
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			a.setId(rs.getInt("id_utente"));
            a.setNome(rs.getString("nome"));
            a.setCapienza(rs.getInt("capienza"));
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return a;
	}
	
	public boolean insert(String nome, int capienza) {
		boolean isInserted = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_INSERT))
		{

			ps.setString(1, nome);
			ps.setInt(2, capienza);
			
			if(ps.executeUpdate() > 0) {
				isInserted = true;
			}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return isInserted;
	}
	
	public boolean update(String nome, int capienza, int id) {
		boolean isUpdated = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_UPDATE))
		{

			ps.setString(1, nome);
			ps.setInt(2, capienza);
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
