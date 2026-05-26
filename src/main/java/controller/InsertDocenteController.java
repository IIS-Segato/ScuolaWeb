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

import dao.AmministratoreDAO;
import model.Docente;

/**
 * Servlet implementation class InsertDocenteController
 */
@WebServlet("/InsertDocenteController")
public class InsertDocenteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AmministratoreDAO amministratoreDAO;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertDocenteController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    /**
	 * Inizializzazione della servlet
	 */
	@Override
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);
			amministratoreDAO = new AmministratoreDAO(config.getServletContext().getRealPath(config.getServletContext().getInitParameter("config"))); // instanzio docentiDAO
		} catch (ClassNotFoundException | JDOMException | IOException | SQLException e) {
			e.printStackTrace();
		} 
	}

	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Recupero i parametri dal form
		String nome = (String)request.getParameter("nome");
		String cognome = (String)request.getParameter("cognome");
		String email = (String)request.getParameter("email");
		String password = (String) request.getParameter("password");
		Docente docente = new Docente();	
		docente.setNome(nome);
		docente.setCognome(cognome);
		docente.setEmail(email);
		docente.setPassword(password);
		
		try {
			try {
				amministratoreDAO.insertDocente(docente);
			} catch (ClassNotFoundException | JDOMException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		response.sendRedirect("view/role/AmministratoreDocenti.jsp"); // ritorno alla pagina della Classe del Docente
	}

}
