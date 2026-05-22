package model;

public class User {

	private int id;
	private String username;
	private String password;
	private int roleId;

	private int idStudente;
	private int idDocente;

	public User() {
	}

	public User(int id, String username, String password, int roleId) {
		this.id = id;
		this.username = username;
		this.password = password;
		this.roleId = roleId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

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

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	// getter / setter per idStudente e idDocente
	public int getIdStudente() {
		return idStudente;
	}

	public void setIdStudente(int idStudente) {
		this.idStudente = idStudente;
	}

	public int getIdDocente() {
		return idDocente;
	}

	public void setIdDocente(int idDocente) {
		this.idDocente = idDocente;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", roleId=" + roleId + ", idStudente=" + idStudente
				+ ", idDocente=" + idDocente + "]";
	}
}
