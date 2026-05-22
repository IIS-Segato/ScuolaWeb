package utils;

import java.io.File;
import java.io.IOException;

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

	public Config(String xmlurl) {
		this.xmlurl = xmlurl;
	}

	private Element readConfig() throws JDOMException, IOException {
		SAXBuilder saxBuilder = new SAXBuilder();
		Document document = saxBuilder.build(new File(this.xmlurl));
		return document.getRootElement();
	}

	public void loadConfig() throws JDOMException, IOException {
		Element root = readConfig();
		dbType = root.getChildText("dbType").trim();

		Element dbNode = root.getChild("connection").getChild(dbType);
		driver = dbNode.getChildText("driver").trim();
		url = dbNode.getChildText("url").trim();
		user = dbNode.getChildText("user").trim();
		psw = dbNode.getChildText("password").trim();
	}

	public String getQuery(String query) throws JDOMException, IOException {
		Element root = readConfig();
		Element queryNode = root.getChild("query").getChild(dbType);
		return queryNode.getChildText(query).trim();
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
