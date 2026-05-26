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
import jakarta.servlet.http.HttpSession;
import model.Voto;

@WebServlet("/VotoController")
public class VotoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
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
		List<Voto> voti;
		
		try {
		    
		    // CONTROLLO DI SICUREZZA: L'utente è loggato?
		    HttpSession session = request.getSession(false);
		    if (session == null || session.getAttribute("utenteId") == null) {
		        response.sendRedirect(request.getContextPath() + "/LoginController");
		        return;
		    }


	        // Recuperiamo l'ID della persona/studente direttamente dalla sessione per evitare manomissioni dall'URL
	        // (Nota: Assicurati di aver salvato questo attributo nel LoginController al momento del login)
	        Integer idStudenteLoggato = (Integer) session.getAttribute("utenteId"); 
	        voti = votoDao.getWithMateriaByStudentId(idStudenteLoggato);
	        request.setAttribute("voti", voti);
	        view = "/voti.jsp";
		    
		    if (view != null && !view.isEmpty()) {
		        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		        dispatcher.forward(request, response);
		    }
		} catch (Exception e) {
		    e.printStackTrace();
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String action = request.getParameter("action");
	    HttpSession session = request.getSession(false);

	    // Sicurezza: Solo i docenti possono inserire voti
	    if (session == null || !"DOCENTE".equals(session.getAttribute("nomeRuolo"))) {
	        response.sendRedirect("LoginController");
	        return;
	    }

	    if ("INSERT".equals(action)) {
	        try {
	            int idStudente = Integer.parseInt(request.getParameter("id_studente"));
	            int idInsegnamento = Integer.parseInt(request.getParameter("id_insegnamento"));
	            int voto = Integer.parseInt(request.getParameter("voto"));
	            String dataVoto = request.getParameter("data_voto");
	            String descrizione = request.getParameter("descrizione");

	            // Chiamata al DAO per l'inserimento
	            boolean success = votoDao.insert(idStudente, idInsegnamento, voto, dataVoto, descrizione);

	            if (success) {
	                response.sendRedirect("VotoController?msg=success");
	            } else {
	                request.setAttribute("errore", "Inserimento fallito.");
	                request.getRequestDispatcher("/aggiungiVoto.jsp").forward(request, response);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.sendError(500, "Errore durante l'inserimento del voto");
	        }
	    }
	}
}
