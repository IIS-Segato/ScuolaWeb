package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Docente;

@WebServlet("/TestDashboard")
public class DocenteDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Creiamo uno studente "finto" per il test
		Docente doc = new Docente();
		studenteTest.setNome("Mario");
		studenteTest.setCognome("Rossi");
		studenteTest.setClasse("5A In formatica");
		// Nota: non serve settare la password per la dashboard

		// Mettiamolo in sessione come farebbe la vera Servlet di Login
		HttpSession session = request.getSession();
		session.setAttribute("utenteLoggato", studenteTest);
		session.setAttribute("ruolo", "STUDENTE");

		// Vai alla dashboard (percorso corretto in WEB-INF)
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/studente_dashboard.jsp");
		dispatcher.forward(request, response);
	}
}