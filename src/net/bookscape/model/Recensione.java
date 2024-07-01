package net.bookscape.model;

public class Recensione {

	private String cliente;
	private int prodotto;
	private String recensione;
	private int valutazione;

	public Recensione(String cliente, int prodotto, String recensione, int valutazione) {
		setCliente(cliente);
		setProdotto(prodotto);
		setRecensione(recensione);
		setValutazione(valutazione);
	}

	public Recensione(){}

	public String getCliente() {
		return cliente;
	}
	
	public void setCliente(String cliente) {
		this.cliente = cliente;
	}
	
	public int getProdotto() {
		return prodotto;
	}
	public void setProdotto(int prodotto) {
		this.prodotto = prodotto;
	}
	
	public String getRecensione() {
		return recensione;
	}
	
	public void setRecensione(String recensione) {
		this.recensione = recensione;
	}
	
	public int getValutazione() {
		return valutazione;
	}
	
	public void setValutazione(int valutazione) {
		this.valutazione = valutazione;
	}
}