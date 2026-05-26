package controller;

import java.io.IOException;
import java.util.List;
import dao.InsegnamentoDAO; // MODIFICATO: Import del nuovo DAO
import model.Insegnamento; // MODIFICATO: Import del nuovo Model piatto
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ClassiDocentiController")
public class ClassiDocentiController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private InsegnamentoDAO insegnamentoDao; // MODIFICATO: Tipo switchato a InsegnamentoDAO

    public void init() throws ServletException {
        try {
            // Inizializzazione basata sulla tua architettura XML
            insegnamentoDao = new InsegnamentoDAO(
                getServletContext().getRealPath("/") + 
                getServletContext().getInitParameter("config")
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        // Protezione: se non è loggato, torna al login
        if (session == null || session.getAttribute("utenteId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // 1. Recuperiamo l'ID della persona dalla sessione
            int idPersona = (Integer) session.getAttribute("utenteId");
            
            // 2. Interroghiamo il DB tramite il nuovo DAO degli insegnamenti
            // Questo recupererà l'oggetto con anno, sezione, indirizzo e nome_materia insieme
            List<Insegnamento> listaInsegnamenti = insegnamentoDao.getInsegnamentiByDocentePersonaId(idPersona);
            
            // 3. Prepariamo l'attributo per la JSP (cambia il nome della lista per chiarezza)
            request.setAttribute("listaInsegnamenti", listaInsegnamenti);
            
            // 4. Inoltriamo il flusso alla pagina di interfaccia del docente
            request.getRequestDispatcher("/home_docente.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}