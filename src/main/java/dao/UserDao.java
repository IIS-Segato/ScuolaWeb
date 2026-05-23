package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.jdom2.JDOMException;

import model.User;

public class UserDao extends AbstractDAO {

	// Join con roles per recuperare il nome del ruolo in un'unica query
	private static final String SQL_LOGIN = "SELECT u.id, u.username, u.role_id, r.name AS role_name " + "FROM users u "
			+ "JOIN roles r ON u.role_id = r.id " + "WHERE u.username = ? AND u.password = ?";

	public UserDao(String xml) throws ClassNotFoundException, JDOMException, IOException {

		super(xml);
	}

	/**
	 * Verifica le credenziali e restituisce l'utente con il suo ruolo. Restituisce
	 * null se le credenziali non sono valide.
	 */
	public User login(String username, String password) throws Exception {

		User user = null;

		try {

			this.conn = getConnection();

			PreparedStatement ps = conn.prepareStatement(SQL_LOGIN);

			ps.setString(1, username);
			ps.setString(2, password);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {

				user = new User();

				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("username"));
				user.setRoleId(rs.getInt("role_id"));
				user.setRoleName(rs.getString("role_name"));
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
}