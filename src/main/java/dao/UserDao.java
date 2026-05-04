package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import model.Contatto;
import utils.Config;

public class UserDao implements DAO{

	Connection conn;
	
	@Override
	public void setConnection(Connection conn) {
			
	}
	
	boolean autentica(String id, String password) {
		
		String pwdGiusta;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/dbes17", "root", "");
			
			Statement statement = conn.createStatement();
			ResultSet rsContatti = statement.executeQuery(Config.getSelectContattiQuery());
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

}
