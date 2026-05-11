package model;

public class Insegnamento {
	private int id;
	private int id_docente;
	private int id_materia;
	private int id_classe;

	public Insegnamento() {

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
	 * @return the id_docente
	 */
	public int getId_docente() {
		return id_docente;
	}
	/**
	 * @param id_docente the id_docente to set
	 */
	public void setId_docente(int id_docente) {
		this.id_docente = id_docente;
	}
	/**
	 * @return the id_materia
	 */
	public int getId_materia() {
		return id_materia;
	}
	/**
	 * @param id_materia the id_materia to set
	 */
	public void setId_materia(int id_materia) {
		this.id_materia = id_materia;
	}
	/**
	 * @return the id_classe
	 */
	public int getId_classe() {
		return id_classe;
	}
	/**
	 * @param id_classe the id_classe to set
	 */
	public void setId_classe(int id_classe) {
		this.id_classe = id_classe;
	}
}
