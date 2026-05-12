package dao;

import java.io.IOException;
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
}