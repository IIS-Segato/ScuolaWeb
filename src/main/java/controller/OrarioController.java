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
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("utenteId") == null) {
                response.sendRedirect(request.getContextPath() + "/LoginController");
                return;
            }

            // Recuperiamo il ruolo dalla sessione per decidere cosa mostrare
            String nomeRuolo = (String) session.getAttribute("nomeRuolo");
            Integer idUtente = (Integer) session.getAttribute("utenteId");
            
            List<Orario> list;

            // Se l'utente è DOCENTE (supponiamo idRuolo = 2)
            if (nomeRuolo.equals("DOCENTE")) {
                // Mostriamo solo l'orario del docente loggato
                list = dao.getByDocente(idUtente);
            } 
            // Se è STUDENTE o altro
            else if (nomeRuolo.equals("STUDENTE")) {
                // Mostriamo l'orario completo o potresti filtrare per classe dello studente
                list = dao.getAllWithDetails();
            } else {
            	list = null;
            }

            request.setAttribute("orari", list);
            request.getRequestDispatcher("/orario.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Errore nel caricamento dell'orario");
        }
    }
}