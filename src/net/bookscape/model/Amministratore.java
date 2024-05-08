package net.bookscape.model;

import java.util.GregorianCalendar;

public class Amministratore extends Utente {
	
	private static final long serialVersionUID = 1L;
	
	public Amministratore(String email, String username, String password, String nome, String cognome, GregorianCalendar dataNascita) {
		super(email, username, password, nome, cognome, dataNascita);
	}
	
	public Amministratore() {
		super();
	}
	
}


