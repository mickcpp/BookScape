package net.bookscape.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

public class Cart {
	
	private Collection<CartItem> items;
	
	public Cart() {
		items = new ArrayList<CartItem>();
	}
	
	public void addItem(CartItem item) {
		items.add(item);
	}
	
	public void updateItemNum(CartItem item, int num) {
	    Iterator<CartItem> iterator = items.iterator();
	    while (iterator.hasNext()) {
	        CartItem i = iterator.next();
	        if (item.getProduct().getId() == i.getProduct().getId()) {
	        	i.setNumElementi(num);
	            break;
	        }
	    }
	}
	
	public boolean deleteItem(CartItem item) {
	    Iterator<CartItem> iterator = items.iterator();
	    while (iterator.hasNext()) {
	        CartItem i = iterator.next();
	        if (item.getProduct().getId() == i.getProduct().getId()) {
	        	iterator.remove();
	        	return true;
	        }
	    }
	    return false;
	}
	
	public Collection<CartItem> getItems() {
		return items;
	}
	
	public void setItems(Collection<CartItem> items) {
		this.items = items;
	}
	
	public CartItem getItem(int id) {
		Iterator<CartItem> iterator = items.iterator();
	    while (iterator.hasNext()) {
	        CartItem i = iterator.next();
	        if(i.getProduct().getId() == id) {
	        	return i;
	        }
	    }
		
		return null;
	}

	public boolean isInCart(CartItem item) {
		for(CartItem i : items) {
			if(item.getProduct().getId() == i.getProduct().getId()) {
				return true;
			}
		}
		return false;
	}
	
	public void incrementItem(CartItem item) {
		for(CartItem i : items) {
			if(item.getProduct().getId() == i.getProduct().getId()) {
				i.incrementNum();
			}
		}
	}
	
}
