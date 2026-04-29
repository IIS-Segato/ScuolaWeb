package model;

import java.io.Serializable;


/**
 * Classe Utente.java modello della tabella utenti del db
 */
public class Utente implements Serializable {
	// Attributi
    private static final long serialVersionUID = 1L;
    private String username;
    private String password;
    private String nome;
    private String cognome;
    private String email;
    private String nascita;
    private String citta;
    
    /**
     * Costruttore
     * @param username
     * @param password
     * @param nome
     * @param cognome
     * @param email
     * @param nascita
     * @param citta
     */
    public Utente(String username, String password, String nome, String cognome, String email, String nascita, String citta) {
		super();
		this.username = username;
		this.password = password;
		this.nome = nome;
		this.cognome = cognome;
		this.email = email;
		this.nascita = nascita;
		this.citta = citta;
	}

	// Getter e setter degli attributi
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
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getNascita() {
		return nascita;
	}
	
	public void setNascita(String nascita) {
		this.nascita = nascita;
	}
	
	public String getCitta() {
		return citta;
	}
	
	public void setCitta(String citta) {
		this.citta = citta;
	}    
}