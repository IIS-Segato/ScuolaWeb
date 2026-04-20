package model;

import java.io.Serializable;

public class Role implements Serializable {
	public Role(int id, String role_name, String description) {
		super();
		this.id = id;
		this.role_name = role_name;
		this.description = description;
	}

	private int id;
	private String role_name, description;

	public Role() {
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getRole_name() {
		return role_name;
	}

	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
