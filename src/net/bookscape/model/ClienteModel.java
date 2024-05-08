package net.bookscape.model;

import java.sql.SQLException;
import java.util.Collection;

public interface ClienteModel<T>{
	
	public void doSave(T cliente) throws SQLException;

    public boolean doDelete(int id) throws SQLException;

    public T doRetrieveByKey(int id) throws SQLException;

    public Collection<T> doRetrieveAll(String order) throws SQLException;
   
    public Amministratore doRetrieveByKeyAdmin(int id) throws SQLException;
    
}
