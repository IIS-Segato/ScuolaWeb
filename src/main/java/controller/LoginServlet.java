package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDao;
import model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		System.out.println(">>> LOGIN SERVLET CHIAMATA");
		System.out.println("USERNAME: " + username);
		System.out.println("PASSWORD: " + password);

		// VALIDAZIONE BASE
		if (username == null || username.isEmpty() || password == null || password.isEmpty()) {

			request.setAttribute("error", "Inserisci username e password");
			request.getRequestDispatcher("login.jsp").forward(request, response);
			return;
		}

		try {
			// DAO
			String path = getServletContext().getRealPath("/WEB-INF/dbcfg.xml");
			UserDao dao = new UserDao(path);

			User user = dao.login(username, password);

			// DEBUG
			System.out.println("DAO RESULT: " + user);

			if (user == null) {
				request.setAttribute("error", "Credenziali non valide");
				request.getRequestDispatcher("login.jsp").forward(request, response);
				return;
			}

			// CREO SESSIONE
			HttpSession session = request.getSession();
			session.setAttribute("user", user);

			// REDIRECT UNICO (per ora)
			response.sendRedirect("viewRole.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Errore interno");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}
}
