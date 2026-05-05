package model;

public class Aula {
	private int id;
	private String nome;
	private int capienza;
	/**
	 * @param id
	 * @param nome
	 * @param capienza
	 */
	public Aula(int id, String nome, int capienza) {
		this.id = id;
		this.nome = nome;
		this.capienza = capienza;
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
	/**
	 * @return the capienza
	 */
	public int getCapienza() {
		return capienza;
	}
	/**
	 * @param capienza the capienza to set
	 */
	public void setCapienza(int capienza) {
		this.capienza = capienza;
	}
	
}
