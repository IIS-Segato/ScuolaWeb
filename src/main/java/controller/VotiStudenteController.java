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
import dao.StudentiDAO;
import model.Studente;
import model.Voto;

/**
 * Classe VotiStudenteController.java per lo stroico dei voti
 */
@WebServlet("/VotiStudente")
public class VotiStudenteController extends HttpServlet {
	// Attributi
	private static final long serialVersionUID = 1L;
	private DocentiDAO docentiDAO;
	private StudentiDAO studentiDAO;
	
	/**
	 * Costruttore
	 */
	public VotiStudenteController() {
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
			studentiDAO = new StudentiDAO(config.getServletContext().getRealPath(config.getServletContext().getInitParameter("config"))); // instanzio studentiDAO
		} catch (ClassNotFoundException | JDOMException | IOException | SQLException e) {
			e.printStackTrace();
		} 
	}
	
	/**
	 * Gestisce le richieste HTTP GET
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Recupero i parametri dal form
		int sid = Integer.parseInt(request.getParameter("sid"));
		String materia = (String) request.getParameter("materia");
		
		// lista dei voti
		ArrayList<Voto> voti = null;
		Studente studente = null;
		try {
			voti = docentiDAO.getVotiByStudenteMateria(sid, materia);
			studente = studentiDAO.getStudente(sid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("materia", materia);
		request.setAttribute("studente", studente);
		request.setAttribute("voti", voti);
		request.getRequestDispatcher("view/role/StudenteVoti.jsp").forward(request, response);
	}
}