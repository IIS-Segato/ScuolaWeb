package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.StudentDao;
import model.Student;
import model.Role;

public class StudentController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	private static final String ACTION_EDIT = "EDIT";
	private static final String ACTION_SEARCH = "SEARCH";

	private StudentDao studentDao = null;

	@Override
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);

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

		String action = request.getParameter("action");
		String id = request.getParameter("id");

		try {
			if (ACTION_SEARCH.equalsIgnoreCase(action)) {
				if (!canViewStudents(request)) {
					response.sendRedirect(request.getContextPath() + "/view/login.jsp?accesso=1");
					return;
				}

				String name = request.getParameter("name");
				String surname = request.getParameter("surname");
				String className = request.getParameter("className");

				List<Student> listStudents = studentDao.search(name, surname, className);
				request.setAttribute("students", listStudents);

				RequestDispatcher dispatcher = request.getRequestDispatcher("/view/student/index.jsp");
				dispatcher.forward(request, response);
				return;
			}

			if (!canViewStudents(request)) {
				response.sendRedirect(request.getContextPath() + "/view/login.jsp?accesso=1");
				return;
			}

			if (ACTION_DELETE.equalsIgnoreCase(action)) {
				if (!canEditStudents(request)) {
					response.sendRedirect(request.getContextPath() + "/Student");
					return;
				}

				if (id != null && !id.isBlank()) {
					studentDao.delete(Integer.parseInt(id));
				}

				response.sendRedirect(request.getContextPath() + "/Student");
				return;
			}

			String view;

			if (ACTION_EDIT.equalsIgnoreCase(action)) {
				if (!canEditStudents(request)) {
					response.sendRedirect(request.getContextPath() + "/Student");
					return;
				}

				if (id != null && !id.isBlank()) {
					Student student = studentDao.getByID(Integer.parseInt(id));
					request.setAttribute("student", student);
					request.setAttribute("action", ACTION_UPDATE);
					view = "/view/student/edit.jsp";
				} else {
					response.sendRedirect(request.getContextPath() + "/Student");
					return;
				}
			} else if (ACTION_INSERT.equalsIgnoreCase(action)) {
				if (!canEditStudents(request)) {
					response.sendRedirect(request.getContextPath() + "/Student");
					return;
				}

				Student student = new Student();
				request.setAttribute("student", student);
				request.setAttribute("action", ACTION_INSERT);
				view = "/view/student/edit.jsp";
			} else {
				List<Student> listStudents = studentDao.getAll();
				request.setAttribute("students", listStudents);
				view = "/view/student/index.jsp";
			}

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
			if (!canEditStudents(request)) {
				response.sendRedirect(request.getContextPath() + "/Student");
				return;
			}

			request.setCharacterEncoding("UTF-8");

			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String surname = request.getParameter("surname");
			String className = request.getParameter("className");
			String action = request.getParameter("action");

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

				RequestDispatcher dispatcher = request.getRequestDispatcher("/view/student/edit.jsp");
				dispatcher.forward(request, response);
				return;
			}

			if (ACTION_INSERT.equalsIgnoreCase(action)) {
				studentDao.insert(name.trim(), surname.trim(), className.trim());
			} else if (ACTION_UPDATE.equalsIgnoreCase(action)) {
				studentDao.update(name.trim(), surname.trim(), className.trim(), Integer.parseInt(id));
			}

			response.sendRedirect(request.getContextPath() + "/Student");

		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage(), e);
		}
	}

	private boolean canViewStudents(HttpServletRequest request) {
		String roleName = getRoleName(request);
		if (roleName == null) {
			return false;
		}

		return roleName.equalsIgnoreCase("admin")
			|| roleName.equalsIgnoreCase("administrator")
			|| roleName.equalsIgnoreCase("amministratore")
			|| roleName.equalsIgnoreCase("teacher")
			|| roleName.equalsIgnoreCase("docente");
	}

	private boolean canEditStudents(HttpServletRequest request) {
		String roleName = getRoleName(request);
		if (roleName == null) {
			return false;
		}

		return roleName.equalsIgnoreCase("admin")
			|| roleName.equalsIgnoreCase("administrator")
			|| roleName.equalsIgnoreCase("amministratore");
	}

	private String getRoleName(HttpServletRequest request) {
		HttpSession session = request.getSession(false);

		if (session == null) {
			return null;
		}

		Object roleObj = session.getAttribute("role");
		if (roleObj == null) roleObj = session.getAttribute("ruolo");
		if (roleObj == null) roleObj = session.getAttribute("role_name");

		if (roleObj instanceof Role) {
			return ((Role) roleObj).getRole_name();
		}
		if (roleObj instanceof String) {
			return (String) roleObj;
		}

		return roleObj != null ? roleObj.toString() : null;
	}

	private boolean isEmpty(String value) {
		return value == null || value.trim().isEmpty();
	}
}
