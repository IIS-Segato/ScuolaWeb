package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jdom2.JDOMException;

import dao.AmministratoreDAO;
import dao.DocentiDAO;
import dao.LoginDAO;
import dao.StudentiDAO;

import model.Docente;
import model.Studente;
import model.Amministratore;

/**
 * Classe LoginController.java per la gestione della servlet login
 */
@WebServlet("/login")
public class LoginController extends HttpServlet {
	// Attributi
	private static final long serialVersionUID = 1L;
	private LoginDAO loginDAO;
	private AmministratoreDAO amministratoreDAO;
	private DocentiDAO docentiDAO;
	private StudentiDAO studentiDAO;
	
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
			amministratoreDAO = new AmministratoreDAO(config.getServletContext().getRealPath(config.getServletContext().getInitParameter("config"))); // instanzio amministratoreDAO
			docentiDAO = new DocentiDAO(config.getServletContext().getRealPath(config.getServletContext().getInitParameter("config"))); // instanzio studentiDAO
			studentiDAO = new StudentiDAO(config.getServletContext().getRealPath(config.getServletContext().getInitParameter("config"))); // instanzio docentiDAO
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
		
		// Controllo che utente ha fatto l'accesso
		int sid = -1;
		int did = -1;
		int aid = -1;
		try {
			sid = loginDAO.checkStudente(email, password);
			did = loginDAO.checkDocente(email, password);
			aid = loginDAO.checkAmministratore(email, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
			
		// Routing alle diverse view in base all'utente loggato
		if (sid >= 0) {
			// creo lo studente
			Studente studente = null;
			try {
				studente = studentiDAO.getStudente(sid);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// crea una sessione se questa non esiste
			HttpSession session = request.getSession();
			session.setAttribute("studente", studente); // salvo lo studente in sessione
			request.getRequestDispatcher("view/role/Studente.jsp").forward(request, response);
		} else if (did >= 0) {
			// creo il docente
			Docente docente = null;
			try {
				docente = docentiDAO.getDocente(did);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// crea una sessione se questa non esiste
			HttpSession session = request.getSession();
			session.setAttribute("docente", docente); // salvo il docente in sessione
			request.getRequestDispatcher("view/role/Docente.jsp").forward(request, response);
		} else if (aid >= 0) {			
			// creo l'amministratore
			Amministratore amministratore = null;
			try {
				amministratore = amministratoreDAO.getAmministratore(aid);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JDOMException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// crea una sessione se questa non esiste
			HttpSession session = request.getSession();
			session.setAttribute("docente", amministratore); // salvo l'amministratore in sessione
			request.getRequestDispatcher("view/role/Amministratore.jsp").forward(request, response);
		} else {
			// se l'utente non è nel db eseguo il redirect al login con l'errore
			response.sendRedirect("index.html?error=1");
			return;
		}
	}
}