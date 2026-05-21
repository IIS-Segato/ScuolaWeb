package model;

import java.io.Serializable;

/**
 * Classe Voto.java modello dei voti
 */
public class Voto implements Serializable{
	// Attributi
	private static final long serialVersionUID = 1L;
	private int vid;
	private float voto;
	private String materia;
	private String data;
	private int did;
	private int sid;
	
	// Getter e setter
	public int getVid() {
		return vid;
	}
	public void setVid(int vid) {
		this.vid = vid;
	}
	public float getVoto() {
		return voto;
	}
	public void setVoto(float voto) {
		this.voto = voto;
	}
	public String getMateria() {
		return materia;
	}
	public void setMateria(String materia) {
		this.materia = materia;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public int getDid() {
		return did;
	}
	public void setDid(int did) {
		this.did = did;
	}
	public int getSid() {
		return sid;
	}
	public void setSid(int sid) {
		this.sid = sid;
	}
}