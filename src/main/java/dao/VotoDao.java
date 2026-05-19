package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Voto;

public class VotoDao {

	private Connection conn;

	public VotoDao(Connection conn) {
		this.conn = conn;
	}

	// INSERT
	public boolean insert(Voto v) {
		String sql = "INSERT INTO voti (id_studente, id_docente, materia, voto, data) VALUES (?, ?, ?, ?, ?)";

		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, v.getIdStudente());
			ps.setInt(2, v.getIdDocente());
			ps.setString(3, v.getMateria());
			ps.setDouble(4, v.getVoto());
			ps.setDate(5, v.getData());

			return ps.executeUpdate() > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	// UPDATE
	public boolean update(Voto v) {
		String sql = "UPDATE voti SET id_studente=?, id_docente=?, materia=?, voto=?, data=? WHERE id=?";

		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, v.getIdStudente());
			ps.setInt(2, v.getIdDocente());
			ps.setString(3, v.getMateria());
			ps.setDouble(4, v.getVoto());
			ps.setDate(5, v.getData());
			ps.setInt(6, v.getId());

			return ps.executeUpdate() > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	// DELETE
	public boolean delete(int id) {
		String sql = "DELETE FROM voti WHERE id=?";

		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, id);
			return ps.executeUpdate() > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	// GET ALL
	public List<Voto> getAll() {
		List<Voto> lista = new ArrayList<>();
		String sql = "SELECT * FROM voti ORDER BY data DESC";

		try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				lista.add(mapRow(rs));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return lista;
	}

	// GET ALL BY STUDENTE
	public List<Voto> getAllByStudente(int idStudente) {
		List<Voto> lista = new ArrayList<>();
		String sql = "SELECT * FROM voti WHERE id_studente=? ORDER BY data DESC";

		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, idStudente);

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					lista.add(mapRow(rs));
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return lista;
	}

	// GET BY ID
	public Voto getById(int id) {
		String sql = "SELECT * FROM voti WHERE id=?";

		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, id);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRow(rs);
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	// MAPPA UNA RIGA DEL RESULTSET → OGGETTO VOTO
	private Voto mapRow(ResultSet rs) throws SQLException {
		Voto v = new Voto();
		v.setId(rs.getInt("id"));
		v.setIdStudente(rs.getInt("id_studente"));
		v.setIdDocente(rs.getInt("id_docente"));
		v.setMateria(rs.getString("materia"));
		v.setVoto(rs.getDouble("voto"));
		v.setData(rs.getDate("data"));
		return v;
	}
}
