package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Role;

public class RoleDao extends AbstractDAO {

	private static final String SQL_GET_ALL =
		"SELECT * FROM roles ORDER BY name";
	private static final String SQL_GET_BY_ID =
		"SELECT * FROM roles WHERE id=?";
	private static final String SQL_INSERT =
		"INSERT INTO roles (name, description) VALUES (?, ?)";
	private static final String SQL_UPDATE =
		"UPDATE roles SET name=?, description=? WHERE id=?";
	private static final String SQL_DELETE =
		"DELETE FROM roles WHERE id=?";

	public RoleDao(String xml) throws ClassNotFoundException, JDOMException, IOException {
		super(xml);
	}

	public List<Role> getAll() throws Exception {
		List<Role> roles = new ArrayList<>();

		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Role role = new Role();
				role.setId(rs.getInt("id"));
				role.setRole_name(rs.getString("name"));
				role.setDescription(rs.getString("description"));
				roles.add(role);
			}
		} catch (Exception e) {
			printException(e);
			throw new Exception(e.getMessage(), e);
		}

		return roles;
	}

	public Role getByID(int id) throws Exception {
		Role role = null;

		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_ID)) {

			ps.setInt(1, id);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					role = new Role();
					role.setId(rs.getInt("id"));
					role.setRole_name(rs.getString("name"));
					role.setDescription(rs.getString("description"));
				}
			}
		} catch (Exception e) {
			printException(e);
			throw new Exception(e.getMessage(), e);
		}

		return role;
	}

	public boolean insert(String role_name, String description) throws Exception {
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement(SQL_INSERT)) {

			ps.setString(1, role_name);
			ps.setString(2, description);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			printException(e);
			throw new Exception(e.getMessage(), e);
		}
	}

	public boolean update(String role_name, String description, int id) throws Exception {
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement(SQL_UPDATE)) {

			ps.setString(1, role_name);
			ps.setString(2, description);
			ps.setInt(3, id);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			printException(e);
			throw new Exception(e.getMessage(), e);
		}
	}

	public boolean delete(int id) throws Exception {
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement(SQL_DELETE)) {

			ps.setInt(1, id);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			printException(e);
			throw new Exception(e.getMessage(), e);
		}
	}
}
