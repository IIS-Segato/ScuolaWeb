package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;
import model.Annuncio;

public class AnnuncioDAO extends AbstractDAO {
	    private static final String SQL_GET_ALL = "SELECT * FROM annunci";
	    private static final String SQL_GET_BY_ID = "SELECT * FROM annunci WHERE id_annuncio=?";
	    private static final String SQL_GET_BY_AUTORE = "SELECT * FROM annunci WHERE autore=?";
	    private static final String SQL_INSERT = "INSERT INTO annunci (titolo, contenuto, data_pubblicazione, autore) VALUES (?, ?, ?, ?)";
	    private static final String SQL_UPDATE = "UPDATE annunci SET titolo=?, contenuto=?, data_pubblicazione=?, autore=? WHERE id_annuncio=?";
	    private static final String SQL_DELETE = "DELETE FROM annunci WHERE id_annuncio=?";

	public AnnuncioDAO(String xml) throws ClassNotFoundException, JDOMException, IOException {
		super(xml);
	}
	
    public List<Annuncio> getAll() throws Exception {
        List<Annuncio> annunci = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
             ResultSet rs = ps.executeQuery())
        {
            while (rs.next()) {
                Annuncio a = new Annuncio();
                a.setId(rs.getInt("id_annuncio"));
                a.setTitolo(rs.getString("titolo"));
                a.setContenuto(rs.getString("contenuto"));
                a.setData_pubblicazione(rs.getInt("data_pubblicazione"));
                a.setAutore(rs.getInt("autore"));
                annunci.add(a);
            }

        } catch (Exception e) {
            printException(e);
        }

        return annunci;
    }
    
    
}
