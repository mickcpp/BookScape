package net.bookscape.model;

import java.util.GregorianCalendar;

public class CartaPagamento {
	
	private String nomeCarta;
	private String numeroCarta;
	private GregorianCalendar dataScadenza;
	private int cvv;
	
	public CartaPagamento(String nomeCarta, String numeroCarta, GregorianCalendar dataScadenza, int cvv) {
		this.nomeCarta = nomeCarta;
		this.numeroCarta = numeroCarta;
		this.setDataScadenza(dataScadenza);
		this.cvv = cvv;
	}

	public CartaPagamento() {
		
	}
	
	public String getNomeCarta() {
		return nomeCarta;
	}
	
	public void setNomeCarta(String nomeCarta) {
		this.nomeCarta = nomeCarta;
	}

	public String getNumeroCarta() {
		return numeroCarta;
	}

	public void setNumeroCarta(String numeroCarta) {
		this.numeroCarta = numeroCarta;
	}

	public GregorianCalendar getDataScadenza() {
		return dataScadenza;
	}

	public void setDataScadenza(GregorianCalendar dataScadenza) {
		this.dataScadenza = dataScadenza;
	}
	
	public int getCvv() {
		return cvv;
	}

	public void setCvv(int cvv) {
		this.cvv = cvv;
	}
	
}
