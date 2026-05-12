package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.OrarioDAO;
import model.Aula;

@WebServlet("/orario")
public class OrarioServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	// Crea un'istanza del DAO per accedere ai dati delle aule
        OrarioDAO dao = new OrarioDAO();
        // Recupera tutte le aule disponibili dal database
        List<Aula> listaAule = dao.trovaAule();
        // Aggiunge la lista come attributo della request, rendendola accessibile alla JSP
        request.setAttribute("listaAule", listaAule);
        // Inoltra la richiesta alla pagina JSP che mostrerà l'orario
        request.getRequestDispatcher("/view/role/orario.jsp").forward(request, response);
    }
}