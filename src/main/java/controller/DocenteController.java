package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DocenteDao;
import model.Docente;
import model.Utente;

@WebServlet("/Docente")
public class DocenteController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String ACTION_INSERT = "INSERT";
    private static final String ACTION_DELETE = "DELETE";
    private static final String ACTION_UPDATE = "UPDATE";
    private static final String ACTION_EDIT   = "EDIT";

    private DocenteDao docenteDao;

    @Override
    public void init(ServletConfig config) throws ServletException {
        try {
            super.init(config);
            docenteDao = new DocenteDao(
                getServletContext().getRealPath("/")
                + config.getServletContext().getInitParameter("config"));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String view   = null;
        String action = request.getParameter("action");
        String id     = request.getParameter("id");

        Utente utente = getUtente(request);

        try {
            if (ACTION_DELETE.equals(action)) {
                requireAdmin(utente, response);
                if (response.isCommitted()) return;
                if (id != null) docenteDao.delete(Integer.parseInt(id));
                response.sendRedirect("Docente");
                return;

            } else if (ACTION_EDIT.equals(action)) {
                requireAdmin(utente, response);
                if (response.isCommitted()) return;
                Docente d = docenteDao.getByID(Integer.parseInt(id));
                request.setAttribute("docente", d);
                request.setAttribute("action", ACTION_UPDATE);
                view = "view/docente/edit.jsp";

            } else if (ACTION_INSERT.equals(action)) {
                requireAdmin(utente, response);
                if (response.isCommitted()) return;
                request.setAttribute("docente", new Docente());
                request.setAttribute("action", ACTION_INSERT);
                view = "view/docente/edit.jsp";

            } else {
                List<Docente> lista = docenteDao.getAll();
                request.setAttribute("docenti", lista);
                view = "view/docente/index.jsp";
            }

            RequestDispatcher rd = request.getRequestDispatcher(view);
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e.getMessage());
        }
    }
