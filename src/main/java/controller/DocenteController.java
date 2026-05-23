package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DocenteDao;
import model.Docente;

/**
 * Servlet implementation class DocenteController
 */
@WebServlet("/Docente")
public class DocenteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	private static final String ACTION_EDIT = "EDIT";
	
	private DocenteDao docenteDao = null;
       
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
			docenteDao = new DocenteDao(getServletContext().getRealPath("/") + config.getServletContext().getInitParameter("config"));
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
		
		List<Docente> listDocenti;
		try {
			action = request.getParameter("action");
			id = request.getParameter("id");
			
			if(ACTION_DELETE.equals(action)) {
				if(id != null) {
					docenteDao.delete(Integer.parseInt(id));
					listDocenti = docenteDao.getAll();
					request.setAttribute("docenti", listDocenti);
					view = "view/docente/index.jsp";
				}
				
			} else if(ACTION_EDIT.equals(action)) {
				if(id != null) {
					docente = docenteDao.getByID(Integer.parseInt(id));
					
					request.setAttribute("docente", docente);
					request.setAttribute("id", docente.getId());
					request.setAttribute("action", ACTION_UPDATE);
					
					view = "view/docente/edit.jsp";
				}
				
			} else if(ACTION_INSERT.equals(action)) {
				docente = new Docente();
				
				request.setAttribute("docente", docente);
				request.setAttribute("action", ACTION_INSERT);
				
				view = "view/docente/edit.jsp";
				
			} else {
				listDocenti = docenteDao.getAll();
				request.setAttribute("docenti", listDocenti);
				view = "view/docente/index.jsp";
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
			String materia = request.getParameter("materia");
			String action = request.getParameter("action");
			
			if(ACTION_INSERT.equals(action)) {
				docenteDao.insert(nome, cognome, materia);
			} else {
				docenteDao.update(nome, cognome, materia, Integer.parseInt(id));
			}
			
			response.sendRedirect("Docente");
			
		} catch(Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}
}
