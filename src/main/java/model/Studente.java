package model;

/**
 * Classe per la creazione di uno studente
 */
public class Studente {
    private int id;
    private String nome;
    private String cognome;
    private String email;
    private String password;
    private int idClasse;
    
    //Costruttore vuoto
    public Studente() {}

    //Getters And Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getCognome() { return cognome; }
    public void setCognome(String cognome) { this.cognome = cognome; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public int getIdClasse() { return idClasse; }
    public void setIdClasse(int idClasse) { this.idClasse = idClasse; }

    @Override
    //del metodo to string
    public String toString() {
        return "Studente{id=" + id + ", nome=" + nome + ", cognome=" + cognome +
               ", email=" + email + ", idClasse=" + idClasse + "}";
    }
}