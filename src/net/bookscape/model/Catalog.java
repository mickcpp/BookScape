package net.bookscape.model;

public class Catalog {
	
	private static Product[] prodotti;
	
	public static Product getProduct(int id) {
		
		if(id == 0) return null;
		
		Product product;
		
	    for(int i=0; i<prodotti.length; i++) {
	    	product = prodotti[i];
	    	if (id == product.getId()) {
	    		return product;
	    	}
	    }
	    
	    return null;
	  }
	
}
               