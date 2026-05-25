package controller;

import java.io.IOException;
import java.util.List;

import dao.AssenzaDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Assenza;

public class AssenzaController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private static final String ACTION_GET_ALL = "GETALL";
	private static final String ACTION_GET_BY_ID = "GETBYID";
	private static final String ACTION_GET_BY_UTENTE_ID = "GETBYUTENTEID";
	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	
	private AssenzaDAO assenzaDao = null;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public AssenzaController() {
        super();
        
        
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);

			assenzaDao = new AssenzaDAO(getServletContext().getRealPath("/") + config.getServletContext().getInitParameter("config"));

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
		
		Assenza assenza = null;	
		List<Assenza> assenze;
		try {
			action = request.getParameter("action");
			id = request.getParameter("id");
			
			if(ACTION_DELETE.equals(action)) {
				if(id != null) {
					assenzaDao.delete(Integer.parseInt(id));
					
					view = "";
				}
				
			}
			else if(ACTION_GET_ALL.equals(action)) {
				assenze = assenzaDao.getAll();
				
				request.setAttribute("assenze", assenze);
				
				view = "";
				
			}
			else if(ACTION_GET_BY_ID.equals(action)) {
				if(id != null) {
					assenza = assenzaDao.getById(Integer.parseInt(id));
					
					request.setAttribute("assenza", assenza);
					
					view = "";
				}
				
			}
			else if(ACTION_GET_BY_UTENTE_ID.equals(action)) {
				if(id != null) {
					assenze = assenzaDao.getByUtenteId(Integer.parseInt(id));
					
					request.setAttribute("assenze", assenze);
					
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
			String id_utente = request.getParameter("id_utente");
			String data_evento = request.getParameter("data_evento");
			String tipo = request.getParameter("tipo");
			String ora_evento = request.getParameter("ora_evento");
			String giustificata = request.getParameter("giustificata");
			String motivazione = request.getParameter("motivazione");
			String giustificata_da = request.getParameter("giustificata_da");
			String data_giustifica = request.getParameter("data_giustifica");
			String action = request.getParameter("action");
			
			if(ACTION_INSERT.equals(action)) {
				assenzaDao.insert(Integer.parseInt(id_utente),
						data_evento,
						tipo,
						ora_evento,
						Boolean.parseBoolean(giustificata),
						motivazione,
						Integer.parseInt(giustificata_da),
						data_giustifica);
			}
			else if(ACTION_UPDATE.equals(action)){
				assenzaDao.update(Integer.parseInt(id_utente),
						data_evento,
						tipo,
						ora_evento,
						Boolean.parseBoolean(giustificata),
						motivazione,
						Integer.parseInt(giustificata_da),
						data_giustifica,
						Integer.parseInt(id));
			}
			
			response.sendRedirect("Assenza");
			
		}catch(Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}
}
