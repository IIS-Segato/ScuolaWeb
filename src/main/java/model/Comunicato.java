package model;

import java.io.Serializable;
import java.sql.Date;

public class Comunicato implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id;
    private String titolo;
    private String testo;
    private Date data;

    public Comunicato() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitolo() { return titolo; }
    public void setTitolo(String titolo) { this.titolo = titolo; }

    public String getTesto() { return testo; }
    public void setTesto(String testo) { this.testo = testo; }

    public Date getData() { return data; }
    public void setData(Date data) { this.data = data; }
}