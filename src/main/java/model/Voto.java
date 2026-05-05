package model;

public class Voto {
	private int id;
	private int id_studente;
	private int id_insegnante;
	private int voto;
	private String data_voto;
	private String descrizione;
	/**
	 * @param id
	 * @param id_studente
	 * @param id_insegnante
	 * @param voto
	 * @param data_voto
	 * @param descrizione
	 */
	public Voto(int id, int id_studente, int id_insegnante, int voto, String data_voto, String descrizione) {
		this.id = id;
		this.id_studente = id_studente;
		this.id_insegnante = id_insegnante;
		this.voto = voto;
		this.data_voto = data_voto;
		this.descrizione = descrizione;
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
	 * @return the id_studente
	 */
	public int getId_studente() {
		return id_studente;
	}
	/**
	 * @param id_studente the id_studente to set
	 */
	public void setId_studente(int id_studente) {
		this.id_studente = id_studente;
	}
	/**
	 * @return the id_insegnante
	 */
	public int getId_insegnante() {
		return id_insegnante;
	}
	/**
	 * @param id_insegnante the id_insegnante to set
	 */
	public void setId_insegnante(int id_insegnante) {
		this.id_insegnante = id_insegnante;
	}
	/**
	 * @return the voto
	 */
	public int getVoto() {
		return voto;
	}
	/**
	 * @param voto the voto to set
	 */
	public void setVoto(int voto) {
		this.voto = voto;
	}
	/**
	 * @return the data_voto
	 */
	public String getData_voto() {
		return data_voto;
	}
	/**
	 * @param data_voto the data_voto to set
	 */
	public void setData_voto(String data_voto) {
		this.data_voto = data_voto;
	}
	/**
	 * @return the descrizione
	 */
	public String getDescrizione() {
		return descrizione;
	}
	/**
	 * @param descrizione the descrizione to set
	 */
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
}
