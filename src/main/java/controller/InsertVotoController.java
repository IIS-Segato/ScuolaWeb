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
 * Classe InsertVotoController.java per l'inserimento dei voti
 */
@WebServlet("/InsertVotoController")
public class InsertVotoController extends HttpServlet {
	// Attributi
	private static final long serialVersionUID = 1L;
	private DocentiDAO docentiDAO;
	
	/**
	 * Costruttore
	 */
	public InsertVotoController() {
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
		int sid = Integer.parseInt(request.getParameter("sid"));
		int cid = Integer.parseInt(request.getParameter("cid"));
		int did = Integer.parseInt(request.getParameter("did"));
		String materia = (String) request.getParameter("materia");
		float voto = Float.parseFloat(request.getParameter("voto"));
		String data = (String) request.getParameter("data");
		
		try {
			docentiDAO.insertVoto(voto, materia, data, did, sid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.sendRedirect("ClasseDocente?cid="+cid+"&did="+did); // ritorno alla pagina della Classe del Docente
	}
}