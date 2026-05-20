package model;

public class Assenza {
	private int id;
	private int id_utente;
	private String data_evento;
	private String tipo;
	private String ora_evento;
	private String giustifica;
	private String motivazione;
	private int giustificata_da;
	private String data_giustifica;
	/**
	 * 
	 */
	public Assenza() {
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
	 * @return the id_utente
	 */
	public int getId_utente() {
		return id_utente;
	}
	/**
	 * @param id_utente the id_utente to set
	 */
	public void setId_utente(int id_utente) {
		this.id_utente = id_utente;
	}
	/**
	 * @return the data_evento
	 */
	public String getData_evento() {
		return data_evento;
	}
	/**
	 * @param data_evento the data_evento to set
	 */
	public void setData_evento(String data_evento) {
		this.data_evento = data_evento;
	}
	/**
	 * @return the tipo
	 */
	public String getTipo() {
		return tipo;
	}
	/**
	 * @param tipo the tipo to set
	 */
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	/**
	 * @return the ora_evento
	 */
	public String getOra_evento() {
		return ora_evento;
	}
	/**
	 * @param ora_evento the ora_evento to set
	 */
	public void setOra_evento(String ora_evento) {
		this.ora_evento = ora_evento;
	}
	/**
	 * @return the giustifica
	 */
	public String getGiustifica() {
		return giustifica;
	}
	/**
	 * @param giustifica the giustifica to set
	 */
	public void setGiustifica(String giustifica) {
		this.giustifica = giustifica;
	}
	/**
	 * @return the motivazione
	 */
	public String getMotivazione() {
		return motivazione;
	}
	/**
	 * @param motivazione the motivazione to set
	 */
	public void setMotivazione(String motivazione) {
		this.motivazione = motivazione;
	}
	/**
	 * @return the giustificata_da
	 */
	public int getGiustificata_da() {
		return giustificata_da;
	}
	/**
	 * @param giustificata_da the giustificata_da to set
	 */
	public void setGiustificata_da(int giustificata_da) {
		this.giustificata_da = giustificata_da;
	}
	/**
	 * @return the data_giustifica
	 */
	public String getData_giustifica() {
		return data_giustifica;
	}
	/**
	 * @param data_giustifica the data_giustifica to set
	 */
	public void setData_giustifica(String data_giustifica) {
		this.data_giustifica = data_giustifica;
	}
}
