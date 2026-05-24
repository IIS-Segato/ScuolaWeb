package dao;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.jdom2.JDOMException;

/**
 * Classe LoginDAO.java per la gestione dell'accesso all'applicazione
 */
public class LoginDAO extends DAO{
	String checkAmministratore;  // Query per controllare l'esistenza dell'amministratore
	String checkStudente;		 // Query per controllare l'esistenza dello studente
	String chekDocente;			 // Query per controllare l'esistenza del docente

	// Costruttore
	public LoginDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
		checkAmministratore = this.getConf().getCheckAmministratore();
		checkStudente = this.getConf().getCheckStudente();
		chekDocente = this.getConf().getCheckDocente();
	}
	
	/**
	 * Metodo per criptare una password in SHA-256
	 * @param password
	 * @return
	 * @throws NoSuchAlgorithmException
	 */
	public String encrypt(String password) throws NoSuchAlgorithmException {
        MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
        byte[] hash = messageDigest.digest(password.getBytes());
        StringBuilder stringBuilder = new StringBuilder();
        for (byte b : hash) {
            stringBuilder.append(String.format("%02x", b));
        }
        return stringBuilder.toString();
    }
	
	/**
	 * Metodo per controllare se l'accesso è stato fatto da uno Studente
	 * @param email
	 * @param password
	 * @return
	 * @throws SQLException
	 * @throws NoSuchAlgorithmException 
	 */
	public int checkStudente(String email, String password) throws SQLException, NoSuchAlgorithmException {
		String passwordHash = encrypt(password); // cripto la password
		
		PreparedStatement ps = this.getConn().prepareStatement(checkStudente);
		ps.setString(1, email);
		ps.setString(2, passwordHash);
		ResultSet rs = ps.executeQuery();
		
		if (rs.next()) {
	        return rs.getInt("sid");
	    }
		
		return -1;
	}
	
	/**
	 * Metodo per controllare se l'accesso è stato fatto da un Docente
	 * @param email
	 * @param password
	 * @return
	 * @throws SQLException
	 * @throws NoSuchAlgorithmException 
	 */
	public int checkDocente(String email, String password) throws SQLException, NoSuchAlgorithmException {
		String passwordHash = encrypt(password); // cripto la password
		
		PreparedStatement ps = this.getConn().prepareStatement(chekDocente);
		ps.setString(1, email);
		ps.setString(2, passwordHash);
		ResultSet rs = ps.executeQuery();
		
		if (rs.next()) {
	        return rs.getInt("did");
	    }
		
		return -1;
	}
	
	/**
	 * Metodo per controllare se l'accesso è stato fatto da un'Amministratore
	 * @param email
	 * @param password
	 * @return
	 * @throws SQLException
	 * @throws NoSuchAlgorithmException 
	 */
	public int checkAmministratore(String email, String password) throws SQLException, NoSuchAlgorithmException {
		String passwordHash = encrypt(password); // cripto la password
		
		PreparedStatement ps = this.getConn().prepareStatement(checkAmministratore);
		ps.setString(1, email);
		ps.setString(2, passwordHash);
		ResultSet rs = ps.executeQuery();
		
		if (rs.next()) {
	        return rs.getInt("aid");
	    }
		
		return -1;
	}

}