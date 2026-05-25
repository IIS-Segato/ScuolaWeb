package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AdminDAO;
import model.Admin;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Gestisce il caricamento della Dashboard
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		// Sicurezza: controlla se la sessione esiste e se l'utente è loggato
		if (session == null || session.getAttribute("utenteLoggato") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		// Recuperiamo l'ID salvato dalla LoginServlet
		String idAdminStr = (String) session.getAttribute("utenteLoggato");

		try {
			String xmlPath = getServletContext().getRealPath("/WEB-INF/dbcfg.xml");

			// Inizializziamo il DAO
			AdminDAO adminDao = new AdminDAO(xmlPath);

			// Recupero l'oggetto Admin dal DB usando l'ID
			Admin admin = adminDao.getAdminById(idAdminStr);

			if (admin != null) {
				// Mando tutto alla JSP
				request.setAttribute("admin", admin);
				request.getRequestDispatcher("/WEB-INF/view/admin_dashboard.jsp").forward(request, response);
			} else {
				response.sendRedirect("login.jsp?errore=admin_non_trovato");
			}

			// Chiusura connessioni
			adminDao.closeConnection();

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("login.jsp?errore=errore_interno");
		}
	}

	// Gestisce l'invio del form per inserire un nuovo docente
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		// Sicurezza: controlla se l'utente è loggato
		if (session == null || session.getAttribute("utenteLoggato") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		// Recuperiamo il valore del campo hidden per capire quale form è stato premuto
		String azione = request.getParameter("azione");
		String xmlPath = getServletContext().getRealPath("/WEB-INF/dbcfg.xml");

		try {
			// CASO 1: L'utente vuole INSERIRE un nuovo docente
			if ("inserisci".equals(azione)) {
				String nome = request.getParameter("nome");
				String cognome = request.getParameter("cognome");
				String materia = request.getParameter("materia");
				String password = request.getParameter("password");

				if (nome == null || cognome == null || materia == null || password == null) {
					response.sendRedirect("AdminDashboardServlet?errore=campi_mancanti");
					return;
				}

				AdminDAO adminDao = new AdminDAO(xmlPath);
				boolean successo = adminDao.insertDocente(nome, cognome, materia, password);
				adminDao.closeConnection();

				if (successo) {
					response.sendRedirect("AdminDashboardServlet?messaggio=docente_inserito_con_successo");
				} else {
					response.sendRedirect("AdminDashboardServlet?errore=inserimento_fallito");
				}
			}

			// CASO 2: L'utente vuole ELIMINARE un docente tramite ID
			else if ("elimina".equals(azione)) {
				String idDocente = request.getParameter("id_docente");

				if (idDocente == null || idDocente.trim().isEmpty()) {
					response.sendRedirect("AdminDashboardServlet?errore=id_mancante");
					return;
				}

				AdminDAO adminDao = new AdminDAO(xmlPath);
				// Chiamata al nuovo metodo che hai appena aggiunto in AdminDAO
				boolean successo = adminDao.rimuoviDocente(idDocente);
				adminDao.closeConnection();

				if (successo) {
					// Rimanda alla dashboard mostrando il banner verde di successo
					response.sendRedirect("AdminDashboardServlet?messaggio=docente_eliminato_con_successo");
				} else {
					// Rimanda alla dashboard mostrando il banner rosso specifico per l'eliminazione
					response.sendRedirect("AdminDashboardServlet?errore=errore_eliminazione");
				}
			}

			// Caso di fallback se l'azione non corrisponde a nessuna delle due
			else {
				response.sendRedirect("AdminDashboardServlet");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("AdminDashboardServlet?errore=errore_interno");
		}
	}
}