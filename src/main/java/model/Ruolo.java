package model;

public class Ruolo {
	private int id;
	private String nome_ruolo;
	private boolean gestione_utenti;
	private boolean voti_modifica_tutti;
	private boolean voti_visualizza_tutti;
	private boolean voti_modifica_propri;
	private boolean voti_visualizza_propri;
	private boolean voti_visualizza_classe;
	private boolean orario_modifica;
	private boolean orario_visualizza;
	private boolean aule_modifica;
	private boolean aule_visualizza;
	private boolean bacheca_pubblica;
	private boolean bacheca_visualizza;
	private boolean dati_visualizza;

	public Ruolo() {
	
	}
	
	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}
	/**
	 * @return the nome_ruolo
	 */
	public String getNome_ruolo() {
		return nome_ruolo;
	}
	/**
	 * @param nome_ruolo the nome_ruolo to set
	 */
	public void setNome_ruolo(String nome_ruolo) {
		this.nome_ruolo = nome_ruolo;
	}
	/**
	 * @return the gestione_utenti
	 */
	public boolean isGestione_utenti() {
		return gestione_utenti;
	}
	/**
	 * @param gestione_utenti the gestione_utenti to set
	 */
	public void setGestione_utenti(boolean gestione_utenti) {
		this.gestione_utenti = gestione_utenti;
	}
	/**
	 * @return the voti_modifica_tutti
	 */
	public boolean isVoti_modifica_tutti() {
		return voti_modifica_tutti;
	}
	/**
	 * @param voti_modifica_tutti the voti_modifica_tutti to set
	 */
	public void setVoti_modifica_tutti(boolean voti_modifica_tutti) {
		this.voti_modifica_tutti = voti_modifica_tutti;
	}
	/**
	 * @return the voti_visualizza_tutti
	 */
	public boolean isVoti_visualizza_tutti() {
		return voti_visualizza_tutti;
	}
	/**
	 * @param voti_visualizza_tutti the voti_visualizza_tutti to set
	 */
	public void setVoti_visualizza_tutti(boolean voti_visualizza_tutti) {
		this.voti_visualizza_tutti = voti_visualizza_tutti;
	}
	/**
	 * @return the voti_modifica_propri
	 */
	public boolean isVoti_modifica_propri() {
		return voti_modifica_propri;
	}
	/**
	 * @param voti_modifica_propri the voti_modifica_propri to set
	 */
	public void setVoti_modifica_propri(boolean voti_modifica_propri) {
		this.voti_modifica_propri = voti_modifica_propri;
	}
	/**
	 * @return the voti_visualizza_propri
	 */
	public boolean isVoti_visualizza_propri() {
		return voti_visualizza_propri;
	}
	/**
	 * @param voti_visualizza_propri the voti_visualizza_propri to set
	 */
	public void setVoti_visualizza_propri(boolean voti_visualizza_propri) {
		this.voti_visualizza_propri = voti_visualizza_propri;
	}
	/**
	 * @return the voti_visualizza_classe
	 */
	public boolean isVoti_visualizza_classe() {
		return voti_visualizza_classe;
	}
	/**
	 * @param voti_visualizza_classe the voti_visualizza_classe to set
	 */
	public void setVoti_visualizza_classe(boolean voti_visualizza_classe) {
		this.voti_visualizza_classe = voti_visualizza_classe;
	}
	/**
	 * @return the orario_modifica
	 */
	public boolean isOrario_modifica() {
		return orario_modifica;
	}
	/**
	 * @param orario_modifica the orario_modifica to set
	 */
	public void setOrario_modifica(boolean orario_modifica) {
		this.orario_modifica = orario_modifica;
	}
	/**
	 * @return the orario_visualizza
	 */
	public boolean isOrario_visualizza() {
		return orario_visualizza;
	}
	/**
	 * @param orario_visualizza the orario_visualizza to set
	 */
	public void setOrario_visualizza(boolean orario_visualizza) {
		this.orario_visualizza = orario_visualizza;
	}
	/**
	 * @return the aule_modifica
	 */
	public boolean isAule_modifica() {
		return aule_modifica;
	}
	/**
	 * @param aule_modifica the aule_modifica to set
	 */
	public void setAule_modifica(boolean aule_modifica) {
		this.aule_modifica = aule_modifica;
	}
	/**
	 * @return the aule_visualizza
	 */
	public boolean isAule_visualizza() {
		return aule_visualizza;
	}
	/**
	 * @param aule_visualizza the aule_visualizza to set
	 */
	public void setAule_visualizza(boolean aule_visualizza) {
		this.aule_visualizza = aule_visualizza;
	}
	/**
	 * @return the bacheca_pubblica
	 */
	public boolean isBacheca_pubblica() {
		return bacheca_pubblica;
	}
	/**
	 * @param bacheca_pubblica the bacheca_pubblica to set
	 */
	public void setBacheca_pubblica(boolean bacheca_pubblica) {
		this.bacheca_pubblica = bacheca_pubblica;
	}
	/**
	 * @return the bacheca_visualizza
	 */
	public boolean isBacheca_visualizza() {
		return bacheca_visualizza;
	}
	/**
	 * @param bacheca_visualizza the bacheca_visualizza to set
	 */
	public void setBacheca_visualizza(boolean bacheca_visualizza) {
		this.bacheca_visualizza = bacheca_visualizza;
	}
	/**
	 * @return the dati_visualizza
	 */
	public boolean isDati_visualizza() {
		return dati_visualizza;
	}
	/**
	 * @param dati_visualizza the dati_visualizza to set
	 */
	public void setDati_visualizza(boolean dati_visualizza) {
		this.dati_visualizza = dati_visualizza;
	}
}
