package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Teacher;

public class TeacherDao extends AbstractDAO {

	public TeacherDao(String configPath) throws Exception {
		super(configPath);
	}

	public Teacher login(String username, String password) throws Exception {
		String sql = "SELECT * FROM teachers WHERE username = ? AND password = ?";

		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, username);
			ps.setString(2, password);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					Teacher t = new Teacher();
					t.setId(rs.getInt("id"));
					t.setName(rs.getString("name"));
					t.setSurname(rs.getString("surname"));
					t.setSubject(rs.getString("subject"));
					return t;
				}
			}
				}

		return null;
	}

	public List<Teacher> getAll() throws Exception {
		List<Teacher> list = new ArrayList<>();
		String sql = "SELECT * FROM teachers ORDER BY id";

		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Teacher t = new Teacher();
				t.setId(rs.getInt("id"));
				t.setName(rs.getString("name"));
				t.setSurname(rs.getString("surname"));
				t.setSubject(rs.getString("subject"));
				list.add(t);
			}
				}

		return list;
	}

	public List<Teacher> search(String name, String surname, String subject) throws Exception {
		List<Teacher> list = new ArrayList<>();
		StringBuilder sql = new StringBuilder("SELECT * FROM teachers WHERE 1=1");
		List<Object> params = new ArrayList<>();

		if (name != null && !name.trim().isEmpty()) {
			sql.append(" AND name LIKE ?");
			params.add("%" + name.trim() + "%");
		}

		if (surname != null && !surname.trim().isEmpty()) {
			sql.append(" AND surname LIKE ?");
			params.add("%" + surname.trim() + "%");
		}

		if (subject != null && !subject.trim().isEmpty()) {
			sql.append(" AND subject LIKE ?");
			params.add("%" + subject.trim() + "%");
		}

		sql.append(" ORDER BY id");

		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement(sql.toString())) {

			for (int i = 0; i < params.size(); i++) {
				ps.setObject(i + 1, params.get(i));
			}

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Teacher t = new Teacher();
					t.setId(rs.getInt("id"));
					t.setName(rs.getString("name"));
					t.setSurname(rs.getString("surname"));
					t.setSubject(rs.getString("subject"));
					list.add(t);
				}
			}
				}

		return list;
	}

	public Teacher getByID(int id) throws Exception {
		Teacher t = null;
		String sql = "SELECT * FROM teachers WHERE id = ?";

		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, id);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					t = new Teacher();
					t.setId(rs.getInt("id"));
					t.setName(rs.getString("name"));
					t.setSurname(rs.getString("surname"));
					t.setSubject(rs.getString("subject"));
				}
			}
				}

		return t;
	}

	public void insert(String name, String surname, String subject, String username, String password) throws Exception {
		String sql = "INSERT INTO teachers (name, surname, subject, username, password) VALUES (?, ?, ?, ?, ?)";

		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, name);
			ps.setString(2, surname);
			ps.setString(3, subject);
			ps.setString(4, username);
			ps.setString(5, password);
			ps.executeUpdate();
				}
	}

	public void update(String name, String surname, String subject, int id) throws Exception {
		String sql = "UPDATE teachers SET name = ?, surname = ?, subject = ? WHERE id = ?";

		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, name);
			ps.setString(2, surname);
			ps.setString(3, subject);
			ps.setInt(4, id);
			ps.executeUpdate();
				}
	}

	public void delete(int id) throws Exception {
		String sql = "DELETE FROM teachers WHERE id = ?";

		try (Connection con = getConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, id);
			ps.executeUpdate();
				}
	}
}
