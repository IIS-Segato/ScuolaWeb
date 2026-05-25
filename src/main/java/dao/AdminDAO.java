package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.jdom2.JDOMException;

import model.Admin;

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
	            
           }

	        return inserito;
	    }
	    
	    /**
		 * Metodo per eliminare un docente dal database tramite il suo ID
		 * @param idDocente
		 * @return true se l'eliminazione ha avuto successo, false altrimenti
		 */
		public boolean rimuoviDocente(String idDocente) {
			boolean eliminato = false;
			
			// Recupera la query di cancellazione dall'XML 
			// (nel tuo dbcfg.xml dovrebbe essere: DELETE FROM docenti WHERE id = ?)
			String query = config.getQuery("docenti", "delete"); 

			try (PreparedStatement ps = this.conn.prepareStatement(query)) {
				
				// Converte la stringa in intero e la imposta al posto del punto interrogativo (?)
				ps.setInt(1, Integer.parseInt(idDocente));

				// executeUpdate() restituisce il numero di righe eliminate
				int righeModificate = ps.executeUpdate();
				
				if (righeModificate > 0) {
					eliminato = true;
				}

			} catch (SQLException e) {
				System.err.println("Errore SQL in AdminDAO - rimuoviDocente: " + e.getMessage());
			} catch (NumberFormatException e) {
				System.err.println("Errore formato ID in AdminDAO - rimuoviDocente. ID inserito: " + idDocente);
			}

			return eliminato;
		}
		
		/**
		 * metodo per la creazione di studenti
		 * @param nome
		 * @param cognome
		 * @param materia
		 * @param password
		 * @return
		 */
	    public boolean insertStudente(String nome, String cognome, String classe, String password) {
	        boolean inserito = false;
	        String query = config.getQuery("studenti", "insert"); // Prende la query dall'XML

	        try (PreparedStatement ps = this.conn.prepareStatement(query)) {
	            
	            ps.setString(1, nome);
	            ps.setString(2, cognome);
	            ps.setString(3, password);
	            ps.setString(4, classe); 

	            // executeUpdate() restituisce il numero di righe modificate
	            int righeModificate = ps.executeUpdate();
	            
	            if (righeModificate > 0) {
	                inserito = true;
	            }
	            

	        } catch (SQLException e) {
	            System.err.println("Errore in AdminDAO - insertStudente: " + e.getMessage());
           }
	        return inserito;
	    }
	    
	    /**
		 * Metodo per eliminare uno studente dal database tramite il suo ID
		 * @param idStudente
		 * @return true se l'eliminazione ha avuto successo, false altrimenti
		 */
		public boolean rimuoviStudente(String idStudente) {
			boolean eliminato = false;
			
			// Recupera la query di cancellazione dall'XML 
			String query = config.getQuery("studenti", "delete"); 

			try (PreparedStatement ps = this.conn.prepareStatement(query)) {
				
				// Converte la stringa in intero e la imposta al posto del punto interrogativo (?)
				ps.setInt(1, Integer.parseInt(idStudente));

				// executeUpdate() restituisce il numero di righe eliminate
				int righeModificate = ps.executeUpdate();
				
				if (righeModificate > 0) {
					eliminato = true;
				}

			} catch (SQLException e) {
				System.err.println("Errore SQL in AdminDAO - rimuoviDocente: " + e.getMessage());
			} catch (NumberFormatException e) {
				System.err.println("Errore formato ID in AdminDAO - rimuoviStudente. ID inserito: " + idStudente);
			}

			return eliminato;
		}
}
