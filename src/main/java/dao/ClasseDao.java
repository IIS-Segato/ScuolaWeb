package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Classe;

public class ClasseDao {

	private Connection conn;

	public ClasseDao(Connection conn) {
		this.conn = conn;
	}

	// GET ALL CLASSI

	public List<Classe> getAll() {
		List<Classe> list = new ArrayList<>();

		try {
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM classi");
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Classe c = new Classe(rs.getInt("id"), rs.getString("nome"));
				list.add(c);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// GET BY ID

	public Classe getById(int id) {
		Classe c = null;

		try {
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM classi WHERE id = ?");
			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				c = new Classe(rs.getInt("id"), rs.getString("nome"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return c;
	}
}
