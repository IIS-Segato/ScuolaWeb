package model;

import java.io.Serializable;

public class Docente implements Serializable {
    
    private int id;
    private String nome;
    private String cognome;
    private String password;
    private String nomeMateria;

    public Docente() {
    }

    public Docente(int id, String nome, String cognome, String password, String nomeMateria) {
        this.id = id;
        this.nome = nome;
        this.cognome = cognome;
        this.password = password;
        this.nomeMateria = nomeMateria;
    }

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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNomeMateria() {
        return nomeMateria;
    }

    public void setNomeMateria(String nomeMateria) {
        this.nomeMateria = nomeMateria;
    }

    @Override
    public String toString() {
        return "Docente [id=" + id + ", nome=" + nome + ", cognome=" + cognome
                + ", password=" + password + ", nomeMateria=" + nomeMateria + "]";
    }
}
