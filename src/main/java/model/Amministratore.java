package model;

import java.io.Serializable;


/**
 * Classe Amministratore.java, modello degli amministratori
 */
public class Amministratore implements Serializable {
	// Attributi
	private static final long serialVersionUID = 1L;
	private int aid;
	private String email;
	private String password;
	
	// Getter e setter
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
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
}