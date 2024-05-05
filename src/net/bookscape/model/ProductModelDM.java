package net.bookscape.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

public class ProductModelDM{
	
   private static final String TABLE_NAME = "libro";
   
   public synchronized void doSave(Libro libro) throws SQLException {
	   
	   Connection connection = null;
	   PreparedStatement preparedStatement = null;
	   String insertLibro = "INSERT INTO " + ProductModelDM.TABLE_NAME
						 + "(ID,Nome, Descrizone, Prezzo, Quantità, Genere, Formato, Anno, ISBN, Autore, `NumeroPagine`)"
						 + " VALUES (?,?,?,?,?,?,?,?,?,?,?)";

	   try {
		   connection = DriverManagerCP.getConnection();
		   preparedStatement= connection.prepareStatement(insertLibro);
		   preparedStatement.setString(1,libro.getNome());
		   preparedStatement.setString(2,libro.getDescrizione());
		   preparedStatement.setDouble(4,libro.getPrezzo());
		   preparedStatement.setInt(5,libro.getQuantita());
		   preparedStatement.setString(6,libro.getGenere());
		   preparedStatement.setString(7,libro.getFormato().toString());
		   preparedStatement.setInt(8,libro.getAnno());
		   preparedStatement.setString(9,libro.getISBN());
		   preparedStatement.setString(10,libro.getAutore());
		   
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
   
}