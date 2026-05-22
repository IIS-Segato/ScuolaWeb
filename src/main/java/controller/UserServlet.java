package controller;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DocenteDao;
import dao.StudenteDao;
import dao.UserAdminDao;
import model.User;
import utils.DBManager;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {

	private UserAdminDao userDao;
	private StudenteDao studenteDao;
	private DocenteDao docenteDao;

	@Override
	public void init() throws ServletException {
		Connection conn = DBManager.getConnection(getServletContext());
		userDao = new UserAdminDao(conn);
		studenteDao = new StudenteDao(conn);
		docenteDao = new DocenteDao(conn);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User u = (User) req.getSession().getAttribute("user");
		if (u == null) {
			resp.sendRedirect("login.jsp");
			return;
		}

		if (u.getRoleId() != 1) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		String action = req.getParameter("action");
		if ("add".equals(action)) {
			req.setAttribute("studenti", studenteDao.getAll());
			req.setAttribute("docenti", docenteDao.getAll());
			req.getRequestDispatcher("formUtente.jsp").forward(req, resp);
		} else {
			req.setAttribute("utenti", userDao.getAll());
			req.getRequestDispatcher("utenti.jsp").forward(req, resp);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User u = (User) req.getSession().getAttribute("user");
		if (u == null) {
			resp.sendRedirect("login.jsp");
			return;
		}

		if (u.getRoleId() != 1) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		String action = req.getParameter("action");
		if ("insert".equals(action)) {
			User nuovo = new User();
			nuovo.setUsername(req.getParameter("username"));
			nuovo.setPassword(req.getParameter("password"));
			nuovo.setRoleId(Integer.parseInt(req.getParameter("roleId")));
			nuovo.setIdStudente(parseOptionalInt(req.getParameter("idStudente")));
			nuovo.setIdDocente(parseOptionalInt(req.getParameter("idDocente")));
			userDao.insert(nuovo);
		}

		resp.sendRedirect("UserServlet?action=list");
	}

	private int parseOptionalInt(String value) {
		if (value == null || value.isBlank()) {
			return 0;
		}
		return Integer.parseInt(value);
	}
}
