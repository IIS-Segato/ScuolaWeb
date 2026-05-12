package model;

import java.io.Serializable;
import java.util.ArrayList;


/**
 * Classe Amministratore.java, modello degli amministratori
 */
public class Classe implements Serializable {
	
	// Attributi
	private static final long serialVersionUID = 1L;
	private String anno;
	private String sezione;
	private ArrayList<String> materie;
	
	// Getter e setter
	public String getAnno() {
		return anno;
	}
	public void setAnno(String anno) {
		this.anno = anno;
	}
	public String getSezione() {
		return sezione;
	}
	public void setSezione(String sezione) {
		this.sezione = sezione;
	}
	public ArrayList<String> getMaterie() {
		return materie;
	}
	public void setMaterie(ArrayList<String> materie) {
		this.materie = materie;
	}
	
}