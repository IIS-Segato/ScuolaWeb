package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.jdom2.JDOMException;

import model.User;
import utils.PasswordUtils;

public class UserDao extends AbstractDAO {

	private static final String SQL_LOGIN = "SELECT * FROM users WHERE username=?";
	private static final String SQL_UPDATE_PASSWORD = "UPDATE users SET password=? WHERE id=?";

	public UserDao(String xml) throws ClassNotFoundException, JDOMException, IOException {

		super(xml);
	}

	public User login(String username, String password) throws Exception {

		User temp = null;

		try {

			this.conn = this.getConnection();

			PreparedStatement st = this.conn.prepareStatement(SQL_LOGIN);

			st.setString(1, username);
			ResultSet rs = st.executeQuery();

			while (rs.next()) {
				String storedPassword = rs.getString("password");
				if (!PasswordUtils.matches(password, storedPassword)) {
					continue;
				}

				temp = new User();

				temp.setId(rs.getInt("id"));
				temp.setUsername(rs.getString("username"));
				temp.setRoleId(rs.getInt("role_id"));
				temp.setIdStudente(rs.getInt("id_studente"));
				temp.setIdDocente(rs.getInt("id_docente"));

				String hashedPassword = PasswordUtils.hash(password);
				temp.setPassword(hashedPassword);

				if (!PasswordUtils.isHashed(storedPassword)) {
					PreparedStatement update = this.conn.prepareStatement(SQL_UPDATE_PASSWORD);
					update.setString(1, hashedPassword);
					update.setInt(2, temp.getId());
					update.executeUpdate();
				}
			}

		} catch (Exception e) {

			e.printStackTrace();
			throw new Exception(e.getMessage());

		} finally {

			this.closeConnection();
		}

		return temp;
	}
}
