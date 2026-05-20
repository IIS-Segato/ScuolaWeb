package controller;

import java.io.IOException;
import java.util.List;

import dao.InsegnamentoDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Insegnamento;

public class InsegnamentoController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private static final String ACTION_GET_ALL = "GETALL";
	private static final String ACTION_GET_BY_ID = "GETBYID";
	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	
	private InsegnamentoDAO insegnamentoDao = null;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public InsegnamentoController() {
        super();


    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);

			insegnamentoDao = new InsegnamentoDAO(getServletContext().getRealPath("/") + config.getServletContext().getInitParameter("config"));

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
		
		Insegnamento insegnamento = null;	
		List<Insegnamento> insegnamenti;
		try {
			action = request.getParameter("action");
			id = request.getParameter("id");
			
			if(ACTION_DELETE.equals(action)) {
				if(id != null) {
					insegnamentoDao.delete(Integer.parseInt(id));
					
					view = "";
				}
				
			}
			else if(ACTION_GET_ALL.equals(action)) {
				insegnamenti = insegnamentoDao.getAll();
				
				request.setAttribute("insegnamenti", insegnamenti);
				
				view = "";
				
			}
			else if(ACTION_GET_BY_ID.equals(action)) {
				if(id != null) {
					insegnamento = insegnamentoDao.getById(Integer.parseInt(id));
					
					request.setAttribute("insegnamento", insegnamento);
					
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
			String id_docente = request.getParameter("id_docente");
			String id_materia = request.getParameter("id_materia");
			String id_classe = request.getParameter("id_classe");
			String action = request.getParameter("action");
			
			if(ACTION_INSERT.equals(action)) {
				insegnamentoDao.insert(Integer.parseInt(id_docente), Integer.parseInt(id_materia), Integer.parseInt(id_classe));
			}
			else if(ACTION_UPDATE.equals(action)){
				insegnamentoDao.update(Integer.parseInt(id_docente), Integer.parseInt(id_materia), Integer.parseInt(id_classe), Integer.parseInt(id));
			}
			
			response.sendRedirect("Insegnamento");
			
		}catch(Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}

}
