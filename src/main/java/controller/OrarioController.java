package controller;

import dao.OrarioDAO;
import model.Orario;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/OrarioController")
public class OrarioController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private OrarioDAO dao;

    public void init(ServletConfig config) throws ServletException {
        try {
            super.init(config);
            dao = new OrarioDAO(
                getServletContext().getRealPath("/") +
                config.getServletContext().getInitParameter("config")
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            // CONTROLLO DI SICUREZZA: L'utente è loggato?
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("utenteId") == null) {
                response.sendRedirect(request.getContextPath() + "/LoginController");
                return;
            }

            // Se l'azione è null o GETALL, carichiamo l'orario completo di dettagli testuali
            if (action == null || "GETALL".equals(action)) {
                
                // MODIFICATO: Usiamo il nuovo metodo con le INNER JOIN
                List<Orario> list = dao.getAllWithDetails(); 

                request.setAttribute("orari", list);
                request.getRequestDispatcher("/orario.jsp").forward(request, response);
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Errore nel caricamento dell'orario");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("utenteId") == null) {
                response.sendRedirect(request.getContextPath() + "/LoginController");
                return;
            }

            String id = request.getParameter("id");
            String ins = request.getParameter("id_insegnamento");
            String aula = request.getParameter("id_aula");
            String giorno = request.getParameter("giorno");
            String inizio = request.getParameter("ora_inizio");
            String fine = request.getParameter("ora_fine");
            String action = request.getParameter("action");

            if ("INSERT".equals(action)) {
                dao.insert(Integer.parseInt(ins), Integer.parseInt(aula), giorno, inizio, fine);
            } else if ("UPDATE".equals(action)) {
                dao.update(Integer.parseInt(ins), Integer.parseInt(aula), giorno, inizio, fine, Integer.parseInt(id));
            }

            response.sendRedirect(request.getContextPath() + "/OrarioController");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e.getMessage());
        }
    }
}