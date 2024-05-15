package net.bookscape.model;

import java.sql.SQLException;
import java.util.Collection;

public interface ClienteModel<T>{
	
	public void doSave(T cliente) throws SQLException;

    public boolean doDelete(String id) throws SQLException;

    public T doRetrieveByKey(String id) throws SQLException;

    public Collection<T> doRetrieveAll(String order) throws SQLException;
   
    public boolean isAdmin(String id) throws SQLException;
    
}
