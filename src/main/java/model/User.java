package model;

import java.io.Serializable;

public class User implements Serializable {

    private int id;
    private String username, password;
    private int roleId;
    private String roleName;

    public User() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public int getRoleId() { return roleId; }
    public void setRoleId(int roleId) { this.roleId = roleId; }

    public String getRoleName() { return roleName; }
    public void setRoleName(String roleName) { this.roleName = roleName; }

    /** Comodo per le JSP: controlla se è admin */
    public boolean isAdmin() {
        return "ADMIN".equalsIgnoreCase(roleName);
    }
}