package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DocenteDao extends DAO {

	Connection conn;

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	public void setConnection(Connection conn) {
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scuola", "root", "password");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
