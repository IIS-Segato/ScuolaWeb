package dao;

import java.io.IOException;
import java.sql.SQLException;

import org.jdom2.JDOMException;

public class StudentiDAO extends DAO{

	public StudentiDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
		
	}

}
