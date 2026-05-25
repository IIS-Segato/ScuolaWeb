package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.StudenteDao;
import dao.VotoDao;
import dao.ComunicatoDao;
import dao.OrarioDao;
import model.Studente;
import model.Voto;
import model.Comunicato;
import model.Orario;

@WebServlet("/StudentDashboardServlet")
public class StudenteDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		// Sicurezza: controlla se la sessione esiste e se l'utente è loggato
		if (session == null || session.getAttribute("utenteLoggato") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		// Recuperiamo l'ID salvato dalla LoginServlet
		String idStudenteStr = (String) session.getAttribute("utenteLoggato");

		try {
			String xmlPath = getServletContext().getRealPath("/WEB-INF/dbcfg.xml");

			// Inizializziamo i DAO
			StudenteDao studenteDao = new StudenteDao(xmlPath);
			OrarioDao orarioDao = new OrarioDao(xmlPath);
			VotoDao votoDao = new VotoDao(xmlPath);
			ComunicatoDao comunicatoDao = new ComunicatoDao(xmlPath);

			// 1. Recupero l'oggetto Studente dal DB usando l'ID
			Studente studente = studenteDao.getStudenteById(idStudenteStr);

			if (studente != null) {
				List<Orario> orarioLezioni = orarioDao.getOrarioByClasse(studente.getClasse());
				List<Voto> listaVoti = votoDao.getVotiByStudente(studente.getId());
				List<Comunicato> comunicati = comunicatoDao.getAllComunicati();

				request.setAttribute("studente", studente);
				request.setAttribute("orari", orarioLezioni);
				request.setAttribute("voti", listaVoti);
				request.setAttribute("comunicati", comunicati);
				request.getRequestDispatcher("/WEB-INF/view/studente_dashboard.jsp").forward(request, response);
			}

			// Chiusura connessioni
			studenteDao.closeConnection();
			orarioDao.closeConnection();
			votoDao.closeConnection();
			comunicatoDao.closeConnection();
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("login.jsp?errore=errore_interno");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response); // Gestisce le richieste POST allo stesso modo
	}
}