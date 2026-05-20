package controller;

import java.io.IOException;
import java.util.List;

import dao.PersonaDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Persona;

public class PersonaController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private static final String ACTION_GET_ALL = "GETALL";
	private static final String ACTION_GET_BY_ID = "GETBYID";
	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	
	private PersonaDAO personaDao = null;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public PersonaController() {
        super();


    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);

			personaDao = new PersonaDAO(getServletContext().getRealPath("/") + config.getServletContext().getInitParameter("config"));

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
		
		Persona persona = null;	
		List<Persona> persone;
		try {
			action = request.getParameter("action");
			id = request.getParameter("id");
			
			if(ACTION_DELETE.equals(action)) {
				if(id != null) {
					personaDao.delete(Integer.parseInt(id));
					
					view = "";
				}
				
			}
			else if(ACTION_GET_ALL.equals(action)) {
				persone = personaDao.getAll();
				
				request.setAttribute("persone", persone);
				
				view = "";
				
			}
			else if(ACTION_GET_BY_ID.equals(action)) {
				if(id != null) {
					persona = personaDao.getById(Integer.parseInt(id));
					
					request.setAttribute("persona", persona);
					
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
			String nome = request.getParameter("nome");
			String cognome = request.getParameter("cognome");
			String nascita = request.getParameter("nascita");
			String cf = request.getParameter("cf");
			String email = request.getParameter("email");
			String img_profilo = request.getParameter("img_profilo");
			String action = request.getParameter("action");
			
			if(ACTION_INSERT.equals(action)) {
				personaDao.insert(nome, cognome, nascita, cf, email, img_profilo.getBytes());
			}
			else if(ACTION_UPDATE.equals(action)){
				personaDao.update(nome, cognome, nascita, cf, email, img_profilo.getBytes(), Integer.parseInt(id));
			}
			
			response.sendRedirect("Voto");
			
		}catch(Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}

}
