package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Docente implements Serializable {

	private int id;

	private String nome;
	private String cognome;
	private String materia;
	private String email;

	private List<String> classi = new ArrayList<>();

	public Docente() {
	}

	public Docente(int id, String nome, String cognome, String materia, String email) {

		this.id = id;
		this.nome = nome;
		this.cognome = cognome;
		this.materia = materia;
		this.email = email;
	}

	public int getId() {

		return id;
	}

	public void setId(int id) {

		this.id = id;
	}

	public String getNome() {

		return nome;
	}

	public void setNome(String nome) {

		this.nome = nome;
	}

	public String getCognome() {

		return cognome;
	}

	public void setCognome(String cognome) {

		this.cognome = cognome;
	}

	public String getMateria() {

		return materia;
	}

	public void setMateria(String materia) {

		this.materia = materia;
	}

	public String getEmail() {

		return email;
	}

	public void setEmail(String email) {

		this.email = email;
	}

	public List<String> getClassi() {

		return classi;
	}

	public void setClassi(List<String> classi) {

		this.classi = classi;
	}
}