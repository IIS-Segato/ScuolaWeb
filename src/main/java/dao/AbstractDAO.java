package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

import org.jdom2.JDOMException;

import utils.Config;

public abstract class AbstractDAO {

	protected Config cfg;

	public AbstractDAO(String xml) throws ClassNotFoundException, JDOMException, IOException {
		this.cfg = new Config(xml);
	}

	protected Connection getConnection() throws Exception {
		cfg.loadConfig();
		Class.forName(cfg.getDriver());
		return DriverManager.getConnection(
				cfg.getDbUrl(),
				cfg.getUser(),
				cfg.getPassword());
	}

	protected void printException(Exception ex) {
		ex.printStackTrace();
	}
}
