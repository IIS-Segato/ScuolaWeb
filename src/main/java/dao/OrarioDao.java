package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Orario;

public class OrarioDao extends AbstractDAO {

	public OrarioDao(String xml) throws ClassNotFoundException, JDOMException, IOException {

		super(xml);
	}

	public List<Orario> getByClasse(int classeId) throws Exception {

		List<Orario> list = new ArrayList<>();

		String sql = "SELECT " + "o.*, " + "c.nome AS classe_nome, " + "d.cognome AS docente_cognome "
				+ "FROM orario o " + "JOIN classi c " + "ON o.classe_id = c.id " + "JOIN docenti d "
				+ "ON o.docente_id = d.id " + "WHERE o.classe_id = ? " + "ORDER BY " + "FIELD(o.giorno, " + "'Lunedi', "
				+ "'Martedi', " + "'Mercoledi', " + "'Giovedi', " + "'Venerdi'), " + "o.ora";

		try (

				Connection c = getConnection();

				PreparedStatement ps = c.prepareStatement(sql)

		) {

			ps.setInt(1, classeId);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				Orario o = new Orario();

				o.setId(rs.getInt("id"));

				o.setClasse(rs.getString("classe_nome"));

				o.setMateria(rs.getString("materia"));

				o.setGiorno(rs.getString("giorno"));

				o.setOra(rs.getString("ora"));

				o.setDocente(rs.getString("docente_cognome"));

				list.add(o);
			}

			rs.close();

		} catch (Exception e) {

			printException(e);
		}

		return list;
	}
}