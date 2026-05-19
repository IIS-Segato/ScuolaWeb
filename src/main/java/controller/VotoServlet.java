package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DocenteDao;
import dao.StudenteDao;
import dao.VotoDao;
import model.User;
import model.Voto;
import utils.DBManager;

@WebServlet("/VotoServlet")
public class VotoServlet extends HttpServlet {

	private VotoDao votoDao;
	private StudenteDao studenteDao;
	private DocenteDao docenteDao;

	@Override
	public void init() throws ServletException {
		Connection conn = DBManager.getConnection();

		votoDao = new VotoDao(conn);
		studenteDao = new StudenteDao(conn);
		docenteDao = new DocenteDao(conn);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		User u = (User) req.getSession().getAttribute("user");
		if (u == null) {
			resp.sendRedirect("login.jsp");
			return;
		}

		String action = req.getParameter("action");
		if (action == null) {
			action = "list";
		}

		switch (action) {

		case "list":
			list(req, resp, u);
			break;

		case "add":
			if (u.getRoleId() == 2) {
				req.setAttribute("studenti", studenteDao.getAll());
				req.setAttribute("docenti", docenteDao.getAll());
				req.getRequestDispatcher("formVoto.jsp").forward(req, resp);
			} else {
				resp.sendRedirect("notAuthorized.jsp");
			}
			break;

		case "edit":
			if (u.getRoleId() == 2) {
				int id = Integer.parseInt(req.getParameter("id"));
				Voto v = votoDao.getById(id);
				req.setAttribute("voto", v);
				req.setAttribute("studenti", studenteDao.getAll());
				req.setAttribute("docenti", docenteDao.getAll());
				req.getRequestDispatcher("formVoto.jsp").forward(req, resp);
			} else {
				resp.sendRedirect("notAuthorized.jsp");
			}
			break;

		case "delete":
			if (u.getRoleId() == 2) {
				int id = Integer.parseInt(req.getParameter("id"));
				votoDao.delete(id);
				resp.sendRedirect("VotoServlet?action=list");
			} else {
				resp.sendRedirect("notAuthorized.jsp");
			}
			break;

		default:
			list(req, resp, u);
			break;
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		User u = (User) req.getSession().getAttribute("user");
		if (u == null) {
			resp.sendRedirect("login.jsp");
			return;
		}

		String action = req.getParameter("action");

		switch (action) {

		case "insert":
			if (u.getRoleId() == 2) {
				Voto v = new Voto();
				v.setIdStudente(Integer.parseInt(req.getParameter("idStudente")));
				v.setIdDocente(Integer.parseInt(req.getParameter("idDocente")));
				v.setMateria(req.getParameter("materia"));
				v.setVoto(Double.parseDouble(req.getParameter("voto")));
				v.setData(Date.valueOf(req.getParameter("data")));

				votoDao.insert(v);
				resp.sendRedirect("VotoServlet?action=list");
			}
			break;

		case "update":
			if (u.getRoleId() == 2) {
				Voto v = new Voto();
				v.setId(Integer.parseInt(req.getParameter("id")));
				v.setIdStudente(Integer.parseInt(req.getParameter("idStudente")));
				v.setIdDocente(Integer.parseInt(req.getParameter("idDocente")));
				v.setMateria(req.getParameter("materia"));
				v.setVoto(Double.parseDouble(req.getParameter("voto")));
				v.setData(Date.valueOf(req.getParameter("data")));

				votoDao.update(v);
				resp.sendRedirect("VotoServlet?action=list");
			}
			break;

		default:
			resp.sendRedirect("VotoServlet?action=list");
			break;
		}
	}

	/**
	 * ⭐⭐⭐ IL METODO CHE MANCAVA ⭐⭐⭐
	 */
	private void list(HttpServletRequest req, HttpServletResponse resp, User u) throws ServletException, IOException {

		List<Voto> lista;

		if (u.getRoleId() == 4) {
			lista = votoDao.getAllByStudente(u.getId());
		} else {
			lista = votoDao.getAll();
		}

		req.setAttribute("voti", lista);
		req.getRequestDispatcher("voti.jsp").forward(req, resp);
	}
}
