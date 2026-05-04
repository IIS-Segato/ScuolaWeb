package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDao;
import model.Utente;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
	
		// 1. Recupera i parametri dal form HTML
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String ruolo = request.getParameter("ruolo");
		
		// 2. Controlla le credenziali nel DB e recupera l'Oggetto Utente
		// (Immaginiamo che UserDao faccia la query al database)
		UserDao userDao = new UserDao();
		if(!userDao.autentica(id, password)) response.sendRedirect("login.jsp?errore=autenticazione_fallita");;
		Utente utente = new Utente(id, ruolo);
		
		
		if (utente != null) {
			// 3. Credenziali corrette: Creiamo la sessione
			HttpSession session = request.getSession();
			session.setAttribute("utenteLoggato", utente.getId);
			session.setAttribute("ruolo", utente.getRuolo()); // es. "STUDENTE", "ADMIN"...
			
			// 4. Smistamento in base al ruolo
			String ruolo = utente.getRuolo();
			
			switch (ruolo) {
				case "ADMIN":
				// Redirect alla dashboard dell'amministratore
				response.sendRedirect("admin_dashboard.jsp");
				break;
				case "INSEGNANTE":
				// Redirect alla dashboard dell'insegnante
				response.sendRedirect("teacher_dashboard.jsp");
				break;
				case "STUDENTE":
				// Redirect alla dashboard dello studente
				response.sendRedirect("student_dashboard.jsp");
				break;
				default:
				// Ruolo non riconosciuto
				response.sendRedirect("login.jsp?errore=ruolo_sconosciuto");
				break;
			}
			} else {
				// Credenziali errate: torna al login con un messaggio di errore
				response.sendRedirect("login.jsp?errore=credenziali_errate");
			}
	}
}