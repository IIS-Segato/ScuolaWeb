package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.DocenteDAO;
import model.*;

@WebServlet("/docente")
public class DocenteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Prendo l'utente dalla sessione
        Utente u = (Utente) request.getSession().getAttribute("utente");

        // Se non è loggato lo rimando al login
        if (u == null) {
            response.sendRedirect("index.html");
            return;
        }

        DocenteDAO dao = new DocenteDAO();
        int id = u.getId();

        // Carico tutti i dati del docente e li metto nella request
        request.setAttribute("materia",       dao.trovaMateria(id));
        request.setAttribute("classiDocente", dao.trovaClassiDocente(id));
        request.setAttribute("auleDocente",   dao.trovaAulePerDocente(id));
        request.setAttribute("orarioDocente", dao.trovaOrarioDocente(id));

        // Forward alla JSP con i dati pronti
        request.getRequestDispatcher("view/role/docente.jsp").forward(request, response);
    }
}