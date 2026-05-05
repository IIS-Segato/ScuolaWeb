package model;

public class Utente {
	private int id;
	private String username;
	private String password_hash;
	private int id_persona;
	private int id_ruolo;
	/**
	 * @param id
	 * @param username
	 * @param password_hash
	 * @param id_persona
	 * @param id_ruolo
	 */
	public Utente(int id, String username, String password_hash, int id_persona, int id_ruolo) {
		this.id = id;
		this.username = username;
		this.password_hash = password_hash;
		this.id_persona = id_persona;
		this.id_ruolo = id_ruolo;
	}
	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}
	/**
	 * @return the username
	 */
	public String getUsername() {
		return username;
	}
	/**
	 * @param username the username to set
	 */
	public void setUsername(String username) {
		this.username = username;
	}
	/**
	 * @return the password_hash
	 */
	public String getPassword_hash() {
		return password_hash;
	}
	/**
	 * @param password_hash the password_hash to set
	 */
	public void setPassword_hash(String password_hash) {
		this.password_hash = password_hash;
	}
	/**
	 * @return the id_persona
	 */
	public int getId_persona() {
		return id_persona;
	}
	/**
	 * @param id_persona the id_persona to set
	 */
	public void setId_persona(int id_persona) {
		this.id_persona = id_persona;
	}
	/**
	 * @return the id_ruolo
	 */
	public int getId_ruolo() {
		return id_ruolo;
	}
	/**
	 * @param id_ruolo the id_ruolo to set
	 */
	public void setId_ruolo(int id_ruolo) {
		this.id_ruolo = id_ruolo;
	}
}
