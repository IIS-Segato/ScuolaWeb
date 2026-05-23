package dao;

import java.io.IOException;
<<<<<<< HEAD
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Studente;

public class StudenteDao extends AbstractDAO {
    private static final String SQL_GET_ALL = "SELECT * FROM studenti";
    private static final String SQL_GET_BY_ID = "SELECT * FROM studenti WHERE id=?";
    private static final String SQL_INSERT = "INSERT INTO studenti (nome, cognome, classe) VALUES (?, ?, ?)";
    private static final String SQL_UPDATE = "UPDATE studenti SET nome=?, cognome=?, classe=? WHERE id=?";
    private static final String SQL_DELETE = "DELETE FROM studenti WHERE id=?";

    public StudenteDao(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
        super(xml);
    }

    //prova
    public List<Studente> getAll() throws Exception {
        List<Studente> listStudenti = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Studente s = new Studente();
                s.setId(rs.getInt("id"));
                s.setNome(rs.getString("nome"));
                s.setCognome(rs.getString("cognome"));
                s.setClasse(rs.getString("classe"));
                listStudenti.add(s);
            }
        } catch (Exception e) {
            printException(e);    
        }
        return listStudenti;
    }

    public Studente getByID(int id) throws Exception {
        Studente temp = null;
        try {
            this.conn = this.getConnection();
            PreparedStatement st = this.conn.prepareStatement(SQL_GET_BY_ID);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                temp = new Studente();
                temp.setId(rs.getInt("id"));
                temp.setNome(rs.getString("nome"));
                temp.setCognome(rs.getString("cognome"));
                temp.setClasse(rs.getString("classe"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        } finally {
            if (this.conn != null) this.conn.close();
        }
        return temp;
    }

    public boolean insert(String nome, String cognome, String classe) throws Exception {
        boolean insert = false;
        try {
            this.conn = this.getConnection();
            PreparedStatement st = this.conn.prepareStatement(SQL_INSERT);
            st.setString(1, nome);
            st.setString(2, cognome);
            st.setString(3, classe);
            if (st.executeUpdate() > 0) {
                insert = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        } finally {
            if (this.conn != null) this.conn.close();
        }
        return insert;
    }

    public boolean update(String nome, String cognome, String classe, int id) throws Exception {
        boolean update = false;
        try {
            this.conn = this.getConnection();
            PreparedStatement st = this.conn.prepareStatement(SQL_UPDATE);
            st.setString(1, nome);
            st.setString(2, cognome);
            st.setString(3, classe);
            st.setInt(4, id);
            if (st.executeUpdate() > 0) {
                update = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        } finally {
            if (this.conn != null) this.conn.close();
        }
        return update;
    }

    public boolean delete(int id) throws Exception {
        boolean update = false;
        try {
            this.conn = this.getConnection();
            PreparedStatement st = this.conn.prepareStatement(SQL_DELETE);
            st.setInt(1, id);
            if (st.executeUpdate() > 0) {
                update = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        } finally {
            if (this.conn != null) this.conn.close();
        }
        return update;
=======
import java.sql.*;
import java.util.*;
import org.jdom2.JDOMException;
import model.Studente;

public class StudenteDao extends AbstractDAO {

    private static final String SQL_GET_ALL  = "SELECT * FROM studenti ORDER BY cognome, nome";
    private static final String SQL_GET_BY_ID = "SELECT * FROM studenti WHERE id=?";
    private static final String SQL_INSERT   = "INSERT INTO studenti (nome, cognome, classe) VALUES (?,?,?)";
    private static final String SQL_UPDATE   = "UPDATE studenti SET nome=?, cognome=?, classe=? WHERE id=?";
    private static final String SQL_DELETE   = "DELETE FROM studenti WHERE id=?";

    public StudenteDao(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
        super(xml);
    }

    public List<Studente> getAll() throws Exception {
        List<Studente> list = new ArrayList<>();
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(SQL_GET_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Studente s = new Studente();
                s.setId(rs.getInt("id"));
                s.setNome(rs.getString("nome"));
                s.setCognome(rs.getString("cognome"));
                s.setClasse(rs.getString("classe"));
                list.add(s);
            }
        } catch (Exception e) { printException(e); }
        return list;
    }

    public Studente getByID(int id) throws Exception {
        Studente s = null;
        try {
            this.conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_ID);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                s = new Studente();
                s.setId(rs.getInt("id"));
                s.setNome(rs.getString("nome"));
                s.setCognome(rs.getString("cognome"));
                s.setClasse(rs.getString("classe"));
            }
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally { closeConnection(); }
        return s;
    }

    public boolean insert(String nome, String cognome, String classe) throws Exception {
        boolean ok = false;
        try {
            this.conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(SQL_INSERT);
            ps.setString(1, nome);
            ps.setString(2, cognome);
            ps.setString(3, classe);
            ok = ps.executeUpdate() > 0;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally { closeConnection(); }
        return ok;
    }

    public boolean update(String nome, String cognome, String classe, int id) throws Exception {
        boolean ok = false;
        try {
            this.conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(SQL_UPDATE);
            ps.setString(1, nome);
            ps.setString(2, cognome);
            ps.setString(3, classe);
            ps.setInt(4, id);
            ok = ps.executeUpdate() > 0;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally { closeConnection(); }
        return ok;
    }

    public boolean delete(int id) throws Exception {
        boolean ok = false;
        try {
            this.conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(SQL_DELETE);
            ps.setInt(1, id);
            ok = ps.executeUpdate() > 0;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally { closeConnection(); }
        return ok;
>>>>>>> branch 'De-Col' of https://github.com/IIS-Segato/ScuolaWeb.git
    }
}