package net.bookscape.model;

import java.sql.SQLException;
import java.util.Collection;

public class OrderModelDM implements OrderModel{

	@Override
	public void doSave(Object order) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean doDelete(int id) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Collection doRetrieveAll(String order) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

}
