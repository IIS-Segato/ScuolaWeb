package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.jdom2.JDOMException;

import model.Docente;

public class DocenteDao extends DAO {

	// Il costruttore chiama quello della superclasse DAO
	public DocenteDao(String xmlurl) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xmlurl);
	}
	
	//metodo che restituisce lo docente dal suo id
	public Docente getDocenteById(String id) {
		Docente docente = null;
		String query = config.getQuery("docenti", "select"); //query presa dal confing

		try (PreparedStatement ps = this.conn.prepareStatement(query)) {

			ps.setInt(1, Integer.parseInt(id));

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					docente = new Docente();
					docente.setId(rs.getInt("id"));
					docente.setNome(rs.getString("nome"));
					docente.setCognome(rs.getString("cognome"));
					docente.setNomeMateria(rs.getString("nome_materia"));
				}
			}
		} catch (SQLException | NumberFormatException e) {
			System.err.println("Errore in docenteDao: " + e.getMessage());
		}

		return docente;
	}
}