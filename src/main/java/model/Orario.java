package model;

public class Orario {
	int id;
	int id_docente;
	private String nome_giorno;
	private String orario_inizio;
	private String orario_fine;
	private String classe;
	private String nomeDocente;
	private String cognomeDocente;
	
	public Orario(int id, int id_docente, String nome_giorno, String orario_inizio, String orario_fine, String classe,
			String nomeDocente, String cognomeDocente) {
		this.id = id;
		this.id_docente = id_docente;
		this.nome_giorno = nome_giorno;
		this.orario_inizio = orario_inizio;
		this.orario_fine = orario_fine;
		this.classe = classe;
		this.nomeDocente = nomeDocente;
	    this.cognomeDocente = cognomeDocente;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getId_docente() {
		return id_docente;
	}
	public void setId_docente(int id_docente) {
		this.id_docente = id_docente;
	}
	public String getNome_giorno() {
		return nome_giorno;
	}
	public void setNome_giorno(String nome_giorno) {
		this.nome_giorno = nome_giorno;
	}
	public String getOrario_inizio() {
		return orario_inizio;
	}
	public void setOrario_inizio(String orario_inizio) {
		this.orario_inizio = orario_inizio;
	}
	public String getOrario_fine() {
		return orario_fine;
	}
	public void setOrario_fine(String orario_fine) {
		this.orario_fine = orario_fine;
	}
	public String getClasse() {
		return classe;
	}
	public void setClasse(String classe) {
		this.classe = classe;
	}
	public String getNomeDocente() { return nomeDocente; }
	public String getCognomeDocente() { return cognomeDocente; }
	@Override
	public String toString() {
		return "Orario [id=" + id + ", id_docente=" + id_docente + ", nome_giorno=" + nome_giorno + ", orario_inizio="
				+ orario_inizio + ", orario_fine=" + orario_fine + ", classe=" + classe + "]";
	}
	
	
}
