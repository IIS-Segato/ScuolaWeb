package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.jdom2.JDOMException;

import model.Amministratore;
import model.Classe;
import model.Docente;
import model.Materia;
import model.Studente;

import dao.DocentiDAO;


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
	
	/**
	 * Metodo per prendere tutti gli studenti nel db
	 * @return
	 * @throws ClassNotFoundException
	 * @throws JDOMException
	 * @throws IOException
	 * @throws SQLException
	 */
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
	
	/**
	 * Metodo per prendere tutti i docenti nel db
	 * @return
	 * @throws ClassNotFoundException
	 * @throws JDOMException
	 * @throws IOException
	 * @throws SQLException
	 */
	public ArrayList<Docente> getDocenti(DocentiDAO dDAO) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		String getDocenti = this.getConf().getDocenti();
		
		ArrayList<Docente> docenti = new ArrayList<>();
		
		PreparedStatement ps = this.getConn().prepareStatement(getDocenti);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Docente s = new Docente();
			int did = rs.getInt("did");

            s.setDid(did);
            s.setEmail(rs.getString("email"));
            s.setPassword(rs.getString("password"));
            s.setNome(rs.getString("nome"));
            s.setCognome(rs.getString("cognome"));
            s.setClassi(dDAO.getClassiByDocente(did));
            
            docenti.add(s);
		}
		
		return docenti;
	}
	
	/**
	 * Metodo per prendere tutte le classi nel db
	 * @return
	 * @throws SQLException
	 */
	public ArrayList<Classe> getClassi() throws SQLException {
		String getClassi = this.getConf().getClassi();
		
		ArrayList<Classe> classi = new ArrayList<>();
		
		PreparedStatement ps = this.getConn().prepareStatement(getClassi);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Classe c = new Classe();
			c.setSezione(rs.getString("sezione"));
			c.setAnno(rs.getInt("anno"));
			
			String getMaterie = this.getConf().getMaterieClasse();
			ArrayList<String> materie = new ArrayList<>();
			
			PreparedStatement psMateria = this.getConn().prepareStatement(getMaterie);
			psMateria.setInt(1, c.getCid());
			ResultSet rsMateria = psMateria.executeQuery();
			
			while (rsMateria.next()) {
				materie.add(rsMateria.getString("materia"));
			}
			
			c.setMaterie(materie);
			classi.add(c);
		}
		
		return classi;
	}
	
	public ArrayList<Materia> getMaterie() throws SQLException {
		String getMaterie = this.getConf().getMaterie();
		
		ArrayList<Materia> materie = new ArrayList<>();
		
		PreparedStatement ps = this.getConn().prepareStatement(getMaterie);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Materia m = new Materia();
			m.setCid(rs.getInt("cid"));
			m.setDid(rs.getInt("did"));
			m.setMateria(rs.getString("materia"));
			
			materie.add(m);
		}
		
		return materie;
	}
	
	
	
	/**
	 * Metodo per prendere un Amministratore dal suo id
	 * @param aid
	 * @return
	 * @throws SQLException
	 * @throws IOException 
	 * @throws JDOMException 
	 * @throws ClassNotFoundException 
	 */
	public Amministratore getAmministratore(int aid, DocentiDAO dDAO) throws SQLException, ClassNotFoundException, JDOMException, IOException {
		// Leggo il get dell'Amministratore
		String getAmministratore = this.getConf().getAmministratore();
		
		// preparo la query
		PreparedStatement preparedStatement = this.getConn().prepareStatement(getAmministratore);	
		preparedStatement.setInt(1, aid);
		
		// eseguo la query
		ResultSet rs = preparedStatement.executeQuery();
		
		// creo l'Amministratore
		Amministratore a = new Amministratore();
		while(rs.next()) {
			String email = rs.getString("email");
			String password = rs.getString("password");
			a.setDocenti(getDocenti(dDAO));
			a.setStudenti(getStudenti());
			a.setClassi(getClassi());
			a.setMaterie(getMaterie());
			a.setEmail(email);
			a.setPassword(password);
		}
		return a;
	}
}
