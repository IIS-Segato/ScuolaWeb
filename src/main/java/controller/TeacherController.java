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

import dao.TeacherDao;
import model.Teacher;
import model.Role;

public class TeacherController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	private static final String ACTION_EDIT = "EDIT";
	private static final String ACTION_SEARCH = "SEARCH";

	private TeacherDao teacherDao = null;

	@Override
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);

			String configPath = getServletContext().getRealPath("/") +
				config.getServletContext().getInitParameter("config");

			teacherDao = new TeacherDao(configPath);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException("Errore durante l'inizializzazione di TeacherController", e);
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {

		String action = request.getParameter("action");
		String id = request.getParameter("id");

		try {
			if (ACTION_SEARCH.equalsIgnoreCase(action)) {
				String name = request.getParameter("name");
				String surname = request.getParameter("surname");
				String subject = request.getParameter("subject");

				List<Teacher> listTeachers = teacherDao.search(name, surname, subject);
				request.setAttribute("teachers", listTeachers);
				RequestDispatcher dispatcher = request.getRequestDispatcher("/view/teacher/index.jsp");
				dispatcher.forward(request, response);
				return;
			}

			if (!isLoggedIn(request)) {
				response.sendRedirect(request.getContextPath() + "/view/login.jsp?accesso=1");
				return;
			}

			if (ACTION_DELETE.equalsIgnoreCase(action)) {
				if (!isAdmin(request)) {
					response.sendRedirect(request.getContextPath() + "/Teacher");
					return;
				}

				if (id != null && !id.isBlank()) {
					teacherDao.delete(Integer.parseInt(id));
				}

				response.sendRedirect(request.getContextPath() + "/Teacher");
				return;
			}

			String view;

			if (ACTION_EDIT.equalsIgnoreCase(action)) {
				if (!isAdmin(request)) {
					response.sendRedirect(request.getContextPath() + "/Teacher");
					return;
				}

				if (id != null && !id.isBlank()) {
					Teacher teacher = teacherDao.getByID(Integer.parseInt(id));
					request.setAttribute("teacher", teacher);
					request.setAttribute("action", ACTION_UPDATE);
					view = "/view/teacher/edit.jsp";
				} else {
					response.sendRedirect(request.getContextPath() + "/Teacher");
					return;
				}
			} else if (ACTION_INSERT.equalsIgnoreCase(action)) {
				if (!isAdmin(request)) {
					response.sendRedirect(request.getContextPath() + "/Teacher");
					return;
				}

				Teacher teacher = new Teacher();
				request.setAttribute("teacher", teacher);
				request.setAttribute("action", ACTION_INSERT);
				view = "/view/teacher/edit.jsp";
			} else {
				List<Teacher> listTeachers = teacherDao.getAll();
				request.setAttribute("teachers", listTeachers);
				view = "/view/teacher/index.jsp";
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
			if (!isAdmin(request)) {
				response.sendRedirect(request.getContextPath() + "/Teacher");
				return;
			}

			request.setCharacterEncoding("UTF-8");

			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String surname = request.getParameter("surname");
			String subject = request.getParameter("subject");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String action = request.getParameter("action");

			if (isEmpty(name) || isEmpty(surname) || isEmpty(subject)) {
				Teacher teacher = new Teacher();

				if (id != null && !id.isBlank()) {
					teacher.setId(Integer.parseInt(id));
				}

				teacher.setName(name);
				teacher.setSurname(surname);
				teacher.setSubject(subject);

				request.setAttribute("teacher", teacher);
				request.setAttribute("action", action);
				request.setAttribute("error", "Compila tutti i campi obbligatori.");

				RequestDispatcher dispatcher = request.getRequestDispatcher("/view/teacher/edit.jsp");
				dispatcher.forward(request, response);
				return;
			}

			if (ACTION_INSERT.equalsIgnoreCase(action)) {
				teacherDao.insert(name.trim(), surname.trim(), subject.trim(), username, password);
			} else if (ACTION_UPDATE.equalsIgnoreCase(action)) {
				teacherDao.update(name.trim(), surname.trim(), subject.trim(), Integer.parseInt(id));
			}

			response.sendRedirect(request.getContextPath() + "/Teacher");

		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage(), e);
		}
	}

	private boolean isEmpty(String value) {
		return value == null || value.trim().isEmpty();
	}

	private boolean isLoggedIn(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		return session != null && session.getAttribute("role") != null;
	}

	private boolean isAdmin(HttpServletRequest request) {
		HttpSession session = request.getSession(false);

		if (session == null) {
			return false;
		}

		Object roleObj = session.getAttribute("role");
		if (roleObj == null) roleObj = session.getAttribute("ruolo");
		if (roleObj == null) roleObj = session.getAttribute("role_name");

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
