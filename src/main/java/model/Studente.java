package model;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Classe Studente.java, modello degli studenti
 */
public class Studente implements Serializable {
	// Attributi
	private static final long serialVersionUID = 1L;
	private int sid;
	private String email;
	private String password;
	private String nome;
	private String cognome;
	private String nascita;
	private int cid;
	private ArrayList<Voto> voti;
	
	// Getter e setter
	public int getSid() {
		return sid;
	}
	public void setSid(int sid) {
		this.sid = sid;
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
	public String getNascita() {
		return nascita;
	}
	public void setNascita(String nascita) {
		this.nascita = nascita;
	}
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public ArrayList<Voto> getVoti() {
		return voti;
	}
	public void setVoti(ArrayList<Voto> voti) {
		this.voti = voti;
	}
}