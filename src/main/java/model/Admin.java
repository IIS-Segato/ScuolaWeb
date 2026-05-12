package model;

import java.io.Serializable;

/**
 * Java Bean per l'entità Admin
 */
public class Admin implements Serializable {
    private static final long serialVersionUID = 1L;

    // Attributi basati sulla tua tabella
    private int id;
    private String username;
    private String password;

    // 1. Costruttore senza argomenti (obbligatorio per i Bean)
    public Admin() {
    }

    // 2. Costruttore completo (comodo per creare l'oggetto velocemente)
    public Admin(int id, String username, String password) {
        this.id = id;
        this.username = username;
        this.password = password;
    }

    // 3. Getter e Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    /**
     * @return username
     */
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // Metodo toString per debug (opzionale ma utile)
    @Override
    public String toString() {
        return "Admin [id=" + id + ", username=" + username + "]";
    }
}