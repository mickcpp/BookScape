package net.bookscape.model;

import java.sql.SQLException;
import java.util.Collection;

public interface RecensioneModel <T>{

	public void doSave(T recensione, TABLE table) throws SQLException;

	public boolean doDelete(String cliente ,int prodotto, TABLE table) throws SQLException;

	public Collection<Recensione> doRetrieveAll(int prodotto, TABLE table) throws SQLException;

	public void doUpdate(T product, TABLE table) throws SQLException;
}