package model;

import java.io.Serializable;

public class Docente implements Serializable {

    private static final long serialVersionUID = 1L;

    private int    id;
    private String nome;
    private String cognome;
    private String materia;

    public Docente() {}

    public Docente(int id, String nome, String cognome, String materia) {
        this.id = id;
        this.nome = nome;
        this.cognome = cognome;
        this.materia = materia;
    }

    public int    getId(){ return id; }
    public String getNome(){ return nome; }
    public String getCognome(){ return cognome; }
    public String getMateria(){ return materia; }

    public void setId(int id){ this.id      = id; }
    public void setNome(String nome){ this.nome    = nome; }
    public void setCognome(String c){ this.cognome = c; }
    public void setMateria(String m){ this.materia = m; }
}
