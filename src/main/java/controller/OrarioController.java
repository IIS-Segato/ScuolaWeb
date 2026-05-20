package controller;

import java.io.IOException;

import dao.OrarioDAO;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class OrarioController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private static final String ACTION_GET_ALL = "GETALL";
	private static final String ACTION_GET_BY_ID = "GETBYID";
	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	
	private OrarioDAO orarioDao = null;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public OrarioController() {
        super();


    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);

			orarioDao = new OrarioDAO(getServletContext().getRealPath("/") + config.getServletContext().getInitParameter("config"));

		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String id = request.getParameter("id");
			String id_insegnamento = request.getParameter("id_insegnamento");
			String id_aula = request.getParameter("id_aula");
			String giorno = request.getParameter("giorno");
			String ora_inizio = request.getParameter("ora_inizio");
			String ora_fine = request.getParameter("ora_fine");
			String action = request.getParameter("action");
			
			if(ACTION_INSERT.equals(action)) {
				orarioDao.insert(Integer.parseInt(id_insegnamento),
						Integer.parseInt(id_aula),
						giorno,
						ora_inizio,
						ora_fine
						);
			}
			else if(ACTION_UPDATE.equals(action)){
				orarioDao.update(Integer.parseInt(id_insegnamento),
						Integer.parseInt(id_aula),
						giorno,
						ora_inizio,
						ora_fine,
						Integer.parseInt(id)
						);
			}
			
			response.sendRedirect("Voto");
			
		}catch(Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}

}
