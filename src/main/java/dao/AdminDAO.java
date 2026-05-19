package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.jdom2.JDOMException;

import model.Admin;
import utils.Config;

//commento per commit 2
public class AdminDAO extends DAO{
	// Il costruttore chiama quello della superclasse DAO
		public AdminDAO(String xmlurl) throws ClassNotFoundException, JDOMException, IOException, SQLException {
			super(xmlurl);
		}

		//metodo che restituisce l'admin dal suo id
		public Admin getAdminById(String id) {
			Admin admin = null;
			String query = config.getQuery("admin", "select"); //query presa dal confing

			try (PreparedStatement ps = this.conn.prepareStatement(query)) {

				ps.setInt(1, Integer.parseInt(id));

				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						admin = new Admin();
						admin.setId(rs.getInt("id"));
						admin.setUsername(rs.getString("username"));
					}
				}
			} catch (SQLException | NumberFormatException e) {
				System.err.println("Errore in AdminDAO: " + e.getMessage());
			}

			return admin;
		}
}
