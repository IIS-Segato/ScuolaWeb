package dao;

import java.io.IOException;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.jdom2.JDOMException;
import model.Voto;

public class VotoDao extends DAO {

    public VotoDao(String xmlurl) throws ClassNotFoundException, JDOMException, IOException, SQLException {
        super(xmlurl);
    }

    public List<Voto> getVotiByStudente(int idStudente) {
        List<Voto> listaVoti = new ArrayList<>();
        String query = config.getQuery("voti", "selectByStudente");

        try (PreparedStatement ps = this.conn.prepareStatement(query)) {
            ps.setInt(1, idStudente);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Voto v = new Voto();
                    v.setId(rs.getInt("id"));
                    v.setVoto(rs.getDouble("voto"));
                    v.setData(rs.getDate("data"));
                    v.setDescrizione(rs.getString("descrizione"));
                    v.setNomeDocente(rs.getString("nome_docente") + " " + rs.getString("cognome_docente"));
                    v.setNomeMateria(rs.getString("nome_materia"));
                    listaVoti.add(v);
                }
            }
        } catch (SQLException e) {
            System.err.println("Errore in VotoDao: " + e.getMessage());
        }
        return listaVoti;
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



