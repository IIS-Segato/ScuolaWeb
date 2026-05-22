package dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.JDOMException;

import model.Student;

public class StudentDao extends AbstractDAO {

	private static final String SQL_GET_ALL =
			"SELECT * FROM students ORDER BY surname, name";
	private static final String SQL_GET_BY_ID =
			"SELECT * FROM students WHERE id=?";
	private static final String SQL_INSERT =
			"INSERT INTO students (name, surname, class_name) VALUES (?, ?, ?)";
	private static final String SQL_UPDATE =
			"UPDATE students SET name=?, surname=?, class_name=? WHERE id=?";
	private static final String SQL_DELETE =
			"DELETE FROM students WHERE id=?";

	public StudentDao(String xml) throws ClassNotFoundException, JDOMException, IOException {
		super(xml);
	}

	public List<Student> getAll() throws Exception {
		List<Student> students = new ArrayList<>();

		try (Connection conn = getConnection();
			 PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
			 ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Student student = new Student();
				student.setId(rs.getInt("id"));
				student.setName(rs.getString("name"));
				student.setSurname(rs.getString("surname"));
				student.setClassName(rs.getString("class_name"));
				students.add(student);
			}
		} catch (Exception e) {
			printException(e);
			throw new Exception(e.getMessage(), e);
		}

		return students;
	}

	public Student getByID(int id) throws Exception {
		Student student = null;

		try (Connection conn = getConnection();
			 PreparedStatement ps = conn.prepareStatement(SQL_GET_BY_ID)) {

			ps.setInt(1, id);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					student = new Student();
					student.setId(rs.getInt("id"));
					student.setName(rs.getString("name"));
					student.setSurname(rs.getString("surname"));
					student.setClassName(rs.getString("class_name"));
				}
			}
		} catch (Exception e) {
			printException(e);
			throw new Exception(e.getMessage(), e);
		}

		return student;
	}

	public boolean insert(String name, String surname, String className) throws Exception {
		try (Connection conn = getConnection();
			 PreparedStatement ps = conn.prepareStatement(SQL_INSERT)) {

			ps.setString(1, name);
			ps.setString(2, surname);
			ps.setString(3, className);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			printException(e);
			throw new Exception(e.getMessage(), e);
		}
	}

	public boolean update(String name, String surname, String className, int id) throws Exception {
		try (Connection conn = getConnection();
			 PreparedStatement ps = conn.prepareStatement(SQL_UPDATE)) {

			ps.setString(1, name);
			ps.setString(2, surname);
			ps.setString(3, className);
			ps.setInt(4, id);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			printException(e);
			throw new Exception(e.getMessage(), e);
		}
	}

	public boolean delete(int id) throws Exception {
		try (Connection conn = getConnection();
			 PreparedStatement ps = conn.prepareStatement(SQL_DELETE)) {

			ps.setInt(1, id);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			printException(e);
			throw new Exception(e.getMessage(), e);
		}
	}
}
