package net.bookscape.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Collection;

public class ProductModelDM implements ProductModel <Product> {
	
   private static String TABLE_NAME = "";
   
   public synchronized void doSave(Product product) throws SQLException {
	   
	   Connection connection = null;
	   PreparedStatement preparedStatement = null;
	   String s = "";
	   
	   if(product instanceof Libro) {
		   s = "Genere, Formato, Anno, ISBN, Autore, `Numero pagine` VALUES (?,?,?,?,?,?,?,?,?,?,?)";
		   TABLE_NAME = "libro";
	   }
	   
	   if(product instanceof Musica) {
		   s = "Genere, Formato, Anno, `Numero tracce`, Artista VALUES (?,?,?,?,?,?,?,?,?,?)";
		   TABLE_NAME = "`dispositivo musicale`";
	   }
	   
	   if(product instanceof Gadget) {
		   s = "Materiale, Lunghezza, Larghezza, Altezza VALUES (?,?,?,?,?,?,?,?,?)";
		   TABLE_NAME = "gadget";
	   }
	   
	   String insertP = "INSERT INTO " + ProductModelDM.TABLE_NAME + " "
					  + "(ID, Nome, Descrizone, Prezzo, Quantità, " + s;

	   try {
		   connection = DriverManagerCP.getConnection();
		   preparedStatement = connection.prepareStatement(insertP);
		   
		   preparedStatement.setString(1,product.getNome());
		   preparedStatement.setString(2, product.getDescrizione());
		   preparedStatement.setDouble(3,product.getPrezzo());
		   preparedStatement.setInt(4,product.getQuantita());
		   
		   if(product instanceof Libro) {
			   Libro l = (Libro) product;
			   preparedStatement.setString(5, l.getGenere());
			   preparedStatement.setString(6, l.getFormato().toString());
			   preparedStatement.setInt(7, l.getAnno());
			   preparedStatement.setString(8, l.getISBN());
			   preparedStatement.setString(9, l.getAutore());
			   preparedStatement.setInt(10, l.getNumeroPagine());
		   }
		   
		   if(product instanceof Gadget) {
			   Gadget g = (Gadget) product;
			   preparedStatement.setString(5, g.getMateriale());
			   preparedStatement.setDouble(6, g.getLunghezza());
			   preparedStatement.setDouble(7, g.getLarghezza());
			   preparedStatement.setDouble(8, g.getAltezza()); 
		   } 
		  
		   if(product instanceof Musica) {
			   Musica m = (Musica) product;
			   preparedStatement.setString(5, m.getGenere());
			   preparedStatement.setString(6, m.getFormato().toString());
			   preparedStatement.setInt(7, m.getAnno());
			   preparedStatement.setInt(8, m.getNumeroTracce());
			   preparedStatement.setString(9, m.getArtista());   
		   } 
		   
		   preparedStatement.executeUpdate();
		   connection.commit();
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
	public boolean doDelete(int id) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		int result = 0;
		
		Product product = Catalog.getProduct(id);
		
		if(product == null) return false;
		  
		if(product instanceof Libro) {
			TABLE_NAME="libro";
		}
 
		if(product instanceof Musica) {
			TABLE_NAME="`dispositivo musicale`";
		}
		
		if(product instanceof Gadget) {
			TABLE_NAME="gadget";
		}
		
		String deleteSQL = "DELETE FROM " + ProductModelDM.TABLE_NAME + " WHERE ID = ?";
		  
		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, id);

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
	public Product doRetrieveByKey(int id) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public Collection<Product> doRetrieveAll(String order) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	
}