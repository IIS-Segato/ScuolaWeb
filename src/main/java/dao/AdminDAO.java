package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.jdom2.JDOMException;

import model.Admin;

//commento per commit 3
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
		
		/**
		 * metodo per la creazione di docenti
		 * @param nome
		 * @param cognome
		 * @param materia
		 * @param password
		 * @return
		 */
	    public boolean insertDocente(String nome, String cognome, String materia, String password) {
	        boolean inserito = false;
	        String query = config.getQuery("docenti", "insert"); // Prende la query dall'XML

	        try (PreparedStatement ps = this.conn.prepareStatement(query)) {
	            
	            ps.setString(1, nome);
	            ps.setString(2, cognome);
	            ps.setString(3, password);
	            ps.setString(4, materia); 

	            // executeUpdate() restituisce il numero di righe modificate
	            int righeModificate = ps.executeUpdate();
	            
	            if (righeModificate > 0) {
	                inserito = true;
	            }

	        } catch (SQLException e) {
	            System.err.println("Errore in AdminDAO - insertDocente: " + e.getMessage());
	            
//	            // 1452 è il codice standard MySQL per: "Cannot add or update a child row: a foreign key constraint fails"
//	            if (e.getErrorCode() == 1452) {
//	                return "errore_materia_non_valida";
//	            }
//	            
//	            // Puoi aggiungere altri controlli qui, ad esempio per chiavi duplicate (codice 1062)
//	            if (e.getErrorCode() == 1062) {
//	                return "errore_duplicato";
//	            }
           }
//	        return "errore_generico";

	        return inserito;
	    }
}
