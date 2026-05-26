package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.jdom2.JDOMException;

import dao.AnnuncioDAO;
import dao.AnnuncioClasseDAO;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Annuncio;
import model.AnnuncioClasse;

@WebServlet("/AnnunciController")
public class AnnunciController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private AnnuncioDAO annuncioDao;
    private AnnuncioClasseDAO annuncioClasseDao;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        String path = getServletContext().getRealPath("/") + getServletContext().getInitParameter("config");
        try {
			this.annuncioDao = new AnnuncioDAO(path);
			this.annuncioClasseDao = new AnnuncioClasseDAO(path);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JDOMException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utenteId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String tipo = request.getParameter("tipo"); // "CLASSE" per annunci di classe, altrimenti generali

        try {
            if ("CLASSE".equals(tipo)) {
                // LOGICA ANNUNCI DI CLASSE
                Integer idClasse = (Integer) session.getAttribute("idClasse");
                List<AnnuncioClasse> lista = (idClasse != null) 
                                           ? annuncioClasseDao.getByIdClasse(idClasse) 
                                           : annuncioClasseDao.getAll();
                
                request.setAttribute("annunciClasse", lista);
                request.getRequestDispatcher("/annuncioClasse.jsp").forward(request, response);
                
            } else {
                // LOGICA ANNUNCI GENERALI
                List<Annuncio> lista = annuncioDao.getAll();
                request.setAttribute("annunci", lista);
                request.getRequestDispatcher("/annunci.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Logica di inserimento/update mantenuta separata se necessario
        // Oppure centralizzata tramite parametro tipo
        doGet(request, response);
    }
}