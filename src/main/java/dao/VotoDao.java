package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;
import org.jdom2.JDOMException;

public class VotoDao extends DAO {

    public VotoDao(String xmlurl) throws ClassNotFoundException, JDOMException, IOException, SQLException {
        super(xmlurl);
    }

    public boolean insertVoto(int idStudente, int idDocente, double voto, String dataStr, String descrizione) {
        // Recupera la query definita nel tuo dbcfg.xml under <voti><insert>
        String query = config.getQuery("voti", "insert");
        
        try (PreparedStatement ps = this.conn.prepareStatement(query)) {
            ps.setInt(1, idStudente);
            ps.setInt(2, idDocente);
            ps.setDouble(3, voto);
            ps.setDate(4, Date.valueOf(dataStr)); // Converte la stringa "YYYY-MM-DD" in java.sql.Date
            ps.setString(5, descrizione);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Restituisce true se l'inserimento è andato a buon fine
        } catch (SQLException | IllegalArgumentException e) {
            System.err.println("Errore in VotoDao: " + e.getMessage());
            return false;
        }
    }
}