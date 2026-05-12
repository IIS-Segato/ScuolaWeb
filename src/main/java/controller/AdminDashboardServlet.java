package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AdminDAO;
import dao.OrarioDao;
import model.Orario;
import model.Admin;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

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

            // Inizializziamo i DAO
            AdminDAO adminDao = new AdminDAO(xmlPath);

            // 1. Recupero l'oggetto Studente dal DB usando l'ID
            Admin admin = adminDao.getAdminById(idAdminStr);

            if (admin != null) {

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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // Gestisce le richieste POST allo stesso modo
    }
}

