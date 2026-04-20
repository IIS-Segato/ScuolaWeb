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


/**
 * Servlet implementation class RoleController
 */
@WebServlet("/Role")
public class RoleController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final String ACTION_INSERT = "INSERT";
	private static final String ACTION_DELETE = "DELETE";
	private static final String ACTION_UPDATE = "UPDATE";
	private static final String ACTION_EDIT = "EDIT";
	
	private RoleDao roleDao = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RoleController() {
        super();


    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		try {
			super.init(config);

			roleDao = new RoleDao(getServletContext().getRealPath("/") + config.getServletContext().getInitParameter("config"));

		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String view = null;
		String action = null;
		String id = null;
		Role role = null;
		
		List<Role> listRoles;
		try {
			action = request.getParameter("action");
			id = request.getParameter("id");
			
			if(ACTION_DELETE.equals(action)) {
				if(id != null) {
					roleDao.delete(Integer.parseInt(id));
					
					listRoles = roleDao.getAll();
					
					request.setAttribute("roles", listRoles);
					
					view = "view/role/index.jsp";
				}
				
			}else if(ACTION_EDIT.equals(action)) {
				if(id != null) {
					role = roleDao.getByID(Integer.parseInt(id));
					
				
					request.setAttribute("role", role);
					request.setAttribute("id", role.getId());
					request.setAttribute("action", ACTION_UPDATE);
					
					view = "view/role/edit.jsp";
				}
				
			}else if(ACTION_INSERT.equals(action)) {
				role = new Role();
				
				
				request.setAttribute("role", role);
				request.setAttribute("action", ACTION_INSERT);
				
				view = "view/role/edit.jsp";
				
			}else {
				listRoles = roleDao.getAll();
				
				request.setAttribute("roles", listRoles);

				
				view = "view/role/index.jsp";
			}
			


		
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
		} catch (Exception e) {

			e.printStackTrace();
		}
		
		

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		try {
			String id = request.getParameter("id");
			String role_name = request.getParameter("role_name");
			String description = request.getParameter("description");
			String action = request.getParameter("action");
			
			if(ACTION_INSERT.equals(action)) {
				roleDao.insert(role_name, description);
			}else {
				roleDao.update(role_name, description, Integer.parseInt(id));
			}
			
			response.sendRedirect("Role");
			
		}catch(Exception e) {
			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
	}

}
