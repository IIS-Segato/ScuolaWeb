package model;

public class Annuncio {
    private int id;
    private String titolo;
    private String contenuto;
    private String data_pubblicazione;
    private int autore;

    public Annuncio() {}

    // Getter e Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitolo() { return titolo; }
    public void setTitolo(String titolo) { this.titolo = titolo; }

    public String getContenuto() { return contenuto; }
    public void setContenuto(String contenuto) { this.contenuto = contenuto; }

    public String getData_pubblicazione() { return data_pubblicazione; }
    public void setData_pubblicazione(String data_pubblicazione) { this.data_pubblicazione = data_pubblicazione; }

    public int getAutore() { return autore; }
    public void setAutore(int autore) { this.autore = autore; }
}