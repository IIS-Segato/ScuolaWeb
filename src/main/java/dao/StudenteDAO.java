package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Studente;

public class StudenteDAO extends AbstractDAO {

	private static final String SQL_GET_ALL = "SELECT * FROM studenti ORDER BY cognome, nome";
	private static final String SQL_GET_BY_ID = "SELECT * FROM studenti WHERE id = ?";
	private static final String SQL_SEARCH = "SELECT * FROM studenti WHERE classe = ? ORDER BY cognome, nome";
	private static final String SQL_INSERT = "INSERT INTO studenti (nome, cognome, classe) VALUES (?, ?, ?)";
	private static final String SQL_UPDATE = "UPDATE studenti SET nome=?, cognome=?, classe=? WHERE id=?";
	private static final String SQL_DELETE = "DELETE FROM studenti WHERE id=?";

	public StudenteDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
	}

	public List<Studente> getAll() throws Exception {
		List<Studente> list = new ArrayList<>();
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

	public List<Studente> getByClasse(String classe) throws Exception {
		List<Studente> list = new ArrayList<>();
		try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(SQL_SEARCH)) {
			ps.setString(1, classe);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next())
					list.add(map(rs));
			}
		} catch (Exception e) {
			printException(e);
		}
		return list;
	}

	public Studente getByID(int id) throws Exception {
		Studente s = null;
		try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(SQL_GET_BY_ID)) {
			ps.setInt(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next())
					s = map(rs);
			}
		} catch (Exception e) {
			printException(e);
			throw new Exception(e.getMessage());
		}
		return s;
	}

	public boolean insert(String nome, String cognome, String classe) throws Exception {
		boolean ok = false;
		try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(SQL_INSERT)) {
			ps.setString(1, nome);
			ps.setString(2, cognome);
			ps.setString(3, classe);
			ok = ps.executeUpdate() > 0;
		} catch (Exception e) {
			printException(e);
			throw new Exception(e.getMessage());
		}
		return ok;
	}

	public boolean update(String nome, String cognome, String classe, int id) throws Exception {
		boolean ok = false;
		try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(SQL_UPDATE)) {
			ps.setString(1, nome);
			ps.setString(2, cognome);
			ps.setString(3, classe);
			ps.setInt(4, id);
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

	private Studente map(ResultSet rs) throws SQLException {
		Studente s = new Studente();
		s.setId(rs.getInt("id"));
		s.setNome(rs.getString("nome"));
		s.setCognome(rs.getString("cognome"));
		s.setClasse(rs.getString("classe"));
		return s;
	}
}
