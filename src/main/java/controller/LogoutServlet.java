package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Recupero sessione SENZA crearne una nuova
		HttpSession session = request.getSession(false);

		// Se esiste -> invalida
		if (session != null) {

			session.invalidate();

			System.out.println("Sessione invalidata");
		}

		// Redirect login
		response.sendRedirect("login.jsp");
	}
}