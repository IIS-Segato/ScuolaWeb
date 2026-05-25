package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.TeacherDao;
import model.Teacher;

public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private TeacherDao teacherDao;

	@Override
	public void init() throws ServletException {
		try {
			String configPath = getServletContext().getRealPath("/") +
				getServletContext().getInitParameter("config");
			teacherDao = new TeacherDao(configPath);
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		try {
			if ("admin".equals(username) && "admin".equals(password)) {
				HttpSession session = request.getSession(true);
				session.setAttribute("user", "admin");
				session.setAttribute("role", "admin");
				response.sendRedirect(request.getContextPath() + "/view/dashboard.jsp");
				return;
			}

			Teacher teacher = teacherDao.login(username, password);

			if (teacher != null) {
				HttpSession session = request.getSession(true);
				session.setAttribute("user", teacher);
				session.setAttribute("role", "teacher");
				response.sendRedirect(request.getContextPath() + "/view/dashboard.jsp");
				return;
			}

			response.sendRedirect(request.getContextPath() + "/view/login.jsp?errore=1");

		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		response.sendRedirect(request.getContextPath() + "/view/login.jsp");
	}
}
