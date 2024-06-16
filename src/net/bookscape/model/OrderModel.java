package net.bookscape.model;

import java.sql.SQLException;
import java.util.Collection;

public interface OrderModel<T>{
	
	public void doSave(T order) throws SQLException;
	
	public Collection<T> doRetrieveAll(String order, boolean completo) throws SQLException;
	
}
