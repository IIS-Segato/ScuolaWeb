package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.jdom2.JDOMException;

import model.Docente;

/**
 * Classe DocentiDAO.java per la gestione dei Docenti
 */
public class DocentiDAO extends DAO{
	/**
	 * Costruttore
	 * @param xml
	 * @throws ClassNotFoundException
	 * @throws JDOMException
	 * @throws IOException
	 * @throws SQLException
	 */
	public DocentiDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
	}
	
	public Docente getDocente(int did) throws SQLException {
		// Leggo il get del Docente
		String getDocente = this.getConf().getDocente();
		
		// preparo la query
		PreparedStatement preparedStatement = this.getConn().prepareStatement(getDocente);	
		preparedStatement.setInt(1, did);
		
		// eseguo la query
		ResultSet rs = preparedStatement.executeQuery();
		
		// creo il Docente
		Docente d = new Docente();
		while(rs.next()) {
			String nome = rs.getString("nome");
			String cognome = rs.getString("cognome");
			d.setNome(nome);
			d.setCognome(cognome);
		}
		
		return d;
	}
}