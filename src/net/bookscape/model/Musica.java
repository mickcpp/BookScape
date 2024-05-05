package net.bookscape.model;

import java.io.Serializable;

public class Musica extends Product implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String genere;
	private FormatoMusica formato;
	private String artista;
	private int anno;
	private int numeroTracce;
	
	public Musica(String nome, String descrizione, double prezzo, String genere, FormatoMusica formato, String artista, int anno, int numeroTracce) {
		super(nome, descrizione, prezzo);
		this.genere = genere;
		this.formato = formato;
		this.artista = artista;
		this.anno = anno;
		this.numeroTracce = numeroTracce;
	}

	public Musica() {
		super();
	}
	
	public String getGenere() {
		return genere;
	}
	
	public void setGenere(String genere) {
		this.genere = genere;
	}

	public FormatoMusica getFormato() {
		return formato;
	}

	public void setFormato(FormatoMusica formato) {
		this.formato = formato;
	}

	public String getArtista() {
		return artista;
	}

	public void setArtista(String artista) {
		this.artista = artista;
	}

	public int getAnno() {
		return anno;
	}

	public void setAnno(int anno) {
		this.anno = anno;
	}

	public int getNumeroTracce() {
		return numeroTracce;
	}

	public void setNumeroTracce(int numeroTracce) {
		this.numeroTracce = numeroTracce;
	}
	
	@Override
	public String toString() {
		return super.toString() + " " + genere + " " + formato + " " + artista + " " + anno + " " + numeroTracce;
	}
	
}
