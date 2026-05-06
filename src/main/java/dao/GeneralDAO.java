package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import utils.Config;

/**
 * Questo DAO va utilizzato sia per gli studenti che per i professori, solo gli admin sono esclusi
 */
public class GeneralDAO{

	Connection conn;
	
	public boolean autentica(String id, String password, String ruolo) {
		
		String pwdGiusta;
		
		try {
			Config config = new Config("WebContent/WEB-INF/dbcfg.xml");
			config.loadConfig();
			Class.forName(config.getDriver());
			conn = DriverManager.getConnection(config.getDbUrl(), config.getUser(), config.getPassword());
			
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