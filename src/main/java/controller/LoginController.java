package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UtenteDAO;
import model.Utente;

@WebServlet("/login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UtenteDAO utenteDao;

	@Override
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);
			utenteDao = new UtenteDAO(
					getServletContext().getRealPath("/") + config.getServletContext().getInitParameter("config"));
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// fa vedere la pagina di login
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// se è gia loggato va dritto alla dashboard
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("utente") != null) {
			response.sendRedirect("Dashboard");
			return;
		}
		RequestDispatcher rd = request.getRequestDispatcher("view/login.jsp");
		rd.forward(request, response);
	}

}
