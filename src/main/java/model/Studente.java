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
	
	
	public Studente() {
	
	}
	
	
	public int getSid(){
		return sid;
	}
	public void setSid(int sid) {
		
		this.sid= sid;
	}
	public String getEmail(){
		return email;
	}
	public void setEmail(String email) {
		
		this.email= email;
	}
	
	public String getPassword(){
		return password;
	}
	public void setPassword(String password) {
		
		this.password= password;
	}
	
	public String getNome(){
		return nome;
	}
	public void setNome(String nome) {
		
		this.nome= nome;
	}

	
	public String getCognome(){
		return cognome;
	}
	public void setCognome(String cognome) {
		
		this.cognome= cognome;
	}
	public String getNascita(){
		return nascita;
	}
	public void setNascita(String nascita) {
		
		this.nascita= nascita;
	}
	
	public int getCid(){
		return cid;
	}
	public void setCid(int cid) {
		
		this.cid= cid;
	}

}
