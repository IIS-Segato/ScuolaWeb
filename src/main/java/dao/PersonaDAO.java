package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

public class PersonaDAO extends AbstractDAO{
	private static final String SQL_GET_ALL = "SELECT * FROM persone";
	private static final String SQL_GET_BY_ID = "SELECT * FROM persone where id_persona=?";
	private static final String SQL_INSERT = "INSERT INTO persone (name, cognome, email, cf, nascita) VALUES (?, ?, ?, ?, ?)";
	private static final String SQL_UPDATE = "UPDATE persone SET name=?, cognome=?, email=?, cf=?, nascita=? WHERE id_persona=?";
	private static final String SQL_DELETE = "DELETE FROM persone WHERE id_persona=?";
	
	public PersonaDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
	}

}
