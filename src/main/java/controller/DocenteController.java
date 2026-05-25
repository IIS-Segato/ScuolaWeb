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

import dao.DocenteDao;
import model.Docente;
import model.User;

@WebServlet("/Docente")
public class DocenteController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	private static final String ACTION_EDIT = "EDIT";

	private DocenteDao docenteDao = null;

	@Override
	public void init(ServletConfig config) throws ServletException {

		try {

			super.init(config);

			docenteDao = new DocenteDao(
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

		User user = (User) request.getSession().getAttribute("user");

		try {

			if (ACTION_DELETE.equals(action) && user.isAdmin()) {

				if (id != null) {
					docenteDao.delete(Integer.parseInt(id));
				}

				request.setAttribute("docenti", docenteDao.getAll());

				view = "view/docente/index.jsp";

			} else if (ACTION_EDIT.equals(action) && user.isAdmin()) {

				Docente docente = docenteDao.getByID(Integer.parseInt(id));

				request.setAttribute("docente", docente);
				request.setAttribute("action", ACTION_UPDATE);

				view = "view/docente/edit.jsp";

			} else if (ACTION_INSERT.equals(action) && user.isAdmin()) {

				request.setAttribute("docente", new Docente());
				request.setAttribute("action", ACTION_INSERT);

				view = "view/docente/edit.jsp";

			} else {

				List<Docente> listDocenti = docenteDao.getAll();

				request.setAttribute("docenti", listDocenti);

				view = "view/docente/index.jsp";
			}

			RequestDispatcher dispatcher = request.getRequestDispatcher(view);

			dispatcher.forward(request, response);

		} catch (Exception e) {

			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		User user = (User) request.getSession().getAttribute("user");

		if (!user.isAdmin()) {

			response.sendRedirect("Docente");
			return;
		}

		try {

			String id = request.getParameter("id");
			String nome = request.getParameter("nome");
			String cognome = request.getParameter("cognome");
			String materia = request.getParameter("materia");
			String action = request.getParameter("action");

			if (nome.trim().isEmpty() || cognome.trim().isEmpty() || materia.trim().isEmpty()) {

				throw new Exception("Tutti i campi sono obbligatori");
			}

			if (ACTION_INSERT.equals(action)) {

				docenteDao.insert(nome.trim(), cognome.trim(), materia.trim());

			} else {

				docenteDao.update(nome.trim(), cognome.trim(), materia.trim(), Integer.parseInt(id));
			}

			response.sendRedirect("Docente");

		} catch (Exception e) {

			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}
}