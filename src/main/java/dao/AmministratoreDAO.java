package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.jdom2.JDOMException;

import model.Docente;
import model.Studente;
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
		preparedStatement.setInt(6, studente.getCid());
		
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
	
	public ArrayList<Studente> getStudenti() throws ClassNotFoundException, JDOMException, IOException, SQLException {
		
		String getStudenti = this.getConf().getStudenti();
		
		ArrayList<Studente> studenti = new ArrayList<>();
		
		PreparedStatement ps = this.getConn().prepareStatement(getStudenti);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Studente s = new Studente();

            s.setSid(rs.getInt("sid"));
            s.setEmail(rs.getString("email"));
            s.setPassword(rs.getString("password"));
            s.setNome(rs.getString("nome"));
            s.setCognome(rs.getString("cognome"));
            s.setNascita(rs.getString("nascita"));
            s.setCid(rs.getInt("cid"));
            
            studenti.add(s);
		}
		
		return studenti;
		
	}
	
	public ArrayList<Docente> getDocenti() throws ClassNotFoundException, JDOMException, IOException, SQLException {
		
		String getDocenti = this.getConf().getDocenti();
		
		ArrayList<Docente> docenti = new ArrayList<>();
		
		PreparedStatement ps = this.getConn().prepareStatement(getDocenti);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Docente s = new Docente();

            s.setDid(rs.getInt("cid"));
            s.setEmail(rs.getString("email"));
            s.setPassword(rs.getString("password"));
            s.setNome(rs.getString("nome"));
            s.setCognome(rs.getString("cognome"));
            
            docenti.add(s);
		}
		
		return docenti;
		
	}
}
