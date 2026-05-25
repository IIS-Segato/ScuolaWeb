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

import dao.RoleDao;
import model.Role;
import model.User;

@WebServlet("/Role")
public class RoleController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	private static final String ACTION_EDIT = "EDIT";

	private RoleDao roleDao;

	@Override
	public void init(ServletConfig config) throws ServletException {

		try {

			super.init(config);

			String xmlPath = getServletContext().getRealPath("/")
					+ config.getServletContext().getInitParameter("config");

			roleDao = new RoleDao(xmlPath);

		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		User user = (User) request.getSession().getAttribute("user");

		if (user == null || !user.isAdmin()) {

			response.sendRedirect("Studente");
			return;
		}

		String action = request.getParameter("action");
		String id = request.getParameter("id");

		String view = null;

		try {

			if (ACTION_DELETE.equals(action)) {

				if (id != null) {
					roleDao.delete(Integer.parseInt(id));
				}

				request.setAttribute("roles", roleDao.getAll());

				view = "view/role/index.jsp";

			} else if (ACTION_EDIT.equals(action)) {

				Role role = roleDao.getByID(Integer.parseInt(id));

				request.setAttribute("role", role);
				request.setAttribute("action", ACTION_UPDATE);

				view = "view/role/edit.jsp";

			} else if (ACTION_INSERT.equals(action)) {

				request.setAttribute("role", new Role());
				request.setAttribute("action", ACTION_INSERT);

				view = "view/role/edit.jsp";

			} else {

				List<Role> roles = roleDao.getAll();

				request.setAttribute("roles", roles);

				view = "view/role/index.jsp";
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

		if (user == null || !user.isAdmin()) {

			response.sendRedirect("Studente");
			return;
		}

		try {

			String id = request.getParameter("id");
			String role_name = request.getParameter("role_name");
			String description = request.getParameter("description");
			String action = request.getParameter("action");

			if (role_name == null || role_name.trim().isEmpty()) {

				throw new Exception("Nome ruolo obbligatorio");
			}

			if (ACTION_INSERT.equals(action)) {

				roleDao.insert(role_name.trim(), description.trim());

			} else {

				roleDao.update(role_name.trim(), description.trim(), Integer.parseInt(id));
			}

			response.sendRedirect("Role");

		} catch (Exception e) {

			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}
}
