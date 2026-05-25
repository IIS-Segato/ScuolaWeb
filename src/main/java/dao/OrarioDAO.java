package dao;

import model.Orario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrarioDAO extends AbstractDAO {

    private static final String SQL_GET_ALL =
            "SELECT * FROM orario";

    private static final String SQL_GET_BY_ID =
            "SELECT * FROM orario WHERE id_orario=?";

    private static final String SQL_INSERT =
            "INSERT INTO orario (id_insegnamento,id_aula,giorno,ora_inizio,ora_fine) VALUES (?,?,?,?,?)";

    private static final String SQL_UPDATE =
            "UPDATE orario SET id_insegnamento=?,id_aula=?,giorno=?,ora_inizio=?,ora_fine=? WHERE id_orario=?";

    private static final String SQL_DELETE =
            "DELETE FROM orario WHERE id_orario=?";

    public OrarioDAO(String xml) throws Exception {
        super(xml);
    }

    public List<Orario> getAll() {

        List<Orario> list = new ArrayList<>();

        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(SQL_GET_ALL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Orario o = new Orario();

                o.setId(rs.getInt("id_orario"));
                o.setId_insegnamento(rs.getInt("id_insegnamento"));
                o.setId_aula(rs.getInt("id_aula"));
                o.setGiorno(rs.getString("giorno"));
                o.setOra_inizio(rs.getString("ora_inizio"));
                o.setOra_fine(rs.getString("ora_fine"));

                list.add(o);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Orario getById(int id) {

        Orario o = new Orario();

        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(SQL_GET_BY_ID)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                o.setId(rs.getInt("id_orario"));
                o.setId_insegnamento(rs.getInt("id_insegnamento"));
                o.setId_aula(rs.getInt("id_aula"));
                o.setGiorno(rs.getString("giorno"));
                o.setOra_inizio(rs.getString("ora_inizio"));
                o.setOra_fine(rs.getString("ora_fine"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return o;
    }

    public boolean insert(int ins, int aula, String g, String in, String fin) {

        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(SQL_INSERT)) {

            ps.setInt(1, ins);
            ps.setInt(2, aula);
            ps.setString(3, g);
            ps.setString(4, in);
            ps.setString(5, fin);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean update(int ins, int aula, String g, String in, String fin, int id) {

        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(SQL_UPDATE)) {

            ps.setInt(1, ins);
            ps.setInt(2, aula);
            ps.setString(3, g);
            ps.setString(4, in);
            ps.setString(5, fin);
            ps.setInt(6, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean delete(int id) {

        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(SQL_DELETE)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
} 