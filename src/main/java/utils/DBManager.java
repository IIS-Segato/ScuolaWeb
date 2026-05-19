package utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBManager {

	private static Connection conn;

	public static Connection getConnection() {
		if (conn != null) {
			return conn;
		}

		try {
			// Percorso ASSOLUTO al file XML dentro WEB-INF
			String xmlPath = DBManager.class.getClassLoader().getResource("../../WEB-INF/dbcfg.xml").getPath();

			Config cfg = new Config(xmlPath);
			cfg.loadConfig();

			Class.forName(cfg.getDriver());

			conn = DriverManager.getConnection(cfg.getDbUrl(), cfg.getUser(), cfg.getPassword());

			System.out.println("CONNESSIONE AL DB OK");
			return conn;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
