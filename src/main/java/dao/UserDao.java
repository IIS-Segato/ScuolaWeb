package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import utils.Config;

public class UserDao implements DAO{

	Connection conn;
	
	@Override
	public void setConnection(Connection conn) {
			
	}
	
	public boolean autentica(String id, String password) {
		
		String pwdGiusta;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/scuolawebsalvioni", "root", "");
			
			Config config = new Config("WebContent/WEB-INF/dbcfg.xml");
			
			Statement statement = conn.createStatement();
			PreparedStatement stmt = conn.prepareStatement(config.getQueryLogin("studente"));
			stmt.setString(1, id);
			ResultSet pwdRs = stmt.executeQuery();
			pwdRs.next();
			pwdGiusta = pwdRs.getString("password").trim();
			System.out.println(pwdGiusta);
			System.out.println(password);
			return (password.trim() == pwdGiusta);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

}
