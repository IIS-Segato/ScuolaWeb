package model;

import java.io.Serializable;

public class Orario implements Serializable {

	private int id;

	private String classe;
	private String materia;

	private String giorno;
	private String ora;

	private String docente;

	public Orario() {
	}

	public int getId() {

		return id;
	}

	public void setId(int id) {

		this.id = id;
	}

	public String getClasse() {

		return classe;
	}

	public void setClasse(String classe) {

		this.classe = classe;
	}

	public String getMateria() {

		return materia;
	}

	public void setMateria(String materia) {

		this.materia = materia;
	}

	public String getGiorno() {

		return giorno;
	}

	public void setGiorno(String giorno) {

		this.giorno = giorno;
	}

	public String getOra() {

		return ora;
	}

	public void setOra(String ora) {

		this.ora = ora;
	}

	public String getDocente() {

		return docente;
	}

	public void setDocente(String docente) {

		this.docente = docente;
	}
}