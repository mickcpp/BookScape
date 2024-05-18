package net.bookscape.model;

import java.sql.SQLException;
import java.util.Collection;

public class OrderModelDM implements OrderModel <Ordine> {

	@Override
	public void doSave(Ordine order) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean doDelete(int id) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Collection<Ordine> doRetrieveAll(String order) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	
}
