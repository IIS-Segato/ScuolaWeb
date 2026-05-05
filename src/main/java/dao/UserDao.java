package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import utils.Config;

/**
 * Questo DAO va utilizzato sia per gli studenti che per i professori, solo gli admin sono esclusi
 */
public class UserDao implements DAO{

	Connection conn;
	
	@Override
	public void setConnection(Connection conn) {
			
	}
	
	public boolean autentica(String id, String password, String ruolo) {
		
		String pwdGiusta;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/scuolawebsalvioni", "root", "");
			
			Config config = new Config("WebContent/WEB-INF/dbcfg.xml");
			
			PreparedStatement stmt = conn.prepareStatement(config.getQueryLogin(ruolo));
			stmt.setString(1, id);
			ResultSet pwdRs = stmt.executeQuery();
			pwdRs.next();
			pwdGiusta = pwdRs.getString("password").trim();
			System.out.println(pwdGiusta);
			System.out.println(password);
			return (password.trim().equals(pwdGiusta));
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

}
