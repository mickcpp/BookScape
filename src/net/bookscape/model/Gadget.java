package net.bookscape.model;

import java.io.Serializable;

public class Gadget extends Product implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String materiale;
	private double altezza;
	private double lunghezza;
	private double larghezza;
	
	public Gadget(String nome, String descrizione, double prezzo, String materiale, double altezza, double lunghezza, double larghezza, String imgUrl) {
		super(nome, descrizione, prezzo, imgUrl);
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
	
	public double getAltezza() {
		return altezza;
	}
	
	public void setAltezza(double altezza) {
		this.altezza = altezza;
	}
	
	public double getLunghezza() {
		return lunghezza;
	}
	
	public void setLunghezza(double lunghezza) {
		this.lunghezza = lunghezza;
	}
	
	public double getLarghezza() {
		return larghezza;
	}
	
	public void setLarghezza(double larghezza) {
		this.larghezza = larghezza;
	}
	
	@Override
	public String toString() {
		return super.toString() + " " + materiale + " " + altezza + " " + lunghezza + " " + larghezza;
	}
	
}
