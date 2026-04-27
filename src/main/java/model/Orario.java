package model;

import java.sql.Time;

public class Orario {
	int id;
	int id_docente;
	private String nome_giorno;
	private String orario_inizio;
	private String orario_fine;
	private String classe;
	
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
	
}
