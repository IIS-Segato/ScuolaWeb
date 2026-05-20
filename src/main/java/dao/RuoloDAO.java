package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Ruolo;

public class RuoloDAO extends AbstractDAO{
	private static final String SQL_GET_ALL = "SELECT * FROM ruoli";
	private static final String SQL_GET_BY_ID = "SELECT * FROM ruoli WHERE id_ruolo=?";
	private static final String SQL_GET_BY_NOME_RUOLO = "SELECT * FROM ruoli WHERE nome_ruolo=?";
	private static final String SQL_INSERT = "INSERT INTO ruoli (nome_ruolo, gestione_utenti, voti_modifica_tutti, voti_visualizza_tutti, voti_modifica_propri, voti_visualizza_propri, voti_visualizza_classe, orario_modifica, orario_visualizza, aule_modifica, aule_visualizza, bacheca_pubblica, bacheca_visualizza, dati_visualizza, assenze_inserimento, assenze_visualizza_classe, assenze_visualizza_proprie, assenze_giustifica, assenze_approva_giustifica) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String SQL_UPDATE = "UPDATE ruoli SET nome_ruolo = ?, gestione_utenti = ?, voti_modifica_tutti = ?, voti_visualizza_tutti = ?, voti_modifica_propri = ?, voti_visualizza_propri = ?, voti_visualizza_classe = ?, orario_modifica = ?, orario_visualizza = ?, aule_modifica = ?, aule_visualizza = ?, bacheca_pubblica = ?, bacheca_visualizza = ?, dati_visualizza = ?, assenze_inserimento = ?, assenze_visualizza_classe = ?, assenze_visualizza_proprie = ?, assenze_giustifica = ?, assenze_approva_giustifica = ? WHERE id_ruolo=?";
	private static final String SQL_DELETE = "DELETE FROM ruoli WHERE id_ruolo=?";
	
	public RuoloDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
	}
	
	public List<Ruolo> getAll() throws Exception {
		List<Ruolo> ruoli = new ArrayList<>();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
	         ResultSet rs = ps.executeQuery())
		{
			while (rs.next()) {
				Ruolo r = new Ruolo();
				r.setId(rs.getInt("id_ruolo"));
                r.setNome_ruolo(rs.getString("nome_ruolo"));
                r.setGestione_utenti(rs.getBoolean("gestione_utenti"));
                r.setVoti_modifica_tutti(rs.getBoolean("voti_modifica_tutti"));
                r.setVoti_visualizza_tutti(rs.getBoolean("voti_visualizza_tutti"));
                r.setVoti_modifica_propri(rs.getBoolean("voti_modifica_propri"));
                r.setVoti_visualizza_propri(rs.getBoolean("voti_visualizza_propri"));
                r.setVoti_visualizza_classe(rs.getBoolean("voti_visualizza_classe"));
                r.setOrario_modifica(rs.getBoolean("orario_modifica"));
                r.setOrario_visualizza(rs.getBoolean("orario_visualizza"));
                r.setAule_modifica(rs.getBoolean("aule_modifica"));
                r.setAule_visualizza(rs.getBoolean("aule_visualizza"));
                r.setBacheca_pubblica(rs.getBoolean("bacheca_pubblica"));
                r.setBacheca_visualizza(rs.getBoolean("bacheca_visualizza"));
                r.setDati_visualizza(rs.getBoolean("dati_visualizza"));
                r.setAssenze_inserimento(rs.getBoolean("assenze_inserimento"));
                r.setAssenze_visualizza_classe(rs.getBoolean("assenze_visualizza_classe"));
                r.setAssenze_visualizza_proprie(rs.getBoolean("assenze_visualizza_proprie"));
                r.setAssenze_giustifica(rs.getBoolean("assenze_giustifica"));
                r.setAssenze_approva_giustifica(rs.getBoolean("assenze_approva_giustifica"));
                ruoli.add(r);
            }
			
		} catch (Exception e) {
			printException(e);
		}
		
		return ruoli;
	}
	
	public Ruolo getById(int id) {
		Ruolo r = new Ruolo();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_ID))
		{
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			r.setId(rs.getInt("id_ruolo"));
            r.setNome_ruolo(rs.getString("nome_ruolo"));
            r.setGestione_utenti(rs.getBoolean("gestione_utenti"));
            r.setVoti_modifica_tutti(rs.getBoolean("voti_modifica_tutti"));
            r.setVoti_visualizza_tutti(rs.getBoolean("voti_visualizza_tutti"));
            r.setVoti_modifica_propri(rs.getBoolean("voti_modifica_propri"));
            r.setVoti_visualizza_propri(rs.getBoolean("voti_visualizza_propri"));
            r.setVoti_visualizza_classe(rs.getBoolean("voti_visualizza_classe"));
            r.setOrario_modifica(rs.getBoolean("orario_modifica"));
            r.setOrario_visualizza(rs.getBoolean("orario_visualizza"));
            r.setAule_modifica(rs.getBoolean("aule_modifica"));
            r.setAule_visualizza(rs.getBoolean("aule_visualizza"));
            r.setBacheca_pubblica(rs.getBoolean("bacheca_pubblica"));
            r.setBacheca_visualizza(rs.getBoolean("bacheca_visualizza"));
            r.setDati_visualizza(rs.getBoolean("dati_visualizza"));
            r.setAssenze_inserimento(rs.getBoolean("assenze_inserimento"));
            r.setAssenze_visualizza_classe(rs.getBoolean("assenze_visualizza_classe"));
            r.setAssenze_visualizza_proprie(rs.getBoolean("assenze_visualizza_proprie"));
            r.setAssenze_giustifica(rs.getBoolean("assenze_giustifica"));
            r.setAssenze_approva_giustifica(rs.getBoolean("assenze_approva_giustifica"));
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return r;
	}
	
	public Ruolo getByNomeRuolo(String nome) {
		Ruolo r = new Ruolo();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_NOME_RUOLO))
		{
			ps.setString(1, nome);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			r.setId(rs.getInt("id_ruolo"));
            r.setNome_ruolo(rs.getString("nome_ruolo"));
            r.setGestione_utenti(rs.getBoolean("gestione_utenti"));
            r.setVoti_modifica_tutti(rs.getBoolean("voti_modifica_tutti"));
            r.setVoti_visualizza_tutti(rs.getBoolean("voti_visualizza_tutti"));
            r.setVoti_modifica_propri(rs.getBoolean("voti_modifica_propri"));
            r.setVoti_visualizza_propri(rs.getBoolean("voti_visualizza_propri"));
            r.setVoti_visualizza_classe(rs.getBoolean("voti_visualizza_classe"));
            r.setOrario_modifica(rs.getBoolean("orario_modifica"));
            r.setOrario_visualizza(rs.getBoolean("orario_visualizza"));
            r.setAule_modifica(rs.getBoolean("aule_modifica"));
            r.setAule_visualizza(rs.getBoolean("aule_visualizza"));
            r.setBacheca_pubblica(rs.getBoolean("bacheca_pubblica"));
            r.setBacheca_visualizza(rs.getBoolean("bacheca_visualizza"));
            r.setDati_visualizza(rs.getBoolean("dati_visualizza"));
            r.setAssenze_inserimento(rs.getBoolean("assenze_inserimento"));
            r.setAssenze_visualizza_classe(rs.getBoolean("assenze_visualizza_classe"));
            r.setAssenze_visualizza_proprie(rs.getBoolean("assenze_visualizza_proprie"));
            r.setAssenze_giustifica(rs.getBoolean("assenze_giustifica"));
            r.setAssenze_approva_giustifica(rs.getBoolean("assenze_approva_giustifica"));
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return r;
	}
	
	public boolean insert(String nome_ruolo, 
							boolean gestione_utenti,
							boolean voti_modifica_tutti,
							boolean voti_visualizza_tutti,
							boolean voti_modifica_propri,
							boolean voti_visualizza_propri,
							boolean voti_visualizza_classe,
							boolean orario_modifica,
							boolean orario_visualizza,
							boolean aule_modifica,
							boolean aule_visualizza,
							boolean bacheca_pubblica,
							boolean bacheca_visualizza,
							boolean dati_visualizza,
							boolean assenze_inserimento,
							boolean assenze_visualizza_classe,
							boolean assenze_visualizza_proprie,
							boolean assenze_giustifica,
							boolean assenze_approva_giustifica) {
		boolean isInserted = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_INSERT))
		{

			ps.setString(1, nome_ruolo);
			ps.setBoolean(2, gestione_utenti);
			ps.setBoolean(3, voti_modifica_tutti);
			ps.setBoolean(4, voti_visualizza_tutti);
			ps.setBoolean(5, voti_modifica_propri);
			ps.setBoolean(6, voti_visualizza_propri);
			ps.setBoolean(7, voti_visualizza_classe);
			ps.setBoolean(8, orario_modifica);
			ps.setBoolean(9, orario_visualizza);
			ps.setBoolean(10, aule_modifica);
			ps.setBoolean(11, aule_visualizza);
			ps.setBoolean(12, bacheca_pubblica);
			ps.setBoolean(13, bacheca_visualizza);
			ps.setBoolean(14, dati_visualizza);
			ps.setBoolean(15, assenze_inserimento);
			ps.setBoolean(16, assenze_visualizza_classe);
			ps.setBoolean(17, assenze_visualizza_proprie);
			ps.setBoolean(18, assenze_giustifica);
			ps.setBoolean(19, assenze_approva_giustifica);
			
			if(ps.executeUpdate() > 0) {
				isInserted = true;
			}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return isInserted;
	}
	
	public boolean update(String nome_ruolo, 
							boolean gestione_utenti,
							boolean voti_modifica_tutti,
							boolean voti_visualizza_tutti,
							boolean voti_modifica_propri,
							boolean voti_visualizza_propri,
							boolean voti_visualizza_classe,
							boolean orario_modifica,
							boolean orario_visualizza,
							boolean aule_modifica,
							boolean aule_visualizza,
							boolean bacheca_pubblica,
							boolean bacheca_visualizza,
							boolean dati_visualizza,
							boolean assenze_inserimento,
							boolean assenze_visualizza_classe,
							boolean assenze_visualizza_proprie,
							boolean assenze_giustifica,
							boolean assenze_approva_giustifica,
							int id) {
		boolean isUpdated = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_UPDATE))
		{

			ps.setString(1, nome_ruolo);
			ps.setBoolean(2, gestione_utenti);
			ps.setBoolean(3, voti_modifica_tutti);
			ps.setBoolean(4, voti_visualizza_tutti);
			ps.setBoolean(5, voti_modifica_propri);
			ps.setBoolean(6, voti_visualizza_propri);
			ps.setBoolean(7, voti_visualizza_classe);
			ps.setBoolean(8, orario_modifica);
			ps.setBoolean(9, orario_visualizza);
			ps.setBoolean(10, aule_modifica);
			ps.setBoolean(11, aule_visualizza);
			ps.setBoolean(12, bacheca_pubblica);
			ps.setBoolean(13, bacheca_visualizza);
			ps.setBoolean(14, dati_visualizza);
			ps.setBoolean(15, assenze_inserimento);
			ps.setBoolean(16, assenze_visualizza_classe);
			ps.setBoolean(17, assenze_visualizza_proprie);
			ps.setBoolean(18, assenze_giustifica);
			ps.setBoolean(19, assenze_approva_giustifica);
			ps.setInt(20, id);
			
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
