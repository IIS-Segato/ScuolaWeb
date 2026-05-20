package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Studente;
import model.Voto;

public class VotoDao {

	private Connection conn;

	public VotoDao(Connection conn) {
		this.conn = conn;
	}

	// LISTA VOTI DI UNO STUDENTE

	public List<Voto> getAllByStudente(int idStudente) {
		List<Voto> list = new ArrayList<>();

		String sql = "SELECT * FROM voti WHERE id_studente = ? ORDER BY data DESC";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idStudente);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Voto v = new Voto();
				v.setId(rs.getInt("id"));
				v.setIdStudente(rs.getInt("id_studente"));
				v.setIdDocente(rs.getInt("id_docente"));
				v.setMateria(rs.getString("materia"));
				v.setVoto(rs.getDouble("voto"));
				v.setData(rs.getDate("data"));

				list.add(v);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// STUDENTI DELLE CLASSI DI UN DOCENTE

	public List<Studente> getStudentiByDocente(int idDocente) {
		List<Studente> list = new ArrayList<>();

		String sql = """
				    SELECT s.*
				    FROM studenti s
				    JOIN docenti_classi dc ON dc.id_classe = s.id_classe
				    WHERE dc.id_docente = ?
				    ORDER BY s.cognome, s.nome
				""";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idDocente);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Studente s = new Studente();
				s.setId(rs.getInt("id"));
				s.setNome(rs.getString("nome"));
				s.setCognome(rs.getString("cognome"));
				list.add(s);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// INSERIMENTO VOTO

	public void insert(Voto v) {
		String sql = """
				    INSERT INTO voti (id_studente, id_docente, materia, voto, data)
				    VALUES (?, ?, ?, ?, ?)
				""";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, v.getIdStudente());
			ps.setInt(2, v.getIdDocente());
			ps.setString(3, v.getMateria());
			ps.setDouble(4, v.getVoto());
			ps.setDate(5, v.getData());

			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// GET BY ID

	public Voto getById(int id) {
		Voto v = null;

		String sql = "SELECT * FROM voti WHERE id = ?";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				v = new Voto();
				v.setId(rs.getInt("id"));
				v.setIdStudente(rs.getInt("id_studente"));
				v.setIdDocente(rs.getInt("id_docente"));
				v.setMateria(rs.getString("materia"));
				v.setVoto(rs.getDouble("voto"));
				v.setData(rs.getDate("data"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return v;
	}

	// UPDATE

	public void update(Voto v) {
		String sql = """
				    UPDATE voti
				    SET id_studente = ?, id_docente = ?, materia = ?, voto = ?, data = ?
				    WHERE id = ?
				""";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, v.getIdStudente());
			ps.setInt(2, v.getIdDocente());
			ps.setString(3, v.getMateria());
			ps.setDouble(4, v.getVoto());
			ps.setDate(5, v.getData());

			ps.setInt(6, v.getId());
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// DELETE

	public void delete(int id) {
		try {
			PreparedStatement ps = conn.prepareStatement("DELETE FROM voti WHERE id = ?");
			ps.setInt(1, id);
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<Voto> getAll() {
		List<Voto> list = new ArrayList<>();

		String sql = "SELECT * FROM voti ORDER BY data DESC";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Voto v = new Voto();
				v.setId(rs.getInt("id"));
				v.setIdStudente(rs.getInt("id_studente"));
				v.setIdDocente(rs.getInt("id_docente"));
				v.setMateria(rs.getString("materia"));
				v.setVoto(rs.getDouble("voto"));
				v.setData(rs.getDate("data"));
				list.add(v);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<Voto> getAllByDocente(int idDocente) {
		List<Voto> list = new ArrayList<>();

		String sql = "SELECT * FROM voti WHERE id_docente = ? ORDER BY data DESC";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idDocente);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Voto v = new Voto();
				v.setId(rs.getInt("id"));
				v.setIdStudente(rs.getInt("id_studente"));
				v.setIdDocente(rs.getInt("id_docente"));
				v.setMateria(rs.getString("materia"));
				v.setVoto(rs.getDouble("voto"));
				v.setData(rs.getDate("data"));
				list.add(v);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

}
