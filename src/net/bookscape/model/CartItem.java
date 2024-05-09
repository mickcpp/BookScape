package net.bookscape.model;

public class CartItem {
	
	private Product product;
	private int num;
	
	public CartItem(Product product) {
		this.product = product;
		this.num = 1;
	}
	
	public CartItem() {
		this.num = 1;
	}
	
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	
	public int getNumElementi() {
		return num;
	}
	
	public void setNumElementi(int num) {
		this.num = num;
	}
	
	public void incrementNum() {
		setNumElementi(getNumElementi() + 1);
    }

	public double getTotalCost() {
	    return(getNumElementi() * product.getPrezzo());
	}
	
}
