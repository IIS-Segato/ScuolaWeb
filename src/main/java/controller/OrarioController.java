package controller;

import dao.OrarioDAO;
import model.Orario;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

public class OrarioController extends HttpServlet {

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

            if ("GETALL".equals(action)) {

                List<Orario> list = dao.getAll();

                request.setAttribute("orari", list);

                request.getRequestDispatcher("/orario.jsp")
                        .forward(request, response);
                return;
            }

            response.sendRedirect("Orario?action=GETALL");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

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

            response.sendRedirect("Orario?action=GETALL");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}