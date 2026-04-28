package model;

public class Classe {
	private String classe;
	private int n_alunni;
	
	public Classe(String classe, int n_alunni) {
		this.classe = classe;
		this.n_alunni = n_alunni;
	}
	public String getClasse() {
		return classe;
	}
	public void setClasse(String classe) {
		this.classe = classe;
	}
	public int getN_alunni() {
		return n_alunni;
	}
	public void setN_alunni(int n_alunni) {
		this.n_alunni = n_alunni;
	}
	@Override
	public String toString() {
		return "Classe [classe=" + classe + ", n_alunni=" + n_alunni + "]";
	}
	
}
