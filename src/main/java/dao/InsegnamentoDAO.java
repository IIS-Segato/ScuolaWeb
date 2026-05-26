package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Insegnamento;

public class InsegnamentoDAO extends AbstractDAO{
	private static final String SQL_GET_ALL = "SELECT * FROM insegnamenti";
	private static final String SQL_GET_BY_ID = "SELECT * FROM insegnamenti WHERE id_insegnamento=?";
	private static final String SQL_INSERT = "INSERT INTO insegnamenti (id_docente, id_materia, id_classe) VALUES (?, ?, ?)";
	private static final String SQL_UPDATE = "UPDATE insegnamenti SET id_docente=?, id_materia=?, id_classe=? WHERE id_insegnamento=?";
	private static final String SQL_DELETE = "DELETE FROM insegnamenti WHERE id_insegnamento=?";
	private static final String SQL_GET_BY_DOCENTE_PERSONA_ID = 
		    "SELECT i.id_insegnamento, i.id_docente, i.id_classe, i.id_materia, " +
		    "c.anno, c.sezione, c.indirizzo, m.nome AS nome_materia " +
		    "FROM insegnamenti i " +
		    "INNER JOIN classi c ON i.id_classe = c.id_classe " +
		    "INNER JOIN materie m ON i.id_materia = m.id_materia " +
		    "INNER JOIN docenti d ON i.id_docente = d.id_docente " +
		    "WHERE d.id_persona = ?";
	
	public InsegnamentoDAO(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
		super(xml);
	}
	
	public List<Insegnamento> getInsegnamentiByDocentePersonaId(int idPersona) {
        List<Insegnamento> lista = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_DOCENTE_PERSONA_ID)) {
            
            ps.setInt(1, idPersona);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Insegnamento ins = new Insegnamento();
                    
                    // ID della tabella di legame
                    ins.setId(rs.getInt("id_insegnamento"));
                    ins.setId_docente(rs.getInt("id_docente"));
                    ins.setId_classe(rs.getInt("id_classe"));
                    ins.setId_materia(rs.getInt("id_materia"));
                    
                    // Attributi della classe inseriti direttamente
                    ins.setAnno(rs.getInt("anno"));
                    ins.setSezione(rs.getString("sezione"));
                    ins.setIndirizzo(rs.getString("indirizzo"));
                    
                    // Nome della materia
                    ins.setNomeMateria(rs.getString("nome_materia"));
                    
                    lista.add(ins);
                }
            }
        } catch (Exception e) {
            printException(e);
        }
        return lista;
    }
	
	public List<Insegnamento> getAll() throws Exception {
		List<Insegnamento> insegnamenti = new ArrayList<>();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
	         ResultSet rs = ps.executeQuery())
		{
			while (rs.next()) {
				Insegnamento i = new Insegnamento();
                i.setId(rs.getInt("id_insegnamento"));
                i.setId_docente(rs.getInt("id_docente"));
                i.setId_materia(rs.getInt("id_materia"));
                i.setId_classe(rs.getInt("id_classe"));
                insegnamenti.add(i);
            }
			
		} catch (Exception e) {
			printException(e);
		}
		
		return insegnamenti;
	}
	
	public Insegnamento getById(int id) {
		Insegnamento i = new Insegnamento();
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_ID))
		{
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
		while (rs.next()) {
			i.setId(rs.getInt("id_utente"));
            i.setId_docente(rs.getInt("id_docente"));
            i.setId_materia(rs.getInt("id_materia"));
            i.setId_classe(rs.getInt("id_classe"));
		}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return i;
	}
	
	public boolean insert(int id_docente, int id_materia, int id_classe) {
		boolean isInserted = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_INSERT))
		{

			ps.setInt(1, id_docente);
			ps.setInt(2, id_materia);
			ps.setInt(3, id_classe);
			
			if(ps.executeUpdate() > 0) {
				isInserted = true;
			}
			
		} catch (Exception e) {
			printException(e);
		}
		
		return isInserted;
	}
	
	public boolean update(int id_docente, int id_materia, int id_classe, int id) {
		boolean isUpdated = false;
		
		try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(SQL_UPDATE))
		{

			ps.setInt(1, id_docente);
			ps.setInt(2, id_materia);
			ps.setInt(3, id_classe);
			ps.setInt(4, id);
			
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
