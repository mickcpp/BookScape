package net.bookscape.model;

import java.io.Serializable;

public abstract class Product implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private final int ID;
    private String nome;
    private String  descrizione;
    private double prezzo;
    private int quantita;
    private static int contatore = 1000;

    public Product(String nome, String descrizione, double prezzo) {
        this.ID = contatore++;
        setNome(nome);
        setPrezzo(prezzo);
        setDescrizione(descrizione);
        this.quantita = 0;
    }
    
    public Product() {
		this.ID = contatore++;
    }

    public int getId() {
    	return ID;
    }

    public String getNome() {
    	return nome;
    }
     
    public void setNome(String nome) {
    	this.nome = nome;
    }
     
    public String getDescrizione() {
    	return descrizione;
    }
     
    public void setDescrizione(String descrizione) {
    	this.descrizione = descrizione;
    }
     
    public double getPrezzo() {
    	return prezzo;
    }
     
    public void setPrezzo(Double prezzo) {
    	this.prezzo = prezzo;
    }
     
    public int getQuantita() {
    	return quantita;
    }
     
    public void setQuantita(int quantita) {
    	this.quantita = quantita;
    }
    
    @Override
	public String toString() {
		return nome + " (" + ID + "), " + descrizione + " " + prezzo + ". " + quantita;
	}
   
}