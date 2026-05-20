package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Docente;

public class DocenteDao {

	private Connection conn;

	public DocenteDao(Connection conn) {
		this.conn = conn;
	}

	public List<Docente> getAll() {
		List<Docente> lista = new ArrayList<>();
		String sql = "SELECT * FROM docenti ORDER BY cognome, nome";

		try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Docente d = new Docente();
				d.setId(rs.getInt("id"));
				d.setNome(rs.getString("nome"));
				d.setCognome(rs.getString("cognome"));
				lista.add(d);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return lista;
	}
}
