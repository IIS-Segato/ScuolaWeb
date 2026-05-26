package controller;

import java.io.IOException;

import dao.RuoloDAO;
import dao.UtenteDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Ruolo;
import model.Utente;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private UtenteDAO utenteDao = null;
	private RuoloDAO ruoloDao = null;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();


    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);

			utenteDao = new UtenteDAO(getServletContext().getRealPath("/") + config.getServletContext().getInitParameter("config"));
			ruoloDao = new RuoloDAO(getServletContext().getRealPath("/") + config.getServletContext().getInitParameter("config"));

		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String view = null;

		try {
			
           HttpSession session = request.getSession(false);
            
            if (session != null && session.getAttribute("utenteId") != null) {
                // L'utente è già loggato! Controlliamo il ruolo per mandarlo alla homepage corretta
                String nomeRuolo = (String) session.getAttribute("nomeRuolo");                
                if (nomeRuolo.equals("STUDENTE")) {
                    response.sendRedirect(request.getContextPath() + "/DocentiController"); 
                } else if (nomeRuolo.equals("DOCENTE")) {
                    response.sendRedirect(request.getContextPath() + "/ClassiDocentiController");
                } else {
                    response.sendRedirect(request.getContextPath() + "/login.jsp");
                }
                return; // Blocca il forward successivo
            } else {
                // Non è loggato, mostriamo la pagina di login
                view = "login.jsp"; 
            }
		
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Ruolo ruolo = null;
		
		try {
	        String action = request.getParameter("action");
	        
	        if ("LOGIN".equals(action)) {
	            String username = request.getParameter("username");
	            String password_hash = request.getParameter("password_hash"); // Password inserita dall'utente

	            // 1. Chiediamo al DAO di verificare se esiste l'utente con queste credenziali
	            Utente utenteLoggato = utenteDao.checkLogin(username, password_hash); 
	            
	            if (utenteLoggato != null) {
	                // LOGIN CORRETTO: Creiamo la sessione HTTP e salviamo i dati utente
	                HttpSession session = request.getSession(true); 
	                
	                session.setAttribute("utenteId", utenteLoggato.getId());
	                ruolo = ruoloDao.getById(utenteLoggato.getId_ruolo());
	                session.setAttribute("nomeRuolo", ruolo.getNome_ruolo()); // es. 1 per Studente, 2 per Docente
	                session.setAttribute("username", utenteLoggato.getUsername());
	                
	                // Rimandiamo al doGet di questo stesso controller per lo smistamento alla homepage corretta
	                response.sendRedirect(request.getContextPath() + "/LoginController");
	            } else {
	                // LOGIN FALLITO: Rimandiamo alla pagina di login mostrando l'errore
	                request.setAttribute("errore", "Username o Password errati!");
	                request.getRequestDispatcher("login.jsp").forward(request, response);
	            }
	            return; // Interrompe il metodo ed evita di eseguire il codice CRUD successivo
	        }
	        
	        response.sendRedirect(request.getContextPath() + "/login.jsp");
	        
	    } catch(Exception e) {
	        e.printStackTrace();
	        throw new ServletException(e.getMessage());
	    }
	}

}
