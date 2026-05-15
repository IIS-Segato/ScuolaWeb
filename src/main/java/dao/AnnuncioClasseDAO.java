package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.AnnuncioClasse;

public class AnnuncioClasseDAO extends AbstractDAO{
	private static final String SQL_GET_ALL = "SELECT * FROM annunci_classe";
	private static final String SQL_GET_BY_ID = "SELECT * FROM annunci_classe WHERE id_annuncio=?";
	private static final String SQL_GET_BY_ID_CLASSE = "SELECT * FROM annunci_classe WHERE id_classe=?";
	private static final String SQL_INSERT = "INSERT INTO annunci_classe (id_classe, id_docente) VALUES (?, ?)";
	private static final String SQL_UPDATE = "UPDATE annunci_classe SET id_classe=?, id_docente=? WHERE id_annuncio=?";
	private static final String SQL_DELETE = "DELETE FROM annunci_classe WHERE id_annuncio=?";
	
	public AnnuncioClasseDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
	}
	
	public List<AnnuncioClasse> getAll() throws Exception {
		List<AnnuncioClasse> annunci = new ArrayList<>();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
	         ResultSet rs = ps.executeQuery())
		{
			while (rs.next()) {
				AnnuncioClasse a = new AnnuncioClasse();
                a.setId(rs.getInt("id_utente"));
                a.setId_classe(rs.getInt("id_classe"));
                a.setId_docente(rs.getInt("id_docente"));
                annunci.add(a);
            }
			
		} catch (Exception e) {
			printException(e);
		}
		
		return annunci;
	}
	
	public AnnuncioClasse getById(int id) {
		AnnuncioClasse a = new AnnuncioClasse();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_ID))
		{
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			a.setId(rs.getInt("id_utente"));
            a.setId_classe(rs.getInt("id_classe"));
            a.setId_docente(rs.getInt("id_docente"));
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return a;
	}
	
	public AnnuncioClasse getByIdClasse(int id) {
		AnnuncioClasse a = new AnnuncioClasse();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_ID_CLASSE))
		{
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			a.setId(rs.getInt("id_utente"));
            a.setId_classe(rs.getInt("id_classe"));
            a.setId_docente(rs.getInt("id_docente"));
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return a;
	}
	
	public boolean insert(int id_classe, int id_docente) {
		boolean isInserted = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_INSERT))
		{

			ps.setInt(1, id_classe);
			ps.setInt(2, id_docente);
			
			if(ps.executeUpdate() > 0) {
				isInserted = true;
			}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return isInserted;
	}
	
	public boolean update(int id_classe, int id_docente, int id) {
		boolean isUpdated = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_UPDATE))
		{

			ps.setInt(1, id_classe);
			ps.setInt(2, id_docente);
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
