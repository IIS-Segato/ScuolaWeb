package controller;

import java.io.IOException;
import java.util.List;

import dao.AnnuncioDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Annuncio;

public class AnnuncioController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private static final String ACTION_GET_ALL = "GETALL";
	private static final String ACTION_GET_BY_ID = "GETBYID";
	private static final String ACTION_GET_BY_AUTORE = "GETBYAUTORE";
	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	
	private AnnuncioDAO annuncioDao = null;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public AnnuncioController() {
        super();


    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);

			annuncioDao = new AnnuncioDAO(getServletContext().getRealPath("/") + config.getServletContext().getInitParameter("config"));

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
		String autore = null;
		
		Annuncio annuncio = null;	
		List<Annuncio> annunci;
		try {
			action = request.getParameter("action");
			id = request.getParameter("id");
			autore = request.getParameter("autore");
			
			if(ACTION_DELETE.equals(action)) {
				if(id != null) {
					annuncioDao.delete(Integer.parseInt(id));
					
					view = "";
				}
				
			}
			else if(ACTION_GET_ALL.equals(action)) {
				annunci = annuncioDao.getAll();
				
				request.setAttribute("annunci", annunci);
				
				view = "/notizie_private.jsp";
				
			}
			else if(ACTION_GET_BY_ID.equals(action)) {
				if(id != null) {
					annuncio = annuncioDao.getById(Integer.parseInt(id));
					
					request.setAttribute("annuncio", annuncio);
					
					view = "";
				}
				
			}
			else if(ACTION_GET_BY_AUTORE.equals(action)){
				if(id != null) {
					annunci = annuncioDao.getByIdAutore(Integer.parseInt(autore));
					
					request.setAttribute("annunci", annunci);
					
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
			String titolo = request.getParameter("titolo");
			String contenuto = request.getParameter("contenuto");
			String data_pubblicazione = request.getParameter("data_pubblicazione");
			String autore = request.getParameter("autore");
			String action = request.getParameter("action");
			
			if(ACTION_INSERT.equals(action)) {
				annuncioDao.insert(titolo, contenuto, data_pubblicazione, Integer.parseInt(autore));
			}
			else if(ACTION_UPDATE.equals(action)){
				annuncioDao.update(titolo, contenuto, data_pubblicazione, Integer.parseInt(autore), Integer.parseInt(id));
			}
			
			response.sendRedirect("Annuncio");
			
		}catch(Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}

}
