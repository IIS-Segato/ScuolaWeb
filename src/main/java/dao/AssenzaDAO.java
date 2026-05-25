package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Assenza;

public class AssenzaDAO extends AbstractDAO{
	private static final String SQL_GET_ALL = "SELECT * FROM assenze";
    private static final String SQL_GET_BY_ID = "SELECT * FROM assenze WHERE id_assenza=?";
    private static final String SQL_GET_BY_UTENTE_ID = "SELECT * FROM assenze WHERE id_utente=?";
    private static final String SQL_INSERT = "INSERT INTO assenze (id_utente, data_evento, tipo, ora_evento, giustificata, motivazione, giustificata_da, data_giustifica) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SQL_UPDATE = "UPDATE assenze SET id_utente=?, data_evento=?, tipo=?, ora_evento=?, giustificata=?, motivazione=?, giustificata_da=?, data_giustifica=? WHERE id_assenza=?";
    private static final String SQL_DELETE = "DELETE FROM assenze WHERE id_assenza=?";
    
    public AssenzaDAO(String xml) throws ClassNotFoundException, JDOMException, IOException {
		super(xml);
	}
    
    public List<Assenza> getAll() throws Exception {
        List<Assenza> assenze = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
             ResultSet rs = ps.executeQuery())
        {
            while (rs.next()) {
            	Assenza a = new Assenza();
                a.setId(rs.getInt("id_assenza"));
                a.setId_utente(rs.getInt("id_utente"));
                a.setData_evento(rs.getString("data_evento"));
                a.setTipo(rs.getString("tipo"));
                a.setOra_evento(rs.getString("ora_evento"));
                a.setGiustificata(rs.getBoolean("giustificata"));
                a.setMotivazione(rs.getString("motivazione"));
                a.setGiustificata_da(rs.getInt("giustificata_da"));
                a.setData_giustifica(rs.getString("data_giustifica"));
                assenze.add(a);
            }

        } catch (Exception e) {
            printException(e);
        }

        return assenze;
    }
	
	public Assenza getById(int autore) {
		Assenza a = new Assenza();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_ID))
		{
			ps.setInt(1, autore);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			a.setId(rs.getInt("id_assenza"));
            a.setId_utente(rs.getInt("id_utente"));
            a.setData_evento(rs.getString("data_evento"));
            a.setTipo(rs.getString("tipo"));
            a.setOra_evento(rs.getString("ora_evento"));
            a.setGiustificata(rs.getBoolean("giustificata"));
            a.setMotivazione(rs.getString("motivazione"));
            a.setGiustificata_da(rs.getInt("giustificata_da"));
            a.setData_giustifica(rs.getString("data_giustifica"));
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return a;
	}
	
	public List<Assenza> getByUtenteId(int id) {
		List<Assenza> assenze = new ArrayList<>();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_UTENTE_ID))
		{
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			Assenza a = new Assenza();
			a.setId(rs.getInt("id_assenza"));
            a.setId_utente(rs.getInt("id_utente"));
            a.setData_evento(rs.getString("data_evento"));
            a.setTipo(rs.getString("tipo"));
            a.setOra_evento(rs.getString("ora_evento"));
            a.setGiustificata(rs.getBoolean("giustificata"));
            a.setMotivazione(rs.getString("motivazione"));
            a.setGiustificata_da(rs.getInt("giustificata_da"));
            a.setData_giustifica(rs.getString("data_giustifica"));
            assenze.add(a);
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return assenze;
	}
	
	public boolean insert(int id_utente, String data_evento, String tipo, String ora_evento, boolean giustificata, String motivazione, int giustificata_da, String data_giustifica) {
		boolean isInserted = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_INSERT))
		{

			ps.setInt(1, id_utente);
			ps.setString(2, data_evento);
			ps.setString(3, tipo);
			ps.setString(4, ora_evento);
			ps.setBoolean(5, giustificata);
			ps.setString(6, motivazione);
			ps.setInt(7, giustificata_da);
			ps.setString(8, data_giustifica);
			
			if(ps.executeUpdate() > 0) {
				isInserted = true;
			}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return isInserted;
	}
	
	public boolean update(int id_utente, String data_evento, String tipo, String ora_evento, boolean giustificata, String motivazione, int giustificata_da, String data_giustifica, int id) {
		boolean isUpdated = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_UPDATE))
		{

			ps.setInt(1, id_utente);
			ps.setString(2, data_evento);
			ps.setString(3, tipo);
			ps.setString(4, ora_evento);
			ps.setBoolean(5, giustificata);
			ps.setString(6, motivazione);
			ps.setInt(7, giustificata_da);
			ps.setString(8, data_giustifica);
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
