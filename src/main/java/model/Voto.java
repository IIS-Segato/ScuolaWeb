package model;

import java.sql.Date;

public class Voto {
	private int id;
	private int idStudente;
	private int idDocente;
	private String materia;
	private double voto;
	private Date data;

	public Voto() {
	}

	public Voto(int id, int idStudente, int idDocente, String materia, double voto, Date data) {
		this.id = id;
		this.idStudente = idStudente;
		this.idDocente = idDocente;
		this.materia = materia;
		this.voto = voto;
		this.data = data;
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

}
