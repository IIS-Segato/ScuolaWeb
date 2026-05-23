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

        String view = null;
        String action = request.getParameter("action");
        String id = request.getParameter("id");

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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utente utente = getUtente(request);
        requireAdmin(utente, response);
        if (response.isCommitted()) return;

        try {
            String id = request.getParameter("id");
            String nome = request.getParameter("nome");
            String cognome = request.getParameter("cognome");
            String materia = request.getParameter("materia");
            String action = request.getParameter("action");

            if (nome == null || nome.trim().isEmpty()
             || cognome == null || cognome.trim().isEmpty()
             || materia == null || materia.trim().isEmpty()) {
                request.setAttribute("errore", "Tutti i campi sono obbligatori.");
                request.setAttribute("docente", new Docente());
                request.setAttribute("action", action);
                RequestDispatcher rd = request.getRequestDispatcher("view/docente/edit.jsp");
                rd.forward(request, response);
                return;
            }

            if (ACTION_INSERT.equals(action)) {
                docenteDao.insert(nome.trim(), cognome.trim(), materia.trim());
            } else {
                docenteDao.update(nome.trim(), cognome.trim(), materia.trim(), Integer.parseInt(id));
            }

            response.sendRedirect("Docente");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e.getMessage());
        }
    }


    private Utente getUtente(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return (session != null) ? (Utente) session.getAttribute("utente") : null;
    }

    private void requireAdmin(Utente utente, HttpServletResponse response)
            throws IOException {
        if (utente == null || !utente.isAdmin()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN,
                "Accesso negato: operazione riservata agli amministratori.");
        }
    }
}