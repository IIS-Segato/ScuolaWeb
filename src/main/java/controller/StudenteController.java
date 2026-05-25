package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.StudenteDao;
import model.Studente;
import model.User;

@WebServlet("/Studente")
public class StudenteController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	private static final String ACTION_EDIT = "EDIT";

	private StudenteDao studenteDao;

	@Override
	public void init(ServletConfig config) throws ServletException {

		try {

			super.init(config);

			String xmlPath = getServletContext().getRealPath("/")
					+ config.getServletContext().getInitParameter("config");

			studenteDao = new StudenteDao(xmlPath);

		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res)

			throws ServletException, IOException {

		String view = null;

		String action = req.getParameter("action");

		String id = req.getParameter("id");

		User user = (User) req.getSession().getAttribute("user");

		try {

			// ADMIN
			if (user.isAdmin()) {

				if (ACTION_DELETE.equals(action)) {

					if (id != null) {

						studenteDao.delete(Integer.parseInt(id));
					}

					req.setAttribute("studenti", studenteDao.getAll());

					view = "view/studente/index.jsp";

				}

				else if (ACTION_EDIT.equals(action)) {

					Studente s = studenteDao.getByID(Integer.parseInt(id));

					req.setAttribute("studente", s);

					req.setAttribute("action", ACTION_UPDATE);

					view = "view/studente/edit.jsp";
				}

				else if (ACTION_INSERT.equals(action)) {

					req.setAttribute("studente", new Studente());

					req.setAttribute("action", ACTION_INSERT);

					view = "view/studente/edit.jsp";
				}

				else {

					req.setAttribute("studenti", studenteDao.getAll());

					view = "view/studente/index.jsp";
				}
			}

			// STUDENTE
			else if (user.isStudente()) {

				Studente studente = studenteDao.getByID(user.getStudenteId());

				List<Studente> listaClasse = studenteDao.getByClasse(studente.getClasseId());

				// RIMUOVE LO STUDENTE LOGGATO
				listaClasse.removeIf(s -> s.getId() == studente.getId());

				req.setAttribute("studenteCorrente", studente);

				req.setAttribute("studenti", listaClasse);

				req.setAttribute("classeCorrente", studente.getNomeClasse());

				view = "view/studente/index.jsp";
			}

			// DOCENTE
			else if (user.isDocente()) {

				res.sendRedirect("Docente");

				return;
			}

			req.getRequestDispatcher(view).forward(req, res);

		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res)

			throws ServletException, IOException {

		User user = (User) req.getSession().getAttribute("user");

		if (!user.isAdmin()) {

			res.sendRedirect("Studente");

			return;
		}

		try {

			String id = req.getParameter("id");

			String nome = req.getParameter("nome");

			String cognome = req.getParameter("cognome");

			int classeId = Integer.parseInt(req.getParameter("classeId"));

			String action = req.getParameter("action");

			if (ACTION_INSERT.equals(action)) {

				studenteDao.insert(nome, cognome, classeId);

			}

			else {

				studenteDao.update(nome, cognome, classeId, Integer.parseInt(id));
			}

			res.sendRedirect("Studente");

		} catch (Exception e) {

			e.printStackTrace();

			throw new ServletException(e.getMessage());
		}
	}
}