package model;

import java.io.Serializable;

public class Studente implements Serializable {

	private static final long serialVersionUID = 1L;

	private int id;
	private String nome;
	private String cognome;
	private String classe;

	public Studente() {
	}

	public Studente(int id, String nome, String cognome, String classe) {
		this.id = id;
		this.nome = nome;
		this.cognome = cognome;
		this.classe = classe;
	}

	public int getId() {
		return id;
	}

	public String getNome() {
		return nome;
	}

	public String getCognome() {
		return cognome;
	}

	public String getClasse() {
		return classe;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public void setCognome(String c) {
		this.cognome = c;
	}

	public void setClasse(String cl) {
		this.classe = cl;
	}
}
