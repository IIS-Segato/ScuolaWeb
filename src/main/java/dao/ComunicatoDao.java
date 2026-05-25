package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.jdom2.JDOMException;
import model.Comunicato;

public class ComunicatoDao extends DAO {

	public ComunicatoDao(String xmlurl) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xmlurl);
	}

	public List<Comunicato> getAllComunicati() {
		List<Comunicato> lista = new ArrayList<>();
		String query = config.getQuery("comunicati", "select");

		try (PreparedStatement ps = this.conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Comunicato c = new Comunicato();
				c.setId(rs.getInt("id"));
				c.setTitolo(rs.getString("titolo"));
				c.setTesto(rs.getString("testo"));
				c.setData(rs.getDate("data"));
				lista.add(c);
			}
		} catch (SQLException e) {
			System.err.println("Errore in ComunicatoDao: " + e.getMessage());
		}
		return lista;
	}

	// Metodo per INSERIRE un nuovo comunicato
	public boolean insertComunicato(String titolo, String testo, String dataStr) {
		String query = config.getQuery("comunicati", "insert");

		try (PreparedStatement ps = this.conn.prepareStatement(query)) {
			ps.setString(1, titolo);
			ps.setString(2, testo);
			ps.setDate(3, java.sql.Date.valueOf(dataStr)); // Converte la stringa "YYYY-MM-DD" in Data SQL

			int rowsAffected = ps.executeUpdate();
			return rowsAffected > 0;
		} catch (SQLException | IllegalArgumentException e) {
			System.err.println("Errore inserimento comunicato: " + e.getMessage());
			return false;
		}
	}

	// Metodo per ELIMINARE un comunicato
	public boolean deleteComunicato(int id) {
		String query = config.getQuery("comunicati", "delete");

		try (PreparedStatement ps = this.conn.prepareStatement(query)) {
			ps.setInt(1, id);

			int rowsAffected = ps.executeUpdate();
			return rowsAffected > 0;
		} catch (SQLException e) {
			System.err.println("Errore eliminazione comunicato: " + e.getMessage());
			return false;
		}
	}
}