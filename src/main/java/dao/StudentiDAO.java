package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.jdom2.JDOMException;

import model.Studente;

/**
 * Classe StudentiDAO.java per la gestione degli studenti
 */
public class StudentiDAO extends DAO{
	/**
	 * Costruttore
	 * @param xml
	 * @throws ClassNotFoundException
	 * @throws JDOMException
	 * @throws IOException
	 * @throws SQLException
	 */
	public StudentiDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
	}

	/**
	 * Metodo per prendere uno Studente dal suo id
	 * @param sid
	 * @return
	 * @throws SQLException
	 */
	public Studente getStudente(int sid) throws SQLException {
		// Leggo il get dello Studente
		String getStudente = this.getConf().getStudente();
		
		// preparo la query
		PreparedStatement preparedStatement = this.getConn().prepareStatement(getStudente);	
		preparedStatement.setInt(1, sid);
		
		// eseguo la query
		ResultSet rs = preparedStatement.executeQuery();
		
		// creo lo Studente
		Studente s = new Studente();
		while(rs.next()) {
			int id = rs.getInt("sid");
			String email = rs.getString("email");
			String password = rs.getString("password");
			String nome = rs.getString("nome");
			String cognome = rs.getString("cognome");
			String nascita = rs.getString("nascita");
			int cid = rs.getInt("cid");
			s.setSid(id);
			s.setEmail(email);
			s.setPassword(password);
			s.setNome(nome);
			s.setCognome(cognome);
			s.setNascita(nascita);
			s.setCid(cid);
		}
		
		return s;
	}
}