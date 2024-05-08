package net.bookscape.model;

import java.io.Serializable;
import java.util.GregorianCalendar;

public class Cliente extends Utente implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String citta;
	private String via;
	private String CAP;
	private CartaPagamento carta;
	
	public Cliente(String email, String username, String password, String nome, String cognome, GregorianCalendar dataNascita, String citta, String via, String CAP, CartaPagamento carta) {
		super(email, username, password, nome, cognome, dataNascita);
		this.citta = citta;
		this.via = via;
		this.CAP = CAP;
		this.carta = carta;
	}
	
	public Cliente() {
		super();
	}

	public String getCitta() {
		return citta;
	}

	public void setCitta(String citta) {
		this.citta = citta;
	}

	public String getVia() {
		return via;
	}

	public void setVia(String via) {
		this.via = via;
	}

	public String getCAP() {
		return CAP;
	}

	public void setCAP(String CAP) {
		this.CAP = CAP;
	}

	public CartaPagamento getCarta() {
		return carta;
	}

	public void setCarta(CartaPagamento carta) {
		this.carta = carta;
	}

	public String toString() {
		return super.toString() + "\nCittà: " + this.citta + "\nVia: " + this.via + "\nCAP: " + this.CAP + "\nCarta: " + this.carta;
	}
	
}
