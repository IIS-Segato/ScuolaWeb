package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Studente;

public class StudenteDao extends AbstractDAO {

	private static final String SQL_GET_ALL = "SELECT s.*, c.nome AS nome_classe " + "FROM studenti s "
			+ "JOIN classi c ON s.classe_id = c.id " + "ORDER BY c.nome, s.cognome";

	private static final String SQL_GET_BY_ID = "SELECT s.*, c.nome AS nome_classe " + "FROM studenti s "
			+ "JOIN classi c ON s.classe_id = c.id " + "WHERE s.id=?";

	private static final String SQL_INSERT = "INSERT INTO studenti " + "(nome, cognome, classe_id) "
			+ "VALUES (?, ?, ?)";

	private static final String SQL_UPDATE = "UPDATE studenti " + "SET nome=?, cognome=?, classe_id=? " + "WHERE id=?";

	private static final String SQL_DELETE = "DELETE FROM studenti WHERE id=?";

	public StudenteDao(String xml) throws ClassNotFoundException, JDOMException, IOException {

		super(xml);
	}

	public List<Studente> getAll() throws Exception {

		List<Studente> list = new ArrayList<>();

		try (

				Connection c = getConnection();

				PreparedStatement ps = c.prepareStatement(SQL_GET_ALL);

				ResultSet rs = ps.executeQuery()

		) {

			while (rs.next()) {

				Studente s = new Studente();

				s.setId(rs.getInt("id"));
				s.setNome(rs.getString("nome"));
				s.setCognome(rs.getString("cognome"));

				s.setClasseId(rs.getInt("classe_id"));
				s.setNomeClasse(rs.getString("nome_classe"));

				list.add(s);
			}

		} catch (Exception e) {

			printException(e);
		}

		return list;
	}

	public List<Studente> getByClasse(int classeId) throws Exception {

		List<Studente> list = new ArrayList<>();

		String sql = "SELECT s.*, c.nome AS nome_classe " + "FROM studenti s " + "JOIN classi c ON s.classe_id = c.id "
				+ "WHERE s.classe_id = ? " + "ORDER BY s.cognome";

		try (

				Connection c = getConnection();

				PreparedStatement ps = c.prepareStatement(sql)

		) {

			ps.setInt(1, classeId);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				Studente s = new Studente();

				s.setId(rs.getInt("id"));
				s.setNome(rs.getString("nome"));
				s.setCognome(rs.getString("cognome"));

				s.setClasseId(rs.getInt("classe_id"));

				s.setNomeClasse(rs.getString("nome_classe"));

				list.add(s);
			}

			rs.close();

		} catch (Exception e) {

			printException(e);
		}

		return list;
	}

	public Studente getByID(int id) throws Exception {

		Studente s = null;

		try {

			this.conn = getConnection();

			PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_ID);

			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {

				s = new Studente();

				s.setId(rs.getInt("id"));
				s.setNome(rs.getString("nome"));
				s.setCognome(rs.getString("cognome"));

				s.setClasseId(rs.getInt("classe_id"));
				s.setNomeClasse(rs.getString("nome_classe"));
			}

			rs.close();
			ps.close();

		} catch (Exception e) {

			throw new Exception(e.getMessage());

		} finally {

			closeConnection();
		}

		return s;
	}

	public boolean insert(String nome, String cognome, int classeId)

			throws Exception {

		boolean ok = false;

		try {

			this.conn = getConnection();

			PreparedStatement ps = conn.prepareStatement(SQL_INSERT);

			ps.setString(1, nome);
			ps.setString(2, cognome);
			ps.setInt(3, classeId);

			ok = ps.executeUpdate() > 0;

			ps.close();

		} catch (Exception e) {

			throw new Exception(e.getMessage());

		} finally {

			closeConnection();
		}

		return ok;
	}

	public boolean update(String nome, String cognome, int classeId, int id)

			throws Exception {

		boolean ok = false;

		try {

			this.conn = getConnection();

			PreparedStatement ps = conn.prepareStatement(SQL_UPDATE);

			ps.setString(1, nome);
			ps.setString(2, cognome);

			ps.setInt(3, classeId);
			ps.setInt(4, id);

			ok = ps.executeUpdate() > 0;

			ps.close();

		} catch (Exception e) {

			throw new Exception(e.getMessage());

		} finally {

			closeConnection();
		}

		return ok;
	}

	public boolean delete(int id) throws Exception {

		boolean ok = false;

		try {

			this.conn = getConnection();

			PreparedStatement ps = conn.prepareStatement(SQL_DELETE);

			ps.setInt(1, id);

			ok = ps.executeUpdate() > 0;

			ps.close();

		} catch (Exception e) {

			throw new Exception(e.getMessage());

		} finally {

			closeConnection();
		}

		return ok;
	}
}