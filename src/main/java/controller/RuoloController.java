package controller;

import java.io.IOException;
import java.util.List;

import dao.RuoloDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Ruolo;

public class RuoloController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private static final String ACTION_GET_ALL = "GETALL";
	private static final String ACTION_GET_BY_ID = "GETBYID";
	private static final String ACTION_GET_BY_NOME_RUOLO = "GETBYNOMERUOLO";
	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	
	private RuoloDAO ruoloDao = null;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public RuoloController() {
        super();


    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);

			ruoloDao = new RuoloDAO(getServletContext().getRealPath("/") + config.getServletContext().getInitParameter("config"));

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
		String nome = null;
		
		Ruolo ruolo = null;	
		List<Ruolo> ruoli;
		try {
			action = request.getParameter("action");
			id = request.getParameter("id");
			nome = request.getParameter("nome");
			
			if(ACTION_DELETE.equals(action)) {
				if(id != null) {
					ruoloDao.delete(Integer.parseInt(id));
					
					view = "";
				}
				
			}
			else if(ACTION_GET_ALL.equals(action)) {
				ruoli = ruoloDao.getAll();
				
				request.setAttribute("ruoli", ruoli);
				
				view = "";
				
			}
			else if(ACTION_GET_BY_ID.equals(action)) {
				if(id != null) {
					ruolo = ruoloDao.getById(Integer.parseInt(id));
					
					request.setAttribute("ruolo", ruolo);
					
					view = "";
				}
				
			}
			else if(ACTION_GET_BY_NOME_RUOLO.equals(action)){
				if(nome != null) {
					ruolo = ruoloDao.getByNomeRuolo(nome);
					
					request.setAttribute("ruolo", ruolo);
					
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
			String nome = request.getParameter("nome");
			String gestione_utenti = request.getParameter("gestione_utenti");
			String voti_modifica_tutti = request.getParameter("voti_modifica_tutti");
			String voti_visualizza_tutti = request.getParameter("voti_visualizza_tutti");
			String voti_modifica_propri = request.getParameter("voti_modifica_propri");
			String voti_visualizza_propri = request.getParameter("voti_visualizza_propri");
			String voti_visualizza_classe = request.getParameter("voti_visualizza_classe");
			String orario_modifica = request.getParameter("orario_modifica");
			String orario_visualizza = request.getParameter("orario_visualizza");
			String aule_modifica = request.getParameter("aule_modifica");
			String aule_visualizza = request.getParameter("aule_visualizza");
			String bacheca_pubblica = request.getParameter("bacheca_pubblica");
			String bacheca_visualizza = request.getParameter("bacheca_visualizza");
			String dati_visualizza = request.getParameter("dati_visualizza");
			String assenze_inserimento = request.getParameter("assenze_inserimento");
			String assenze_visualizza_classe = request.getParameter("assenze_visualizza_classe");
			String assenze_visualizza_proprie = request.getParameter("assenze_visualizza_proprie");
			String assenze_giustifica = request.getParameter("assenze_giustifica");
			String assenze_approva_giustifica = request.getParameter("assenze_approva_giustifica");
			String action = request.getParameter("action");
			
			if(ACTION_INSERT.equals(action)) {
				ruoloDao.insert(nome,
						Boolean.parseBoolean(gestione_utenti),
						Boolean.parseBoolean(voti_modifica_tutti),
						Boolean.parseBoolean(voti_visualizza_tutti),
						Boolean.parseBoolean(voti_modifica_propri),
						Boolean.parseBoolean(voti_visualizza_propri),
						Boolean.parseBoolean(voti_visualizza_classe),
						Boolean.parseBoolean(orario_modifica),
						Boolean.parseBoolean(orario_visualizza),
						Boolean.parseBoolean(aule_modifica),
						Boolean.parseBoolean(aule_visualizza),
						Boolean.parseBoolean(bacheca_pubblica),
						Boolean.parseBoolean(bacheca_visualizza),
						Boolean.parseBoolean(dati_visualizza),
						Boolean.parseBoolean(assenze_inserimento),
						Boolean.parseBoolean(assenze_visualizza_classe),
						Boolean.parseBoolean(assenze_visualizza_proprie),
						Boolean.parseBoolean(assenze_giustifica),
						Boolean.parseBoolean(assenze_approva_giustifica)
						);
			}
			else if(ACTION_UPDATE.equals(action)){
				ruoloDao.update(nome,
						Boolean.parseBoolean(gestione_utenti),
						Boolean.parseBoolean(voti_modifica_tutti),
						Boolean.parseBoolean(voti_visualizza_tutti),
						Boolean.parseBoolean(voti_modifica_propri),
						Boolean.parseBoolean(voti_visualizza_propri),
						Boolean.parseBoolean(voti_visualizza_classe),
						Boolean.parseBoolean(orario_modifica),
						Boolean.parseBoolean(orario_visualizza),
						Boolean.parseBoolean(aule_modifica),
						Boolean.parseBoolean(aule_visualizza),
						Boolean.parseBoolean(bacheca_pubblica),
						Boolean.parseBoolean(bacheca_visualizza),
						Boolean.parseBoolean(dati_visualizza),
						Boolean.parseBoolean(assenze_inserimento),
						Boolean.parseBoolean(assenze_visualizza_classe),
						Boolean.parseBoolean(assenze_visualizza_proprie),
						Boolean.parseBoolean(assenze_giustifica),
						Boolean.parseBoolean(assenze_approva_giustifica),
						Integer.parseInt(id)
						);
			}
			
			response.sendRedirect("Ruolo");
			
		}catch(Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}

}
