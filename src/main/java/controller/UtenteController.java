package controller;

import java.io.IOException;
import java.util.List;

import dao.UtenteDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Utente;

public class UtenteController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private static final String ACTION_GET_ALL = "GETALL";
	private static final String ACTION_GET_BY_ID = "GETBYID";
	private static final String ACTION_GET_BY_PERSONA_ID = "GETBYPERSONAID";
	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	
	private UtenteDAO utenteDao = null;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public UtenteController() {
        super();


    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);

			utenteDao = new UtenteDAO(getServletContext().getRealPath("/") + config.getServletContext().getInitParameter("config"));

		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String view = null;
		String action = null;
		String id = null;
		
		Utente utente = null;	
		List<Utente> utenti;
		try {
			action = request.getParameter("action");
			id = request.getParameter("id");
			
			if(ACTION_DELETE.equals(action)) {
				if(id != null) {
					utenteDao.delete(Integer.parseInt(id));
					
					view = "";
				}
				
			}
			else if(ACTION_GET_ALL.equals(action)) {
				if(id != null) {
					utenti = utenteDao.getAll();
					
					request.setAttribute("utenti", utenti);
					
					view = "";
				}
				
			}
			else if(ACTION_GET_BY_ID.equals(action)) {
				if(id != null) {
					utente = utenteDao.getById(Integer.parseInt(id));
					
					request.setAttribute("utente", utente);
					
					view = "";
				}
				
			}
			else if(ACTION_GET_BY_PERSONA_ID.equals(action)){
				if(id != null) {
					utente = utenteDao.getByPersonaId(Integer.parseInt(id));
					
					request.setAttribute("utente", utente);
					
					view = "";
				}
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
		try {
			String id = request.getParameter("id");
			String username = request.getParameter("username");
			String password_hash = request.getParameter("password_hash");
			String id_persona = request.getParameter("id_persona");
			String id_ruolo = request.getParameter("id_ruolo");
			String action = request.getParameter("action");
			
			if(ACTION_INSERT.equals(action)) {
				utenteDao.insert(username, password_hash, Integer.parseInt(id_persona), Integer.parseInt(id_ruolo));
			}
			else if(ACTION_UPDATE.equals(action)){
				utenteDao.update(username, password_hash, Integer.parseInt(id_persona), Integer.parseInt(id_ruolo), Integer.parseInt(id));
			}
			
			response.sendRedirect("Utente");
			
		}catch(Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}

}
