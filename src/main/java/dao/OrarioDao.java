package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.jdom2.JDOMException;
import model.Orario;

public class OrarioDao extends DAO {

	public OrarioDao(String xmlurl) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xmlurl);
	}

	public List<Orario> getOrarioByClasse(String classe) {
		List<Orario> listaOrari = new ArrayList<>();

		String query = super.config.getQuery("orari", "selectByClasse");

		try (PreparedStatement ps = this.conn.prepareStatement(query)) {
			ps.setString(1, classe);

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Orario orario = new Orario(rs.getInt("id"), rs.getInt("id_docente"), rs.getString("nome_giorno"),
							rs.getString("orario_inizio"), rs.getString("orario_fine"), rs.getString("classe"),
							rs.getString("nome"), rs.getString("cognome"), rs.getString("nome_materia"));
					listaOrari.add(orario);
				}
			}
		} catch (SQLException e) {
			System.err.println("Errore in OrarioDao: " + e.getMessage());
		}
		return listaOrari;
	}
}