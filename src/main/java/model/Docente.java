package model;

//Mettere tutti le variabili utili per il docente e metodi get and set

public class Docente {

	private int did;
	private String email;
	private String password;
	private String nome;
	private String cognome;
	
	
	public Docente( int did , String password, String email,String nome,String cognome) {
		
		this.did= did;
		this.email= email;
		this.password=password;
		this.nome=nome;
		this.cognome=cognome;
	
	}
	
	public int getDid(){
		return did;
	}
	public void SetDid(int did) {
		
		this.did= did;
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
	
	public String getNome(){
		return nome;
	}
	public void SetNome(String nome) {
		
		this.nome= nome;
	}
	public String getCognome(){
		return cognome;
	}
	public void SetCognome(String cognome) {
		
		this.cognome= cognome;
	}

}
