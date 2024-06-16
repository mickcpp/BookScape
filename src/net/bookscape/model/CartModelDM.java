package net.bookscape.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

public class CartModelDM implements CartModel<CartItem>{
	
	private static String TABLE_NAME = "carrello";

	@Override
	public void doSave(CartItem item, String clienteId) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String line = "";
		if(item.getProduct() instanceof Libro) {
			line = "Libro";
		}
		if(item.getProduct() instanceof Musica) {
			line = "Musica";
		}
		if(item.getProduct() instanceof Gadget) {
			line = "Gadget";
		}
		   
		String insertItem = "INSERT INTO " + TABLE_NAME + " "
					  + "(" + line + ", Cliente, Quantità) "
					  + "VALUES (?,?,?)";
		
		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(insertItem);
		  
			preparedStatement.setInt(1, item.getProduct().getId());
			preparedStatement.setString(2, clienteId);
			preparedStatement.setInt(3, item.getNumElementi());
			
		   	preparedStatement.executeUpdate();
//		   	connection.commit();
		   	
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
	public boolean doDeleteAll(String userId) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		int result = 0;

		String deleteSQL = "DELETE FROM " + TABLE_NAME + " WHERE Cliente = ?";
		  
		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setString(1, userId);

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
	public Collection<CartItem> doRetrieveAll(String order, String clienteId) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ProductModelDM productModel = new ProductModelDM();
		
		Collection<CartItem> listaItem = new LinkedList<CartItem>();

		String selectSQL = "SELECT * FROM carrello WHERE Cliente = ?";

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
				CartItem item = new CartItem();
				
				if((id = rs.getInt("Libro")) != 0) {
					Libro libro = (Libro) productModel.doRetrieveByKey(id, TABLE.libro);
					item.setProduct(libro);
				}
				if((id = rs.getInt("Musica")) != 0) {
					Musica musica = (Musica) productModel.doRetrieveByKey(id, TABLE.musica);
					item.setProduct(musica);
				}
				if((id = rs.getInt("Gadget")) != 0) {
					Gadget gadget = (Gadget) productModel.doRetrieveByKey(id, TABLE.gadget);
					item.setProduct(gadget);
				}
				
				item.setNumElementi(rs.getInt("Quantità"));
				listaItem.add(item);
			}
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerCP.releaseConnection(connection);
			}
		}
		
		return listaItem;
	}

	@Override
	public boolean doUpdate(CartItem item, String clienteId) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		int result = 0;
		
		String line = "";
		if(item.getProduct() instanceof Libro) {
			line = "Libro";
		}
		if(item.getProduct() instanceof Musica) {
			line = "Musica";
		}
		if(item.getProduct() instanceof Gadget) {
			line = "Gadget";
		}
		   
		String insertItem = "UPDATE " + TABLE_NAME + " "
					  + "SET Quantità = ? "
					  + "WHERE Cliente = ? AND " + line + " = ?";
		
		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(insertItem);
			
			preparedStatement.setInt(1, item.getNumElementi());
			preparedStatement.setString(2, clienteId);
			preparedStatement.setInt(3, item.getProduct().getId());
			
		   	result = preparedStatement.executeUpdate();
	   } finally {
		   try {
			   if (preparedStatement != null) {
				   preparedStatement.close();
			   }
		   } finally {
			   DriverManagerCP.releaseConnection(connection);	
		   }
	   }
		
		return result != 0 ? true : false;
	}

}
