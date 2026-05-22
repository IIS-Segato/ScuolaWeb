package controller;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserAdminDao;
import model.User;
import utils.DBManager;
import utils.PasswordUtils;

@WebServlet("/CambioPasswordServlet")
public class CambioPasswordServlet extends HttpServlet {

	private UserAdminDao userAdminDao;

	@Override
	public void init() throws ServletException {
		Connection conn = DBManager.getConnection();
		userAdminDao = new UserAdminDao(conn);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User u = (User) req.getSession().getAttribute("user");

		if (u == null) {
			resp.sendRedirect("login.jsp");
			return;
		}

		req.getRequestDispatcher("cambioPassword.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User u = (User) req.getSession().getAttribute("user");

		if (u == null) {
			resp.sendRedirect("login.jsp");
			return;
		}

		String passwordAttuale = req.getParameter("passwordAttuale");
		String nuovaPassword = req.getParameter("nuovaPassword");
		String confermaPassword = req.getParameter("confermaPassword");

		if (!PasswordUtils.matches(passwordAttuale, u.getPassword())) {
			req.setAttribute("error", "Password attuale non corretta");
			req.getRequestDispatcher("cambioPassword.jsp").forward(req, resp);
			return;
		}

		if (nuovaPassword == null || nuovaPassword.isBlank() || !nuovaPassword.equals(confermaPassword)) {
			req.setAttribute("error", "Le nuove password non coincidono");
			req.getRequestDispatcher("cambioPassword.jsp").forward(req, resp);
			return;
		}

		userAdminDao.updatePassword(u.getId(), nuovaPassword);
		u.setPassword(PasswordUtils.hash(nuovaPassword));
		req.getSession().setAttribute("user", u);

		req.setAttribute("success", "Password modificata correttamente");
		req.getRequestDispatcher("cambioPassword.jsp").forward(req, resp);
	}
}
