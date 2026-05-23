package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.jdom2.JDOMException;

import model.Utente;
import utils.StringUtils;

public class UtenteDAO extends AbstractDAO {

	private static final String SQL_LOGIN = "SELECT * FROM utenti WHERE username = ? AND password = ?";
	private static final String SQL_GET_ALL = "SELECT * FROM utenti ORDER BY cognome, nome";
	private static final String SQL_GET_BY_ID = "SELECT * FROM utenti WHERE id = ?";
	private static final String SQL_INSERT = "INSERT INTO utenti (username, password, ruolo, nome, cognome) VALUES (?, ?, ?, ?, ?)";
	private static final String SQL_UPDATE = "UPDATE utenti SET username=?, ruolo=?, nome=?, cognome=? WHERE id=?";
	private static final String SQL_UPDATE_PWD = "UPDATE utenti SET password=? WHERE id=?";
	private static final String SQL_DELETE = "DELETE FROM utenti WHERE id=?";

	public UtenteDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
	}

	public Utente login(String username, String password) throws Exception {
		Utente u = null;
		String hashedPwd = StringUtils.encrypt(password);
		try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(SQL_LOGIN)) {
			ps.setString(1, username);
			ps.setString(2, hashedPwd);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next())
					u = map(rs);
			}
		} catch (Exception e) {
			printException(e);
			throw new Exception(e.getMessage());
		}
		return u;
	}
}