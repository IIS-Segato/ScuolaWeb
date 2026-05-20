package controller;

import java.io.IOException;
import java.util.List;

import dao.DocenteDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Docente;

public class DocenteController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private static final String ACTION_GET_ALL = "GETALL";
	private static final String ACTION_GET_BY_ID = "GETBYID";
	private static final String ACTION_GET_BY_PERSONA_ID = "GETBYPERSONAID";
	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	
	private DocenteDAO docenteDao = null;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public DocenteController() {
        super();


    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);

			docenteDao = new DocenteDAO(getServletContext().getRealPath("/") + config.getServletContext().getInitParameter("config"));

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
		
		Docente docente = null;	
		List<Docente> docenti;
		try {
			action = request.getParameter("action");
			id = request.getParameter("id");
			
			if(ACTION_DELETE.equals(action)) {
				if(id != null) {
					docenteDao.delete(Integer.parseInt(id));
					
					view = "";
				}
				
			}
			else if(ACTION_GET_ALL.equals(action)) {
				docenti = docenteDao.getAll();
				
				request.setAttribute("docenti", docenti);
				
				view = "";
				
			}
			else if(ACTION_GET_BY_ID.equals(action)) {
				if(id != null) {
					docente = docenteDao.getById(Integer.parseInt(id));
					
					request.setAttribute("docente", docente);
					
					view = "";
				}
				
			}
			else if(ACTION_GET_BY_PERSONA_ID.equals(action)){
				if(id != null) {
					docente = docenteDao.getByPersonaId(Integer.parseInt(id));
					
					request.setAttribute("docente", docente);
					
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
			String action = request.getParameter("action");
			
			if(ACTION_INSERT.equals(action)) {
				docenteDao.insert(Integer.parseInt(id_persona));
			}
			else if(ACTION_UPDATE.equals(action)){
				docenteDao.update(Integer.parseInt(id_persona), Integer.parseInt(id));
			}
			
			response.sendRedirect("Docente");
			
		}catch(Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}

}
