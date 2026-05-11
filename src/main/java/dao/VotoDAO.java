package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Voto;

public class VotoDAO extends AbstractDAO{
	private static final String SQL_GET_ALL = "SELECT * FROM voti";
	private static final String SQL_GET_BY_STUDENTE_ID = "SELECT * FROM voti WHERE id_studente=?";
	private static final String SQL_GET_BY_INSEGNAMENTO_ID = "SELECT * FROM voti WHERE id_insegnamento=?";
	private static final String SQL_INSERT = "INSERT INTO voti (id_studente, id_insegnamento, voto, data_voto, descrizione) VALUES (?, ?, ?, ?, ?)";
	private static final String SQL_UPDATE = "UPDATE voti SET id_studente=?, id_insegnamento=?, voto=?, data_voto=?, descrizione=? WHERE id_voto=?";
	private static final String SQL_DELETE = "DELETE FROM voti WHERE id_voto=?";
	
	public VotoDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
	}
	
	public List<Voto> getAll() throws Exception {
		List<Voto> voti = new ArrayList<>();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
	         ResultSet rs = ps.executeQuery())
		{
			while (rs.next()) {
                Voto v = new Voto();
                v.setId(rs.getInt("id_voto"));
                v.setId_studente(rs.getInt("id_studente"));
                v.setId_insegnamento(rs.getInt("id_insegnamento"));
                v.setVoto(rs.getInt("voto"));
                v.setData_voto(rs.getString("data_voto"));
                v.setDescrizione(rs.getString("descrizione"));
                voti.add(v);
            }
			
		} catch (Exception e) {
			printException(e);
		}
		
		return voti;
	}
	
	public List<Voto> getByStudentId(int id) {
		List<Voto> voti = new ArrayList<>();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_STUDENTE_ID))
		{
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			Voto v = new Voto();
			v.setId(rs.getInt("id_voto"));
            v.setId_studente(rs.getInt("id_studente"));
            v.setId_insegnamento(rs.getInt("id_insegnamento"));
            v.setVoto(rs.getInt("voto"));
            v.setData_voto(rs.getString("data_voto"));
            v.setDescrizione(rs.getString("descrizione"));
            voti.add(v);
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return voti;
	}
	
	public List<Voto> getByInsegnamentoId(int id) {
		List<Voto> voti = new ArrayList<>();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_INSEGNAMENTO_ID))
		{
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			Voto v = new Voto();
			v.setId(rs.getInt("id_voto"));
            v.setId_studente(rs.getInt("id_studente"));
            v.setId_insegnamento(rs.getInt("id_insegnamento"));
            v.setVoto(rs.getInt("voto"));
            v.setData_voto(rs.getString("data_voto"));
            v.setDescrizione(rs.getString("descrizione"));
            voti.add(v);
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return voti;
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
