package model;

public class Orario {
    private String giorno;
    private String oraIni;
    private String oraFin;
    private String classe;  // es. "A 3" (sezione + anno)
    private String aula;

    public Orario() {}

    public String getGiorno() { return giorno; }
    public void setGiorno(String giorno) { this.giorno = giorno; }

    public String getOraIni() { return oraIni; }
    public void setOraIni(String oraIni) { this.oraIni = oraIni; }

    public String getOraFin() { return oraFin; }
    public void setOraFin(String oraFin) { this.oraFin = oraFin; }

    public String getClasse() { return classe; }
    public void setClasse(String classe) { this.classe = classe; }

    public String getAula() { return aula; }
    public void setAula(String aula) { this.aula = aula; }

    @Override
    public String toString() {
        return "Orario{giorno=" + giorno + ", oraIni=" + oraIni + ", oraFin=" + oraFin + 
               ", classe=" + classe + ", aula=" + aula + "}";
    }
}