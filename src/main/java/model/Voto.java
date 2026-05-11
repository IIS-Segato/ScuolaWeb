package model;

public class Voto {
	private int id;
	private int id_studente;
	private int id_insegnamento;
	private int voto;
	private String data_voto;
	private String descrizione;

	public Voto() {
	
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
	public int getId_insegnamento() {
		return id_insegnamento;
	}
	/**
	 * @param id_insegnante the id_insegnante to set
	 */
	public void setId_insegnamento(int id_insegnamento) {
		this.id_insegnamento = id_insegnamento;
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
