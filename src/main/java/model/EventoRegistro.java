package model;

import java.sql.Date;
import java.sql.Time;

public class EventoRegistro {
	private int id;
	private int idStudente;
	private int idDocente;
	private String tipo;
	private Date data;
	private Time oraIngresso;
	private Time oraUscita;
	private String note;

	private Studente studente;
	private Docente docente;

	public EventoRegistro() {
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

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

	public Time getOraIngresso() {
		return oraIngresso;
	}

	public void setOraIngresso(Time oraIngresso) {
		this.oraIngresso = oraIngresso;
	}

	public Time getOraUscita() {
		return oraUscita;
	}

	public void setOraUscita(Time oraUscita) {
		this.oraUscita = oraUscita;
	}

	// Compatibilita con la prima versione della gestione registro.
	public Time getOra() {
		return oraIngresso;
	}

	public void setOra(Time ora) {
		this.oraIngresso = ora;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
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
		return "EventoRegistro [id=" + id + ", idStudente=" + idStudente + ", idDocente=" + idDocente + ", tipo="
				+ tipo + ", data=" + data + ", oraIngresso=" + oraIngresso + ", oraUscita=" + oraUscita + ", note="
				+ note + "]";
	}
}
