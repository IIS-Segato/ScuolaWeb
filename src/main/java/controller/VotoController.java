package controller;

import java.io.IOException;
import java.util.List;

import dao.VotoDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Voto;

@WebServlet("/VotoController")
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
		    
		    // CONTROLLO DI SICUREZZA: L'utente è loggato?
		    jakarta.servlet.http.HttpSession session = request.getSession(false);
		    if (session == null || session.getAttribute("utenteId") == null) {
		        response.sendRedirect(request.getContextPath() + "/LoginController");
		        return;
		    }

		    // Se l'azione non è specificata, assumiamo che uno studente voglia vedere i suoi voti
		    if (action == null) {
		        // Recuperiamo l'ID della persona/studente direttamente dalla sessione per evitare manomissioni dall'URL
		        // (Nota: Assicurati di aver salvato questo attributo nel LoginController al momento del login)
		        Integer idStudenteLoggato = (Integer) session.getAttribute("utenteId"); 
		        voti = votoDao.getWithMateriaByStudentId(idStudenteLoggato);
		        request.setAttribute("voti", voti);
		        view = "/voti.jsp";
		    }
		    else if(ACTION_GET_BY_STUDENTE_ID.equals(action)){
		        if(id != null) {
		            voti = votoDao.getWithMateriaByStudentId(Integer.parseInt(id));
		            request.setAttribute("voti", voti);
		            view = "/voti.jsp"; // Impostiamo la vista corretta
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
		    // ... mantieni gli altri tuoi blocchi else if (DELETE, INSEGNAMENTO) ...

		    if (view != null && !view.isEmpty()) {
		        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		        dispatcher.forward(request, response);
		    }
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
