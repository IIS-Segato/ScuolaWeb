package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.OrarioDAO;
import model.Aula;

@WebServlet("/orario")
public class OrarioServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        OrarioDAO dao = new OrarioDAO();
        List<Aula> listaAule = dao.trovaAule();
        request.setAttribute("listaAule", listaAule);
        request.getRequestDispatcher("/view/role/orario.jsp").forward(request, response);
    }
}