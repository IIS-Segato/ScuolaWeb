package controller;

import java.io.IOException;
import java.util.List;

import dao.VotoDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Voto;

public class VotoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final String ACTION_GET_ALL = "GETALL";
	private static final String ACTION_GET_BY_ID = "GETBYID";
	private static final String ACTION_GET_BY_STUDENTE_ID = "GETBYSTUDENTEID";
	private static final String ACTION_GET_BY_INSEGNAMENTO_ID = "GETBYINSEGNAMENTOID";
	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	
	private VotoDAO votoDao = null;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public VotoController() {
        super();


    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);

			votoDao = new VotoDAO(getServletContext().getRealPath("/") + config.getServletContext().getInitParameter("config"));

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
		
		Voto voto = null;	
		List<Voto> voti;
		try {
			action = request.getParameter("action");
			id = request.getParameter("id");
			
			if(ACTION_DELETE.equals(action)) {
				if(id != null) {
					votoDao.delete(Integer.parseInt(id));
					
					view = "";
				}
				
			}
			else if(ACTION_GET_ALL.equals(action)) {
				voti = votoDao.getAll();
				
				request.setAttribute("voti", voti);
				
				view = "/voti.jsp";
				
			}
			else if(ACTION_GET_BY_ID.equals(action)) {
				if(id != null) {
					voto = votoDao.getById(Integer.parseInt(id));
					
					request.setAttribute("voto", voto);
					
					view = "/voti.jsp";
				}
				
			}
			else if(ACTION_GET_BY_STUDENTE_ID.equals(action)){
				if(id != null) {
					voti = votoDao.getByStudentId(Integer.parseInt(id));
					
					request.setAttribute("voti", voti);
					
					view = "";
				}
			}
			else if(ACTION_GET_BY_INSEGNAMENTO_ID.equals(action)) {
				if(id != null) {
					voti = votoDao.getByInsegnamentoId(Integer.parseInt(id));
					
					request.setAttribute("voti", voti);
					
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
			String id_studente = request.getParameter("id_studente");
			String id_insegnamento = request.getParameter("id_insegnamento");
			String voto = request.getParameter("voto");
			String data_voto = request.getParameter("data_voto");
			String descrizione = request.getParameter("descrizione");
			String action = request.getParameter("action");
			
			if(ACTION_INSERT.equals(action)) {
				votoDao.insert(Integer.parseInt(id_studente), Integer.parseInt(id_insegnamento), Integer.parseInt(voto), data_voto, descrizione);
			}
			else if(ACTION_UPDATE.equals(action)){
				votoDao.update(Integer.parseInt(id_studente), Integer.parseInt(id_insegnamento), Integer.parseInt(voto), data_voto, descrizione, Integer.parseInt(id));
			}
			
			response.sendRedirect("Voto");
			
		}catch(Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}

}
