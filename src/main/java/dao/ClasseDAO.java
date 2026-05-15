package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Classe;

public class ClasseDAO extends AbstractDAO{
	private static final String SQL_GET_ALL = "SELECT * FROM classi";
	private static final String SQL_GET_BY_ID = "SELECT * FROM classi WHERE id_classe=?";
	private static final String SQL_INSERT = "INSERT INTO classi (anno, sezione, indirizzo) VALUES (?, ?, ?)";
	private static final String SQL_UPDATE = "UPDATE insegnamenti SET anno=?, sezione=?, indirizzo=? WHERE id_classe=?";
	private static final String SQL_DELETE = "DELETE FROM classi WHERE id_classe=?";
	
	public ClasseDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
	}
	
	public List<Classe> getAll() throws Exception {
		List<Classe> classi = new ArrayList<>();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
	         ResultSet rs = ps.executeQuery())
		{
			while (rs.next()) {
				Classe c = new Classe();
                c.setId(rs.getInt("id_utente"));
                c.setAnno(rs.getInt("anno"));
                c.setSezione(rs.getString("sezione"));
                c.setIndirizzo(rs.getString("indirizzo"));
                classi.add(c);
            }
			
		} catch (Exception e) {
			printException(e);
		}
		
		return classi;
	}
	
	public Classe getById(int id) {
		Classe c = new Classe();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_ID))
		{
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			c.setId(rs.getInt("id_utente"));
            c.setAnno(rs.getInt("anno"));
            c.setSezione(rs.getString("sezione"));
            c.setIndirizzo(rs.getString("indirizzo"));
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return c;
	}
	
	public boolean insert(int anno, String sezione, String indirizzo) {
		boolean isInserted = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_INSERT))
		{

			ps.setInt(1, anno);
			ps.setString(2, sezione);
			ps.setString(3, indirizzo);
			
			if(ps.executeUpdate() > 0) {
				isInserted = true;
			}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return isInserted;
	}
	
	public boolean update(int anno, String sezione, String indirizzo, int id) {
		boolean isUpdated = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_UPDATE))
		{

			ps.setInt(1, anno);
			ps.setString(2, sezione);
			ps.setString(3, indirizzo);
			ps.setInt(4, id);
			
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
