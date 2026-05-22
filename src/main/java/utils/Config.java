package utils;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;

public class Config {

	private String driver;
	private String url;
	private String user;
	private String psw;
	private String dbType;
	private final String xmlurl;

	public Config(String xmlurl) throws MalformedURLException {
		this.xmlurl = xmlurl;
	}

	private Element readConfig() throws JDOMException, IOException {
		SAXBuilder saxBuilder = new SAXBuilder();
		Document document = saxBuilder.build(new File(this.xmlurl));
		return document.getRootElement();
	}

	// Legge da dbcfg.xml i dati necessari alla connessione.
	public void loadConfig() throws JDOMException, IOException {
		Element root = readConfig();
		dbType = root.getChildText("dbType");
		Element mysql = root.getChild("connection").getChild(dbType);
		driver = mysql.getChildText("driver").trim();
		url = mysql.getChildText("url").trim();
		user = mysql.getChildText("user").trim();
		psw = mysql.getChildText("password").trim();
	}

	public String getQuery(String query) throws JDOMException, IOException {
		if (dbType == null) {
			loadConfig();
		}

		Element root = readConfig();
		Element mysql = root.getChild("query").getChild(dbType);
		return mysql.getChildText(query).trim();
	}

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
}
