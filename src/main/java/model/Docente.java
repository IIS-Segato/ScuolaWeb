package model;


/**
 * Classe Docente.java, modello dei docenti
 */
public class Docente{
	// Attributi
	private int did;
	private String email;
	private String password;
	private String nome;
	private String cognome;
	
	/**
	 * Costruttore
	 * @param did
	 * @param email
	 * @param password
	 * @param nome
	 * @param cognome
	 */
	public Docente(int did, String email, String password, String nome, String cognome) {
		super();
		this.did = did;
		this.email = email;
		this.password = password;
		this.nome = nome;
		this.cognome = cognome;
	}
	
	// Getter e setter
	public int getDid() {
		return did;
	}
	public void setDid(int did) {
		this.did = did;
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
}