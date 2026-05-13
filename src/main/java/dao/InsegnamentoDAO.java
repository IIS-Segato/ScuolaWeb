package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Insegnamento;

public class InsegnamentoDAO extends AbstractDAO{
	private static final String SQL_GET_ALL = "SELECT * FROM insegnamenti";
	private static final String SQL_GET_BY_ID = "SELECT * FROM insegnamenti WHERE id_insegnamento=?";
	private static final String SQL_INSERT = "INSERT INTO insegnamenti (id_docente, id_materia, id_classe) VALUES (?, ?, ?)";
	private static final String SQL_UPDATE = "UPDATE insegnamenti SET id_docente=?, id_materia=?, id_classe=? WHERE id_insegnamento=?";
	private static final String SQL_DELETE = "DELETE FROM insegnamenti WHERE id_insegnamento=?";
	
	public InsegnamentoDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
	}
	
	public List<Insegnamento> getAll() throws Exception {
		List<Insegnamento> insegnamenti = new ArrayList<>();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
	         ResultSet rs = ps.executeQuery())
		{
			while (rs.next()) {
				Insegnamento i = new Insegnamento();
                i.setId(rs.getInt("id_insegnamento"));
                i.setId_docente(rs.getInt("id_docente"));
                i.setId_materia(rs.getInt("id_materia"));
                i.setId_classe(rs.getInt("id_classe"));
                insegnamenti.add(i);
            }
			
		} catch (Exception e) {
			printException(e);
		}
		
		return insegnamenti;
	}
	
	public Insegnamento getById(int id) {
		Insegnamento i = new Insegnamento();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_ID))
		{
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			i.setId(rs.getInt("id_utente"));
            i.setId_docente(rs.getInt("id_docente"));
            i.setId_materia(rs.getInt("id_materia"));
            i.setId_classe(rs.getInt("id_classe"));
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return i;
	}
	
	public boolean insert(int id_docente, int id_materia, int id_classe) {
		boolean isInserted = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_INSERT))
		{

			ps.setInt(1, id_docente);
			ps.setInt(2, id_materia);
			ps.setInt(3, id_classe);
			
			if(ps.executeUpdate() > 0) {
				isInserted = true;
			}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return isInserted;
	}
	
	public boolean update(int id_docente, int id_materia, int id_classe, int id) {
		boolean isUpdated = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_UPDATE))
		{

			ps.setInt(1, id_docente);
			ps.setInt(2, id_materia);
			ps.setInt(3, id_classe);
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
