package net.bookscape.model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
	
	private List<Product> products;
	
	public Cart() {
		products = new ArrayList<Product>();
	}
	
	public void addProduct(Product product) {
		products.add(product);
	}
	
	public void deleteProduct(Product product) {
		for(Product p : products) {
			if(p.getId() == product.getId()) {
				products.remove(p);
				break;
			}
		}
 	}
	
	public List<Product> getProducts() {
		return products;
	}
}
