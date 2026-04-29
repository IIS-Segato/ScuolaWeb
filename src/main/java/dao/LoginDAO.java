package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.jdom2.JDOMException;

/**
 * Classe per controllare a quale enità appartiene
 * il login
 * 
 * @author Dell'Agostin Davide
 *
 */

public class LoginDAO extends DAO{
	
	String checkAmministratore;  // Query per controllare l'esistenza dell'amministratore
	String checkStudente;		 // Query per controllare l'esistenza dello studente
	String chekDocente;			 // Query per controllare l'esistenza del docente

	public LoginDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
		checkAmministratore = this.getConf().getCheckAmministratore();
		checkStudente = this.getConf().getCheckStudente();
		chekDocente = this.getConf().getCheckDocente();
	}
	
	public int checkStudente(String email, String password) throws SQLException {
		PreparedStatement ps = this.getConn().prepareStatement(checkStudente);
		ps.setString(1, email);
		ps.setString(2, password);
		ResultSet rs = ps.executeQuery();
		
		if (rs.next()) {
	        return rs.getInt("sid");
	    }
		
		return -1;
	}
	
	public int checkDocente(String email, String password) throws SQLException {
		PreparedStatement ps = this.getConn().prepareStatement(chekDocente);
		ps.setString(1, email);
		ps.setString(2, password);
		ResultSet rs = ps.executeQuery();
		
		if (rs.next()) {
	        return rs.getInt("did");
	    }
		
		return -1;
	}
	
	public int checkAmministratore(String email, String password) throws SQLException {
		PreparedStatement ps = this.getConn().prepareStatement(checkAmministratore);
		ps.setString(1, email);
		ps.setString(2, password);
		ResultSet rs = ps.executeQuery();
		
		if (rs.next()) {
	        return rs.getInt("aid");
	    }
		
		return -1;
	}
	

}
