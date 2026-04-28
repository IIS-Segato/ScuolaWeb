package model;

public class Materia {
	private String nome_materia;

	public Materia(String nome_materia) {
		this.nome_materia = nome_materia;
	}

	public String getNome_materia() {
		return nome_materia;
	}

	public void setNome_materia(String nome_materia) {
		this.nome_materia = nome_materia;
	}

	@Override
	public String toString() {
		return "Materia [nome_materia=" + nome_materia + "]";
	}
	
}
