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
		
		// *CONTROLLI DI LOGIN....
		try {
			if (loginDAO.checkStudente(email, password) >= 0) {
				
			}else if (loginDAO.checkDocente(email, password) >= 0) {
				
			}else if (loginDAO.checkAmministratore(email, password) >= 0) {
				
			}else {
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}