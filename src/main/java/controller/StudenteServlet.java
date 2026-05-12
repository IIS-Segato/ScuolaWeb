package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.StudenteDAO;
import model.*;

/**
 * Servlet controller per la visualizzazione della dashboard dello studente.
 * Recupera dalla sessione l'utente loggato e ne mostra classe e orario.
 * Mappata sull'URL "/studente".
 */
@WebServlet("/studente")
public class StudenteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	// Recupera l'utente dalla sessione corrente
        Utente u = (Utente) request.getSession().getAttribute("utente");

        if (u == null) {
            response.sendRedirect("index.html");
            return;
        }

        StudenteDAO dao = new StudenteDAO();
        int id = u.getId();
        // Recupera la classe dello studente e la passa alla JSP
        request.setAttribute("classeStudente", dao.trovaClasseStudente(id));
        //// Recupera l'orario dello studente e lo passa alla JSP
        request.setAttribute("orarioStudente", dao.trovaOrarioStudente(id));
        // Inoltra alla vista della dashboard studente
        request.getRequestDispatcher("view/role/studente.jsp").forward(request, response);
    }
}