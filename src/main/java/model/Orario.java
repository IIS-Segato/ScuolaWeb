package model;

public class Orario {

    private int id;
    private int id_insegnamento;
    private int id_aula;
    private String giorno;
    private String ora_inizio;
    private String ora_fine;
    private String nomeMateria;
    private String cognomeDocente;
    private String nomeDocente;
    private String nomeAula;

    // Aggiungi qui i relativi Getter e Setter per ognuno di questi campi
    public String getNomeMateria() {
    	return nomeMateria;
    }
    public void setNomeMateria(String nomeMateria) {
    	this.nomeMateria = nomeMateria;
    }

    public String getCognomeDocente() {
    	return cognomeDocente;
    }
    public void setCognomeDocente(String cognomeDocente) {
    	this.cognomeDocente = cognomeDocente;
    }

    public String getNomeDocente() {
    	return nomeDocente;
    }
    public void setNomeDocente(String nomeDocente) {
    	this.nomeDocente = nomeDocente;
    }

    public String getNomeAula() {
    	return nomeAula;
    }
    public void setNomeAula(String nomeAula) { this.nomeAula = nomeAula; }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_insegnamento() {
        return id_insegnamento;
    }

    public void setId_insegnamento(int id_insegnamento) {
        this.id_insegnamento = id_insegnamento;
    }

    public int getId_aula() {
        return id_aula;
    }

    public void setId_aula(int id_aula) {
        this.id_aula = id_aula;
    }

    public String getGiorno() {
        return giorno;
    }

    public void setGiorno(String giorno) {
        this.giorno = giorno;
    }

    public String getOra_inizio() {
        return ora_inizio;
    }

    public void setOra_inizio(String ora_inizio) {
        this.ora_inizio = ora_inizio;
    }

    public String getOra_fine() {
        return ora_fine;
    }

    public void setOra_fine(String ora_fine) {
        this.ora_fine = ora_fine;
    }
}