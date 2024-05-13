package net.bookscape.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

public class WishlistModelDM implements CartModel<Product>{
	
	private static String TABLE_NAME = "wishlist";

	@Override
	public void doSave(Product item, String clienteId) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String line = "";
		if(item instanceof Libro) {
			line = "Libro";
		}
		if(item instanceof Musica) {
			line = "Musica";
		}
		if(item instanceof Gadget) {
			line = "Gadget";
		}
		   
		String insertItem = "INSERT INTO " + TABLE_NAME + " "
					  + "(" + line + ", Cliente) "
					  + "VALUES (?,?)";
		
		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(insertItem);
		  
			preparedStatement.setInt(1, item.getId());
			preparedStatement.setString(2, clienteId);
			
		   	preparedStatement.executeUpdate();
	   } finally {
		   try {
			   if (preparedStatement != null) {
				   preparedStatement.close();
			   }
		   } finally {
			   DriverManagerCP.releaseConnection(connection);	
		   }
	   }
	}

	@Override
	public boolean doDelete(int id, String clienteId) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		int result = 0;
	
		ProductModelDM productModel = new ProductModelDM();
		Product p = productModel.doRetrieveByKeyGeneral(id);
		
		String line = "";
		
		if(p instanceof Libro) {
			line = "Libro";
		}
		if(p instanceof Musica) {
			line = "Musica";
		}
		if(p instanceof Gadget) {
			line = "Gadget";
		}
		
		String deleteSQL = "DELETE FROM " + TABLE_NAME + " WHERE " + line + " = ? AND Cliente = ?";
		  
		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, id);
			preparedStatement.setString(2, clienteId);

			result = preparedStatement.executeUpdate();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerCP.releaseConnection(connection);
			}
		}
		
		return result != 0 ? true : false;
	}

	@Override
	public Collection<Product> doRetrieveAll(String order, String clienteId) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ProductModelDM productModel = new ProductModelDM();
		
		Collection<Product> listaProdotti = new LinkedList<Product>();

		String selectSQL = "SELECT * FROM wishlist WHERE Cliente = ?";

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, clienteId);

			ResultSet rs = preparedStatement.executeQuery();
			int id = 0;

			while (rs.next()) {
				Product p = null;
				
				if((id = rs.getInt("Libro")) != 0) {
					Libro libro = (Libro) productModel.doRetrieveByKey(id, TABLE.libro);
					p = libro;
				}
				if((id = rs.getInt("Musica")) != 0) {
					Musica musica = (Musica) productModel.doRetrieveByKey(id, TABLE.musica);
					p = musica;
				}
				if((id = rs.getInt("Gadget")) != 0) {
					Gadget gadget = (Gadget) productModel.doRetrieveByKey(id, TABLE.gadget);
					p = gadget;
				}
				
				listaProdotti.add(p);
			}
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerCP.releaseConnection(connection);
			}
		}
		
		return listaProdotti;
	}

	@Override
	public boolean doUpdate(Product item, String userId) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

}


