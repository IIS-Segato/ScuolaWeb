package model;

public class Studente {
	private int id;
	private String nome;
	private String cognome;
	private String password;
	private String classe;
	
	public Studente(int id, String nome, String cognome, String password, String classe) {
		this.id = id;
		this.nome = nome;
		this.cognome = cognome;
		this.password = password;
		this.classe = classe;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getCognome() {
		return cognome;
	}
	public void setCognome(String cognome) {
		this.cognome = cognome;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getClasse() {
		return classe;
	}
	public void setClasse(String classe) {
		this.classe = classe;
	}
	@Override
	public String toString() {
		return "Studente [id=" + id + ", nome=" + nome + ", cognome=" + cognome + ", password=" + password + ", classe="
				+ classe + "]";
	}
	
}
