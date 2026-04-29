package dao;

import java.sql.Connection;

public interface DAO {
	public String url = "jdbc:mysql://localhost:3306/scuolaweb";
	public String username = "root";
	public String password = "your_password";

    void setConnection(Connection conn);

}