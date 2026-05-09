package model;

import java.io.Serializable;

public class Studente implements Serializable {

    private int id;
    private String nome, cognome, classe;

    public Studente() {}

    public Studente(int id, String nome, String cognome, String classe) {
        this.id = id;
        this.nome = nome;
        this.cognome = cognome;
        this.classe = classe;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getCognome() { return cognome; }
    public void setCognome(String cognome) { this.cognome = cognome; }

    public String getClasse() { return classe; }
    public void setClasse(String classe) { this.classe = classe; }
}