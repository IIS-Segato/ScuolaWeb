package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ClasseDao;
import dao.DocenteClasseDao;
import dao.EventoRegistroDao;
import dao.StudenteDao;
import model.Classe;
import model.EventoRegistro;
import model.Studente;
import model.User;
import utils.DBManager;

@WebServlet("/RegistroServlet")
public class RegistroServlet extends HttpServlet {

	private EventoRegistroDao registroDao;
	private StudenteDao studenteDao;
	private ClasseDao classeDao;
	private DocenteClasseDao docenteClasseDao;

	@Override
	public void init() throws ServletException {
		Connection conn = DBManager.getConnection(getServletContext());
		registroDao = new EventoRegistroDao(conn);
		studenteDao = new StudenteDao(conn);
		classeDao = new ClasseDao(conn);
		docenteClasseDao = new DocenteClasseDao(conn);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User u = (User) req.getSession().getAttribute("user");
		if (u == null) {
			resp.sendRedirect("login.jsp");
			return;
		}

		if (u.getRoleId() == 4) {
			mostraStoricoStudente(req, resp, u);
			return;
		}

		if (u.getRoleId() != 1 && u.getRoleId() != 2 && u.getRoleId() != 3) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		String action = req.getParameter("action");
		if ("delete".equals(action)) {
			deleteEvento(req, resp, u);
			return;
		}

		List<Classe> classi = u.getRoleId() == 2 ? docenteClasseDao.getClassiByDocente(u.getIdDocente())
				: classeDao.getAll();
		int idClasse = getIdClasse(req, classi);
		Date data = getData(req);

		if (u.getRoleId() == 2 && idClasse > 0 && !registroDao.isClasseAssegnataADocente(u.getIdDocente(), idClasse)) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		String mese = getMese(req, data, idClasse);
		List<Studente> studenti = idClasse > 0 ? studenteDao.getByClasse(idClasse) : Collections.emptyList();
		Map<Integer, EventoRegistro> presenze = idClasse > 0 ? registroDao.getByClasseAndData(idClasse, data)
				: Collections.emptyMap();
		List<EventoRegistro> storico = idClasse > 0 ? registroDao.getStoricoByClasse(idClasse, mese)
				: registroDao.getStoricoAll(mese);

		req.setAttribute("classi", classi);
		req.setAttribute("idClasse", idClasse);
		req.setAttribute("data", data.toString());
		req.setAttribute("mese", mese);
		req.setAttribute("studenti", studenti);
		req.setAttribute("presenze", presenze);
		req.setAttribute("storico", storico);
		req.getRequestDispatcher("registro.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User u = (User) req.getSession().getAttribute("user");
		if (u == null) {
			resp.sendRedirect("login.jsp");
			return;
		}

		String action = req.getParameter("action");
		if ("updateEvento".equals(action)) {
			updateEvento(req, resp, u);
			return;
		}
		if ("deleteEvento".equals(action)) {
			deleteEvento(req, resp, u);
			return;
		}

		if (u.getRoleId() != 2 || u.getIdDocente() <= 0) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		int idClasse = Integer.parseInt(req.getParameter("idClasse"));
		if (!registroDao.isClasseAssegnataADocente(u.getIdDocente(), idClasse)) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		Date data = Date.valueOf(req.getParameter("data"));
		List<Studente> studenti = studenteDao.getByClasse(idClasse);

		for (Studente s : studenti) {
			String tipo = req.getParameter("tipo_" + s.getId());
			if (tipo == null || (!"PRESENTE".equals(tipo) && !"ASSENTE".equals(tipo))) {
				tipo = "PRESENTE";
			}

			// Il ritardo viene salvato come assenza con ora di ingresso.
			Time oraIngresso = parseOra(req.getParameter("ora_" + s.getId()));
			Time oraUscita = parseOra(req.getParameter("uscita_" + s.getId()));
			if (oraIngresso != null) {
				tipo = "ASSENTE";
			} else if (oraUscita != null) {
				tipo = "PRESENTE";
			}

			registroDao.salvaPresenza(s.getId(), u.getIdDocente(), data, tipo, oraIngresso, oraUscita);
		}

		resp.sendRedirect("RegistroServlet?action=list&idClasse=" + idClasse + "&data=" + data);
	}

	private void updateEvento(HttpServletRequest req, HttpServletResponse resp, User u) throws IOException {
		if (u.getRoleId() != 1 && u.getRoleId() != 2 && u.getRoleId() != 3) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		int id = Integer.parseInt(req.getParameter("id"));
		EventoRegistro evento = registroDao.getById(id);
		if (evento == null) {
			resp.sendRedirect("RegistroServlet?action=list");
			return;
		}

		int idClasse = getIdClasseEvento(evento);
		if (u.getRoleId() == 2 && !registroDao.isClasseAssegnataADocente(u.getIdDocente(), idClasse)) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		String tipo = req.getParameter("tipo");
		if (tipo == null || (!"PRESENTE".equals(tipo) && !"ASSENTE".equals(tipo))) {
			tipo = "PRESENTE";
		}

		Time oraIngresso = parseOra(req.getParameter("oraIngresso"));
		Time oraUscita = parseOra(req.getParameter("oraUscita"));
		if (oraIngresso != null) {
			tipo = "ASSENTE";
		} else if (oraUscita != null) {
			tipo = "PRESENTE";
		}

		registroDao.updateStorico(id, tipo, oraIngresso, oraUscita);
		resp.sendRedirect("RegistroServlet?action=list&idClasse=" + idClasse + "&data=" + evento.getData() + "&mese="
				+ evento.getData().toString().substring(0, 7));
	}

	private void deleteEvento(HttpServletRequest req, HttpServletResponse resp, User u) throws IOException {
		if (u.getRoleId() != 1 && u.getRoleId() != 2 && u.getRoleId() != 3) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		int id = Integer.parseInt(req.getParameter("id"));
		EventoRegistro evento = registroDao.getById(id);
		if (evento == null) {
			resp.sendRedirect("RegistroServlet?action=list");
			return;
		}

		int idClasse = getIdClasseEvento(evento);

		if (u.getRoleId() == 2 && !registroDao.isClasseAssegnataADocente(u.getIdDocente(), idClasse)) {
			resp.sendRedirect("notAuthorized.jsp");
			return;
		}

		registroDao.delete(id);
		resp.sendRedirect("RegistroServlet?action=list&idClasse=" + idClasse + "&data=" + evento.getData());
	}

	private int getIdClasseEvento(EventoRegistro evento) {
		Studente studente = evento.getStudente();
		Classe classe = studente != null ? studente.getClasse() : null;
		return classe != null ? classe.getId() : 0;
	}

	private void mostraStoricoStudente(HttpServletRequest req, HttpServletResponse resp, User u)
			throws ServletException, IOException {
		List<EventoRegistro> storico = registroDao.getAllByStudente(u.getIdStudente());
		req.setAttribute("storicoStudente", storico);
		req.setAttribute("numeroAssenze", registroDao.countAssenzeByStudente(u.getIdStudente()));
		req.setAttribute("numeroRitardi", registroDao.countRitardiByStudente(u.getIdStudente()));
		req.setAttribute("numeroUscite", registroDao.countUsciteByStudente(u.getIdStudente()));
		req.getRequestDispatcher("registro.jsp").forward(req, resp);
	}

	private int getIdClasse(HttpServletRequest req, List<Classe> classi) {
		String parametro = req.getParameter("idClasse");
		if (parametro != null && !parametro.isBlank()) {
			return Integer.parseInt(parametro);
		}
		return classi != null && !classi.isEmpty() ? classi.get(0).getId() : 0;
	}

	private Date getData(HttpServletRequest req) {
		String data = req.getParameter("data");
		if (data == null || data.isBlank()) {
			return Date.valueOf(LocalDate.now());
		}
		return Date.valueOf(data);
	}

	private String getMese(HttpServletRequest req, Date data, int idClasse) {
		String mese = req.getParameter("mese");
		if (mese == null || mese.isBlank()) {
			// Se non scelgo il mese, apro l'ultimo mese con assenze registrate.
			String ultimoMese = idClasse > 0 ? registroDao.getUltimoMeseByClasse(idClasse)
					: registroDao.getUltimoMese();
			if (ultimoMese != null) {
				return ultimoMese;
			}
			return YearMonth.from(data.toLocalDate()).toString();
		}
		return mese;
	}

	private Time parseOra(String ora) {
		if (ora == null || ora.isBlank()) {
			return null;
		}
		return Time.valueOf(ora + ":00");
	}
}
