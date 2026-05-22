package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.User;

public class UserAdminDao {

	private Connection conn;

	public UserAdminDao(Connection conn) {
		this.conn = conn;
	}

	public List<User> getAll() {
		List<User> utenti = new ArrayList<>();
		String sql = "SELECT * FROM users ORDER BY role_id, username";

		try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setRoleId(rs.getInt("role_id"));
				u.setIdStudente(rs.getInt("id_studente"));
				u.setIdDocente(rs.getInt("id_docente"));
				utenti.add(u);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return utenti;
	}

	public void insert(User u) {
		String sql = "INSERT INTO users (username, password, role_id, id_studente, id_docente) VALUES (?, ?, ?, ?, ?)";

		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, u.getUsername());
			ps.setString(2, u.getPassword());
			ps.setInt(3, u.getRoleId());

			if (u.getIdStudente() > 0) {
				ps.setInt(4, u.getIdStudente());
			} else {
				ps.setNull(4, java.sql.Types.INTEGER);
			}

			if (u.getIdDocente() > 0) {
				ps.setInt(5, u.getIdDocente());
			} else {
				ps.setNull(5, java.sql.Types.INTEGER);
			}

			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
