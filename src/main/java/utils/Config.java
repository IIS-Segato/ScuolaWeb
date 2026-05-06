package utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;

//classe confing per il collegamento al database e l ottenimento di querys dal file dbcfg.xml
public class Config {

	private String driver;
	private String url;
	private String user;
	private String psw;
	private final String xmlurl;
	private Element rootElement;

	public Config(String inputStream) {
		this.xmlurl = inputStream;
		try {
			// Carichiamo tutto all'avvio dell'oggetto
			loadConfig();
		} catch (Exception e) {
			System.err.println("Errore fatale nel caricamento configurazione: " + e.getMessage());
		}
	}

	public void loadConfig() throws JDOMException, IOException, ClassNotFoundException {
		// Leggiamo il file una volta sola
		SAXBuilder saxBuilder = new SAXBuilder();
		Document document = saxBuilder.build(new File(this.xmlurl));
		this.rootElement = document.getRootElement();

		// Estraiamo i dati di connessione
		String dbType = rootElement.getChildText("dbType");
		Element conn = rootElement.getChild("connection").getChild(dbType);

		this.driver = conn.getChildText("driver").trim();
		this.url = conn.getChildText("url").trim();
		this.user = conn.getChildText("user").trim();
		this.psw = conn.getChildText("password").trim();

		// Carichiamo il Driver JDBC in memoria (una sola volta)
		Class.forName(this.driver);
		System.out.println("Driver JDBC caricato con successo: " + this.driver);
	}

	// metodo per ottenere le query
	public String getQuery(String tabella, String azione) {
		Element queryTag = rootElement.getChild("query").getChild(tabella);
		return queryTag.getChildText(azione).trim();
	}

	// metodo per ottenere le query di login
	public String getQueryLogin(String tipoUtente) {
		Element login = rootElement.getChild("query").getChild("login");
		return login.getChildText(tipoUtente).trim();
	}

	// Getter classici...
	public String getDriver() {
		return driver;
	}

	public String getDbUrl() {
		return url;
	}

	public String getUser() {
		return user;
	}

	public String getPassword() {
		return psw;
	}

	public static void main(String[] args) {
		// Percorso relativo: parte dalla cartella radice del progetto
		String pathRelativo = "WebContent/WEB-INF/dbcfg.xml";

		Config conf = new Config(pathRelativo);

		try {
			System.out.println("--- Avvio Test Config ---");
			conf.loadConfig();

			// Test parametri connessione
			System.out.println("Connessione a: " + conf.getDbUrl());

			// Test Query
			String sqlStudenti = conf.getQuery("studenti", "select");
			System.out.println("SQL Studenti: " + sqlStudenti);

			// Test Login
			String sqlLogin = conf.getQueryLogin("admin");
			System.out.println("SQL Login Admin: " + sqlLogin);

			System.out.println("--- Test Completato ---");

		} catch (FileNotFoundException e) {
			System.err.println("Errore: Il file XML non è stato trovato al percorso: " + pathRelativo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}