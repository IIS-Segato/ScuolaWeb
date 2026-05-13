package model;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Classe Docente.java, modello dei docenti
 */
public class Docente implements Serializable {
	// Attributi
	private static final long serialVersionUID = 1L;
	private int did;
	private String email;
	private String password;
	private String nome;
	private String cognome;
	private ArrayList<Studente> studenti;
	private ArrayList<Classe> classi;
	
	// Getter e setter
	public int getDid() {
		return did;
	}
	public void setDid(int did) {
		this.did = did;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	public ArrayList<Studente> getStudenti() {
		return studenti;
	}
	public void setStudenti(ArrayList<Studente> studenti) {
		this.studenti = studenti;
	}
	public ArrayList<Classe> getClassi() {
		return classi;
	}
	public void setClassi(ArrayList<Classe> classi) {
		this.classi = classi;
	}
}