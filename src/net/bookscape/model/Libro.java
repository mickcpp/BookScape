package net.bookscape.model;

import java.io.Serializable;

public class Libro extends Product implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String genere;
	private FormatoLibro formato;
	private String ISBN;
	private String autore;
	private int anno;
	private int numeroPagine;

	public Libro(String nome, String descrizione, double prezzo, String genere, FormatoLibro formato, String ISBN, String autore, int anno, int numeroPagine) {
		super(nome, descrizione, prezzo);
		this.genere=genere;
		this.formato = formato;
		this.ISBN = ISBN;
		this.autore = autore;
		this.anno = anno;
		this.numeroPagine = numeroPagine;
	}

	public Libro() {
		super();
	}

	public String getGenere() {
		return genere;
	}
	
	public void setGenere(String genere) {
		this.genere = genere;
	}
	
	public FormatoLibro getFormato() {
		return formato;
	}
	
	public void setFormato(FormatoLibro formato) {
		this.formato = formato;
	}
	
	public String getISBN() {
		return ISBN;
	}
	
	public void setISBN(String ISBN) {
		this.ISBN = ISBN;
	}
	
	public String getAutore() {
		return autore;
	}
	
	public void setAutore(String autore) {
		this.autore = autore;
	}
	
	public int getAnno() {
		return anno;
	}

	public void setAnno(int anno) {
		this.anno = anno;
	}
	
	public int getNumeroPagine() {
		return numeroPagine;
	}
	
	public void setNumeroPagine(int numeroPagine) {
		this.numeroPagine = numeroPagine;
	}
	
	@Override
	public String toString() {
		return super.toString() + " " + genere + " " + formato + " " + ISBN + " " + autore + " " + anno + " " + numeroPagine;
	}
	
}
