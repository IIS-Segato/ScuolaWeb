package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
}