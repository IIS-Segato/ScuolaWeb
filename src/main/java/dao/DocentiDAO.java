package dao;

import java.io.IOException;
import java.sql.SQLException;

import org.jdom2.JDOMException;

/**
 * Classe DocentiDAO.java per la gestione dei Docenti
 */
public class DocentiDAO extends DAO{
	/**
	 * Costruttore
	 * @param xml
	 * @throws ClassNotFoundException
	 * @throws JDOMException
	 * @throws IOException
	 * @throws SQLException
	 */
	public DocentiDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
	}
}