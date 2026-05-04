package model;

//Mettere tutti le variabili utili per lo studente e metodi get and set

public class Studente {
	
	
	private int sid;
	private String email;
	private String password;
	private String nome;
	private String cognome;
	private String nascita; 
	private int cid;
	
	
	public Studente( int sid , String password, String email,String nome,String cognome,String nascita, int cid) {
		
		this.sid= sid;
		this.email= email;
		this.password=password;
		this.nome=nome;
		this.cognome=cognome;
		this.nascita= nascita;
		this.cid=cid;
	
	}
	
	
	public int getSid(){
		return sid;
	}
	public void SetSid(int sid) {
		
		this.sid= sid;
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
	public String getNascita(){
		return nascita;
	}
	public void SetNascita(String nascita) {
		
		this.nascita= nascita;
	}
	
	public int getCid(){
		return cid;
	}
	public void SetCid(int cid) {
		
		this.cid= cid;
	}

}
