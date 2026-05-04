package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.Utente;
import dao.UtenteDAO;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UtenteDAO dao = new UtenteDAO();
        Utente utente = dao.trovaPerEmail(email);

        if (utente != null && utente.getPassword().equals(password)) {
            // LOGIN OK
            HttpSession session = request.getSession();
            session.setAttribute("utente", utente);

            String ruolo = utente.getRuolo().toUpperCase(); // Usiamo maiuscolo per sicurezza

            if (ruolo.equals("AMMINISTRATORE")) {
                List<Utente> lista = dao.trovaTutti();
                request.setAttribute("listaUtenti", lista);
                request.setAttribute("utente", utente); // 'utente' è quello appena loggato
                request.setAttribute("action", "UPDATE");
                
                /* 
                 * Spiegazione del metodo (by Roni)
                 * getRequestDispatcher: Individua la destinazione (la pagina JSP).
                 * forward: Passa il controllo alla JSP senza che il browser se ne accorga.
                 * A differenza del redirect, qui il server NON dice al browser di cambiare pagina,
                 * ma "chiama" internamente la JSP e le passa gli oggetti 'request' e 'response'.
                 * Questo permette alla JSP di leggere i dati che abbiamo salvato nel request
                 */
                request.getRequestDispatcher("view/role/edit.jsp").forward(request, response);
            } 
            else if (ruolo.equals("DOCENTE")) {
            	response.sendRedirect("docente");
            } 
            else if (ruolo.equals("STUDENTE")) {
            	response.sendRedirect("view/role/studente.jsp");

            } 
            else {
                response.sendRedirect("index.html");
            }

        } else {
            // LOGIN FALLITO
            response.sendRedirect("errore_credenziali.html");
        }
    }
}