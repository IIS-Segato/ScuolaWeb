package controller;
//prova
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
        String ruolo = request.getParameter("ruolo");

        if ("edit".equals(action) && email != null) {
            Utente u = dao.trovaPerEmail(email);
            request.setAttribute("utente", u);
            request.setAttribute("action", "UPDATE");
        }
        else if ("delete".equals(action)) {
            dao.elimina(email, ruolo);
        }

        // Recupera la lista aggiornata per la JSP
        request.setAttribute("listaUtenti", dao.trovaTutti());
        request.getRequestDispatcher("view/role/edit.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        UtenteDAO dao = new UtenteDAO();
        
        // --- RECUPERO L'ACTION (FONDAMENTALE!) ---
        String action = request.getParameter("action");
        
        Utente u = new Utente();
        u.setNome(request.getParameter("nome"));
        u.setCognome(request.getParameter("cognome"));
        u.setEmail(request.getParameter("email"));
        u.setPassword(request.getParameter("password"));
        u.setRuolo(request.getParameter("ruolo"));

        // Scelta tra Inserimento e Aggiornamento
        if ("INSERT".equals(action)) {
            dao.inserisciNuovoUtente(u); // Assicurati di avere questo metodo nel DAO
        } else {
            dao.aggiorna(u);
        }
        
        // Usiamo il redirect verso la Servlet stessa (doGet) 
        // così la lista si aggiorna correttamente senza duplicare i dati
        response.sendRedirect("Utente"); 
    }
}