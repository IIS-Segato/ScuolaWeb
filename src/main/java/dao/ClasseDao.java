package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Classe;

public class ClasseDao extends AbstractDAO {

	private static final String SQL_GET_ALL = "SELECT * FROM classi ORDER BY nome";

	public ClasseDao(String xml) throws ClassNotFoundException, JDOMException, IOException {

		super(xml);
	}

	public List<Classe> getAll() throws Exception {

		List<Classe> list = new ArrayList<>();

		try (

				Connection c = getConnection();

				PreparedStatement ps = c.prepareStatement(SQL_GET_ALL);

				ResultSet rs = ps.executeQuery()

		) {

			while (rs.next()) {

				Classe classe = new Classe();

				classe.setId(rs.getInt("id"));
				classe.setNome(rs.getString("nome"));

				list.add(classe);
			}

		} catch (Exception e) {

			printException(e);
		}

		return list;
	}
}