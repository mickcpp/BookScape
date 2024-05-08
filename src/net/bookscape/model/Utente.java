package net.bookscape.model;

import java.io.Serializable;
import java.util.GregorianCalendar;

public abstract class Utente implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String email;
	private String username;
	private String password;
	private String nome;
	private String cognome;
	private GregorianCalendar dataNascita;
	
	public Utente(String email, String username, String password, String nome, String cognome, GregorianCalendar dataNascita) {
		this.email = email;
		this.username = username;
		this.password = password;
		this.nome = nome;
		this.cognome = cognome;
		this.dataNascita = dataNascita;
	}

	public Utente() {}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCognome() {
		return cognome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
	}

	public GregorianCalendar getDataNascita() {
		return dataNascita;
	}

	public void setDataNascita(GregorianCalendar dataNascita) {
		this.dataNascita = dataNascita;
	}
	
	public String toString() {
		return "Email: " + this.email + "\nUsername: " + this.username + "\nPassword: " + this.getPassword() + "\nNome: " + this.getNome() + "\nCognome: " + this.getCognome() + "\nData nascita: " + this.dataNascita;
	}
	
}
