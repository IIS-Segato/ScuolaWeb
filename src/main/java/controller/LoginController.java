package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jdom2.JDOMException;

import dao.LoginDAO;
import model.Amministratore;

/**
 * Classe LoginController.java per la gestione della servlet login
 */
@WebServlet("/login")
public class LoginController extends HttpServlet {
	// Attributi
	private static final long serialVersionUID = 1L;
	private LoginDAO loginDAO;
	
	/**
	 * Costruttore
	 */
	public LoginController() {
		super();
	}

	/**
	 * Inizializzazione della servlet
	 */
	@Override
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);
			loginDAO = new LoginDAO(config.getServletContext().getRealPath(config.getServletContext().getInitParameter("config"))); // instanzio loginDAO
		} catch (ClassNotFoundException | JDOMException | IOException | SQLException e) {
			e.printStackTrace();
		} 
	}

	/**
	 * Gestisce le richieste HTTP POST
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Recupero i parametri dal form
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		int sid = -1;
		int did = -1;
		int aid = -1;
		try {
			sid = loginDAO.checkStudente(email, password);
			did = loginDAO.checkDocente(email, password);
			aid = loginDAO.checkAmministratore(email, password);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		// *CONTROLLI DI LOGIN....
		if (sid >= 0) {			
			request.setAttribute("sid", sid);
			request.getRequestDispatcher("view/role/Studente.jsp").forward(request, response);
		}else if (did >= 0) {
			request.setAttribute("did", did);
			request.getRequestDispatcher("view/role/Docente.jsp").forward(request, response);
				
		}else if (aid >= 0) {
			
			request.setAttribute("aid", aid);
			request.getRequestDispatcher("view/role/Amministratore.jsp").forward(request, response);
		}else {
			
		}
		
	}
}