package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.StudenteDao;
import model.Studente;
import model.User;

@WebServlet("/Studente")
public class SudenteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String ACTION_INSERT = "INSERT";
    private static final String ACTION_DELETE = "DELETE";
    private static final String ACTION_UPDATE = "UPDATE";
    private static final String ACTION_EDIT   = "EDIT";

    private StudenteDao studenteDao;

    @Override
    public void init(ServletConfig config) throws ServletException {
        try {
            super.init(config);
            String xmlPath = getServletContext().getRealPath("/")
                           + config.getServletContext().getInitParameter("config");
            studenteDao = new StudenteDao(xmlPath);
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String view   = null;
        String action = req.getParameter("action");
        String id     = req.getParameter("id");
        User   user   = (User) req.getSession().getAttribute("user");

        try {
            if (ACTION_DELETE.equals(action) && user.isAdmin()) {
                if (id != null) studenteDao.delete(Integer.parseInt(id));
                List<Studente> list = studenteDao.getAll();
                req.setAttribute("studenti", list);
                view = "view/studente/index.jsp";

            } else if (ACTION_EDIT.equals(action) && user.isAdmin()) {
                Studente s = studenteDao.getByID(Integer.parseInt(id));
                req.setAttribute("studente", s);
                req.setAttribute("action", ACTION_UPDATE);
                view = "view/studente/edit.jsp";

            } else if (ACTION_INSERT.equals(action) && user.isAdmin()) {
                req.setAttribute("studente", new Studente());
                req.setAttribute("action", ACTION_INSERT);
                view = "view/studente/edit.jsp";

            } else {
                List<Studente> list = studenteDao.getAll();
                req.setAttribute("studenti", list);
                view = "view/studente/index.jsp";
            }

            req.getRequestDispatcher(view).forward(req, res);

        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("user");
        if (!user.isAdmin()) { res.sendRedirect("Studente"); return; }

        String id      = req.getParameter("id");
        String nome    = req.getParameter("nome");
        String cognome = req.getParameter("cognome");
        String classe  = req.getParameter("classe");
        String action  = req.getParameter("action");

        try {
            if (ACTION_INSERT.equals(action)) {
                studenteDao.insert(nome, cognome, classe);
            } else {
                studenteDao.update(nome, cognome, classe, Integer.parseInt(id));
            }
            res.sendRedirect("Studente");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e.getMessage());
        }
    }
}