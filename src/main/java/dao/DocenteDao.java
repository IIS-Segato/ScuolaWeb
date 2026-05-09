package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Docente;

public class DocenteDao extends AbstractDAO {
    
    // Query SQL basate sulla tua tabella 'docenti'
    private static final String SQL_GET_ALL = "SELECT * FROM docenti";
    private static final String SQL_GET_BY_ID = "SELECT * FROM docenti WHERE id=?";
    private static final String SQL_INSERT = "INSERT INTO docenti (nome, cognome, materia) VALUES (?, ?, ?)";
    private static final String SQL_UPDATE = "UPDATE docenti SET nome=?, cognome=?, materia=? WHERE id=?";
    private static final String SQL_DELETE = "DELETE FROM docenti WHERE id=?";

    public DocenteDao(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
        super(xml);
    }

    /**
     * Recupera tutti i docenti dal database
     */
    public List<Docente> getAll() throws Exception {
        List<Docente> listDocenti = new ArrayList<>();
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Docente d = new Docente();
                d.setId(rs.getInt("id"));
                d.setNome(rs.getString("nome"));
                d.setCognome(rs.getString("cognome"));
                d.setMateria(rs.getString("materia"));
                listDocenti.add(d);
            }

        } catch (Exception e) {
            printException(e);
        }
        
        return listDocenti;
    }

    /**
     * Recupera un singolo docente tramite ID
     */
    public Docente getByID(int id) throws Exception {
        Docente temp = null;
        
        try {
            this.conn = this.getConnection();
            PreparedStatement st = this.conn.prepareStatement(SQL_GET_BY_ID);
            st.setInt(1, id);
            
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                temp = new Docente();
                temp.setId(rs.getInt("id"));
                temp.setNome(rs.getString("nome"));
                temp.setCognome(rs.getString("cognome"));
                temp.setMateria(rs.getString("materia"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        } finally {
            closeConnection();
        }
        
        return temp;
    }

    /**
     * Inserisce un nuovo docente
     */
    public boolean insert(String nome, String cognome, String materia) throws Exception {
        boolean success = false;
        
        try {
            this.conn = this.getConnection();
            PreparedStatement st = this.conn.prepareStatement(SQL_INSERT);
            st.setString(1, nome);
            st.setString(2, cognome);
            st.setString(3, materia);
            
            if (st.executeUpdate() > 0) {
                success = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        } finally {
            closeConnection();
        }
        
        return success;
    }

    /**
     * Aggiorna i dati di un docente esistente
     */
    public boolean update(String nome, String cognome, String materia, int id) throws Exception {
        boolean success = false;
        
        try {
            this.conn = this.getConnection();
            PreparedStatement st = this.conn.prepareStatement(SQL_UPDATE);
            st.setString(1, nome);
            st.setString(2, cognome);
            st.setString(3, materia);
            st.setInt(4, id);
            
            if (st.executeUpdate() > 0) {
                success = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        } finally {
            closeConnection();
        }
        
        return success;
    }

    /**
     * Elimina un docente dal database
     */
    public boolean delete(int id) throws Exception {
        boolean success = false;
        
        try {
            this.conn = this.getConnection();
            PreparedStatement st = this.conn.prepareStatement(SQL_DELETE);
            st.setInt(1, id);
            
            if (st.executeUpdate() > 0) {
                success = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        } finally { 
            closeConnection();
        }
             
        return success;
    }
}



