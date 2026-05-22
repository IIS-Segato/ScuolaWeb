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

import dao.VotoDao;
import model.User;
import model.Voto;
import utils.DBManager;

@WebServlet("/VotoServlet")
public class VotoServlet extends HttpServlet {

	private VotoDao votoDao;

	@Override
	public void init() throws ServletException {
		Connection conn = DBManager.getConnection();
		votoDao = new VotoDao(conn);
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
			if (u.getRoleId() == 2 && u.getIdDocente() > 0) {
				req.setAttribute("studenti", votoDao.getStudentiByDocente(u.getIdDocente()));
				req.setAttribute("idDocente", u.getIdDocente());
				req.getRequestDispatcher("formVoto.jsp").forward(req, resp);
			} else {
				resp.sendRedirect("notAuthorized.jsp");
			}
			break;

		case "edit":
			if (u.getRoleId() == 2 && u.getIdDocente() > 0) {
				int id = Integer.parseInt(req.getParameter("id"));
				Voto v = votoDao.getById(id);

				if (v == null || v.getIdDocente() != u.getIdDocente()) {
					resp.sendRedirect("notAuthorized.jsp");
					return;
				}

				req.setAttribute("voto", v);
				req.setAttribute("studenti", votoDao.getStudentiByDocente(u.getIdDocente()));
				req.setAttribute("idDocente", u.getIdDocente());
				req.getRequestDispatcher("formVoto.jsp").forward(req, resp);
			} else {
				resp.sendRedirect("notAuthorized.jsp");
			}
			break;

		case "delete":
			if (u.getRoleId() == 2 && u.getIdDocente() > 0) {
				int id = Integer.parseInt(req.getParameter("id"));
				Voto v = votoDao.getById(id);

				if (v == null || v.getIdDocente() != u.getIdDocente()) {
					resp.sendRedirect("notAuthorized.jsp");
					return;
				}

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
			if (u.getRoleId() == 2 && u.getIdDocente() > 0) {
				int idStudente = Integer.parseInt(req.getParameter("idStudente"));
				if (!votoDao.isStudenteAssegnatoADocente(u.getIdDocente(), idStudente)) {
					resp.sendRedirect("notAuthorized.jsp");
					return;
				}

				Voto v = new Voto();
				v.setIdStudente(idStudente);
				v.setIdDocente(u.getIdDocente());
				v.setMateria(req.getParameter("materia"));
				v.setVoto(Double.parseDouble(req.getParameter("voto")));
				v.setData(Date.valueOf(req.getParameter("data")));

				votoDao.insert(v);
				resp.sendRedirect("VotoServlet?action=list");
			} else {
				resp.sendRedirect("notAuthorized.jsp");
			}
			break;

		case "update":
			if (u.getRoleId() == 2 && u.getIdDocente() > 0) {
				int id = Integer.parseInt(req.getParameter("id"));
				int idStudente = Integer.parseInt(req.getParameter("idStudente"));
				Voto votoEsistente = votoDao.getById(id);
				if (votoEsistente == null || votoEsistente.getIdDocente() != u.getIdDocente()
						|| !votoDao.isStudenteAssegnatoADocente(u.getIdDocente(), idStudente)) {
					resp.sendRedirect("notAuthorized.jsp");
					return;
				}

				Voto v = new Voto();
				v.setId(id);
				v.setIdStudente(idStudente);
				v.setIdDocente(u.getIdDocente());
				v.setMateria(req.getParameter("materia"));
				v.setVoto(Double.parseDouble(req.getParameter("voto")));
				v.setData(Date.valueOf(req.getParameter("data")));

				votoDao.update(v);
				resp.sendRedirect("VotoServlet?action=list");
			} else {
				resp.sendRedirect("notAuthorized.jsp");
			}
			break;

		default:
			resp.sendRedirect("VotoServlet?action=list");
			break;
		}
	}

	private void list(HttpServletRequest req, HttpServletResponse resp, User u) throws ServletException, IOException {

		List<Voto> lista;

		if (u.getRoleId() == 4) {
			lista = votoDao.getAllByStudente(u.getIdStudente());
		} else if (u.getRoleId() == 2) {
			lista = votoDao.getAllByDocente(u.getIdDocente());
		} else {
			lista = votoDao.getAll();
		}

		req.setAttribute("voti", lista);
		req.getRequestDispatcher("voti.jsp").forward(req, resp);
	}
}
