package model;

public class Giorno {
	String nome_giorno;

	public Giorno(String nome_giorno) {
		this.nome_giorno = nome_giorno;
	}

	public String getNome_giorno() {
		return nome_giorno;
	}

	public void setNome_giorno(String nome_giorno) {
		this.nome_giorno = nome_giorno;
	}

	@Override
	public String toString() {
		return "Giorno [nome_giorno=" + nome_giorno + "]";
	}
	
}
