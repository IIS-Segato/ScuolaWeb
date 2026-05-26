package model;

import java.io.Serializable;
import java.util.ArrayList;


/**
 * Classe Amministratore.java, modello degli amministratori
 */
public class Amministratore implements Serializable {
	// Attributi
	private static final long serialVersionUID = 1L;
	private String email;
	private String password;
	private ArrayList<Studente> studenti;
	private ArrayList<Docente> docenti; 
	private ArrayList<Classe> classi;
	private ArrayList<Materia> materie;

	// Getter e setter
	public String getEmail() {
		return email;
	}
	
	public ArrayList<Studente> getStudenti() {
		return studenti;
	}
	
	public void setStudenti(ArrayList<Studente> studenti) {
		this.studenti = studenti;
	}
	
	public ArrayList<Docente> getDocenti() {
		return docenti;
	}
	public void setDocenti(ArrayList<Docente> docenti) {
		this.docenti = docenti;
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
	
	public ArrayList<Classe> getClassi() {
		return classi;
	}

	public void setClassi(ArrayList<Classe> classi) {
		this.classi = classi;
	}

	public ArrayList<Materia> getMaterie() {
		return materie;
	}

	public void setMaterie(ArrayList<Materia> materie) {
		this.materie = materie;
	}
	
	
}