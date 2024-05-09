package net.bookscape.model;

import java.io.Serializable;

public abstract class Product implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int ID;
    private String nome;
    private String  descrizione;
    private double prezzo;
    private int quantita;
    private String imgURL;

    public Product(String nome, String descrizione, double prezzo, String imgUrl) {
        this.ID = 0;
        setNome(nome);
        setPrezzo(prezzo);
        setDescrizione(descrizione);
        this.quantita = 0;
        this.setImgURL(imgUrl);
    }
    
    public Product() {
		this.ID = 0;
    }

    public int getId() {
    	return ID;
    }

    public void setId(int ID) {
    	if(this.ID == 0) this.ID = ID;
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
    
	public String getImgURL() {
		return imgURL;
	}

	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}
	
    @Override
	public String toString() {
		return nome + " (" + ID + "), " + descrizione + " " + prezzo + ". " + quantita;
	}
   
}