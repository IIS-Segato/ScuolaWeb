package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                annunci.add(mapRow(rs));
            }
        } catch (Exception e) {
            printException(e);
        }
        return annunci;
    }

    // CORRETTO: Usava SQL_GET_BY_AUTORE ma cercava di tornare un singolo oggetto
    public Annuncio getById(int id) {
        Annuncio a = null;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_ID)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    a = mapRow(rs);
                }
            }
        } catch (Exception e) {
            printException(e);
        }
        return a;
    }

    // CORRETTO: Usava SQL_GET_BY_ID ma doveva usare SQL_GET_BY_AUTORE
    public List<Annuncio> getByIdAutore(int idAutore) {
        List<Annuncio> annunci = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_AUTORE)) {
            ps.setInt(1, idAutore);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    annunci.add(mapRow(rs));
                }
            }
        } catch (Exception e) {
            printException(e);
        }
        return annunci;
    }

    // Metodo helper per evitare ripetizioni
    private Annuncio mapRow(ResultSet rs) throws Exception {
        Annuncio a = new Annuncio();
        a.setId(rs.getInt("id_annuncio"));
        a.setTitolo(rs.getString("titolo"));
        a.setContenuto(rs.getString("contenuto"));
        // NOTA: Se nel database è DATE, usa rs.getString per evitare errori di conversione
        a.setData_pubblicazione(rs.getString("data_pubblicazione")); 
        a.setAutore(rs.getInt("autore"));
        return a;
    }

    // Gli altri metodi (insert, update, delete) sono corretti come li avevi scritti
    public boolean insert(String titolo, String contenuto, String data_pubblicazione, int autore) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_INSERT)) {
            ps.setString(1, titolo);
            ps.setString(2, contenuto);
            ps.setString(3, data_pubblicazione);
            ps.setInt(4, autore);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            printException(e);
            return false;
        }
    }
    
    public boolean update(String titolo, String contenuto, String data_pubblicazione, int autore, int id) {
    	boolean isUpdated = false;
    	
    	try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_UPDATE))
    	{

    		ps.setString(1, titolo);
    		ps.setString(2, contenuto);
    		ps.setString(3, data_pubblicazione);
    		ps.setInt(4, autore);
    		ps.setInt(5, id);
    		
    		if(ps.executeUpdate() > 0) {
    			isUpdated = true;
    		}
    		
    	} catch (Exception e) {
    		printException(e);
    	}
    	
    	return isUpdated;
    }

    public boolean delete(int id) {
    	boolean isDeleted = false;
    	
    	try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_DELETE))
    	{

    		ps.setInt(1, id);
    		
    		if(ps.executeUpdate() > 0) {
    			isDeleted = true;
    		}
    		
    	} catch (Exception e) {
    		printException(e);
    	}
    	
    	return isDeleted;
    }
}
