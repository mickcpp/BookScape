package net.bookscape.model;

public class CartaPagamento {
	
	private String nomeCarta;
	private String numeroCarta;
	private int cvv;
	
	public CartaPagamento(String nomeCarta, String numeroCarta, int cvv) {
		this.nomeCarta = nomeCarta;
		this.numeroCarta = numeroCarta;
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

	public int getCvv() {
		return cvv;
	}

	public void setCvv(int cvv) {
		this.cvv = cvv;
	}
}
