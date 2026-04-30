package model;

public class Aula {
    private String nome;
    private int capienza;

    public Aula() {}

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public int getCapienza() { return capienza; }
    public void setCapienza(int capienza) { this.capienza = capienza; }

    @Override
    public String toString() {
        return "Aula{nome=" + nome + ", capienza=" + capienza + "}";
    }
}