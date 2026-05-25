package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DocenteDao;
import dao.StudenteDao;
import model.Docente;
import model.Studente;
import model.User;

@WebServlet("/Docente")
public class DocenteController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private DocenteDao docenteDao;
	private StudenteDao studenteDao;

	@Override
	public void init(ServletConfig config) throws ServletException {

		try {

			super.init(config);

			String xmlPath = getServletContext().getRealPath("/")
					+ config.getServletContext().getInitParameter("config");

			docenteDao = new DocenteDao(xmlPath);

			studenteDao = new StudenteDao(xmlPath);

		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res)

			throws ServletException, IOException {

		User user = (User) req.getSession().getAttribute("user");

		String classe = req.getParameter("classe");

		try {

			// ADMIN
			if (user.isAdmin()) {

				req.setAttribute("docenti", docenteDao.getAll());

				req.getRequestDispatcher("view/docente/index.jsp").forward(req, res);

				return;
			}

			// STUDENTE
			if (user.isStudente()) {

				Studente studente = studenteDao.getByID(user.getStudenteId());

				List<Docente> docenti = docenteDao.getByClasse(studente.getClasseId());

				req.setAttribute("docenti", docenti);

				req.setAttribute("classeCorrente", studente.getNomeClasse());

				req.getRequestDispatcher("view/docente/index.jsp").forward(req, res);

				return;
			}

			// DOCENTE
			if (user.isDocente()) {

				// CLICK SU CLASSE
				if (classe != null) {

					List<Studente> studenti = studenteDao.getByNomeClasse(classe);

					req.setAttribute("studenti", studenti);

					req.setAttribute("classeCorrente", classe);

					req.getRequestDispatcher("view/docente/studenti.jsp").forward(req, res);

					return;
				}

				// LISTA CLASSI
				List<String> classi = docenteDao.getClassiDocente(user.getDocenteId());

				req.setAttribute("classiDocente", classi);

				req.getRequestDispatcher("view/docente/classi.jsp").forward(req, res);
			}

		} catch (Exception e) {

			e.printStackTrace();
		}
	}
}