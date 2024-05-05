package net.bookscape.model;

import java.sql.SQLException;
import java.util.Collection;

public interface ProductModel {
	
	public void doSave(Product product) throws SQLException;

	public boolean doDelete(int id) throws SQLException;

	public Product doRetrieveByKey(int id) throws SQLException;
	
	public Collection<Product> doRetrieveAll(String order) throws SQLException;
}
