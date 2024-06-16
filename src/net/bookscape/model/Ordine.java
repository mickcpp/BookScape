package net.bookscape.model;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Collection;
import java.util.GregorianCalendar;
import java.util.LinkedList;

public class Ordine implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private Collection<CartItem> prodotti;
	private int id;
	private String nomeConsegna;
	private String cognomeConsegna;
	private double prezzoTotale;
	private GregorianCalendar dataConsegna;
	private GregorianCalendar dataOrdine;
	private String citta;
	private String via;
	private String CAP;
	private String clienteId;
	
	public Ordine(Collection<CartItem> prodotti, String nomeConsegna, String cognomeConsegna, double prezzoTotale, GregorianCalendar dataConsegna, GregorianCalendar dataOrdine, String citta, String via, String CAP, String clienteId) {
		setProdotti(prodotti);
		this.nomeConsegna = nomeConsegna;
		this.cognomeConsegna = cognomeConsegna;
		this.prezzoTotale = prezzoTotale;
		this.dataConsegna = dataConsegna;
		this.dataOrdine = dataOrdine;
		this.citta = citta;
		this.via = via;
		this.CAP = CAP;
		this.clienteId = clienteId;
		this.id = 0;
	}
	
	public Ordine() {
		prodotti = new LinkedList<CartItem>();
	}
	
	public Collection<CartItem> getProdotti() {
		return prodotti;
	}
	
	public void setProdotti(Collection<CartItem> items) {
		for(CartItem i : items) {
			Product prodotto = i.getProduct();
			CartItem newItem = new CartItem();
			newItem.setProduct(prodotto);
			newItem.setNumElementi(i.getNumElementi());
			newItem.getProduct().setPrezzo(prodotto.getPrezzo() + (22*prodotto.getPrezzo()/100));
			prodotti.add(newItem);
		}
	}
	
	public int getId() {
    	return id;
    }

    public void setId(int id) {
    	if(this.id == 0) this.id = id;
    }
    
	public String getNomeConsegna() {
		return nomeConsegna;
	}
	
	public void setNomeConsegna(String nomeConsegna) {
		this.nomeConsegna = nomeConsegna;
	}

	public String getCognomeConsegna() {
		return cognomeConsegna;
	}

	public void setCognomeConsegna(String cognomeConsegna) {
		this.cognomeConsegna = cognomeConsegna;
	}

	public double getPrezzoTotale() {
		return prezzoTotale;
	}

	public void setPrezzoTotale() {
		double tot = 0;
		for(CartItem item : prodotti) {
			tot += item.getTotalCost();
		}
		this.prezzoTotale = tot;
	}
	
	public void setPrezzoTotale(double prezzoTotale) {
		this.prezzoTotale = prezzoTotale;
	}

	public GregorianCalendar getDataConsegna() {
		return dataConsegna;
	}

	public void setDataConsegna() {
		// Creare un oggetto Calendar per rappresentare la data corrente
		Calendar oggi = Calendar.getInstance();

		// Aggiungere sette giorni alla data corrente
		oggi.add(Calendar.DAY_OF_MONTH, 7);

		// Utilizzare il valore aggiornato per impostare la data di consegna
		this.dataConsegna = (GregorianCalendar) oggi;
	}

	public void setDataConsegna(GregorianCalendar dataConsegna) {
		this.dataConsegna = dataConsegna;
	}
	
	public GregorianCalendar getDataOrdine() {
		return dataOrdine;
	}

	public void setDataOrdine() {
		// Creare un oggetto Calendar per rappresentare la data corrente
		Calendar oggi = Calendar.getInstance();

		// Utilizzare il valore aggiornato per impostare la data di consegna
		this.dataOrdine = (GregorianCalendar) oggi;
	}

	public void setDataOrdine(GregorianCalendar dataOrdine) {
		this.dataOrdine = dataOrdine;
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

	public String getCliente() {
		return clienteId;
	}

	public void setCliente(String clienteId) {
		this.clienteId = clienteId;
	}
	
}
