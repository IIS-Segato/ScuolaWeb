package controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ClasseDao;
import dao.DocenteClasseDao;
import dao.DocenteDao;
import dao.StudenteDao;
import dao.UserAdminDao;
import model.Classe;
import model.Docente;
import model.Studente;
import model.User;
import utils.DBManager;

@WebServlet("/DocenteServlet")
public class DocenteServlet extends HttpServlet {

	private DocenteDao docenteDao;
	private DocenteClasseDao docenteClasseDao;
	private StudenteDao studenteDao;
	private ClasseDao classeDao;
	private UserAdminDao userAdminDao;

	@Override
	public void init() throws ServletException {
		Connection conn = DBManager.getConnection();
		docenteDao = new DocenteDao(conn);
		docenteClasseDao = new DocenteClasseDao(conn);
		studenteDao = new StudenteDao(conn);
		classeDao = new ClasseDao(conn);
		userAdminDao = new UserAdminDao(conn);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User u = (User) req.getSession().getAttribute("user");
		if (u == null) {
			resp.sendRedirect("login.jsp");
			return;
		}

		if (u.getRoleId() != 1 && u.getRoleId() != 2 && u.getRoleId() != 3) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		String action = req.getParameter("action");
		if ("add".equals(action) && (u.getRoleId() == 1 || u.getRoleId() == 3)) {
			req.setAttribute("classi", classeDao.getAll());
			req.getRequestDispatcher("formDocente.jsp").forward(req, resp);
			return;
		}

		Docente docenteLoggato = u.getRoleId() == 2 ? findLoggedDocente(u) : null;
		List<Docente> docenti = u.getRoleId() == 2
				? (docenteLoggato != null ? List.of(docenteLoggato) : java.util.Collections.emptyList())
				: docenteDao.getAll();
		Map<Integer, List<Classe>> classiPerDocente = new HashMap<>();
		Map<Integer, List<Studente>> studentiPerClasse = new HashMap<>();

		for (Docente d : docenti) {
			if (d == null) {
				continue;
			}

			List<Classe> classi = docenteClasseDao.getClassiByDocente(d.getId());
			classiPerDocente.put(d.getId(), classi);

			for (Classe c : classi) {
				studentiPerClasse.put(c.getId(), studenteDao.getByClasse(c.getId()));
			}
		}

		req.setAttribute("docenti", docenti);
		req.setAttribute("classiPerDocente", classiPerDocente);
		req.setAttribute("studentiPerClasse", studentiPerClasse);
		req.getRequestDispatcher("docenti.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User u = (User) req.getSession().getAttribute("user");
		if (u == null) {
			resp.sendRedirect("login.jsp");
			return;
		}

		if (u.getRoleId() != 1 && u.getRoleId() != 3) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		String action = req.getParameter("action");
		if ("insert".equals(action)) {
			Docente d = new Docente();
			d.setNome(req.getParameter("nome"));
			d.setCognome(req.getParameter("cognome"));
			int idDocente = docenteDao.insert(d);

			if (idDocente > 0) {
				User nuovoUtente = new User();
				nuovoUtente.setUsername(req.getParameter("username"));
				nuovoUtente.setPassword(req.getParameter("password"));
				nuovoUtente.setRoleId(2);
				nuovoUtente.setIdDocente(idDocente);
				userAdminDao.insert(nuovoUtente);
			}

			String[] idClassi = req.getParameterValues("idClassi");
			if (idDocente > 0 && idClassi != null) {
				for (String idClasse : idClassi) {
					docenteClasseDao.assegna(idDocente, Integer.parseInt(idClasse));
				}
			}
		}

		resp.sendRedirect("DocenteServlet?action=list");
	}

	private Docente findLoggedDocente(User u) {
		for (Docente d : docenteDao.getAll()) {
			if (d.getId() == u.getIdDocente()) {
				return d;
			}
		}
		return null;
	}
}
