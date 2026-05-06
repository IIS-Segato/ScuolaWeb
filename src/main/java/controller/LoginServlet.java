package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDao;
import model.Utente;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //prendo i parametri dal form
        String id = request.getParameter("id");
        String password = request.getParameter("password");
        String ruolo = request.getParameter("ruolo");
        
        UserDao userDao = null;

        try {
            //passo il percorso del file per la connessione al database TODO:cambia sta roba fa schifo a vedersi 
            String xmlPath = getServletContext().getRealPath("/WEB-INF/dbcfg.xml");
            userDao = new UserDao(xmlPath);

            //controllo credenziali 
            if (!userDao.autentica(id, password, ruolo)) {
                // Se fallisce, reindirizza e FERMA L'ESECUZIONE con il return
                response.sendRedirect("login.jsp?errore=autenticazione_fallita");
                return; 
            }

            //credenziali correte creo la sessione e l utente 
            Utente utente = new Utente(id, ruolo);
            HttpSession session = request.getSession();
            session.setAttribute("utenteLoggato", utente.getId());
            session.setAttribute("ruolo", utente.getRuolo().toUpperCase()); // Convertito in maiuscolo per sicurezza nello switch

            //smisto in base al ruolo 
            String ruoloUtente = (String) session.getAttribute("ruolo"); 

            switch (ruoloUtente) {
                case "ADMIN":
                    response.sendRedirect("AdminDashboardServlet");
                    break;
                case "DOCENTE":
                    response.sendRedirect("DocenteDashboardServlet");
                    break;
                case "STUDENTE":
                    response.sendRedirect("StudentDashboardServlet");
                    break;
                default:
                    response.sendRedirect("login.jsp?errore=ruolo_sconosciuto");
                    break;
            }

        } catch (Exception e) {
            // Gestione in caso di database spento o file XML non trovato
            e.printStackTrace();
            response.sendRedirect("login.jsp?errore=errore_interno");
        } finally {
            //chiusura database 
            if (userDao != null) {
                userDao.closeConnection();
            }
        }
    }
}