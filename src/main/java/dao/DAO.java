package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import org.jdom2.JDOMException;
import utils.Config;

public class DAO {

	protected Connection conn;
	protected Config config;

	public DAO(String xmlurl) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		// iniziallizo il confing
		this.config = new Config(xmlurl);

		// carico il confing
		this.config.loadConfig();

		// apro la connesione
		this.conn = openConnection();
	}

	// metodo per aprire la connesione
	private Connection openConnection() throws SQLException {
		// Recuperiamo i dati già caricati in config
		String url = this.config.getDbUrl();
		String user = this.config.getUser();
		String psw = this.config.getPassword();

		// Stampa di log per vedere se funziona effetivamente
		System.out.println("Tentativo di connessione a: " + url + " come utente: " + user);

		return DriverManager.getConnection(url, user, psw);
	}
	// metodo per chiudere la connesione
	public void closeConnection() {
        try {
            if (this.conn != null && !this.conn.isClosed()) {
                this.conn.close();
                System.out.println("Connessione al database chiusa con successo.");
            }
        } catch (SQLException e) {
            System.err.println("Errore durante la chiusura della connessione: " + e.getMessage());
        }
    }

	// metodo utile per le sottoclassi per aprire le connessioni
	public Connection getConnection() {
		return this.conn;
	}

	// metodo main di test
	public static void main(String[] args) {
		// Percorso relativo al file di configurazione
		String path = "WebContent/WEB-INF/dbcfg.xml";
		try {
			// tentativo di istanza del DAO
			DAO testDao = new DAO(path);
			if (testDao.conn != null && !testDao.conn.isClosed()) {
				System.out.println("************************************");
				System.out.println("CONNESSIONE RIUSCITA CON SUCCESSO!");
				System.out.println("Database: " + testDao.conn.getMetaData().getDatabaseProductName());
				System.out.println("Versione: " + testDao.conn.getMetaData().getDatabaseProductVersion());
				System.out.println("************************************");
				testDao.conn.close();
			}

		} catch (ClassNotFoundException e) {
			System.err.println("ERRORE: Driver JDBC non trovato. Controlla di aver aggiunto il JAR alle librerie.");
		} catch (SQLException e) {
			System.err.println("ERRORE SQL: Impossibile connettersi al database.");
			System.err.println("Dettaglio: " + e.getMessage());
		} catch (IOException e) {
			System.err.println("ERRORE IO: File non trovato al percorso: " + path);
		} catch (JDOMException e) {
			System.err.println("ERRORE XML: Il file dbcfg.xml non è formattato correttamente.");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
