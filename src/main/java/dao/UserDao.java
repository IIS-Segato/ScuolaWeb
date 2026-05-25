package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.jdom2.JDOMException;

import model.User;
import utils.StringUtils;

public class UserDao extends AbstractDAO {

	private static final String SQL_LOGIN = "SELECT " + "u.id, " + "u.username, " + "u.role_id, " + "u.studente_id, "
			+ "u.docente_id, " + "r.name AS role_name " + "FROM users u " + "JOIN roles r ON u.role_id = r.id "
			+ "WHERE u.username = ? " + "AND u.password = ?";

	public UserDao(String xml) throws ClassNotFoundException, JDOMException, IOException {

		super(xml);
	}

	public User login(String username, String password)

			throws Exception {

		User user = null;

		try {

			this.conn = getConnection();

			PreparedStatement ps = conn.prepareStatement(SQL_LOGIN);

			ps.setString(1, username);

			String encrypted = StringUtils.encrypt(password);

			ps.setString(2, encrypted);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {

				user = new User();

				user.setId(rs.getInt("id"));

				user.setUsername(rs.getString("username"));

				user.setRoleId(rs.getInt("role_id"));

				user.setRoleName(rs.getString("role_name"));

				user.setStudenteId((Integer) rs.getObject("studente_id"));

				user.setDocenteId((Integer) rs.getObject("docente_id"));
			}

			rs.close();
			ps.close();

		} catch (Exception e) {

			throw new Exception(e.getMessage());

		} finally {

			closeConnection();
		}

		return user;
	}

	public void changePassword(int userId, String nuovaPassword)

			throws Exception {

		String sql = "UPDATE users " + "SET password=? " + "WHERE id=?";

		try {

			this.conn = getConnection();

			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, StringUtils.encrypt(nuovaPassword));

			ps.setInt(2, userId);

			ps.executeUpdate();

			ps.close();

		} finally {

			closeConnection();
		}
	}
}