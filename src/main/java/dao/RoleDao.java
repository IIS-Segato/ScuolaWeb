package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Role;

public class RoleDao extends AbstractDAO {
	private static final String SQL_GET_ALL = "SELECT * FROM roles";
	private static final String SQL_GET_BY_ID = "SELECT * FROM roles where id=?";
	private static final String SQL_INSERT = "INSERT INTO roles (name, description) VALUES (?, ?)";
	private static final String SQL_UPDATE = "UPDATE roles SET name=?, description=? WHERE id=?";
	private static final String SQL_DELETE = "DELETE FROM roles WHERE id=?";

	public RoleDao(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);

	}
	
	public List<Role> getAll() throws Exception {
		List<Role> listRoles = new ArrayList<Role>();
		
		try (Connection conn = getConnection();
	             PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
	             ResultSet rs = ps.executeQuery()) {

	            while (rs.next()) {
	                Role r = new Role();
	                r.setId(rs.getInt("id"));
	                r.setRole_name(rs.getString("name"));
	                r.setDescription(rs.getString("description"));
	                listRoles.add(r);
	            }

	        } catch (Exception e) {
	            printException(e);
	        }
		
		return listRoles;
	}
	
	public Role getByID(int id) throws Exception {
		Role temp = null;

		
		try {
			this.conn = this.getConnection();
			
			PreparedStatement st = this.conn.prepareStatement(SQL_GET_BY_ID);
			
			st.setInt(1, id);
			
			ResultSet rs = st.executeQuery();
			
			while (rs.next()) {
				temp = new Role();
				temp.setId(rs.getInt("id"));
				temp.setDescription(rs.getString("description"));
				temp.setRole_name(rs.getString("name"));


			}
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}finally {
			this.conn.close();
		}
		
		return temp;
	}
	
	public boolean insert(String role_name, String description) throws Exception {
		Role temp = null;
		boolean insert = false;
		
		try {
			this.conn = this.getConnection();
			
			PreparedStatement st = this.conn.prepareStatement(SQL_INSERT);
			
			st.setString(1, role_name);
			st.setString(2, description);
			
			if( st.executeUpdate() > 0) {
				insert = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}finally {
			this.conn.close();
		}
		
		return insert;
	}
	
	public boolean update(String role_name, String description, int id) throws Exception {
		Role temp = null;
		boolean update = false;
		
		try {
			this.conn = this.getConnection();
			
			PreparedStatement st = this.conn.prepareStatement(SQL_UPDATE);
			
			st.setString(1, role_name);
			st.setString(2, description);
			st.setInt(3, id);
			
			if( st.executeUpdate() > 0) {
				update = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}finally {
			this.conn.close();
		}
		
		return update;
	}
	
	public boolean delete(int id) throws Exception {
		Role temp = null;
		boolean update = false;
		
		try {
			this.conn = this.getConnection();
			
			PreparedStatement st = this.conn.prepareStatement(SQL_DELETE);
			
			st.setInt(1, id);
			
			if( st.executeUpdate() > 0) {
				update = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}finally {
			this.conn.close();
		}
		
		return update;
	}


}
