package model;

// classe studente
public class Studente {

	private int id;
	private String nome;
	private String cognome;
	private Classe classe;

	// Costruttore vuoto
	public Studente() {
	}

	// Costruttore completo
	public Studente(int id, String nome, String cognome, Classe classe) {
		this.id = id;
		this.nome = nome;
		this.cognome = cognome;
		this.classe = classe;
	}

	// Getter e Setter
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

	public Classe getClasse() {
		return classe;
	}

	public void setClasse(Classe classe) {
		this.classe = classe;
	}

	@Override
	public String toString() {
		return "Studente [id=" + id + ", nome=" + nome + ", cognome=" + cognome + ", classe=" + classe + "]";
	}
}