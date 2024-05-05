package net.bookscape.model;

import java.io.Serializable;

public class Gadget extends Product implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String materiale;
	private int altezza;
	private int lunghezza;
	private int larghezza;
	
	public Gadget(String nome, String descrizione, double prezzo, String materiale, int altezza, int lunghezza, int larghezza) {
		super(nome, descrizione, prezzo);
		this.materiale = materiale;
		this.altezza = altezza;
		this.lunghezza = lunghezza;
		this.larghezza = larghezza;
	}
	
	public Gadget() {
		super();
	}
	
	public String getMateriale() {
		return materiale;
	}
	
	public void setMateriale(String materiale) {
		this.materiale = materiale;
	}
	
	public int getAltezza() {
		return altezza;
	}
	
	public void setAltezza(int altezza) {
		this.altezza = altezza;
	}
	
	public int getLunghezza() {
		return lunghezza;
	}
	
	public void setLunghezza(int lunghezza) {
		this.lunghezza = lunghezza;
	}
	
	public int getLarghezza() {
		return larghezza;
	}
	
	public void setLarghezza(int larghezza) {
		this.larghezza = larghezza;
	}
	
	@Override
	public String toString() {
		return super.toString() + " " + materiale + " " + altezza + " " + lunghezza + " " + larghezza;
	}
	
}
