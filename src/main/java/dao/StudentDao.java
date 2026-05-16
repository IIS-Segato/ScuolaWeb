package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Student;

public class StudentDao extends AbstractDAO {

    private static final String SQL_GET_ALL = "SELECT * FROM students ORDER BY surname, name";
    private static final String SQL_GET_BY_ID = "SELECT * FROM students WHERE id=?";
    private static final String SQL_INSERT = "INSERT INTO students (name, surname, class_name) VALUES (?, ?, ?)";
    private static final String SQL_UPDATE = "UPDATE students SET name=?, surname=?, class_name=? WHERE id=?";
    private static final String SQL_DELETE = "DELETE FROM students WHERE id=?";

    public StudentDao(String xml) throws ClassNotFoundException, JDOMException, IOException, SQLException {
        super(xml);
    }

    public List<Student> getAll() throws Exception {
        List<Student> listStudents = new ArrayList<Student>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Student s = new Student();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setSurname(rs.getString("surname"));
                s.setClassName(rs.getString("class_name"));

                listStudents.add(s);
            }

        } catch (Exception e) {
            printException(e);
        }

        return listStudents;
    }

    public Student getByID(int id) throws Exception {
        Student temp = null;

        try {
            this.conn = this.getConnection();

            PreparedStatement st = this.conn.prepareStatement(SQL_GET_BY_ID);
            st.setInt(1, id);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                temp = new Student();
                temp.setId(rs.getInt("id"));
                temp.setName(rs.getString("name"));
                temp.setSurname(rs.getString("surname"));
                temp.setClassName(rs.getString("class_name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());

        } finally {
            if (this.conn != null) {
                this.conn.close();
            }
        }

        return temp;
    }

    public boolean insert(String name, String surname, String className) throws Exception {
        boolean insert = false;

        try {
            this.conn = this.getConnection();

            PreparedStatement st = this.conn.prepareStatement(SQL_INSERT);

            st.setString(1, name);
            st.setString(2, surname);
            st.setString(3, className);

            if (st.executeUpdate() > 0) {
                insert = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());

        } finally {
            if (this.conn != null) {
                this.conn.close();
            }
        }

        return insert;
    }

    public boolean update(String name, String surname, String className, int id) throws Exception {
        boolean update = false;

        try {
            this.conn = this.getConnection();

            PreparedStatement st = this.conn.prepareStatement(SQL_UPDATE);

            st.setString(1, name);
            st.setString(2, surname);
            st.setString(3, className);
            st.setInt(4, id);

            if (st.executeUpdate() > 0) {
                update = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());

        } finally {
            if (this.conn != null) {
                this.conn.close();
            }
        }

        return update;
    }

    public boolean delete(int id) throws Exception {
        boolean delete = false;

        try {
            this.conn = this.getConnection();

            PreparedStatement st = this.conn.prepareStatement(SQL_DELETE);

            st.setInt(1, id);

            if (st.executeUpdate() > 0) {
                delete = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());

        } finally {
            if (this.conn != null) {
                this.conn.close();
            }
        }

        return delete;
    }
}