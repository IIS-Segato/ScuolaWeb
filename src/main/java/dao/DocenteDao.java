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

	public int insert(Docente d) {
		String sql = "INSERT INTO docenti (nome, cognome) VALUES (?, ?)";

		try (PreparedStatement ps = conn.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS)) {
			ps.setString(1, d.getNome());
			ps.setString(2, d.getCognome());
			ps.executeUpdate();

			try (ResultSet rs = ps.getGeneratedKeys()) {
				if (rs.next()) {
					d.setId(rs.getInt(1));
					return d.getId();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	public Docente getById(int id) {
		Docente d = null;
		String sql = "SELECT * FROM docenti WHERE id = ?";

		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					d = new Docente();
					d.setId(rs.getInt("id"));
					d.setNome(rs.getString("nome"));
					d.setCognome(rs.getString("cognome"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return d;
	}

	public void update(Docente d) {
		String sql = "UPDATE docenti SET nome = ?, cognome = ? WHERE id = ?";

		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, d.getNome());
			ps.setString(2, d.getCognome());
			ps.setInt(3, d.getId());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// restituisce la lista di docenti che insegnano alla classe dello studente
	public List<Docente> getDocentiByStudente(int idStudente) {
		List<Docente> lista = new ArrayList<>();
		String sql = """
				    SELECT DISTINCT d.id, d.nome, d.cognome
				    FROM docenti d
				    JOIN docenti_classi dc ON dc.id_docente = d.id
				    JOIN studenti s ON s.id_classe = dc.id_classe
				    WHERE s.id = ?
				    ORDER BY d.cognome, d.nome
				""";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, idStudente);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Docente d = new Docente();
					d.setId(rs.getInt("id"));
					d.setNome(rs.getString("nome"));
					d.setCognome(rs.getString("cognome"));
					lista.add(d);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}

}
