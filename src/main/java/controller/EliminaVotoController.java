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

import dao.DocentiDAO;

/**
 * Classe EliminaVotoController.java per l'eliminazione dei voti
 */
@WebServlet("/EliminaVoto")
public class EliminaVotoController extends HttpServlet {
	// Attributi
	private static final long serialVersionUID = 1L;
	private DocentiDAO docentiDAO;
	
	/**
	 * Costruttore
	 */
	public EliminaVotoController() {
		super();
	}
	
	/**
	 * Inizializzazione della servlet
	 */
	@Override
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);
			docentiDAO = new DocentiDAO(config.getServletContext().getRealPath(config.getServletContext().getInitParameter("config"))); // instanzio docentiDAO
		} catch (ClassNotFoundException | JDOMException | IOException | SQLException e) {
			e.printStackTrace();
		} 
	}
	
	/**
	 * Gestisce le richieste HTTP POST
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Recupero i parametri dal form
		int vid = Integer.parseInt(request.getParameter("vid"));
		int sid = Integer.parseInt(request.getParameter("sid"));
		String materia = (String) request.getParameter("materia");
		
		try {
			docentiDAO.deleteVoto(vid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.sendRedirect("VotiStudente?sid="+sid+"&materia="+materia);
	}
}