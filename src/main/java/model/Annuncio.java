package model;

public class Annuncio {
	private int id;
	private String titolo;
	private String contenuto;
	private int data_pubblicazione;
	private int autore;
	/**
	 * @param id
	 * @param titolo
	 * @param contenuto
	 * @param data_pubblicazione
	 * @param autore
	 */
	public Annuncio(int id, String titolo, String contenuto, int data_pubblicazione, int autore) {
		this.id = id;
		this.titolo = titolo;
		this.contenuto = contenuto;
		this.data_pubblicazione = data_pubblicazione;
		this.autore = autore;
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
	 * @return the titolo
	 */
	public String getTitolo() {
		return titolo;
	}
	/**
	 * @param titolo the titolo to set
	 */
	public void setTitolo(String titolo) {
		this.titolo = titolo;
	}
	/**
	 * @return the contenuto
	 */
	public String getContenuto() {
		return contenuto;
	}
	/**
	 * @param contenuto the contenuto to set
	 */
	public void setContenuto(String contenuto) {
		this.contenuto = contenuto;
	}
	/**
	 * @return the data_pubblicazione
	 */
	public int getData_pubblicazione() {
		return data_pubblicazione;
	}
	/**
	 * @param data_pubblicazione the data_pubblicazione to set
	 */
	public void setData_pubblicazione(int data_pubblicazione) {
		this.data_pubblicazione = data_pubblicazione;
	}
	/**
	 * @return the autore
	 */
	public int getAutore() {
		return autore;
	}
	/**
	 * @param autore the autore to set
	 */
	public void setAutore(int autore) {
		this.autore = autore;
	}
}
