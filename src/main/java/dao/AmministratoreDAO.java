package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.jdom2.JDOMException;

import model.Utente;


/**
 * Classe AmministratoreDAO.java per la gestione degli amministratori
 */
public class AmministratoreDAO extends DAO {
	/**
	 * Costruttore
	 * @param xml
	 * @throws ClassNotFoundException
	 * @throws JDOMException
	 * @throws IOException
	 * @throws SQLException
	 */
	public AmministratoreDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
	}
	
	/**
	 * Metodo per inserire uno Studente nel db
	 * @param studente
	 * @throws ClassNotFoundException
	 * @throws JDOMException
	 * @throws IOException
	 * @throws SQLException
	 */
	public void insertStudente(Studente studente) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		// Leggo l'insert dello Studente
		String insertStudente = this.getConf().getInsertStudente();
		
		// preparo la query
		PreparedStatement preparedStatement = this.getConn().prepareStatement(insertStudente);	
		preparedStatement.setString(1, studente.getEmail());
		preparedStatement.setString(2, studente.getPassword());
		preparedStatement.setString(3, studente.getNome());
		preparedStatement.setString(4, studente.getCognome());
		preparedStatement.setString(5, studente.getNascita());
		preparedStatement.setString(6, studente.getCid());
		
		// eseguo l'insert
		preparedStatement.executeUpdate();
	}
	
	/**
	 * Metodo per inserire un Docente nel db
	 * @param docente
	 * @throws ClassNotFoundException
	 * @throws JDOMException
	 * @throws IOException
	 * @throws SQLException
	 */
	public void insertDocente(Docente docente) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		// Leggo l'insert del Docente
		String insertDocente = this.getConf().getInsertDocente();
		
		// preparo la query
		PreparedStatement preparedStatement = this.getConn().prepareStatement(insertDocente);	
		preparedStatement.setString(1, docente.getEmail());
		preparedStatement.setString(2, docente.getPassword());
		preparedStatement.setString(3, docente.getNome());
		preparedStatement.setString(4, docente.getCognome());
		
		// eseguo l'insert
		preparedStatement.executeUpdate();
	}
}
