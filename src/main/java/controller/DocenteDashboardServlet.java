package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ComunicatoDao;
import dao.DocenteDao;
import dao.OrarioDao;
import dao.VotoDao; // Assicurati di aver creato il VotoDao visto in precedenza
import model.Comunicato;
import model.Docente;
import model.Orario;
//Aggiungi questo import in cima al file
import dao.StudenteDao;
import model.Voto;
import model.Studente;

@WebServlet("/DocenteDashboardServlet")
public class DocenteDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 1. Il GET si occupa solo di mostrare la Dashboard
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
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
			ComunicatoDao comunicatoDao = new ComunicatoDao(xmlPath);

			// Recupero l'oggetto Docente dal DB usando l'ID
			Docente docente = docenteDao.getDocenteById(idDocenteStr);

			if (docente != null) {
				// Recupero la lista dell'orario in base all'ID del docente
				List<Orario> orarioLezioni = orarioDao.getOrarioByDocente(docente.getId());
				List<Comunicato> comunicati = comunicatoDao.getAllComunicati();

				VotoDao votoDao = new VotoDao(xmlPath);
				StudenteDao studenteDao = new StudenteDao(xmlPath);

				List<Voto> voti = votoDao.getVotiByDocente(docente.getId());
				List<Studente> studenti = studenteDao.getStudentiByDocente(docente.getId());

				request.setAttribute("voti", voti);
				request.setAttribute("studenti", studenti);

				// e chiudi le connessioni insieme alle altre
				votoDao.closeConnection();
				studenteDao.closeConnection();
				comunicatoDao.closeConnection();

				// Salvo i dati nella request
				request.setAttribute("docente", docente);
				request.setAttribute("orari", orarioLezioni);
				request.setAttribute("comunicati", comunicati);

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

	// 2. Il POST  gestisce sia l'inserimento che la rimozione dei voti
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		// Controllo sicurezza sessione anche nel POST
		if (session == null || session.getAttribute("utenteLoggato") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		String idDocenteStr = (String) session.getAttribute("utenteLoggato");

		// Verifichiamo quale azione vuole compiere il docente
		String action = request.getParameter("action");

		try {
			String xmlPath = getServletContext().getRealPath("/WEB-INF/dbcfg.xml");
			VotoDao votoDao = new VotoDao(xmlPath);
			int idDocente = Integer.parseInt(idDocenteStr);

			if ("elimina".equals(action)) {
				// LOGICA DI RIMOZIONE VOTO
				String idVotoStr = request.getParameter("idVoto");
				int idVoto = Integer.parseInt(idVotoStr);

				boolean esito = votoDao.deleteVoto(idVoto, idDocente);
				votoDao.closeConnection();

				if (esito) {
					response.sendRedirect("DocenteDashboardServlet?successo=voto_eliminato");
				} else {
					response.sendRedirect("DocenteDashboardServlet?errore=errore_eliminazione");
				}

			} else {
				// LOGICA DI INSERIMENTO VOTO 
				String idStudenteStr = request.getParameter("idStudente");
				String votoStr = request.getParameter("voto");
				String dataStr = request.getParameter("data");
				String descrizione = request.getParameter("descrizione");

				int idStudente = Integer.parseInt(idStudenteStr);
				double voto = Double.parseDouble(votoStr);

				boolean esito = votoDao.insertVoto(idStudente, idDocente, voto, dataStr, descrizione);
				votoDao.closeConnection();

				if (esito) {
					response.sendRedirect("DocenteDashboardServlet?successo=voto_inserito");
				} else {
					response.sendRedirect("DocenteDashboardServlet?errore=errore_inserimento");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("DocenteDashboardServlet?errore=dati_non_validi");
		}
	}
}