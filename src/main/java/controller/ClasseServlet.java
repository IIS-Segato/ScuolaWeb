package controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ClasseDao;
import dao.DocenteClasseDao;
import dao.DocenteDao;
import dao.StudenteDao;
import model.Classe;
import model.Docente;
import model.Studente;
import utils.DBManager;

@WebServlet("/ClasseServlet")
public class ClasseServlet extends HttpServlet {

	private ClasseDao classeDao;
	private StudenteDao studenteDao;
	private DocenteDao docenteDao;
	private DocenteClasseDao docenteClasseDao;

	@Override
	public void init() throws ServletException {
		Connection conn = DBManager.getConnection();
		classeDao = new ClasseDao(conn);
		studenteDao = new StudenteDao(conn);
		docenteDao = new DocenteDao(conn);
		docenteClasseDao = new DocenteClasseDao(conn);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String action = req.getParameter("action");
		if (action == null) {
			action = "list";
		}

		switch (action) {

		case "list":
			listClassi(req, resp);
			break;

		case "studenti":
			studentiClasse(req, resp);
			break;

		case "assegnaForm":
			mostraFormAssegnazione(req, resp);
			break;

		default:
			listClassi(req, resp);
			break;
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String action = req.getParameter("action");

		if ("assegna".equals(action)) {
			assegnaDocenteClasse(req, resp);
		} else {
			resp.sendRedirect("ClasseServlet?action=list");
		}
	}

	// LISTA CLASSI

	private void listClassi(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		List<Classe> classi = classeDao.getAll();
		req.setAttribute("classi", classi);
		req.getRequestDispatcher("classi.jsp").forward(req, resp);
	}

	// STUDENTI DI UNA CLASSE

	private void studentiClasse(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int idClasse = Integer.parseInt(req.getParameter("id"));

		List<Studente> studenti = studenteDao.getByClasse(idClasse);
		Classe c = classeDao.getById(idClasse);

		req.setAttribute("studenti", studenti);
		req.setAttribute("nomeClasse", c.getNome());

		req.getRequestDispatcher("studentiClasse.jsp").forward(req, resp);
	}

	// FORM ASSEGNAZIONE DOCENTE → CLASSE

	private void mostraFormAssegnazione(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		List<Docente> docenti = docenteDao.getAll();
		List<Classe> classi = classeDao.getAll();

		req.setAttribute("docenti", docenti);
		req.setAttribute("classi", classi);

		req.getRequestDispatcher("docentiClasse.jsp").forward(req, resp);
	}

	// ASSEGNA DOCENTE A CLASSE

	private void assegnaDocenteClasse(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		int idDocente = Integer.parseInt(req.getParameter("idDocente"));
		int idClasse = Integer.parseInt(req.getParameter("idClasse"));

		docenteClasseDao.assegna(idDocente, idClasse);

		resp.sendRedirect("ClasseServlet?action=list");
	}
}
