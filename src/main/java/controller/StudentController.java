package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.StudentDao;
import model.Role;
import model.Student;

@WebServlet("/Student")
public class StudentController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String ACTION_INSERT = "INSERT";
    private static final String ACTION_DELETE = "DELETE";
    private static final String ACTION_UPDATE = "UPDATE";
    private static final String ACTION_EDIT = "EDIT";

    private StudentDao studentDao = null;

    public StudentController() {
        super();
    }

    public void init(ServletConfig config) throws ServletException {
        try {
            super.init(config);

            studentDao = new StudentDao(
                getServletContext().getRealPath("/") + config.getServletContext().getInitParameter("config")
            );

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String view = null;
        String action = null;
        String id = null;
        Student student = null;

        List<Student> listStudents;

        try {
            action = request.getParameter("action");
            id = request.getParameter("id");

            if (ACTION_DELETE.equals(action)) {

                if (!isAdmin(request)) {
                    response.sendRedirect("Student");
                    return;
                }

                if (id != null) {
                    studentDao.delete(Integer.parseInt(id));
                    response.sendRedirect("Student");
                    return;
                }

            } else if (ACTION_EDIT.equals(action)) {

                if (!isAdmin(request)) {
                    response.sendRedirect("Student");
                    return;
                }

                if (id != null) {
                    student = studentDao.getByID(Integer.parseInt(id));

                    request.setAttribute("student", student);
                    request.setAttribute("id", student.getId());
                    request.setAttribute("action", ACTION_UPDATE);

                    view = "view/student/edit.jsp";
                }

            } else if (ACTION_INSERT.equals(action)) {

                if (!isAdmin(request)) {
                    response.sendRedirect("Student");
                    return;
                }

                student = new Student();

                request.setAttribute("student", student);
                request.setAttribute("action", ACTION_INSERT);

                view = "view/student/edit.jsp";

            } else {

                listStudents = studentDao.getAll();

                request.setAttribute("students", listStudents);

                view = "view/student/index.jsp";
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher(view);
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            if (!isAdmin(request)) {
                response.sendRedirect("Student");
                return;
            }

            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String className = request.getParameter("className");
            String action = request.getParameter("action");

            if (isEmpty(name) || isEmpty(surname) || isEmpty(className)) {

                Student student = new Student();

                if (id != null && !id.isEmpty()) {
                    student.setId(Integer.parseInt(id));
                }

                student.setName(name);
                student.setSurname(surname);
                student.setClassName(className);

                request.setAttribute("student", student);
                request.setAttribute("action", action);
                request.setAttribute("error", "Compila tutti i campi obbligatori.");

                RequestDispatcher dispatcher = request.getRequestDispatcher("view/student/edit.jsp");
                dispatcher.forward(request, response);
                return;
            }

            if (ACTION_INSERT.equals(action)) {
                studentDao.insert(name.trim(), surname.trim(), className.trim());

            } else if (ACTION_UPDATE.equals(action)) {
                studentDao.update(name.trim(), surname.trim(), className.trim(), Integer.parseInt(id));
            }

            response.sendRedirect("Student");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e.getMessage());
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