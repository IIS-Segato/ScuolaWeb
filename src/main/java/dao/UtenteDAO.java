package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

	public List<Utente> getAll() throws Exception {
		List<Utente> list = new ArrayList<>();
		try (Connection c = getConnection();
				PreparedStatement ps = c.prepareStatement(SQL_GET_ALL);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next())
				list.add(map(rs));
		} catch (Exception e) {
			printException(e);
		}
		return list;
	}

	public Utente getByID(int id) throws Exception {
		Utente u = null;
		try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(SQL_GET_BY_ID)) {
			ps.setInt(1, id);
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

	public boolean insert(String username, String password, String ruolo, String nome, String cognome)
			throws Exception {
		boolean ok = false;
		try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(SQL_INSERT)) {
			ps.setString(1, username);
			ps.setString(2, StringUtils.encrypt(password));
			ps.setString(3, ruolo);
			ps.setString(4, nome);
			ps.setString(5, cognome);
			ok = ps.executeUpdate() > 0;
		} catch (Exception e) {
			printException(e);
			throw new Exception(e.getMessage());
		}
		return ok;
	}

	public boolean update(String username, String ruolo, String nome, String cognome, int id) throws Exception {
		boolean ok = false;
		try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(SQL_UPDATE)) {
			ps.setString(1, username);
			ps.setString(2, ruolo);
			ps.setString(3, nome);
			ps.setString(4, cognome);
			ps.setInt(5, id);
			ok = ps.executeUpdate() > 0;
		} catch (Exception e) {
			printException(e);
			throw new Exception(e.getMessage());
		}
		return ok;
	}

	public boolean delete(int id) throws Exception {
		boolean ok = false;
		try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(SQL_DELETE)) {
			ps.setInt(1, id);
			ok = ps.executeUpdate() > 0;
		} catch (Exception e) {
			printException(e);
			throw new Exception(e.getMessage());
		}
		return ok;
	}

	private Utente map(ResultSet rs) throws SQLException {
		Utente u = new Utente();
		u.setId(rs.getInt("id"));
		u.setUsername(rs.getString("username"));
		u.setPassword(rs.getString("password"));
		u.setRuolo(rs.getString("ruolo"));
		u.setNome(rs.getString("nome"));
		u.setCognome(rs.getString("cognome"));
		return u;
	}
}
