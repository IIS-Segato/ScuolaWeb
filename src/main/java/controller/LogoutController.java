package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet logout
 */
@WebServlet("/logout")
public class LogoutController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Recupera la sessione senza crearne una nuova
		HttpSession session = request.getSession(false);

		// Se esiste -> invalida
		if (session != null) {
			session.invalidate();
		}

		// Redirect al login
		response.sendRedirect("index.html");
	}
}