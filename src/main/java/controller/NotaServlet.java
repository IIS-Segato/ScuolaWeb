package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NotaDao;
import model.Nota;
import model.User;
import utils.DBManager;

@WebServlet("/NotaServlet")
public class NotaServlet extends HttpServlet {

	private NotaDao notaDao;

	@Override
	public void init() throws ServletException {
		Connection conn = DBManager.getConnection(getServletContext());
		notaDao = new NotaDao(conn);
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
		case "add":
			mostraFormNuovaNota(req, resp, u);
			break;
		case "edit":
			mostraFormModificaNota(req, resp, u);
			break;
		case "delete":
			deleteNota(req, resp, u);
			break;
		default:
			list(req, resp, u);
			break;
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		User u = (User) req.getSession().getAttribute("user");
		if (u == null) {
			resp.sendRedirect("login.jsp");
			return;
		}

		if (u.getRoleId() != 2 || u.getIdDocente() <= 0) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		String action = req.getParameter("action");
		if ("insert".equals(action)) {
			salvaNota(req, resp, u, false);
		} else if ("update".equals(action)) {
			salvaNota(req, resp, u, true);
		} else {
			resp.sendRedirect("NotaServlet?action=list");
		}
	}

	private void list(HttpServletRequest req, HttpServletResponse resp, User u) throws ServletException, IOException {
		if (u.getRoleId() == 4) {
			req.setAttribute("note", notaDao.getAllByStudente(u.getIdStudente()));
		} else if (u.getRoleId() == 2) {
			req.setAttribute("note", notaDao.getAllByClassiDocente(u.getIdDocente()));
		} else if (u.getRoleId() == 1 || u.getRoleId() == 3) {
			req.setAttribute("note", notaDao.getAll());
		} else {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		req.getRequestDispatcher("note.jsp").forward(req, resp);
	}

	private void mostraFormNuovaNota(HttpServletRequest req, HttpServletResponse resp, User u)
			throws ServletException, IOException {
		if (u.getRoleId() != 2 || u.getIdDocente() <= 0) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		preparaForm(req, u);
		req.getRequestDispatcher("formNota.jsp").forward(req, resp);
	}

	private void mostraFormModificaNota(HttpServletRequest req, HttpServletResponse resp, User u)
			throws ServletException, IOException {
		if (u.getRoleId() != 2 || u.getIdDocente() <= 0) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		int id = parseId(req.getParameter("id"));
		if (id <= 0) {
			resp.sendRedirect("NotaServlet?action=list");
			return;
		}

		Nota nota = notaDao.getById(id);
		if (nota == null || nota.getIdDocente() != u.getIdDocente()) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		req.setAttribute("nota", nota);
		preparaForm(req, u);
		req.getRequestDispatcher("formNota.jsp").forward(req, resp);
	}

	private void deleteNota(HttpServletRequest req, HttpServletResponse resp, User u) throws IOException {
		if (u.getRoleId() != 2 || u.getIdDocente() <= 0) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		int id = parseId(req.getParameter("id"));
		if (id <= 0) {
			resp.sendRedirect("NotaServlet?action=list");
			return;
		}

		Nota nota = notaDao.getById(id);
		if (nota == null || nota.getIdDocente() != u.getIdDocente()) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		notaDao.delete(id);
		resp.sendRedirect("NotaServlet?action=list");
	}

	private void salvaNota(HttpServletRequest req, HttpServletResponse resp, User u, boolean editing)
			throws ServletException, IOException {
		Nota nota = new Nota();
		if (editing) {
			int id = parseId(req.getParameter("id"));
			if (id <= 0) {
				resp.sendRedirect("NotaServlet?action=list");
				return;
			}
			nota.setId(id);
		}

		try {
			nota.setIdStudente(Integer.parseInt(req.getParameter("idStudente")));
			nota.setIdDocente(u.getIdDocente());
			nota.setTipo(req.getParameter("tipo"));
			String testo = req.getParameter("testo");
			nota.setTesto(testo != null ? testo.trim() : null);
			nota.setData(Date.valueOf(req.getParameter("data")));
			nota.setOra(parseOra(req.getParameter("ora")));
		} catch (Exception e) {
			forwardFormConErrore(req, resp, u, nota, "Controlla data, ora e campi obbligatori.");
			return;
		}

		if (!isTipoValido(nota.getTipo()) || nota.getTesto() == null || nota.getTesto().isBlank()) {
			forwardFormConErrore(req, resp, u, nota, "Inserisci il tipo di nota e il testo.");
			return;
		}

		if (nota.getTesto().length() > 1000) {
			forwardFormConErrore(req, resp, u, nota, "Il testo della nota deve restare entro 1000 caratteri.");
			return;
		}

		if (!notaDao.isStudenteAssegnatoADocente(u.getIdDocente(), nota.getIdStudente())) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		if (editing) {
			Nota notaEsistente = notaDao.getById(nota.getId());
			if (notaEsistente == null || notaEsistente.getIdDocente() != u.getIdDocente()) {
				resp.sendRedirect("notAuthorized.jsp");
				return;
			}
			notaDao.update(nota);
		} else {
			notaDao.insert(nota);
		}

		resp.sendRedirect("NotaServlet?action=list");
	}

	private void preparaForm(HttpServletRequest req, User u) {
		req.setAttribute("studenti", notaDao.getStudentiByDocente(u.getIdDocente()));
		req.setAttribute("dataOggi", LocalDate.now().toString());
		req.setAttribute("oraAdesso", LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm")));
	}

	private void forwardFormConErrore(HttpServletRequest req, HttpServletResponse resp, User u, Nota nota, String errore)
			throws ServletException, IOException {
		req.setAttribute("nota", nota);
		req.setAttribute("error", errore);
		preparaForm(req, u);
		req.getRequestDispatcher("formNota.jsp").forward(req, resp);
	}

	private boolean isTipoValido(String tipo) {
		return "DISCIPLINARE".equals(tipo) || "GENERICA".equals(tipo);
	}

	private Time parseOra(String ora) {
		if (ora == null || ora.isBlank()) {
			throw new IllegalArgumentException("Ora obbligatoria");
		}

		String value = ora.trim();
		if (value.length() == 5) {
			return Time.valueOf(value + ":00");
		}
		if (value.length() == 8) {
			return Time.valueOf(value);
		}

		throw new IllegalArgumentException("Ora non valida");
	}

	private int parseId(String value) {
		try {
			return Integer.parseInt(value);
		} catch (Exception e) {
			return 0;
		}
	}
}
