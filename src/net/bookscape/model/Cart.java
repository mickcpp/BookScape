package net.bookscape.model;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Cart {
	
	private List<CartItem> items;
	
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
	
	public void deleteItem(CartItem item) {
	    Iterator<CartItem> iterator = items.iterator();
	    while (iterator.hasNext()) {
	        CartItem i = iterator.next();
	        if (item.getProduct().getId() == i.getProduct().getId()) {
	        	iterator.remove();
	        }
	    }
	}
	
	public List<CartItem> getItems() {
		return items;
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
