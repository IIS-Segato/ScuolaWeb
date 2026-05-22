package controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DocenteDao;
import dao.ClasseDao;
import dao.StudenteDao;
import dao.UserAdminDao;
import dao.VotoDao;
import model.Classe;
import model.Docente;
import model.Studente;
import model.User;
import model.Voto;
import utils.DBManager;

@WebServlet("/StudenteServlet")
public class StudenteServlet extends HttpServlet {

	private StudenteDao studenteDao;
	private DocenteDao docenteDao;
	private VotoDao votoDao;
	private ClasseDao classeDao;
	private UserAdminDao userAdminDao;

	@Override
	public void init() throws ServletException {
		Connection conn = DBManager.getConnection(getServletContext());

		studenteDao = new StudenteDao(conn);
		docenteDao = new DocenteDao(conn);
		votoDao = new VotoDao(conn);
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

		if (u.getRoleId() == 1 || u.getRoleId() == 3) {
			String action = req.getParameter("action");
			if ("add".equals(action)) {
				req.setAttribute("classi", classeDao.getAll());
				req.getRequestDispatcher("formStudente.jsp").forward(req, resp);
			} else {
				req.setAttribute("studenti", studenteDao.getAll());
				req.setAttribute("classi", classeDao.getAll());
				req.getRequestDispatcher("studenti.jsp").forward(req, resp);
			}
			return;
		}

		if (u.getRoleId() != 4) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		int idStudente = u.getIdStudente();

		Studente studente = studenteDao.getById(idStudente);
		Classe classe = studenteDao.getClasseByStudente(idStudente);
		List<Docente> professori = docenteDao.getDocentiByStudente(idStudente);
		List<Voto> voti = votoDao.getAllByStudente(idStudente);
		List<Studente> compagni = classe != null ? studenteDao.getByClasse(classe.getId()) : java.util.Collections.emptyList();

		req.setAttribute("studente", studente);
		req.setAttribute("classe", classe);
		req.setAttribute("professori", professori);
		req.setAttribute("voti", voti);
		req.setAttribute("compagni", compagni);

		req.getRequestDispatcher("studente.jsp").forward(req, resp);
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
			Studente s = new Studente();
			s.setNome(req.getParameter("nome"));
			s.setCognome(req.getParameter("cognome"));
			int idClasse = Integer.parseInt(req.getParameter("idClasse"));
			studenteDao.insert(s, idClasse);

			if (s.getId() > 0) {
				User nuovoUtente = new User();
				nuovoUtente.setUsername(req.getParameter("username"));
				nuovoUtente.setPassword(req.getParameter("password"));
				nuovoUtente.setRoleId(4);
				nuovoUtente.setIdStudente(s.getId());
				userAdminDao.insert(nuovoUtente);
			}
		}

		resp.sendRedirect("StudenteServlet?action=list");
	}
}
