package controller;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import model.User;

@WebServlet("/ChangePassword")
public class ChangePasswordController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private UserDao userDao;

	@Override
	public void init(ServletConfig config) throws ServletException {

		try {

			super.init(config);

			String xmlPath = getServletContext().getRealPath("/")
					+ config.getServletContext().getInitParameter("config");

			userDao = new UserDao(xmlPath);

		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res)

			throws ServletException, IOException {

		req.getRequestDispatcher("view/changePassword.jsp").forward(req, res);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res)

			throws ServletException, IOException {

		User user = (User) req.getSession().getAttribute("user");

		String nuova = req.getParameter("nuova");

		try {

			userDao.changePassword(user.getId(), nuova);

			req.setAttribute("successo", "Password aggiornata");

			req.getRequestDispatcher("view/changePassword.jsp").forward(req, res);

		} catch (Exception e) {

			e.printStackTrace();
		}
	}
}