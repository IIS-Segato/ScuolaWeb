package model;

import java.sql.Date;
import java.sql.Time;

public class Nota {
	private int id;
	private int idStudente;
	private int idDocente;
	private String tipo;
	private String testo;
	private Date data;
	private Time ora;

	private Studente studente;
	private Docente docente;

	public Nota() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdStudente() {
		return idStudente;
	}

	public void setIdStudente(int idStudente) {
		this.idStudente = idStudente;
	}

	public int getIdDocente() {
		return idDocente;
	}

	public void setIdDocente(int idDocente) {
		this.idDocente = idDocente;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getTesto() {
		return testo;
	}

	public void setTesto(String testo) {
		this.testo = testo;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

	public Time getOra() {
		return ora;
	}

	public void setOra(Time ora) {
		this.ora = ora;
	}

	public Studente getStudente() {
		return studente;
	}

	public void setStudente(Studente studente) {
		this.studente = studente;
	}

	public Docente getDocente() {
		return docente;
	}

	public void setDocente(Docente docente) {
		this.docente = docente;
	}

	@Override
	public String toString() {
		return "Nota [id=" + id + ", idStudente=" + idStudente + ", idDocente=" + idDocente + ", tipo=" + tipo
				+ ", data=" + data + ", ora=" + ora + "]";
	}
}
