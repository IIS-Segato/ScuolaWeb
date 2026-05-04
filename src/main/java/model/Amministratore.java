package model;

//Mettere tutti le variabili utili per l'Amministratore e metodi get and set

public class Amministratore {

	private int aid;
	private String email;
	private String password;
	public Amministratore( int aid , String password, String email) {
		
		this.aid= aid;
		this.email= email;
		this.password=password;
		
	}
	public int getAid(){
		return aid;
	}
	public void SetAid(int aid) {
		
		this.aid= aid;
	}
	public String getEmail(){
		return email;
	}
	public void SetAid(String email) {
		
		this.email= email;
	}
	
	public String getPassword(){
		return password;
	}
	public void SetPassword(String password) {
		
		this.password= password;
	}

}
