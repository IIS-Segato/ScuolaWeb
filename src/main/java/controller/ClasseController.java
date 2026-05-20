package controller;

import java.io.IOException;
import java.util.List;

import dao.ClasseDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Classe;

public class ClasseController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private static final String ACTION_GET_ALL = "GETALL";
	private static final String ACTION_GET_BY_ID = "GETBYID";
	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	
	private ClasseDAO classeDao = null;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public ClasseController() {
        super();


    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);

			classeDao = new ClasseDAO(getServletContext().getRealPath("/") + config.getServletContext().getInitParameter("config"));

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
		
		Classe classe = null;	
		List<Classe> classi;
		try {
			action = request.getParameter("action");
			id = request.getParameter("id");
			
			if(ACTION_DELETE.equals(action)) {
				if(id != null) {
					classeDao.delete(Integer.parseInt(id));
					
					view = "";
				}
				
			}
			else if(ACTION_GET_ALL.equals(action)) {
				classi = classeDao.getAll();
				
				request.setAttribute("classi", classi);
				
				view = "";
				
			}
			else if(ACTION_GET_BY_ID.equals(action)) {
				if(id != null) {
					classe = classeDao.getById(Integer.parseInt(id));
					
					request.setAttribute("classe", classe);
					
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
			String anno = request.getParameter("anno");
			String sezione = request.getParameter("sezione");
			String indirizzo = request.getParameter("indirizzo");
			String action = request.getParameter("action");
			
			if(ACTION_INSERT.equals(action)) {
				classeDao.insert(Integer.parseInt(anno), sezione, indirizzo);
			}
			else if(ACTION_UPDATE.equals(action)){
				classeDao.update(Integer.parseInt(anno), sezione, indirizzo, Integer.parseInt(id));
			}
			
			response.sendRedirect("Classe");
			
		}catch(Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}

}
