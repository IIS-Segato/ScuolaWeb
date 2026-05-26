package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jdom2.JDOMException;

import dao.AmministratoreDAO;
import dao.DocentiDAO;
import model.Amministratore;

/**
 * Servlet implementation class EliminaStudenteController
 */
@WebServlet("/EliminaStudenteController")
public class EliminaStudenteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AmministratoreDAO amministratoreDAO;
	private DocentiDAO docentiDAO;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EliminaStudenteController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    /**
	 * Inizializzazione della servlet
	 */
	@Override
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);
			amministratoreDAO = new AmministratoreDAO(config.getServletContext().getRealPath(config.getServletContext().getInitParameter("config"))); // instanzio docentiDAO
			docentiDAO = new DocentiDAO(config.getServletContext().getRealPath(config.getServletContext().getInitParameter("config"))); // instanzio studentiDAO
		} catch (ClassNotFoundException | JDOMException | IOException | SQLException e) {
			e.printStackTrace();
		} 
	}

	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int aid = Integer.parseInt(request.getParameter("aid"));
		int sid = Integer.parseInt(request.getParameter("sid"));
		int cid = Integer.parseInt(request.getParameter("cid"));
		
		try {
			amministratoreDAO.deleteStudente(sid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// creo l'amministratore
	     Amministratore amministratore = null;
	     		
	     try {
	     	amministratore = amministratoreDAO.getAmministratore(aid, docentiDAO);
	     } catch (SQLException e) {
	     			e.printStackTrace();
	     } catch (ClassNotFoundException e) {
	     	// TODO Auto-generated catch block
	     	e.printStackTrace();
	     } catch (JDOMException e) {
	     	// TODO Auto-generated catch block
	   		e.printStackTrace();
	     }
	     // crea una sessione se questa non esiste
	     HttpSession session = request.getSession();
	   	session.setAttribute("amministratore", amministratore); // salvo l'amministratore in sessione
	    			
	   	response.sendRedirect("view/role/AmministratoreClasse.jsp?cid="+cid); // ritorno alla pagina della Classe del Docente
	}

}
