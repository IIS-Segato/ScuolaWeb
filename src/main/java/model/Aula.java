package model;

import java.util.List;
import model.Orario;

public class Aula {
    private String nome;
    private int capienza;
    private List<Orario> orari;

    public Aula() {}

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public int getCapienza() { return capienza; }
    public void setCapienza(int capienza) { this.capienza = capienza; }
    
    public List<Orario> getOrari() { return orari; }
    public void setOrari(List<Orario> orari) { this.orari = orari; }

    @Override
    public String toString() {
        return "Aula{nome=" + nome + ", capienza=" + capienza + "}";
    }
}