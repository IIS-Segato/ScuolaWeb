package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.OrarioDao;
import dao.StudenteDao;
import model.Orario;
import model.Studente;
import model.User;

@WebServlet("/Orario")
public class OrarioController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private OrarioDao orarioDao;
	private StudenteDao studenteDao;

	@Override
	public void init(ServletConfig config) throws ServletException {

		try {

			super.init(config);

			String xmlPath = getServletContext().getRealPath("/")
					+ config.getServletContext().getInitParameter("config");

			orarioDao = new OrarioDao(xmlPath);

			studenteDao = new StudenteDao(xmlPath);

		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res)

			throws ServletException, IOException {

		User user = (User) req.getSession().getAttribute("user");

		try {

			// STUDENTE
			if (user.isStudente()) {

				Studente studente = studenteDao.getByID(user.getStudenteId());

				List<Orario> orario = orarioDao.getByClasse(studente.getClasseId());

				req.setAttribute("orario", orario);

				req.setAttribute("titolo", "Orario classe " + studente.getNomeClasse());

				req.getRequestDispatcher("view/orario/index.jsp").forward(req, res);

				return;
			}

			// DOCENTE
			if (user.isDocente()) {

				List<Orario> orario = orarioDao.getByDocente(user.getDocenteId());

				req.setAttribute("orario", orario);

				req.setAttribute("titolo", "Il mio orario");

				req.getRequestDispatcher("view/orario/index.jsp").forward(req, res);

				return;
			}

			res.sendRedirect("Studente");

		} catch (Exception e) {

			e.printStackTrace();
		}
	}
}