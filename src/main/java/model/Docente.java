package model;

// classe docente
public class Docente {

	private int id;
	private String nome;
	private String cognome;
	private String materia;

	// Costruttore vuoto
	public Docente() {
	}

	// Costruttore completo
	public Docente(int id, String nome, String cognome, String materia) {
		this.id = id;
		this.nome = nome;
		this.cognome = cognome;
		this.materia = materia;
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

	public String getMateria() {
		return materia;
	}

	public void setMateria(String materia) {
		this.materia = materia;
	}

	@Override
	public String toString() {
		return "Docente [id=" + id + ", nome=" + nome + ", cognome=" + cognome + ", materia=" + materia + "]";
	}
}