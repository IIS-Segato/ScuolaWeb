package model;

public class Classe {
	private int id;
	private int anno;
	private String sezione;
	private String indirizzo;
	/**
	 * @param id
	 * @param anno
	 * @param sezione
	 * @param indirizzo
	 */
	public Classe(int id, int anno, String sezione, String indirizzo) {
		this.id = id;
		this.anno = anno;
		this.sezione = sezione;
		this.indirizzo = indirizzo;
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
	 * @return the anno
	 */
	public int getAnno() {
		return anno;
	}
	/**
	 * @param anno the anno to set
	 */
	public void setAnno(int anno) {
		this.anno = anno;
	}
	/**
	 * @return the sezione
	 */
	public String getSezione() {
		return sezione;
	}
	/**
	 * @param sezione the sezione to set
	 */
	public void setSezione(String sezione) {
		this.sezione = sezione;
	}
	/**
	 * @return the indirizzo
	 */
	public String getIndirizzo() {
		return indirizzo;
	}
	/**
	 * @param indirizzo the indirizzo to set
	 */
	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}
}
