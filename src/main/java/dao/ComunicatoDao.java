package dao;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.jdom2.JDOMException;
import model.Comunicato;

public class ComunicatoDao extends DAO {

    public ComunicatoDao(String xmlurl) throws ClassNotFoundException, JDOMException, IOException, SQLException {
        super(xmlurl);
    }

    public List<Comunicato> getAllComunicati() {
        List<Comunicato> lista = new ArrayList<>();
        String query = config.getQuery("comunicati", "select");

        try (PreparedStatement ps = this.conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Comunicato c = new Comunicato();
                c.setId(rs.getInt("id"));
                c.setTitolo(rs.getString("titolo"));
                c.setTesto(rs.getString("testo"));
                c.setData(rs.getDate("data"));
                lista.add(c);
            }
        } catch (SQLException e) {
            System.err.println("Errore in ComunicatoDao: " + e.getMessage());
        }
        return lista;
    }
}