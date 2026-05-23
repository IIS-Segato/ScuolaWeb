package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.StudenteDAO;
import model.Studente;
import model.Utente;

@WebServlet("/Studente")
public class StudenteController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	private static final String ACTION_EDIT = "EDIT";

	private StudenteDAO studenteDao;

	@Override
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);
			studenteDao = new StudenteDAO(
					getServletContext().getRealPath("/") + config.getServletContext().getInitParameter("config"));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String view = null;
		String action = request.getParameter("action");
		String id = request.getParameter("id");
		String filtroClasse = request.getParameter("classe");

		Utente utente = getUtente(request);

		try {
			if (ACTION_DELETE.equals(action)) {
				requireAdmin(utente, response);
				if (response.isCommitted())
					return;
				if (id != null)
					studenteDao.delete(Integer.parseInt(id));
				response.sendRedirect("Studente");
				return;

			} else if (ACTION_EDIT.equals(action)) {
				requireAdmin(utente, response);
				if (response.isCommitted())
					return;
				Studente s = studenteDao.getByID(Integer.parseInt(id));
				request.setAttribute("studente", s);
				request.setAttribute("action", ACTION_UPDATE);
				view = "view/studente/edit.jsp";

			} else if (ACTION_INSERT.equals(action)) {
				requireAdmin(utente, response);
				if (response.isCommitted())
					return;
				request.setAttribute("studente", new Studente());
				request.setAttribute("action", ACTION_INSERT);
				view = "view/studente/edit.jsp";

			} else {

				List<Studente> lista;
				if (filtroClasse != null && !filtroClasse.isEmpty()) {
					lista = studenteDao.getByClasse(filtroClasse);
					request.setAttribute("filtroClasse", filtroClasse);
				} else {
					lista = studenteDao.getAll();
				}
				request.setAttribute("studenti", lista);
				view = "view/studente/index.jsp";
			}

			RequestDispatcher rd = request.getRequestDispatcher(view);
			rd.forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Utente utente = getUtente(request);
		requireAdmin(utente, response);
		if (response.isCommitted())
			return;

		try {
			String id = request.getParameter("id");
			String nome = request.getParameter("nome");
			String cognome = request.getParameter("cognome");
			String classe = request.getParameter("classe");
			String action = request.getParameter("action");

			if (nome == null || nome.trim().isEmpty() || cognome == null || cognome.trim().isEmpty() || classe == null
					|| classe.trim().isEmpty()) {
				request.setAttribute("errore", "Tutti i campi sono obbligatori.");
				request.setAttribute("studente", new Studente());
				request.setAttribute("action", action);
				RequestDispatcher rd = request.getRequestDispatcher("view/studente/edit.jsp");
				rd.forward(request, response);
				return;
			}

			if (ACTION_INSERT.equals(action)) {
				studenteDao.insert(nome.trim(), cognome.trim(), classe.trim());
			} else {
				studenteDao.update(nome.trim(), cognome.trim(), classe.trim(), Integer.parseInt(id));
			}

			response.sendRedirect("Studente");

		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}

	private Utente getUtente(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		return (session != null) ? (Utente) session.getAttribute("utente") : null;
	}

	private void requireAdmin(Utente utente, HttpServletResponse response) throws IOException {
		if (utente == null || !utente.isAdmin()) {
			response.sendError(HttpServletResponse.SC_FORBIDDEN,
					"Accesso negato: operazione riservata agli amministratori.");
		}
	}
}
