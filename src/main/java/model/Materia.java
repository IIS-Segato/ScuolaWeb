package model;

import java.io.Serializable;

/**
 * Classe Voto.java modello dei voti
 */
public class Materia implements Serializable{
	// Attributi
	private static final long serialVersionUID = 1L;
	private int cid;
	private int did;
	private String materia;
	
	
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public int getDid() {
		return did;
	}
	public void setDid(int did) {
		this.did = did;
	}
	public String getMateria() {
		return materia;
	}
	public void setMateria(String materia) {
		this.materia = materia;
	}
	
	
	
}