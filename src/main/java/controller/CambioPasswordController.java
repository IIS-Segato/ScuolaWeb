package controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
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
 * Classe InsertVotoController.java per l'inserimento dei voti
 */
@WebServlet("/CambioPasswordController")
public class CambioPasswordController extends HttpServlet {
	// Attributi
	private static final long serialVersionUID = 1L;
	private LoginDAO loginDAO;
	
	/**
	 * Costruttore
	 */
	public CambioPasswordController() {
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
	    int id = Integer.parseInt(request.getParameter("id"));
	    String nuovaPassword    = request.getParameter("nuovaPassword");
	    String confermaPassword = request.getParameter("confermaPassword");
	    String tipo             = request.getParameter("tipo");

	    if(!nuovaPassword.equals(confermaPassword)){
	        request.setAttribute("errore", "Le password non coincidono.");
	        request.getRequestDispatcher("CambioPassword.jsp").forward(request, response);
	        return;
	    }

	    try {
	        if(tipo.equals("studente"))
	            loginDAO.updatePasswordStudente(nuovaPassword, id);
	        else
	            loginDAO.updatePasswordDocente(nuovaPassword, id);

	        request.setAttribute("successo", "Password aggiornata correttamente.");
	        request.getRequestDispatcher("view/role/CambioPassword.jsp").forward(request, response);

	    } catch(SQLException | NoSuchAlgorithmException e){
	        e.printStackTrace();
	        request.setAttribute("errore", "Errore durante l'aggiornamento. Riprova.");
	        request.getRequestDispatcher("view/role/CambioPassword.jsp").forward(request, response);
	    }
	}
}