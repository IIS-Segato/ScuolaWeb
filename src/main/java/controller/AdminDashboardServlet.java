package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AdminDAO;
import model.Admin;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Gestisce il caricamento della Dashboard
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Sicurezza: controlla se la sessione esiste e se l'utente è loggato
        if (session == null || session.getAttribute("utenteLoggato") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Recuperiamo l'ID salvato dalla LoginServlet
        String idAdminStr = (String) session.getAttribute("utenteLoggato");
        
        try {
            String xmlPath = getServletContext().getRealPath("/WEB-INF/dbcfg.xml");

            // Inizializziamo il DAO
            AdminDAO adminDao = new AdminDAO(xmlPath);

            // Recupero l'oggetto Admin dal DB usando l'ID
            Admin admin = adminDao.getAdminById(idAdminStr);

            if (admin != null) {
                // Mando tutto alla JSP
                request.setAttribute("admin", admin);
                request.getRequestDispatcher("/WEB-INF/view/admin_dashboard.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp?errore=admin_non_trovato");
            }

            // Chiusura connessioni
            adminDao.closeConnection();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?errore=errore_interno");
        }
    }

    // Gestisce l'invio del form per inserire un nuovo docente
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Sicurezza: controlla se la sessione esiste
        if (session == null || session.getAttribute("utenteLoggato") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 1. Recupero i parametri dal form della JSP
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String materia = request.getParameter("materia");
        String password = request.getParameter("password");

        // Se per qualche motivo i parametri sono nulli, rimando alla dashboard
        if (nome == null || cognome == null || materia == null || password == null) {
            doGet(request, response);
            return;
        }

        try {
            String xmlPath = getServletContext().getRealPath("/WEB-INF/dbcfg.xml");
            
            // 2. Inizializzo l'AdminDAO ed eseguo l'inserimento
            AdminDAO adminDao = new AdminDAO(xmlPath);
            boolean successo = adminDao.insertDocente(nome, cognome, materia, password);
            
            // Chiusura connessione
            adminDao.closeConnection();

            // 3. Reindirizzo in base al risultato per far comparire i banner (messaggio/errore)
            if (successo) {
                response.sendRedirect("AdminDashboardServlet?messaggio=docente_inserito_con_successo");
            } else {
                response.sendRedirect("AdminDashboardServlet?errore=inserimento_fallito");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminDashboardServlet?errore=errore_interno");
        }
    }
}