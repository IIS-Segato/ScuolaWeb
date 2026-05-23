<<<<<<< HEAD
package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.jdom2.JDOMException;
import model.User;

public class UserDao extends AbstractDAO {

    public UserDao(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
        super(xml);
    }

    // Metodo fondamentale per illlll LOGIN   
    public User login(String username, String password) throws Exception {
        User user = null;
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setString(2, password); // Nota: se usi l'encrypt di StringUtils, qui dovresti passare la password criptata
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setRoleId(rs.getInt("role_id"));
                }
            }
        }
        return user;
    }
}
=======
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
>>>>>>> branch 'De-Col' of https://github.com/IIS-Segato/ScuolaWeb.git
