package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AdminDAO;
import dao.ComunicatoDao;
import model.Admin;
import model.Comunicato;
import utils.StringUtils;

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
			ComunicatoDao comunicatoDao = new ComunicatoDao(xmlPath);

			// Recupero l'oggetto Admin dal DB usando l'ID
			Admin admin = adminDao.getAdminById(idAdminStr);

			if (admin != null) {
				List<Comunicato> comunicati = comunicatoDao.getAllComunicati();
				// Mando tutto alla JSP
				request.setAttribute("admin", admin);
				request.setAttribute("comunicati", comunicati);
				request.getRequestDispatcher("/WEB-INF/view/admin_dashboard.jsp").forward(request, response);
			} else {
				response.sendRedirect("login.jsp?errore=admin_non_trovato");
			}

			// Chiusura connessioni
			adminDao.closeConnection();
			comunicatoDao.closeConnection();

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("login.jsp?errore=errore_interno");
		}
	}

	// Gestisce l'invio dei vari form
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
			// --- GESTIONE DOCENTI ---

			// CASO 1: L'utente vuole INSERIRE un nuovo docente
			if ("inserisci".equals(azione)) {
				String nome = request.getParameter("nome");
				String cognome = request.getParameter("cognome");
				String materia = request.getParameter("materia");
				String password = StringUtils.encrypt(request.getParameter("password"));
				
				
				
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
				boolean successo = adminDao.rimuoviDocente(idDocente);
				adminDao.closeConnection();

				if (successo) {
					response.sendRedirect("AdminDashboardServlet?messaggio=docente_eliminato_con_successo");
				} else {
					response.sendRedirect("AdminDashboardServlet?errore=errore_eliminazione");
				}
			}

			// --- GESTIONE STUDENTI ---

			// CASO 3: L'utente vuole INSERIRE un nuovo studente
			else if ("inserisci_studente".equals(azione)) {
				String nome = request.getParameter("nome");
				String cognome = request.getParameter("cognome");
				String classe = request.getParameter("classe");
				String password = StringUtils.encrypt(request.getParameter("password"));

				if (nome == null || cognome == null || classe == null || password == null) {
					response.sendRedirect("AdminDashboardServlet?errore=campi_mancanti");
					return;
				}

				AdminDAO adminDao = new AdminDAO(xmlPath);
				boolean successo = adminDao.insertStudente(nome, cognome, classe, password);
				adminDao.closeConnection();

				if (successo) {
					response.sendRedirect("AdminDashboardServlet?messaggio=studente_inserito_con_successo");
				} else {
					response.sendRedirect("AdminDashboardServlet?errore=inserimento_studente_fallito");
				}
			}

			// CASO 4: L'utente vuole ELIMINARE uno studente tramite ID
			else if ("elimina_studente".equals(azione)) {
				String idStudente = request.getParameter("id_studente");

				if (idStudente == null || idStudente.trim().isEmpty()) {
					response.sendRedirect("AdminDashboardServlet?errore=id_mancante");
					return;
				}

				AdminDAO adminDao = new AdminDAO(xmlPath);
				boolean successo = adminDao.rimuoviStudente(idStudente);
				adminDao.closeConnection();

				if (successo) {
					response.sendRedirect("AdminDashboardServlet?messaggio=studente_eliminato_con_successo");
				} else {
					response.sendRedirect("AdminDashboardServlet?errore=errore_eliminazione_studente");
				}
			}
			
			// --- GESTIONE COMUNICATI ---
			
			// CASO 5: L'utente vuole INSERIRE un comunicato
			else if ("inserisci_comunicato".equals(azione)) {
				String titolo = request.getParameter("titolo");
				String testo = request.getParameter("testo");
				String data = request.getParameter("data");
				
				ComunicatoDao comunicatoDao = new ComunicatoDao(xmlPath);
				boolean successo = comunicatoDao.insertComunicato(titolo, testo, data);
				comunicatoDao.closeConnection();
				
				if (successo) {
					response.sendRedirect("AdminDashboardServlet?messaggio=comunicato_inserito_con_successo");
				} else {
					response.sendRedirect("AdminDashboardServlet?errore=errore_inserimento_comunicato");
				}
			}
			
			// CASO 6: L'utente vuole ELIMINARE un comunicato
			else if ("elimina_comunicato".equals(azione)) {
				String idComunicatoStr = request.getParameter("id_comunicato");
				int idComunicato = Integer.parseInt(idComunicatoStr);
				
				ComunicatoDao comunicatoDao = new ComunicatoDao(xmlPath);
				boolean successo = comunicatoDao.deleteComunicato(idComunicato);
				comunicatoDao.closeConnection();
				
				if (successo) {
					response.sendRedirect("AdminDashboardServlet?messaggio=comunicato_eliminato_con_successo");
				} else {
					response.sendRedirect("AdminDashboardServlet?errore=errore_eliminazione_comunicato");
				}
			}

			// Caso di fallback
			else {
				response.sendRedirect("AdminDashboardServlet");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("AdminDashboardServlet?errore=errore_interno");
		}
	}
}