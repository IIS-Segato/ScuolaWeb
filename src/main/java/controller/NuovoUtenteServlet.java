package controller;

import dao.ClassiDAO;
import model.Classe;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/nuovoUtente")
public class NuovoUtenteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ClassiDAO dao = new ClassiDAO();
        List<Classe> classi = dao.trovaTutte();
        request.setAttribute("classi", classi);

        request.getRequestDispatcher("/view/role/nuovoUtente.jsp").forward(request, response);
    }
}