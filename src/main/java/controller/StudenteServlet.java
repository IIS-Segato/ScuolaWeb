package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.StudenteDAO;
import model.*;

@WebServlet("/studente")
public class StudenteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utente u = (Utente) request.getSession().getAttribute("utente");

        if (u == null) {
            response.sendRedirect("index.html");
            return;
        }

        StudenteDAO dao = new StudenteDAO();
        int id = u.getId();

        request.setAttribute("classeStudente", dao.trovaClasseStudente(id));
        request.setAttribute("orarioStudente", dao.trovaOrarioStudente(id));

        request.getRequestDispatcher("view/role/studente.jsp").forward(request, response);
    }
}