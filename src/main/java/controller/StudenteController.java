package controller;

import java.io.IOException;
import java.util.List;

import dao.StudenteDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Studente;

public class StudenteController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private static final String ACTION_GET_ALL = "GETALL";
	private static final String ACTION_GET_BY_ID = "GETBYID";
	private static final String ACTION_GET_BY_PERSONA_ID = "GETBYPERSONAID";
	private static final String ACTION_GET_BY_CLASSE_ID = "GETBYCLASSEID";
	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	
	private StudenteDAO studenteDao = null;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public StudenteController() {
        super();


    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);

			studenteDao = new StudenteDAO(getServletContext().getRealPath("/") + config.getServletContext().getInitParameter("config"));

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
		
		Studente studente = null;	
		List<Studente> studenti;
		try {
			action = request.getParameter("action");
			id = request.getParameter("id");
			
			if(ACTION_DELETE.equals(action)) {
				if(id != null) {
					studenteDao.delete(Integer.parseInt(id));
					
					view = "";
				}
				
			}
			else if(ACTION_GET_ALL.equals(action)) {
				studenti = studenteDao.getAll();
				
				request.setAttribute("studenti", studenti);
				
				view = "";
				
			}
			else if(ACTION_GET_BY_ID.equals(action)) {
				if(id != null) {
					studente = studenteDao.getById(Integer.parseInt(id));
					
					request.setAttribute("studente", studente);
					
					view = "";
				}
				
			}
			else if(ACTION_GET_BY_PERSONA_ID.equals(action)){
				if(id != null) {
					studente = studenteDao.getByPersonaId(Integer.parseInt(id));
					
					request.setAttribute("studente", studente);
					
					view = "";
				}
			}
			else if(ACTION_GET_BY_CLASSE_ID.equals(action)) {
				if(id != null) {
					studenti = studenteDao.getByClasseId(Integer.parseInt(id));
					
					request.setAttribute("studenti", studenti);
					
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
			String id_persona = request.getParameter("id_persona");
			String id_classe = request.getParameter("id_classe");
			String action = request.getParameter("action");
			
			if(ACTION_INSERT.equals(action)) {
				studenteDao.insert(Integer.parseInt(id_persona), Integer.parseInt(id_classe));
			}
			else if(ACTION_UPDATE.equals(action)){
				studenteDao.update(Integer.parseInt(id_persona), Integer.parseInt(id_classe), Integer.parseInt(id));
			}
			
			response.sendRedirect("Studente");
			
		}catch(Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}

}
