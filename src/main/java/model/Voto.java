package model;

import java.sql.Date;

public class Voto {
    private int id;
    private int idStudente;
    private int idDocente;
    private double voto;
    private Date data;
    private String descrizione;
    
    // Campi aggiuntivi per la visualizzazione (JOIN)
    private String nomeDocente;
    private String nomeMateria;

    public Voto() {}

    // Getter e Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdStudente() { return idStudente; }
    public void setIdStudente(int idStudente) { this.idStudente = idStudente; }

    public double getVoto() { return voto; }
    public void setVoto(double voto) { this.voto = voto; }

    public Date getData() { return data; }
    public void setData(Date data) { this.data = data; }

    public String getDescrizione() { return descrizione; }
    public void setDescrizione(String descrizione) { this.descrizione = descrizione; }

    public String getNomeDocente() { return nomeDocente; }
    public void setNomeDocente(String nomeDocente) { this.nomeDocente = nomeDocente; }

    public String getNomeMateria() { return nomeMateria; }
    public void setNomeMateria(String nomeMateria) { this.nomeMateria = nomeMateria; }
}