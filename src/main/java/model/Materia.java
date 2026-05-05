package model;

public class Materia {
	private int id;
	private String nome;
	/**
	 * @param id
	 * @param nome
	 */
	public Materia(int id, String nome) {
		this.id = id;
		this.nome = nome;
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
	 * @return the nome
	 */
	public String getNome() {
		return nome;
	}
	/**
	 * @param nome the nome to set
	 */
	public void setNome(String nome) {
		this.nome = nome;
	}
}
