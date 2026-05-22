package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Classe;
import model.Studente;

public class StudenteDao {

	private Connection conn;

	public StudenteDao(Connection conn) {
		this.conn = conn;
	}

	// GET ALL STUDENTI (con classe)

	public List<Studente> getAll() {
		List<Studente> list = new ArrayList<>();

		String sql = """
				    SELECT s.*, c.id AS classe_id, c.nome AS classe_nome
				    FROM studenti s
				    LEFT JOIN classi c ON s.id_classe = c.id
				""";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Studente s = new Studente();
				s.setId(rs.getInt("id"));
				s.setNome(rs.getString("nome"));
				s.setCognome(rs.getString("cognome"));

				// Classe
				Classe c = new Classe();
				c.setId(rs.getInt("classe_id"));
				c.setNome(rs.getString("classe_nome"));

				s.setClasse(c);

				list.add(s);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// GET STUDENTI DI UNA CLASSE

	public List<Studente> getByClasse(int idClasse) {
		List<Studente> list = new ArrayList<>();

		String sql = """
				    SELECT s.*, c.id AS classe_id, c.nome AS classe_nome
				    FROM studenti s
				    LEFT JOIN classi c ON s.id_classe = c.id
				    WHERE s.id_classe = ?
				""";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idClasse);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Studente s = new Studente();
				s.setId(rs.getInt("id"));
				s.setNome(rs.getString("nome"));
				s.setCognome(rs.getString("cognome"));

				Classe c = new Classe();
				c.setId(rs.getInt("classe_id"));
				c.setNome(rs.getString("classe_nome"));

				s.setClasse(c);

				list.add(s);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// GET BY ID

	public Studente getById(int id) {
		Studente s = null;

		String sql = """
				    SELECT s.*, c.id AS classe_id, c.nome AS classe_nome
				    FROM studenti s
				    LEFT JOIN classi c ON s.id_classe = c.id
				    WHERE s.id = ?
				""";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				s = new Studente();
				s.setId(rs.getInt("id"));
				s.setNome(rs.getString("nome"));
				s.setCognome(rs.getString("cognome"));

				Classe c = new Classe();
				c.setId(rs.getInt("classe_id"));
				c.setNome(rs.getString("classe_nome"));

				s.setClasse(c);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return s;
	}

	public void insert(Studente s, int idClasse) {
		String sql = "INSERT INTO studenti (nome, cognome, id_classe) VALUES (?, ?, ?)";

		try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			ps.setString(1, s.getNome());
			ps.setString(2, s.getCognome());
			ps.setInt(3, idClasse);
			ps.executeUpdate();

			try (ResultSet rs = ps.getGeneratedKeys()) {
				if (rs.next()) {
					s.setId(rs.getInt(1));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// restituisce la Classe dellostudente dato l'id dello studente
	public Classe getClasseByStudente(int idStudente) {
		Classe c = null;
		String sql = """
				    SELECT c.id AS classe_id, c.nome AS classe_nome
				    FROM classi c
				    JOIN studenti s ON s.id_classe = c.id
				    WHERE s.id = ?
				""";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, idStudente);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					c = new Classe();
					c.setId(rs.getInt("classe_id"));
					c.setNome(rs.getString("classe_nome"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return c;
	}

}
