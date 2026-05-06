package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

//classe userDao nuova che estende il dao 
public class UserDao extends DAO {

    //costruttore 
    public UserDao(String xmlurl) throws Exception {
        super(xmlurl);
    }
    //controllo se l accesso è autenticato 
    public boolean autentica(String id, String password, String ruolo) {
        String pwdGiusta;
        
        try {
            //metodo getQueryLogin dal config ereditato 
            String sql = config.getQueryLogin(ruolo);
            //oggetto CONN ereditato anche questo dalla classe DAO
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, id); //setto il parametro per il prepare stmnt
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                pwdGiusta = rs.getString("password").trim();
                
                //chiudo tutto 
                rs.close();
                stmt.close();
                
                return (password.trim().equals(pwdGiusta));
            }
        } catch (Exception e) {
            System.err.println("Errore durante l'autenticazione: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
}