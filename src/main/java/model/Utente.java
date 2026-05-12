package model;

import java.io.Serializable;



/**
 * Classe per l'utente con tutte le sue proprietà
 */
public class Utente implements Serializable {

    private int id;
    private String email;
    private String password;
    private String ruolo;
    private String nome;
    private String cognome;

    // Costruttore vuoto
    public Utente() {}

    // Costruttore completo
    public Utente(int id, String email, String password, String ruolo, String nome, String cognome) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.ruolo = ruolo;
        this.nome = nome;
        this.cognome = cognome;
    }

    // Getters e Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

	@Override
	/**
	 * del metodo toString
	 */
	public String toString() {
		return "Utente [id=" + id + ", email=" + email + ", password=" + password + ", ruolo=" + ruolo + ", nome="
				+ nome + ", cognome=" + cognome + "]";
	}
    
}