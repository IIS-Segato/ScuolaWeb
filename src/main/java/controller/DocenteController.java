package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jdom2.JDOMException;

import dao.DocentiDAO;
import model.Classe;
import model.Studente;

/**
 * Classe DocenteController.java per la gestione della servlet del Docente in una Classe
 */
@WebServlet("/ClasseDocente")
public class DocenteController extends HttpServlet {
	// Attributi
	private static final long serialVersionUID = 1L;
	private DocentiDAO docentiDAO;
	
	/**
	 * Costruttore
	 */
	public DocenteController() {
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
	 * Gestisce le richieste HTTP GET
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Recupero i parametri dal form
		int cid = Integer.parseInt(request.getParameter("cid"));
		int did = Integer.parseInt(request.getParameter("did"));
		
		// Prendo la lista studenti della classe, la materia di insegnamento del docente e la classe
		ArrayList<Studente> studenti = null;
		String materia = null;
		Classe classe = null;
		try {
			studenti = docentiDAO.getStudentiByClasse(cid);
			materia = docentiDAO.getMateriaByClasseDocente(cid, did);
			classe = docentiDAO.getClasseByCid(cid);
		} catch (ClassNotFoundException | JDOMException | IOException | SQLException e) {
			e.printStackTrace();
		}
		request.setAttribute("studenti", studenti); // salvo gli studenti nella richiesta
		request.setAttribute("materia", materia); // salvo la materia nella richiesta
		request.setAttribute("classe", classe); // salvo la classe nella richiesta
		request.getRequestDispatcher("view/role/DocenteClasse.jsp").forward(request, response);
	}
}