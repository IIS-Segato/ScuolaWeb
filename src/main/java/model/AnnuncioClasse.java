package model;

public class AnnuncioClasse {
	private int id;
	private int id_classe;
	private int id_docente;
	private String titolo;
	private String contenuto;
	private String dataPubblicazione;
	private String cognomeDocente;

	public AnnuncioClasse() {
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public int getId_classe() {
		return id_classe;
	}
	public void setId_classe(int id_classe) {
		this.id_classe = id_classe;
	}

	public int getId_docente() {
		return id_docente;
	}
	public void setId_docente(int id_docente) {
		this.id_docente = id_docente;
	}

	// GETTER AND SETTER DEI NUOVI CAMPI
	public String getTitolo() {
		return titolo;
	}
	public void setTitolo(String titolo) {
		this.titolo = titolo;
	}

	public String getContenuto() {
		return contenuto;
	}
	public void setContenuto(String contenuto) {
		this.contenuto = contenuto;
	}

	public String getDataPubblicazione() {
		return dataPubblicazione;
	}
	public void setDataPubblicazione(String dataPubblicazione) {
		this.dataPubblicazione = dataPubblicazione;
	}

	public String getCognomeDocente() {
		return cognomeDocente;
	}
	public void setCognomeDocente(String cognomeDocente) {
		this.cognomeDocente = cognomeDocente;
	}
}