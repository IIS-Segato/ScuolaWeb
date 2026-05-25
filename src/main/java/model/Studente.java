package model;

import java.io.Serializable;

public class Studente implements Serializable {

	private int id;

	private String nome;
	private String cognome;

	private int classeId;
	private String nomeClasse;

	public Studente() {
	}

	public Studente(int id, String nome, String cognome, int classeId, String nomeClasse) {

		this.id = id;
		this.nome = nome;
		this.cognome = cognome;
		this.classeId = classeId;
		this.nomeClasse = nomeClasse;
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

	public int getClasseId() {

		return classeId;
	}

	public void setClasseId(int classeId) {

		this.classeId = classeId;
	}

	public String getNomeClasse() {

		return nomeClasse;
	}

	public void setNomeClasse(String nomeClasse) {

		this.nomeClasse = nomeClasse;
	}
}