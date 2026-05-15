package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Materia;

public class MateriaDAO extends AbstractDAO{
	private static final String SQL_GET_ALL = "SELECT * FROM materie";
	private static final String SQL_GET_BY_ID = "SELECT * FROM materie WHERE id_materia=?";
	private static final String SQL_INSERT = "INSERT INTO materie (nome) VALUES (?)";
	private static final String SQL_UPDATE = "UPDATE materie SET nome=? WHERE id_materia=?";
	private static final String SQL_DELETE = "DELETE FROM materie WHERE id_materia=?";
	
	public MateriaDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
	}
	
	public List<Materia> getAll() throws Exception {
		List<Materia> materie = new ArrayList<>();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
	         ResultSet rs = ps.executeQuery())
		{
			while (rs.next()) {
				Materia m = new Materia();
                m.setId(rs.getInt("id_materia"));
                m.setNome(rs.getString("nome"));
                materie.add(m);
            }
			
		} catch (Exception e) {
			printException(e);
		}
		
		return materie;
	}
	
	public Materia getById(int id) {
		Materia m = new Materia();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_ID))
		{
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			m.setId(rs.getInt("id_utente"));
            m.setNome(rs.getString("nome"));
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return m;
	}
	
	public boolean insert(String nome) {
		boolean isInserted = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_INSERT))
		{

			ps.setString(1, nome);
			
			if(ps.executeUpdate() > 0) {
				isInserted = true;
			}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return isInserted;
	}
	
	public boolean update(String nome, int id) {
		boolean isUpdated = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_UPDATE))
		{

			ps.setString(1, nome);
			ps.setInt(2, id);
			
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
