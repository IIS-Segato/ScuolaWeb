package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Classe;
import model.Docente;
import model.Nota;
import model.Studente;

public class NotaDao {

	private Connection conn;

	public NotaDao(Connection conn) {
		this.conn = conn;
		ensureTable();
	}

	private void ensureTable() {
		executeSilently("""
				    CREATE TABLE IF NOT EXISTS note_alunni (
				      id int(11) NOT NULL AUTO_INCREMENT,
				      id_studente int(11) NOT NULL,
				      id_docente int(11) NOT NULL,
				      tipo enum('DISCIPLINARE','GENERICA') NOT NULL,
				      testo text NOT NULL,
				      data date NOT NULL,
				      ora time NOT NULL,
				      created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
				      PRIMARY KEY (id),
				      KEY id_studente (id_studente),
				      KEY id_docente (id_docente),
				      KEY data_ora (data, ora),
				      CONSTRAINT note_alunni_ibfk_1 FOREIGN KEY (id_studente) REFERENCES studenti (id),
				      CONSTRAINT note_alunni_ibfk_2 FOREIGN KEY (id_docente) REFERENCES docenti (id)
				    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
				""");
	}

	private void executeSilently(String sql) {
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.executeUpdate();
		} catch (Exception e) {
			// Se la tabella esiste gia o il database non permette la modifica, il resto continua.
		}
	}

	public List<Nota> getAll() {
		List<Nota> list = new ArrayList<>();
		String sql = baseSelect() + " ORDER BY n.data DESC, n.ora DESC, c.nome, s.cognome, s.nome";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(buildNota(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<Nota> getAllByStudente(int idStudente) {
		List<Nota> list = new ArrayList<>();
		String sql = baseSelect() + " WHERE n.id_studente = ? ORDER BY n.data DESC, n.ora DESC";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idStudente);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(buildNota(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<Nota> getAllByClassiDocente(int idDocente) {
		List<Nota> list = new ArrayList<>();
		String sql = baseSelect() + """
				    WHERE EXISTS (
				        SELECT 1
				        FROM docenti_classi dc
				        WHERE dc.id_docente = ? AND dc.id_classe = s.id_classe
				    )
				    ORDER BY c.nome, s.cognome, s.nome, n.data DESC, n.ora DESC
				""";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idDocente);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(buildNota(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public Nota getById(int id) {
		Nota nota = null;
		String sql = baseSelect() + " WHERE n.id = ?";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				nota = buildNota(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return nota;
	}

	public void insert(Nota nota) {
		String sql = "INSERT INTO note_alunni (id_studente, id_docente, tipo, testo, data, ora) VALUES (?, ?, ?, ?, ?, ?)";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			setNotaParameters(ps, nota);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void update(Nota nota) {
		String sql = "UPDATE note_alunni SET id_studente = ?, id_docente = ?, tipo = ?, testo = ?, data = ?, ora = ? WHERE id = ?";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			setNotaParameters(ps, nota);
			ps.setInt(7, nota.getId());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void delete(int id) {
		try {
			PreparedStatement ps = conn.prepareStatement("DELETE FROM note_alunni WHERE id = ?");
			ps.setInt(1, id);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public boolean isStudenteAssegnatoADocente(int idDocente, int idStudente) {
		String sql = """
				    SELECT 1
				    FROM studenti s
				    JOIN docenti_classi dc ON dc.id_classe = s.id_classe
				    WHERE dc.id_docente = ? AND s.id = ?
				""";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idDocente);
			ps.setInt(2, idStudente);
			ResultSet rs = ps.executeQuery();
			return rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public List<Studente> getStudentiByDocente(int idDocente) {
		List<Studente> list = new ArrayList<>();
		String sql = """
				    SELECT s.*, c.id AS classe_id, c.nome AS classe_nome
				    FROM studenti s
				    LEFT JOIN classi c ON c.id = s.id_classe
				    JOIN docenti_classi dc ON dc.id_classe = s.id_classe
				    WHERE dc.id_docente = ?
				    ORDER BY c.nome, s.cognome, s.nome
				""";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idDocente);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Studente s = new Studente();
				s.setId(rs.getInt("id"));
				s.setNome(rs.getString("nome"));
				s.setCognome(rs.getString("cognome"));

				Classe c = new Classe();
				c.setId(rs.getInt("classe_id"));
				c.setNome(rs.getString("classe_nome"));
				s.setClasse(c);

				list.add(s);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	private void setNotaParameters(PreparedStatement ps, Nota nota) throws Exception {
		ps.setInt(1, nota.getIdStudente());
		ps.setInt(2, nota.getIdDocente());
		ps.setString(3, nota.getTipo());
		ps.setString(4, nota.getTesto());
		ps.setDate(5, nota.getData());
		ps.setTime(6, nota.getOra());
	}

	private String baseSelect() {
		return """
				    SELECT n.*,
				           s.nome AS studente_nome, s.cognome AS studente_cognome,
				           c.id AS classe_id, c.nome AS classe_nome,
				           d.nome AS docente_nome, d.cognome AS docente_cognome
				    FROM note_alunni n
				    JOIN studenti s ON s.id = n.id_studente
				    LEFT JOIN classi c ON c.id = s.id_classe
				    JOIN docenti d ON d.id = n.id_docente
				""";
	}

	private Nota buildNota(ResultSet rs) throws Exception {
		Nota nota = new Nota();
		nota.setId(rs.getInt("id"));
		nota.setIdStudente(rs.getInt("id_studente"));
		nota.setIdDocente(rs.getInt("id_docente"));
		nota.setTipo(rs.getString("tipo"));
		nota.setTesto(rs.getString("testo"));
		nota.setData(rs.getDate("data"));
		nota.setOra(rs.getTime("ora"));

		Studente s = new Studente();
		s.setId(nota.getIdStudente());
		s.setNome(rs.getString("studente_nome"));
		s.setCognome(rs.getString("studente_cognome"));

		Classe c = new Classe();
		c.setId(rs.getInt("classe_id"));
		c.setNome(rs.getString("classe_nome"));
		s.setClasse(c);
		nota.setStudente(s);

		Docente d = new Docente();
		d.setId(nota.getIdDocente());
		d.setNome(rs.getString("docente_nome"));
		d.setCognome(rs.getString("docente_cognome"));
		nota.setDocente(d);

		return nota;
	}
}
