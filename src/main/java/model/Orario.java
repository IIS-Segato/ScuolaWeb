package model;

public class Orario {
	private int orario;
	private int id_insegnamento;
	private int id_aula;
	private String giorno;
	private String ora_inizio;
	private String ora_fine;

	public Orario() {

	}
	
	/**
	 * @return the orario
	 */
	public int getOrario() {
		return orario;
	}
	/**
	 * @param orario the orario to set
	 */
	public void setOrario(int orario) {
		this.orario = orario;
	}
	/**
	 * @return the id_insegnamento
	 */
	public int getId_insegnamento() {
		return id_insegnamento;
	}
	/**
	 * @param id_insegnamento the id_insegnamento to set
	 */
	public void setId_insegnamento(int id_insegnamento) {
		this.id_insegnamento = id_insegnamento;
	}
	/**
	 * @return the id_aula
	 */
	public int getId_aula() {
		return id_aula;
	}
	/**
	 * @param id_aula the id_aula to set
	 */
	public void setId_aula(int id_aula) {
		this.id_aula = id_aula;
	}
	/**
	 * @return the giorno
	 */
	public String getGiorno() {
		return giorno;
	}
	/**
	 * @param giorno the giorno to set
	 */
	public void setGiorno(String giorno) {
		this.giorno = giorno;
	}
	/**
	 * @return the ora_inizio
	 */
	public String getOra_inizio() {
		return ora_inizio;
	}
	/**
	 * @param ora_inizio the ora_inizio to set
	 */
	public void setOra_inizio(String ora_inizio) {
		this.ora_inizio = ora_inizio;
	}
	/**
	 * @return the ora_fine
	 */
	public String getOra_fine() {
		return ora_fine;
	}
	/**
	 * @param ora_fine the ora_fine to set
	 */
	public void setOra_fine(String ora_fine) {
		this.ora_fine = ora_fine;
	}
}
