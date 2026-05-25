package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DocenteDao;
import dao.OrarioDao;
import dao.VotoDao; // Assicurati di aver creato il VotoDao visto in precedenza
import model.Docente;
import model.Orario;

@WebServlet("/DocenteDashboardServlet")
public class DocenteDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 1. Il GET si occupa solo di mostrare la Dashboard (Invariato, tranne VotoDao se serve)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Sicurezza: controlla se la sessione esiste e se l'utente è loggato
        if (session == null || session.getAttribute("utenteLoggato") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Recuperiamo l'ID salvato dalla LoginServlet
        String idDocenteStr = (String) session.getAttribute("utenteLoggato");

        try {
            String xmlPath = getServletContext().getRealPath("/WEB-INF/dbcfg.xml");
            
            // Inizializziamo i DAO
            DocenteDao docenteDao = new DocenteDao(xmlPath);
            OrarioDao orarioDao = new OrarioDao(xmlPath);

            // Recupero l'oggetto Docente dal DB usando l'ID
            Docente docente = docenteDao.getDocenteById(idDocenteStr);

            if (docente != null) {
                // Recupero la lista dell'orario in base all'ID del docente 
                List<Orario> orarioLezioni = orarioDao.getOrarioByDocente(docente.getId());

                // Salvo i dati nella request
                request.setAttribute("docente", docente);
                request.setAttribute("orari", orarioLezioni);

                // Mando tutto alla JSP
                request.getRequestDispatcher("/WEB-INF/view/docente_dashboard.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp?errore=docente_non_trovato");
            }

            // Chiusura connessioni
            docenteDao.closeConnection();
            orarioDao.closeConnection();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?errore=errore_interno");
        }
    }

    // 2. Il POST adesso intercetta il form dell'inserimento voti
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Controllo sicurezza sessione anche nel POST
        if (session == null || session.getAttribute("utenteLoggato") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idDocenteStr = (String) session.getAttribute("utenteLoggato");
        
        // Recuperiamo i dati compilati nel form della JSP
        String idStudenteStr = request.getParameter("idStudente");
        String votoStr = request.getParameter("voto");
        String dataStr = request.getParameter("data");
        String descrizione = request.getParameter("descrizione");

        try {
            int idDocente = Integer.parseInt(idDocenteStr);
            int idStudente = Integer.parseInt(idStudenteStr);
            double voto = Double.parseDouble(votoStr);

            String xmlPath = getServletContext().getRealPath("/WEB-INF/dbcfg.xml");
            
            // Sfruttiamo il VotoDao per inserire la riga
            VotoDao votoDao = new VotoDao(xmlPath);
            boolean esito = votoDao.insertVoto(idStudente, idDocente, voto, dataStr, descrizione);
            votoDao.closeConnection();

            if (esito) {
                // Ricarica la dashboard (in GET) notificando il successo
                response.sendRedirect("DocenteDashboardServlet?successo=voto_inserito");
            } else {
                response.sendRedirect("DocenteDashboardServlet?errore=errore_inserimento");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("DocenteDashboardServlet?errore=dati_non_validi");
        }
    }
}