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
import model.Voto;

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
			c.setCid(rs.getInt("cid"));
			c.setAnno(rs.getInt("anno"));
			c.setSezione(rs.getString("sezione"));
            
            classi.add(c);
		}
		
		return classi;
		
	}
	
	public String getMateriaByClasseDocente(int cid, int did) throws SQLException {
		String getMateriaByClasseDocente = this.getConf().getMateriaByClasseDocente();
		
		PreparedStatement ps = this.getConn().prepareStatement(getMateriaByClasseDocente);
		ps.setInt(1, cid);
		ps.setInt(2, did);
		
		ResultSet rs = ps.executeQuery();
		
		String materia = null;
		
		while(rs.next()) materia = rs.getString("materia");
		
		return materia;
	}
	
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
	
	public void insertVoto(int voto, String materia, String data, int did, int sid) throws SQLException {
		String insertVoto = this.getConf().insertVoto();

		PreparedStatement ps = this.getConn().prepareStatement(insertVoto);
		ps.setInt(1, voto);
		ps.setString(2, materia);
		ps.setString(3, data);
		ps.setInt(4, did);
		ps.setInt(5, sid);
		
		ps.executeUpdate();
	}
	
	public void deleteVoto(int vid) throws SQLException {
		String deleteVoto = this.getConf().deleteVoto();

		PreparedStatement ps = this.getConn().prepareStatement(deleteVoto);
		ps.setInt(1, vid);
		
		ps.executeUpdate();
	}
	
	public ArrayList<Voto> getVotiByStudenteMateria(int sid, String materia) throws SQLException {
		String getVotiByStudenteMateria = this.getConf().getVotiByStudenteMateria();
		
		ArrayList<Voto> voti = new ArrayList<>();
		
		PreparedStatement ps = this.getConn().prepareStatement(getVotiByStudenteMateria);
		ps.setInt(1, sid);
		ps.setString(2, materia);
		
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Voto v = new Voto();
			v.setVid(rs.getInt("vid"));
			v.setVoto(rs.getInt("voto"));
			v.setMateria(rs.getString("materia"));
			v.setData(rs.getString("data"));
			v.setDid(rs.getInt("did"));
			v.setSid(rs.getInt("sid"));
            
            voti.add(v);
		}
		
		return voti;
	}
}