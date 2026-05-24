package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Classe;

public class DocenteClasseDao {

	private Connection conn;

	public DocenteClasseDao(Connection conn) {
		this.conn = conn;
	}

	// ASSEGNA DOCENTE → CLASSE

	public void assegna(int idDocente, int idClasse) {
		try {
			String sql = "INSERT INTO docenti_classi (id_docente, id_classe) VALUES (?, ?)";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idDocente);
			ps.setInt(2, idClasse);
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// CLASSI DI UN DOCENTE

	public List<Classe> getClassiByDocente(int idDocente) {
		List<Classe> list = new ArrayList<>();

		try {
			String sql = """
					    SELECT c.id, c.nome
					    FROM classi c
					    JOIN docenti_classi dc ON dc.id_classe = c.id
					    WHERE dc.id_docente = ?
					""";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idDocente);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Classe c = new Classe();
				c.setId(rs.getInt("id"));
				c.setNome(rs.getString("nome"));
				list.add(c);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// RIMUOVI ASSEGNAZIONE (opzionale)

	public void rimuovi(int idDocente, int idClasse) {
		try {
			String sql = "DELETE FROM docenti_classi WHERE id_docente = ? AND id_classe = ?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idDocente);
			ps.setInt(2, idClasse);
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void rimuoviTutte(int idDocente) {
		try {
			String sql = "DELETE FROM docenti_classi WHERE id_docente = ?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idDocente);
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
