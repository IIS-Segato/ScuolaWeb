package model;

import java.io.Serializable;

public class Utente implements Serializable {

	private static final long serialVersionUID = 1L;

	public static final String RUOLO_ADMIN = "admin";
	public static final String RUOLO_DOCENTE = "docente";
	public static final String RUOLO_STUDENTE = "studente";

	private int id;
	private String username;
	private String password;
	private String ruolo;
	private String nome;
	private String cognome;
	
	//classe utente
	public Utente() {
	}

	public Utente(int id, String username, String password, String ruolo, String nome, String cognome) {
		this.id = id;
		this.username=username;
		this.password=password;
		this.ruolo=ruolo;
		this.nome=nome;
		this.cognome=cognome;
		
	}

	public boolean isAdmin() {return RUOLO_ADMIN.equals(ruolo);	}
	public boolean isDocente() {return RUOLO_DOCENTE.equals(ruolo);}
	public boolean isStudente() {return RUOLO_STUDENTE.equals(ruolo);}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRuolo() {
		return ruolo;
	}

	public void setRuolo(String ruolo) {
		this.ruolo = ruolo;
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

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public static String getRuoloAdmin() {
		return RUOLO_ADMIN;
	}

	public static String getRuoloDocente() {
		return RUOLO_DOCENTE;
	}

	public static String getRuoloStudente() {
		return RUOLO_STUDENTE;
	}
	
	
}
