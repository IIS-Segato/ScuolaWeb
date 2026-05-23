package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.UserDao;
import model.User;

@WebServlet("/Login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDao userDao;

    @Override
    public void init(ServletConfig config) throws ServletException {
        try {
            super.init(config);
            String xmlPath = getServletContext().getRealPath("/")
                           + config.getServletContext().getInitParameter("config");
            userDao = new UserDao(xmlPath);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /** GET → mostra il form di login */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Se già loggato, vai alla home
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            res.sendRedirect("Studente");
            return;
        }
        req.getRequestDispatcher("view/login.jsp").forward(req, res);
    }

    /** POST → verifica le credenziali */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        try {
            User user = userDao.login(username, password);
            if (user != null) {
                HttpSession session = req.getSession(true);
                session.setAttribute("user", user);
                res.sendRedirect("Studente");
            } else {
                req.setAttribute("errore", "Username o password non corretti.");
                req.getRequestDispatcher("view/login.jsp").forward(req, res);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errore", "Errore interno del server.");
            req.getRequestDispatcher("view/login.jsp").forward(req, res);
        }
    }
}