package controller;

import java.io.IOException;
import java.util.List;

import dao.AnnuncioClasseDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.AnnuncioClasse;

public class AnnuncioClasseController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private static final String ACTION_GET_ALL = "GETALL";
	private static final String ACTION_GET_BY_ID = "GETBYID";
	private static final String ACTION_GET_BY_ID_CLASSE = "GETBYIDCLASSE";
	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	
	private AnnuncioClasseDAO annuncioClasseDao = null;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public AnnuncioClasseController() {
        super();


    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);

			annuncioClasseDao = new AnnuncioClasseDAO(getServletContext().getRealPath("/") + config.getServletContext().getInitParameter("config"));

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
		
		AnnuncioClasse annuncioClasse = null;	
		List<AnnuncioClasse> annunciClasse;
		try {
			action = request.getParameter("action");
			id = request.getParameter("id");
			
			if(ACTION_DELETE.equals(action)) {
				if(id != null) {
					annuncioClasseDao.delete(Integer.parseInt(id));
					
					view = "";
				}
				
			}
			else if(ACTION_GET_ALL.equals(action)) {
				annunciClasse = annuncioClasseDao.getAll();
				
				request.setAttribute("annunciClasse", annunciClasse);
				
				view = "";
				
			}
			else if(ACTION_GET_BY_ID.equals(action)) {
				if(id != null) {
					annuncioClasse = annuncioClasseDao.getById(Integer.parseInt(id));
					
					request.setAttribute("annuncioClasse", annuncioClasse);
					
					view = "";
				}
				
			}
			else if(ACTION_GET_BY_ID_CLASSE.equals(action)){
				if(id != null) {
					annunciClasse = annuncioClasseDao.getByIdClasse(Integer.parseInt(id));
					
					request.setAttribute("annunciClasse", annunciClasse);
					
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
			String id_classe = request.getParameter("id_classe");
			String id_docente = request.getParameter("id_docente");
			String action = request.getParameter("action");
			
			if(ACTION_INSERT.equals(action)) {
				annuncioClasseDao.insert(Integer.parseInt(id_classe), Integer.parseInt(id_docente));
			}
			else if(ACTION_UPDATE.equals(action)){
				annuncioClasseDao.update(Integer.parseInt(id_classe), Integer.parseInt(id_docente), Integer.parseInt(id));
			}
			
			response.sendRedirect("AnnuncioClasse");
			
		}catch(Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}

}
