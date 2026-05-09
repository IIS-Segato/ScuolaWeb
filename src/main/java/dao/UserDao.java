package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.jdom2.JDOMException;

import model.User;

public class UserDao extends AbstractDAO {

	private static final String SQL_LOGIN = "SELECT * FROM users WHERE username=? AND password=?";

	public UserDao(String xml) throws ClassNotFoundException, JDOMException, IOException {

		super(xml);
	}

	public User login(String username, String password) throws Exception {

		User temp = null;

		try {

			this.conn = this.getConnection();

			PreparedStatement st = this.conn.prepareStatement(SQL_LOGIN);

			st.setString(1, username);
			st.setString(2, password);

			ResultSet rs = st.executeQuery();

			while (rs.next()) {

				temp = new User();

				temp.setId(rs.getInt("id"));
				temp.setUsername(rs.getString("username"));
				temp.setPassword(rs.getString("password"));
				temp.setRoleId(rs.getInt("role_id"));
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