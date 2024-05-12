package net.bookscape.model;

import java.sql.SQLException;
import java.util.Collection;

public interface CartModel<T> {
	
	public void doSave(T item, String userId) throws SQLException;

    public boolean doDelete(int id, String userId) throws SQLException;

    public boolean doUpdate(T item, String userId) throws SQLException;

    public Collection<T> doRetrieveAll(String order, String userId) throws SQLException;
    
}
