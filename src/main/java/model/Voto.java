package model;

import java.sql.Date;

public class Voto {
	private int id;
	private int idStudente;
	private int idDocente;
	private String materia;
	private double voto;
	private Date data;

	private Studente studente;
	private Docente docente;

	public Voto() {
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

	public String getMateria() {
		return materia;
	}

	public void setMateria(String materia) {
		this.materia = materia;
	}

	public double getVoto() {
		return voto;
	}

	public void setVoto(double voto) {
		this.voto = voto;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

	public Studente getStudente() {
		return studente;
	}

	public void setStudente(Studente studente) {
		this.studente = studente;
	}

	public Docente getDocente() {
		return docente;
	} // <-- getter

	public void setDocente(Docente docente) {
		this.docente = docente;
	} // <-- setter

	@Override
	public String toString() {
		return "Voto [id=" + id + ", idStudente=" + idStudente + ", idDocente=" + idDocente + ", materia=" + materia
				+ ", voto=" + voto + ", data=" + data + ", studente=" + studente + ", docente=" + docente + "]";
	}
}
