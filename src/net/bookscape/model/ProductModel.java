package net.bookscape.model;

import java.sql.SQLException;
import java.util.Collection;

public interface ProductModel <T> {
	
	public boolean doSave(T product) throws SQLException;

	public boolean doDelete(int id) throws SQLException;

	public T doRetrieveByKey(int id, TABLE tabella) throws SQLException;
	
	public Collection<T> doRetrieveAll(String order) throws SQLException;
	
	public boolean doUpdate(T product) throws SQLException;
	
}
