package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.StudentDao;
import model.Role;
import model.Student;

@WebServlet("/Student")
public class StudentController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	private static final String ACTION_EDIT = "EDIT";

	private StudentDao studentDao = null;

	public StudentController() {
		super();
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);

			// The DAO is initialized once at servlet startup.
			// It reads the XML config path from web.xml and prepares DB access.
			String configPath = getServletContext().getRealPath("/") +
				config.getServletContext().getInitParameter("config");

			studentDao = new StudentDao(configPath);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException("Errore durante l'inizializzazione di StudentController", e);
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {

		String view;
		String action = request.getParameter("action");
		String id = request.getParameter("id");

		try {
			// DELETE: only admin users can remove a student.
			if (ACTION_DELETE.equalsIgnoreCase(action)) {
				if (!isAdmin(request)) {
					response.sendRedirect("Student");
					return;
				}

				if (id != null && !id.isBlank()) {
					studentDao.delete(Integer.parseInt(id));
				}

				response.sendRedirect("Student");
				return;
			}

			// EDIT: load the student and open the edit form.
			if (ACTION_EDIT.equalsIgnoreCase(action)) {
				if (!isAdmin(request)) {
					response.sendRedirect("Student");
					return;
				}

				if (id != null && !id.isBlank()) {
					Student student = studentDao.getByID(Integer.parseInt(id));
					request.setAttribute("student", student);
					request.setAttribute("id", student.getId());
					request.setAttribute("action", ACTION_UPDATE);
					view = "view/student/edit.jsp";
				} else {
					response.sendRedirect("Student");
					return;
				}
			}
			// INSERT: open an empty form for a new student.
			else if (ACTION_INSERT.equalsIgnoreCase(action)) {
				if (!isAdmin(request)) {
					response.sendRedirect("Student");
					return;
				}

				Student student = new Student();
				request.setAttribute("student", student);
				request.setAttribute("action", ACTION_INSERT);
				view = "view/student/edit.jsp";
			}
			// Default: show the list of students.
			else {
				List<Student> listStudents = studentDao.getAll();
				request.setAttribute("students", listStudents);
				view = "view/student/index.jsp";
			}

			// Forward keeps the current request data available to the JSP.
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage(), e);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {

		try {
			if (!isAdmin(request)) {
				response.sendRedirect("Student");
				return;
			}

			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String surname = request.getParameter("surname");
			String className = request.getParameter("className");
			String action = request.getParameter("action");

			// Basic validation before editing the database.
			if (isEmpty(name) || isEmpty(surname) || isEmpty(className)) {
				Student student = new Student();

				if (id != null && !id.isBlank()) {
					student.setId(Integer.parseInt(id));
				}

				student.setName(name);
				student.setSurname(surname);
				student.setClassName(className);

				request.setAttribute("student", student);
				request.setAttribute("action", action);
				request.setAttribute("error", "Compila tutti i campi obbligatori.");

				RequestDispatcher dispatcher = request.getRequestDispatcher("view/student/edit.jsp");
				dispatcher.forward(request, response);
				return;
			}

			// POST + redirect pattern avoids resubmission on refresh.
			if (ACTION_INSERT.equalsIgnoreCase(action)) {
				studentDao.insert(name.trim(), surname.trim(), className.trim());
			} else if (ACTION_UPDATE.equalsIgnoreCase(action)) {
				studentDao.update(name.trim(), surname.trim(), className.trim(), Integer.parseInt(id));
			}

			response.sendRedirect("Student");

		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage(), e);
		}
	}

	private boolean isEmpty(String value) {
		return value == null || value.trim().isEmpty();
	}

	// The app stores the current role in session under different keys,
	// so we check the common alternatives to stay compatible.
	private boolean isAdmin(HttpServletRequest request) {
		HttpSession session = request.getSession(false);

		if (session == null) {
			return false;
		}

		Object roleObj = session.getAttribute("role");
		if (roleObj == null) {
			roleObj = session.getAttribute("ruolo");
		}
		if (roleObj == null) {
			roleObj = session.getAttribute("role_name");
		}

		String roleName = null;

		if (roleObj instanceof Role) {
			roleName = ((Role) roleObj).getRole_name();
		} else if (roleObj instanceof String) {
			roleName = (String) roleObj;
		}

		if (roleName == null) {
			return false;
		}

		return roleName.equalsIgnoreCase("admin")
			|| roleName.equalsIgnoreCase("administrator")
			|| roleName.equalsIgnoreCase("amministratore");
	}
}
