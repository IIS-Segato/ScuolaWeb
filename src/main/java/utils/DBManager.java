package utils;

import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.ServletContext;

public class DBManager {

	private static Connection conn;

	// Versione usata dalle servlet: legge il path dal context-param del web.xml.
	public static Connection getConnection(ServletContext context) {
		return getConnection(resolveConfigPath(context));
	}

	// Fallback mantenuto per compatibilita con codice gia esistente.
	public static Connection getConnection() {
		return getConnection(resolveConfigPath(null));
	}

	private static synchronized Connection getConnection(String xmlPath) {
		try {
			if (conn != null && !conn.isClosed()) {
				return conn;
			}

			Config cfg = new Config(xmlPath);
			cfg.loadConfig();

			Class.forName(cfg.getDriver());
			conn = DriverManager.getConnection(cfg.getDbUrl(), cfg.getUser(), cfg.getPassword());
			return conn;
		} catch (Exception e) {
			throw new RuntimeException("Errore connessione database", e);
		}
	}

	private static String resolveConfigPath(ServletContext context) {
		if (context != null) {
			String configParam = context.getInitParameter("config");
			if (configParam != null) {
				String realPath = context.getRealPath(configParam);
				if (realPath != null) {
					return realPath;
				}
			}
		}

		// Fallback utile in esecuzioni Eclipse/Tomcat dove il context non e
		// disponibile.
		return DBManager.class.getClassLoader().getResource("../../WEB-INF/dbcfg.xml").getPath();
	}
}
