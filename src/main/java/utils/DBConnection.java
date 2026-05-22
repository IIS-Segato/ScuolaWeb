package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private DBConnection() {
	}

	public static Connection getConnection(String driver, String url, String user, String password) throws SQLException {
		try {
			Class.forName(driver);
			return DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			throw new SQLException("Driver non trovato: " + e.getMessage(), e);
		}
	}
}
