package net.bookscape.model;

public class Catalog {
	
	private static Product[] prodotti;
	
	public static Product getProduct(int id) {
		
		if(id <= 1000) return null;
		
		Product product;
		
	    for(Product p: prodotti) {
	    	product = p;
	    	if (id == product.getId()) {
	    		return product;
	    	}
	    }
	    return null;
	  }
	
}
               