package controller;

import java.io.IOException;
import java.util.List;
import dao.DocenteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Docente;

@WebServlet("/DocentiController")
public class DocentiController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private DocenteDAO docenteDao;

    public void init() throws ServletException {
        try {
            docenteDao = new DocenteDAO(getServletContext().getRealPath("/") + getServletContext().getInitParameter("config"));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utenteId") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        try {
            // Recupera la lista dei docenti con i nuovi campi inclusi
            List<Docente> listaDocenti = docenteDao.getAll();
            request.setAttribute("listaDocenti", listaDocenti);
            
            // Inoltra i dati alla dashboard dello studente
            request.getRequestDispatcher("/home_studente.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}