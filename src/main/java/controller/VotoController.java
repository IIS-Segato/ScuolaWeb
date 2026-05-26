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
		    jakarta.servlet.http.HttpSession session = request.getSession(false);
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
}
