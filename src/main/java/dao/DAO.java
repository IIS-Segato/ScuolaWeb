package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.jdom2.JDOMException;

import utils.Config;


/**
 * Classe DAO.java che gestisce la comunicazione con il db
 * @author Mathias Dal Zotto
 */
public class DAO {
	// Attributi
	private Connection conn;
	private Config conf;

	/**
	 * Costruttore
	 * @param xml
	 * @throws ClassNotFoundException
	 * @throws JDOMException
	 * @throws IOException
	 * @throws SQLException
	 */
	public DAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		this.conf = new Config(xml);
		this.conn = this.connect(xml);
	}

	/**
	 * Funzione che crea la connessione col db
	 * @param xml
	 * @return conn
	 * @throws JDOMException
	 * @throws IOException
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	private Connection connect(String xml) throws JDOMException, IOException, ClassNotFoundException, SQLException {
		// carico il file di configurazione
		this.conf.loadConfig();
		
		// leggo i parametri
		String driver = this.conf.getDriver();
		String url = this.conf.getUrl();
		String user = this.conf.getUser();
		String password = this.conf.getPassword();
		
		// installo i driver e creo la connessione col db
		Class.forName(driver);
		return DriverManager.getConnection(url + "&user=" + user + "&password=" + password);
	}
	
	// Funzione per chiusura della connessione
	public void closeConn() throws SQLException {
		this.conn.close();
	}

	// Getter
	public Connection getConn() {
		return this.conn;
	}
	
	public Config getConf() {
		return this.conf;
	}
}