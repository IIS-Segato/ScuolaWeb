package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;
import model.Studente;

public class StudenteDao extends DAO {

	// Il costruttore chiama quello della superclasse DAO
	public StudenteDao(String xmlurl) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xmlurl);
	}
	
	//metodo che restituisce lo studente dal suo id
	public Studente getStudenteById(String id) {
		Studente studente = null;
		String query = config.getQuery("studenti", "select"); //query presa dal confing

		try (PreparedStatement ps = this.conn.prepareStatement(query)) {

			ps.setInt(1, Integer.parseInt(id));

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					studente = new Studente();
					studente.setId(rs.getInt("id"));
					studente.setNome(rs.getString("nome"));
					studente.setCognome(rs.getString("cognome"));
					studente.setClasse(rs.getString("classe"));
				}
			}
		} catch (SQLException | NumberFormatException e) {
			System.err.println("Errore in StudenteDao: " + e.getMessage());
		}

		return studente;
	}
	
	
	/**
	 * @param idDocente
	 * @return
	 */
	public List<Studente> getStudentiByDocente(int idDocente) {
	    List<Studente> lista = new ArrayList<>();
	    String query = "SELECT DISTINCT s.* FROM studenti s " +
	                   "JOIN orari o ON s.classe = o.classe " +
	                   "WHERE o.id_docente = ? ORDER BY s.cognome, s.nome";
	    try (PreparedStatement ps = this.conn.prepareStatement(query)) {
	        ps.setInt(1, idDocente);
	        try (ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                Studente s = new Studente();
	                s.setId(rs.getInt("id"));
	                s.setNome(rs.getString("nome"));
	                s.setCognome(rs.getString("cognome"));
	                s.setClasse(rs.getString("classe"));
	                lista.add(s);
	            }
	        }
	    } catch (SQLException e) {
	        System.err.println("Errore in getStudentiByDocente: " + e.getMessage());
	    }
	    return lista;
	}
}