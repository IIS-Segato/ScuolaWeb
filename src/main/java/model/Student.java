package model;

import java.io.Serializable;

public class Student implements Serializable {

	private int id;
	private String name;
	private String surname;
	private String className;

	public Student(int id, String name, String surname, String className) {
		this.id = id;
		this.name = name;
		this.surname = surname;
		this.className = className;
	}

	public Student(String name, String surname, String className) {
		this.name = name;
		this.surname = surname;
		this.className = className;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSurname() {
		return surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}
}
