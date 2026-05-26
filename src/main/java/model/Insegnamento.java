package model;

public class Insegnamento {
	private int id;
	private int id_docente;
	private int id_materia;
	private int id_classe;
	// Attributi della classe portati direttamente qui
    private int anno;
    private String sezione;
    private String indirizzo;
    
    // Attributo della materia
    private String nomeMateria;

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
	public int getAnno() {
		return anno;
	}
	public void setAnno(int anno) {
		this.anno = anno;
	}
	public String getSezione() {
		return sezione;
	}
	public void setSezione(String sezione) {
		this.sezione = sezione;
	}
	public String getIndirizzo() {
		return indirizzo;
	}
	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}
	public String getNomeMateria() {
		return nomeMateria;
	}
	public void setNomeMateria(String nomeMateria) {
		this.nomeMateria = nomeMateria;
	}
}
