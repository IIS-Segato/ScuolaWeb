package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Orario;

public class OrarioDAO extends AbstractDAO{
	private static final String SQL_GET_ALL = "SELECT * FROM orario";
	private static final String SQL_GET_BY_ID = "SELECT * FROM orario where id_orario=?";
	private static final String SQL_INSERT = "INSERT INTO orario (id_insegnamento, id_aula, giorno, ora_inizio, ora_fine) VALUES (?, ?, ?, ?, ?)";
	private static final String SQL_UPDATE = "UPDATE orario SET id_insegnamento=?, id_aula=?, giorno=?, ora_inizio=?, ora_fine=? WHERE id_orario=?";
	private static final String SQL_DELETE = "DELETE FROM orario WHERE id_orario=?";
	
	public OrarioDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
	}
	
	public List<Orario> getAll() throws Exception {
		List<Orario> orari = new ArrayList<>();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
	         ResultSet rs = ps.executeQuery())
		{
			while (rs.next()) {
				Orario o = new Orario();
                o.setId(rs.getInt("id_orario"));
                o.setId_insegnamento(rs.getInt("id_insegnamento"));
                o.setId_aula(rs.getInt("id_aula"));
                o.setGiorno(rs.getString("giorno"));
                o.setOra_inizio(rs.getString("ora_inizio"));
                o.setOra_fine(rs.getString("ora_fine"));
                orari.add(o);
            }
			
		} catch (Exception e) {
			printException(e);
		}
		
		return orari;
	}
	
	public Orario getById(int id) {
		Orario o = new Orario();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_ID))
		{
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			o.setId(rs.getInt("id"));
            o.setId_insegnamento(rs.getInt("id_insegnamento"));
            o.setId_aula(rs.getInt("id_aula"));
            o.setGiorno(rs.getString("giorno"));
            o.setOra_inizio(rs.getString("ora_inizio"));
            o.setOra_fine(rs.getString("ora_fine"));
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return o;
	}
	
	public boolean insert(int id_insegnamento, int id_aula, String giorno, String ora_inizio, String ora_fine) {
		boolean isInserted = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_INSERT))
		{

			ps.setInt(1, id_insegnamento);
			ps.setInt(2, id_aula);
			ps.setString(3, giorno);
			ps.setString(4, ora_inizio);
			ps.setString(5, ora_fine);
			
			if(ps.executeUpdate() > 0) {
				isInserted = true;
			}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return isInserted;
	}
	
	public boolean update(int id, int id_insegnamento, int id_aula, String giorno, String ora_inizio, String ora_fine) {
		boolean isUpdated = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_UPDATE))
		{

			ps.setInt(1, id_insegnamento);
			ps.setInt(2, id_aula);
			ps.setString(3, giorno);
			ps.setString(4, ora_inizio);
			ps.setString(5, ora_fine);
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
