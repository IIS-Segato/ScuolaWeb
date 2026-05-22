package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.RoleDao;
import model.Role;

@WebServlet("/Role")
public class RoleController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	private static final String ACTION_EDIT = "EDIT";

	private RoleDao roleDao = null;

	public RoleController() {
		super();
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);

			String configPath = getServletContext().getRealPath("/") +
				config.getServletContext().getInitParameter("config");

			roleDao = new RoleDao(configPath);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException("Errore durante l'inizializzazione di RoleController", e);
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {

		String view;
		String action = request.getParameter("action");
		String id = request.getParameter("id");

		try {
			// Role management should also be protected.
			if (!isAdmin(request)) {
				response.sendRedirect("Role");
				return;
			}

			if (ACTION_DELETE.equalsIgnoreCase(action)) {
				if (id != null && !id.isBlank()) {
					roleDao.delete(Integer.parseInt(id));
				}

				response.sendRedirect("Role");
				return;
			}

			if (ACTION_EDIT.equalsIgnoreCase(action)) {
				if (id != null && !id.isBlank()) {
					Role role = roleDao.getByID(Integer.parseInt(id));
					request.setAttribute("role", role);
					request.setAttribute("id", role.getId());
					request.setAttribute("action", ACTION_UPDATE);
					view = "view/role/edit.jsp";
				} else {
					response.sendRedirect("Role");
					return;
				}
			} else if (ACTION_INSERT.equalsIgnoreCase(action)) {
				Role role = new Role();
				request.setAttribute("role", role);
				request.setAttribute("action", ACTION_INSERT);
				view = "view/role/edit.jsp";
			} else {
				List<Role> listRoles = roleDao.getAll();
				request.setAttribute("roles", listRoles);
				view = "view/role/index.jsp";
			}

			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage(), e);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {

		try {
			if (!isAdmin(request)) {
				response.sendRedirect("Role");
				return;
			}

			String id = request.getParameter("id");
			String roleName = request.getParameter("role_name");
			String description = request.getParameter("description");
			String action = request.getParameter("action");

			if (isEmpty(roleName) || isEmpty(description)) {
				Role role = new Role();

				if (id != null && !id.isBlank()) {
					role.setId(Integer.parseInt(id));
				}

				role.setRole_name(roleName);
				role.setDescription(description);

				request.setAttribute("role", role);
				request.setAttribute("action", action);
				request.setAttribute("error", "Compila tutti i campi obbligatori.");

				RequestDispatcher dispatcher = request.getRequestDispatcher("view/role/edit.jsp");
				dispatcher.forward(request, response);
				return;
			}

			if (ACTION_INSERT.equalsIgnoreCase(action)) {
				roleDao.insert(roleName.trim(), description.trim());
			} else if (ACTION_UPDATE.equalsIgnoreCase(action)) {
				roleDao.update(roleName.trim(), description.trim(), Integer.parseInt(id));
			}

			response.sendRedirect("Role");

		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage(), e);
		}
	}

	private boolean isEmpty(String value) {
		return value == null || value.trim().isEmpty();
	}

	private boolean isAdmin(HttpServletRequest request) {
		HttpSession session = request.getSession(false);

		if (session == null) {
			return false;
		}

		Object roleObj = session.getAttribute("role");
		if (roleObj == null) {
			roleObj = session.getAttribute("ruolo");
		}
		if (roleObj == null) {
			roleObj = session.getAttribute("role_name");
		}

		String roleName = null;

		if (roleObj instanceof Role) {
			roleName = ((Role) roleObj).getRole_name();
		} else if (roleObj instanceof String) {
			roleName = (String) roleObj;
		}

		if (roleName == null) {
			return false;
		}

		return roleName.equalsIgnoreCase("admin")
			|| roleName.equalsIgnoreCase("administrator")
			|| roleName.equalsIgnoreCase("amministratore");
	}
}
