package net.bookscape.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

public class Wishlist {
	
	private Collection<Product> items;
	
	public Wishlist() {
		items = new ArrayList<Product>();
	}
	
	public void addItem(Product item) {
		if(!isInWishlist(item)) {
			items.add(item);
		}
	}
	
	public boolean deleteItem(Product item) {
	    Iterator<Product> iterator = items.iterator();
	    while (iterator.hasNext()) {
	    	Product p = iterator.next();
	        if (item.getId() == p.getId()) {
	        	iterator.remove();
	        	return true;
	        }
	    }
	    return false;
	}
	
	public Collection<Product> getItems() {
		return items;
	}
	
	public void setItems(Collection<Product> items) {
		this.items = items;
	}
	
	public Product getItem(int id) {
		Iterator<Product> iterator = items.iterator();
	    while (iterator.hasNext()) {
	    	Product p = iterator.next();
	        if(p.getId() == id) {
	        	return p;
	        }
	    }
		return null;
	}

	public boolean isInWishlist(Product item) {
		for(Product p : items) {
			if(item.getId() == p.getId()) {
				return true;
			}
		}
		return false;
	}

}
