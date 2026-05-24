package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.jdom2.JDOMException;

import model.Classe;
import model.Studente;
import model.Voto;

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
	
	/**
	 * Metodo per prendere tutti i voti di uno Studente
	 * @param sid
	 * @return
	 * @throws SQLException
	 */
	public ArrayList<Voto> getVotiByStudente(int sid) throws SQLException {
		String getVotiByStudente = this.getConf().getVotiByStudente();
		ArrayList<Voto> voti = new ArrayList<>();
		
		PreparedStatement ps = this.getConn().prepareStatement(getVotiByStudente);
		ps.setInt(1, sid);
		
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Voto v = new Voto();
			v.setVid(rs.getInt("vid"));
			v.setVoto(rs.getFloat("voto"));
			v.setMateria(rs.getString("materia"));
			v.setData(rs.getString("data"));
			v.setDid(rs.getInt("did"));
			v.setSid(rs.getInt("sid"));
            
            voti.add(v);
		}
		
		return voti;
	}
	
	/**
	 * Metodo per prendere una Classe dal suo cid
	 * @param cid
	 * @return
	 * @throws SQLException
	 */
	public Classe getClasseByCid(int cid) throws SQLException {
		String getClasseByCid = this.getConf().getClasseByCid();
		
		Classe c = new Classe();
		
		PreparedStatement ps = this.getConn().prepareStatement(getClasseByCid);
		ps.setInt(1, cid);
		
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			c.setCid(rs.getInt("cid"));
			c.setAnno(rs.getInt("anno"));
			c.setSezione(rs.getString("sezione"));
		}
		
		return c;
	}
}