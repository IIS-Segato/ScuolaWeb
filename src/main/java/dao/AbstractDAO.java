package dao;

import java.io.IOException;
import java.sql.*;
import org.jdom2.JDOMException;
import utils.Config;

public abstract class AbstractDAO implements DAO {

    protected Connection conn;
    protected Config cfg;

    public AbstractDAO(String xml) throws ClassNotFoundException, JDOMException, IOException {
        this.cfg = new Config(xml);
    }

    @Override
    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    protected Connection getConnection() throws Exception {
        cfg.loadConfig();
        Class.forName(cfg.getDriver());
        return DriverManager.getConnection(
            cfg.getDbUrl(),
            cfg.getUser(),
            cfg.getPassword()
        );
    }

    protected void closeConnection() throws SQLException {
        if (conn != null && !conn.isClosed()) {
            conn.close();
        }
    }

    protected void printException(Exception ex) {
        ex.printStackTrace();
    }
}