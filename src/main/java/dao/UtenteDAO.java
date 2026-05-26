package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Utente;

public class UtenteDAO extends AbstractDAO{
	private static final String SQL_GET_ALL = "SELECT * FROM utenti";
	private static final String SQL_GET_BY_ID = "SELECT * FROM utenti WHERE id_utente=?";
	private static final String SQL_GET_BY_PERSONA_ID = "SELECT * FROM utenti WHERE id_persona=?";
	private static final String SQL_INSERT = "INSERT INTO utenti (username, password_hash, id_persona, id_ruolo) VALUES (?, ?, ?, ?)";
	private static final String SQL_UPDATE = "UPDATE utenti SET username=?, password_hash=?, id_persona=?, id_ruolo=? WHERE id_utente=?";
	private static final String SQL_DELETE = "DELETE FROM utenti WHERE id_utente=?";
	
	public UtenteDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
	}
	
	public List<Utente> getAll() throws Exception {
		List<Utente> utenti = new ArrayList<>();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
	         ResultSet rs = ps.executeQuery())
		{
			while (rs.next()) {
				Utente u = new Utente();
                u.setId(rs.getInt("id_utente"));
                u.setUsername(rs.getString("username"));
                u.setPassword_hash(rs.getString("password_hash"));
                u.setId_persona(rs.getInt("id_persona"));
                u.setId_ruolo(rs.getInt("id_ruolo"));
                utenti.add(u);
            }
			
		} catch (Exception e) {
			printException(e);
		}
		
		return utenti;
	}
	
	public Utente getById(int id) {
		Utente u = new Utente();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_ID))
		{
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			u.setId(rs.getInt("id_utente"));
		    u.setUsername(rs.getString("username"));
		    u.setPassword_hash(rs.getString("password_hash"));
		    u.setId_persona(rs.getInt("id_persona"));
		    u.setId_ruolo(rs.getInt("id_ruolo"));
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return u;
	}
	
	public Utente getByPersonaId(int id) {
		Utente u = new Utente();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_PERSONA_ID))
		{
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			u.setId(rs.getInt("id_utente"));
		    u.setUsername(rs.getString("username"));
		    u.setPassword_hash(rs.getString("password_hash"));
		    u.setId_persona(rs.getInt("id_persona"));
		    u.setId_ruolo(rs.getInt("id_ruolo"));
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return u;
	}
	
	public boolean insert(String username, String password_hash, int id_persona, int id_ruolo) {
		boolean isInserted = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_INSERT))
		{

			ps.setString(1, username);
			ps.setString(2, password_hash);
			ps.setInt(3, id_persona);
			ps.setInt(4, id_ruolo);
			
			if(ps.executeUpdate() > 0) {
				isInserted = true;
			}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return isInserted;
	}
	
	public boolean update(String username, String password_hash, int id_persona, int id_ruolo, int id) {
		boolean isUpdated = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_UPDATE))
		{

			ps.setString(1, username);
			ps.setString(2, password_hash);
			ps.setInt(3, id_persona);
			ps.setInt(4, id_ruolo);
			ps.setInt(5, id);
			
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
	
	public Utente getByUsername(String username) {

	    Utente u = null;

	    String sql = "SELECT * FROM utenti WHERE username = ?";

	    try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setString(1, username);

	        try (ResultSet rs = ps.executeQuery()) {

	            if (rs.next()) {
	                u = new Utente();
	                u.setId(rs.getInt("id_utente"));
	                u.setUsername(rs.getString("username"));
	                u.setPassword_hash(rs.getString("password_hash"));
	                u.setId_persona(rs.getInt("id_persona"));
	                u.setId_ruolo(rs.getInt("id_ruolo"));
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return u;
	}
	
	public Utente checkLogin(String username, String passwordInserita) {
	    // 1. Sfrutta il metodo già esistente nel tuo DAO per cercare l'utente
	    Utente utente = this.getByUsername(username);

	    // 2. Se l'utente esiste, controlla se la password coincide
	    if (utente != null) {
	        // NOTA: Se salvi le password cifrate (scelta consigliata), 
	        // qui dovrai confrontare l'hash della passwordInserita.
	        if (utente.getPassword_hash().equals(passwordInserita)) {
	            return utente; // Credenziali corrette, restituisce l'utente completo
	        }
	    }

	    // 3. Se l'utente non esiste o la password è errata, restituisce null
	    return null;
	}
}
