package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Docente;

public class DocenteDao extends AbstractDAO {

	private static final String SQL_GET_ALL = "SELECT * FROM docenti ORDER BY cognome";

	public DocenteDao(String xml) throws ClassNotFoundException, JDOMException, IOException {

		super(xml);
	}

	public List<Docente> getAll() throws Exception {

		List<Docente> list = new ArrayList<>();

		try (

				Connection c = getConnection();

				PreparedStatement ps = c.prepareStatement(SQL_GET_ALL);

				ResultSet rs = ps.executeQuery()

		) {

			while (rs.next()) {

				Docente d = new Docente();

				d.setId(rs.getInt("id"));
				d.setNome(rs.getString("nome"));
				d.setCognome(rs.getString("cognome"));
				d.setMateria(rs.getString("materia"));
				d.setEmail(rs.getString("email"));

				d.setClassi(getClassiDocente(rs.getInt("id")));

				list.add(d);
			}

		} catch (Exception e) {

			printException(e);
		}

		return list;
	}

	public List<Docente> getByClasse(int classeId) throws Exception {

		List<Docente> list = new ArrayList<>();

		String sql = "SELECT DISTINCT d.* " + "FROM docenti d " + "JOIN docente_classi dc " + "ON d.id = dc.docente_id "
				+ "WHERE dc.classe_id = ?";

		try (

				Connection c = getConnection();

				PreparedStatement ps = c.prepareStatement(sql)

		) {

			ps.setInt(1, classeId);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				Docente d = new Docente();

				d.setId(rs.getInt("id"));
				d.setNome(rs.getString("nome"));
				d.setCognome(rs.getString("cognome"));
				d.setMateria(rs.getString("materia"));
				d.setEmail(rs.getString("email"));

				d.setClassi(getClassiDocente(rs.getInt("id")));

				list.add(d);
			}

			rs.close();

		} catch (Exception e) {

			printException(e);
		}

		return list;
	}

	public List<String> getClassiDocente(int docenteId) throws Exception {

		List<String> classi = new ArrayList<>();

		String sql = "SELECT c.nome " + "FROM classi c " + "JOIN docente_classi dc " + "ON c.id = dc.classe_id "
				+ "WHERE dc.docente_id = ?";

		try (

				Connection c = getConnection();

				PreparedStatement ps = c.prepareStatement(sql)

		) {

			ps.setInt(1, docenteId);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				classi.add(rs.getString("nome"));
			}

			rs.close();

		} catch (Exception e) {

			printException(e);
		}

		return classi;
	}
}