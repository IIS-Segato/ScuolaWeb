package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.jdom2.JDOMException;

import model.Classe;
import model.Docente;
import model.Studente;

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
	
	/**
	 * Metodo per prendere un Docente dal suo id
	 * @param did
	 * @return
	 * @throws SQLException
	 */
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
			int id = rs.getInt("did");
			String email = rs.getString("email");
			String password = rs.getString("password");
			String nome = rs.getString("nome");
			String cognome = rs.getString("cognome");
			d.setDid(id);
			d.setEmail(email);
			d.setPassword(password);
			d.setNome(nome);
			d.setCognome(cognome);
		}
		
		return d;
	}
	
	/**
	 * Metodo per prendere tutti gli studenti di una classe
	 * @param cid
	 * @return Lista studenti
	 * @throws ClassNotFoundException
	 * @throws JDOMException
	 * @throws IOException
	 * @throws SQLException
	 */
	public ArrayList<Studente> getStudentiByClasse(int cid) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		
		String getStudentiByClasse = this.getConf().getStudentiByClasse();
		
		ArrayList<Studente> studenti = new ArrayList<>();
		
		PreparedStatement ps = this.getConn().prepareStatement(getStudentiByClasse);
		ps.setInt(1, cid);
		
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
	
	/**
	 * Metodo per prendere tutte le classi di un docente
	 * @param did
	 * @return Lista classi
	 * @throws ClassNotFoundException
	 * @throws JDOMException
	 * @throws IOException
	 * @throws SQLException
	 */
	public ArrayList<Classe> getClassiByDocente(int did) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		
		String getClassiByDocente = this.getConf().getClassiByDocente();
		
		ArrayList<Classe> classi = new ArrayList<>();
		
		PreparedStatement ps = this.getConn().prepareStatement(getClassiByDocente);
		ps.setInt(1, did);
		
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Classe c = new Classe();

			c.setAnno(rs.getInt("anno"));
			c.setSezione(rs.getString("sezione"));
            
            classi.add(c);
		}
		
		return classi;
		
	}
}