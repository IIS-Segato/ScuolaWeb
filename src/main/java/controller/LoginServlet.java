package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.Utente;
import dao.UtenteDAO;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UtenteDAO dao = new UtenteDAO();
        Utente utente = dao.trovaPerEmail(email);

        if (utente != null && BCrypt.checkpw(password, utente.getPassword())) {

            // Salvo utente in sessione
            HttpSession session = request.getSession();
            session.setAttribute("utente", utente);

            // Redirect in base al ruolo
            switch (utente.getRuolo()) {
                case "amministratore":
                    response.sendRedirect("admin.jsp");
                    break;
                case "docente":
                    response.sendRedirect("docente.jsp");
                    break;
                case "studente":
                    response.sendRedirect("studente.jsp");
                    break;
                default:
                    response.sendRedirect("index.html");
            }

        } else {
            // login fallito
            request.setAttribute("errore", "Credenziali non valide");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}