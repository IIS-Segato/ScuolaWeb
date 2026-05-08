package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.Utente;
import dao.UtenteDAO;

@WebServlet("/Utente")
public class UtenteServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        UtenteDAO dao = new UtenteDAO();
        String action = request.getParameter("action");
        String email = request.getParameter("email");

        if ("edit".equals(action) && email != null) {
            Utente u = dao.trovaPerEmail(email);
            request.setAttribute("utente", u);
            request.setAttribute("action", "UPDATE");
        }

        request.setAttribute("listaUtenti", dao.trovaTutti());
        request.getRequestDispatcher("view/role/edit.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        Utente u = new Utente();
        u.setNome(request.getParameter("nome"));
        u.setCognome(request.getParameter("cognome"));
        u.setEmail(request.getParameter("email"));
        u.setPassword(request.getParameter("password"));
        u.setRuolo(request.getParameter("ruolo"));

        UtenteDAO dao = new UtenteDAO();
        
        if ("INSERT".equals(action)) {
            dao.inserisciNuovoUtente(u);
        } else {
            dao.aggiorna(u);
        }
        
        // CANCELLA QUESTA RIGA: dao.aggiorna(u); <--- Era qui l'errore

        response.sendRedirect("Utente"); 
    }
}