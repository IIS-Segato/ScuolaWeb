package model;

import java.io.Serializable;

public class User implements Serializable {

	private int id;

	private String username;
	private String password;

	private int roleId;
	private String roleName;

	private Integer studenteId;
	private Integer docenteId;

	public User() {
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

	public String getRoleName() {

		return roleName;
	}

	public void setRoleName(String roleName) {

		this.roleName = roleName;
	}

	public Integer getStudenteId() {

		return studenteId;
	}

	public void setStudenteId(Integer studenteId) {

		this.studenteId = studenteId;
	}

	public Integer getDocenteId() {

		return docenteId;
	}

	public void setDocenteId(Integer docenteId) {

		this.docenteId = docenteId;
	}

	public boolean isAdmin() {

		return "ADMIN".equalsIgnoreCase(roleName);
	}

	public boolean isStudente() {

		return "STUDENTE".equalsIgnoreCase(roleName);
	}

	public boolean isDocente() {

		return "DOCENTE".equalsIgnoreCase(roleName);
	}
}