package utils;

import java.io.IOException;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;


/**
 * Classe Config.java per la configurazione per l'applicazione
 */
public class Config {
	// Attributi
	private String xml;
	private String driver, url, user, password;
	private String insertStudente;
	private String insertDocente;
	private String checkAmministratore;
	private String checkStudente;
	private String checkDocente;
	private String getStudenti;
	private String getDocenti;
	private String getDocente;
	private String getAmministratore;
	private String getStudente;
	private String getStudentiByClasse;
	private String getClassiByDocente;
	private String getClassi;
	private String getMaterieClasse;
	private String getMateriaByClasseDocente;
	private String getClasseByCid;
	private String insertVoto;
	private String getVotiByStudenteMateria;
	private String deleteVoto;
	
	/**
	 * Costruttore
	 * @param path dell'xml di configurazione
	 */
	public Config(String xml) {
		super();
		this.xml = xml;
	}

	/**
	 * Funzione che restituisce l'Element root del file xml
	 * @return root
	 * @throws JDOMException
	 * @throws IOException
	 */
	private Element readConfig() throws JDOMException, IOException {
		SAXBuilder saxBuilder = new SAXBuilder();
		Document document = saxBuilder.build(this.xml);
		return document.getRootElement();
	}

	/**
	 * Funzione che carica i parametri di configurazione
	 * @throws IOException
	 * @throws JDOMException
	 */
	public void loadConfig() throws JDOMException, IOException {
		// db
		Element root = readConfig();
		Element connection = root.getChild("connection");
		this.driver = connection.getChildText("driver").trim();
		this.url = connection.getChildText("url").trim();
		this.user = connection.getChildText("user").trim();
		this.password = connection.getChildText("password").trim();
		
		// query
		Element query = root.getChild("query");
		this.insertStudente = query.getChildText("insertStudente").trim();
		this.insertDocente = query.getChildText("insertDocente").trim();
		this.checkAmministratore = query.getChildText("checkAmministratore").trim();
		this.checkStudente = query.getChildText("checkStudente").trim();
		this.checkDocente = query.getChildText("checkDocente").trim();
		this.getStudenti = query.getChildText("getStudenti").trim();
		this.getDocenti = query.getChildText("getDocenti").trim();
		this.getDocente = query.getChildText("getDocente").trim();
		this.getAmministratore = query.getChildText("getAmministratore").trim();
		this.getStudente = query.getChildText("getStudente").trim();
		this.getStudentiByClasse = query.getChildText("getStudentiByClasse").trim();
		this.getClassiByDocente = query.getChildText("getClassiByDocente").trim();
		this.getClassi = query.getChildText("getClassi").trim();
		this.getMaterieClasse = query.getChildText("getMaterieClasse").trim();
		this.getMateriaByClasseDocente = query.getChildText("getMateriaByClasseDocente").trim();
		this.getClasseByCid = query.getChildText("getClasseByCid").trim();
		this.insertVoto = query.getChildText("insertVoto").trim();
		this.getVotiByStudenteMateria = query.getChildText("getVotiByStudenteMateria").trim();
		this.deleteVoto = query.getChildText("deleteVoto").trim();
	}

	// Getter degli attributi
	public String getDriver() {
		return driver;
	}

	public String getUrl() {
		return url;
	}

	public String getInsertStudente() {
		return insertStudente;
	}

	public String getInsertDocente() {
		return insertDocente;
	}

	public String getCheckAmministratore() {
		return checkAmministratore;
	}

	public String getCheckStudente() {
		return checkStudente;
	}

	public String getCheckDocente() {
		return checkDocente;
	}

	public String getUser() {
		return user;
	}

	public String getPassword() {
		return password;
	}

	public String getStudenti() {
		return getStudenti;
	}

	public String getDocenti() {
		return getDocenti;
	}
	
	public String getDocente() {
		return getDocente;
	}

	public String getAmministratore() {
		return getAmministratore;
	}

	public String getStudente() {
		return getStudente;
	}	
	
	public String getStudentiByClasse() {
		return getStudentiByClasse;
	}
	
	public String getClassiByDocente() {
		return getClassiByDocente;
	}
	
	public String getClassi() {
		return getClassi;
	}

	public String getMaterieClasse() {
		return getMaterieClasse;
	}
	
	public String getMateriaByClasseDocente() {
		return getMateriaByClasseDocente;
	}
	
	public String getClasseByCid() {
		return getClasseByCid;
	}
	
	public String insertVoto() {
		return insertVoto;
	}
	
	public String getVotiByStudenteMateria() {
		return getVotiByStudenteMateria;
	}
	
	public String deleteVoto() {
		return deleteVoto;
	}
}