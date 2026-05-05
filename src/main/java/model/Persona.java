package model;

public class Persona {
	private int id;
	private String nome;
	private String cognome;
	private String email;
	private String cf;
	private String nascita;
	private byte[] img_profilo;
	
	/**
	 * @param id
	 * @param nome
	 * @param cognome
	 * @param email
	 * @param cf
	 * @param nascita
	 */
	public Persona(int id, String nome, String cognome, String email, String cf, String nascita, byte[] img_profilo) {
		this.id = id;
		this.nome = nome;
		this.cognome = cognome;
		this.email = email;
		this.cf = cf;
		this.nascita = nascita;
		this.img_profilo = img_profilo;
	}
	/**
	 * @return the nome
	 */
	public String getNome() {
		return nome;
	}
	/**
	 * @param nome the nome to set
	 */
	public void setNome(String nome) {
		this.nome = nome;
	}
	/**
	 * @return the cognome
	 */
	public String getCognome() {
		return cognome;
	}
	/**
	 * @param cognome the cognome to set
	 */
	public void setCognome(String cognome) {
		this.cognome = cognome;
	}
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the cf
	 */
	public String getCf() {
		return cf;
	}
	/**
	 * @param cf the cf to set
	 */
	public void setCf(String cf) {
		this.cf = cf;
	}
	/**
	 * @return the nascita
	 */
	public String getNascita() {
		return nascita;
	}
	/**
	 * @param nascita the nascita to set
	 */
	public void setNascita(String nascita) {
		this.nascita = nascita;
	}
	/**
	 * @param id the id to set
	 */
	public int setId(int id) {
		this.id = id;
	}
	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}
	/**
	 * @return the img_profilo
	 */
	public byte[] getImg_profilo() {
		return img_profilo;
	}
	/**
	 * @param img_profilo the img_profilo to set
	 */
	public void setImg_profilo(byte[] img_profilo) {
		this.img_profilo = img_profilo;
	}
}
