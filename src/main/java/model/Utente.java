package model;

public class Utente {
	
	//proprieta'
	private String id;
	private String ruolo;
	
	public Utente(String id, String ruolo) {
		this.id = id;
		this.ruolo = ruolo;
	}
	
	public String getId() {
		return id;
	}
	
	public String getRuolo() {
		return ruolo;
	}
}
