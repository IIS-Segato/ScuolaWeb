package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.sql.Types;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import model.Classe;
import model.Docente;
import model.EventoRegistro;
import model.Studente;

public class EventoRegistroDao {

	private Connection conn;

	public EventoRegistroDao(Connection conn) {
		this.conn = conn;
		ensureTable();
	}

	private void ensureTable() {
		executeSilently("""
				    CREATE TABLE IF NOT EXISTS registro_eventi (
				      id int(11) NOT NULL AUTO_INCREMENT,
				      id_studente int(11) NOT NULL,
				      id_docente int(11) NOT NULL,
				      tipo enum('PRESENTE','ASSENTE') NOT NULL,
				      data date NOT NULL,
				      ora_ingresso time DEFAULT NULL,
				      ora_uscita time DEFAULT NULL,
				      PRIMARY KEY (id),
				      UNIQUE KEY studente_data (id_studente, data),
				      KEY id_docente (id_docente),
				      CONSTRAINT registro_eventi_ibfk_1 FOREIGN KEY (id_studente) REFERENCES studenti (id),
				      CONSTRAINT registro_eventi_ibfk_2 FOREIGN KEY (id_docente) REFERENCES docenti (id)
				    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
				""");

		// Piccola migrazione per chi aveva creato la prima versione della tabella.
		executeSilently("ALTER TABLE registro_eventi MODIFY tipo varchar(20) NOT NULL");
		executeSilently("UPDATE registro_eventi SET tipo = 'ASSENTE' WHERE tipo IN ('ASSENZA', 'RITARDO', 'USCITA')");
		executeSilently("ALTER TABLE registro_eventi MODIFY tipo enum('PRESENTE','ASSENTE') NOT NULL");
		executeSilently("ALTER TABLE registro_eventi CHANGE ora ora_ingresso time DEFAULT NULL");
		executeSilently("ALTER TABLE registro_eventi ADD COLUMN ora_uscita time DEFAULT NULL");
		executeSilently("ALTER TABLE registro_eventi DROP COLUMN note");
		executeSilently("ALTER TABLE registro_eventi ADD UNIQUE KEY studente_data (id_studente, data)");
	}

	private void executeSilently(String sql) {
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.executeUpdate();
		} catch (Exception e) {
			// Alcune ALTER falliscono se la tabella e gia aggiornata: va bene cosi.
		}
	}

	public Map<Integer, EventoRegistro> getByClasseAndData(int idClasse, Date data) {
		Map<Integer, EventoRegistro> map = new LinkedHashMap<>();
		String sql = baseSelect() + " WHERE s.id_classe = ? AND e.data = ? ORDER BY s.cognome, s.nome";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idClasse);
			ps.setDate(2, data);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				EventoRegistro evento = buildEvento(rs);
				map.put(evento.getIdStudente(), evento);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return map;
	}

	public List<EventoRegistro> getStoricoByClasse(int idClasse, String mese) {
		List<EventoRegistro> list = new ArrayList<>();
		String sql = baseSelect()
				+ " WHERE s.id_classe = ? AND DATE_FORMAT(e.data, '%Y-%m') = ? AND (e.tipo = 'ASSENTE' OR e.ora_uscita IS NOT NULL)"
				+ " ORDER BY e.data DESC, s.cognome, s.nome";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idClasse);
			ps.setString(2, mese);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(buildEvento(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<EventoRegistro> getStoricoAll(String mese) {
		List<EventoRegistro> list = new ArrayList<>();
		String sql = baseSelect()
				+ " WHERE DATE_FORMAT(e.data, '%Y-%m') = ? AND (e.tipo = 'ASSENTE' OR e.ora_uscita IS NOT NULL)"
				+ " ORDER BY e.data DESC, c.nome, s.cognome, s.nome";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, mese);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(buildEvento(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public String getUltimoMeseByClasse(int idClasse) {
		String sql = """
				    SELECT DATE_FORMAT(MAX(e.data), '%Y-%m')
				    FROM registro_eventi e
				    JOIN studenti s ON s.id = e.id_studente
				    WHERE s.id_classe = ? AND (e.tipo = 'ASSENTE' OR e.ora_uscita IS NOT NULL)
				""";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idClasse);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public String getUltimoMese() {
		String sql = "SELECT DATE_FORMAT(MAX(data), '%Y-%m') FROM registro_eventi WHERE tipo = 'ASSENTE' OR ora_uscita IS NOT NULL";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public List<EventoRegistro> getAllByStudente(int idStudente) {
		List<EventoRegistro> list = new ArrayList<>();
		String sql = baseSelect()
				+ " WHERE e.id_studente = ? AND (e.tipo = 'ASSENTE' OR e.ora_uscita IS NOT NULL) ORDER BY e.data DESC";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idStudente);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(buildEvento(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public int countAssenzeByStudente(int idStudente) {
		String sql = "SELECT COUNT(*) FROM registro_eventi WHERE id_studente = ? AND tipo = 'ASSENTE' AND ora_ingresso IS NULL";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idStudente);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	public int countRitardiByStudente(int idStudente) {
		String sql = "SELECT COUNT(*) FROM registro_eventi WHERE id_studente = ? AND tipo = 'ASSENTE' AND ora_ingresso IS NOT NULL";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idStudente);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	public int countUsciteByStudente(int idStudente) {
		String sql = "SELECT COUNT(*) FROM registro_eventi WHERE id_studente = ? AND ora_uscita IS NOT NULL";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idStudente);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	public boolean isClasseAssegnataADocente(int idDocente, int idClasse) {
		String sql = "SELECT 1 FROM docenti_classi WHERE id_docente = ? AND id_classe = ?";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idDocente);
			ps.setInt(2, idClasse);
			ResultSet rs = ps.executeQuery();
			return rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public EventoRegistro getById(int id) {
		EventoRegistro evento = null;
		String sql = baseSelect() + " WHERE e.id = ?";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				evento = buildEvento(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return evento;
	}

	public void delete(int id) {
		try {
			PreparedStatement ps = conn.prepareStatement("DELETE FROM registro_eventi WHERE id = ?");
			ps.setInt(1, id);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void updateStorico(int id, String tipo, Time oraIngresso, Time oraUscita) {
		String sql = "UPDATE registro_eventi SET tipo = ?, ora_ingresso = ?, ora_uscita = ? WHERE id = ?";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, tipo);
			setOra(ps, 2, oraIngresso);
			setOra(ps, 3, oraUscita);
			ps.setInt(4, id);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void salvaPresenza(int idStudente, int idDocente, Date data, String tipo, Time oraIngresso, Time oraUscita) {
		EventoRegistro esistente = getByStudenteAndData(idStudente, data);

		// Ogni studente ha una sola registrazione per giorno.
		if (esistente == null) {
			insert(idStudente, idDocente, data, tipo, oraIngresso, oraUscita);
		} else {
			update(esistente.getId(), idDocente, tipo, oraIngresso, oraUscita);
		}
	}

	private EventoRegistro getByStudenteAndData(int idStudente, Date data) {
		EventoRegistro evento = null;
		String sql = baseSelect() + " WHERE e.id_studente = ? AND e.data = ?";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idStudente);
			ps.setDate(2, data);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				evento = buildEvento(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return evento;
	}

	private void insert(int idStudente, int idDocente, Date data, String tipo, Time oraIngresso, Time oraUscita) {
		String sql = "INSERT INTO registro_eventi (id_studente, id_docente, tipo, data, ora_ingresso, ora_uscita) VALUES (?, ?, ?, ?, ?, ?)";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idStudente);
			ps.setInt(2, idDocente);
			ps.setString(3, tipo);
			ps.setDate(4, data);
			setOra(ps, 5, oraIngresso);
			setOra(ps, 6, oraUscita);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void update(int id, int idDocente, String tipo, Time oraIngresso, Time oraUscita) {
		String sql = "UPDATE registro_eventi SET id_docente = ?, tipo = ?, ora_ingresso = ?, ora_uscita = ? WHERE id = ?";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idDocente);
			ps.setString(2, tipo);
			setOra(ps, 3, oraIngresso);
			setOra(ps, 4, oraUscita);
			ps.setInt(5, id);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void setOra(PreparedStatement ps, int index, Time oraIngresso) throws Exception {
		if (oraIngresso != null) {
			ps.setTime(index, oraIngresso);
		} else {
			ps.setNull(index, Types.TIME);
		}
	}

	private String baseSelect() {
		return """
				    SELECT e.*,
				           s.nome AS studente_nome, s.cognome AS studente_cognome,
				           c.id AS classe_id, c.nome AS classe_nome,
				           d.nome AS docente_nome, d.cognome AS docente_cognome
				    FROM registro_eventi e
				    JOIN studenti s ON s.id = e.id_studente
				    LEFT JOIN classi c ON c.id = s.id_classe
				    JOIN docenti d ON d.id = e.id_docente
				""";
	}

	private EventoRegistro buildEvento(ResultSet rs) throws Exception {
		EventoRegistro evento = new EventoRegistro();
		evento.setId(rs.getInt("id"));
		evento.setIdStudente(rs.getInt("id_studente"));
		evento.setIdDocente(rs.getInt("id_docente"));
		evento.setTipo(rs.getString("tipo"));
		evento.setData(rs.getDate("data"));
		evento.setOraIngresso(rs.getTime("ora_ingresso"));
		evento.setOraUscita(rs.getTime("ora_uscita"));

		Studente s = new Studente();
		s.setId(evento.getIdStudente());
		s.setNome(rs.getString("studente_nome"));
		s.setCognome(rs.getString("studente_cognome"));

		Classe c = new Classe();
		c.setId(rs.getInt("classe_id"));
		c.setNome(rs.getString("classe_nome"));
		s.setClasse(c);
		evento.setStudente(s);

		Docente d = new Docente();
		d.setId(evento.getIdDocente());
		d.setNome(rs.getString("docente_nome"));
		d.setCognome(rs.getString("docente_cognome"));
		evento.setDocente(d);

		return evento;
	}
}
