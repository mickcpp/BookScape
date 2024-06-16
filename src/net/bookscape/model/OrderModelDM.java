package net.bookscape.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.GregorianCalendar;

public class OrderModelDM implements OrderModel <Ordine> {

	public static final String TABLE_NAME = "ordine";
	
	@Override
	public void doSave(Ordine order) throws SQLException {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    PreparedStatement preparedStatementProdotti = null;
	    ResultSet generatedKeys = null; // Per recuperare l'ID generato
	    
	    String insertOrder = "INSERT INTO " + TABLE_NAME + " "
	                      + "(`Nome consegna`, `Cognome consegna`, `Prezzo totale`, `Data consegna`, `Data ordine`, Città, Via, CAP, Cliente) "
	                      + "VALUES (?,?,?,?,?,?,?,?,?)";

	    try {
	        connection = DriverManagerCP.getConnection();
	        preparedStatement = connection.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS);
	        
	        preparedStatement.setString(1, order.getNomeConsegna());
	        preparedStatement.setString(2, order.getCognomeConsegna());
	        preparedStatement.setDouble(3, order.getPrezzoTotale());
	        preparedStatement.setTimestamp(4, new Timestamp(order.getDataConsegna().getTimeInMillis()));
	        preparedStatement.setTimestamp(5, new Timestamp(order.getDataOrdine().getTimeInMillis()));
	        preparedStatement.setString(6, order.getCitta());
	        preparedStatement.setString(7, order.getVia());
	        preparedStatement.setString(8, order.getCAP());
	        preparedStatement.setString(9, order.getCliente());
	        
	        preparedStatement.executeUpdate();
	        
	        generatedKeys = preparedStatement.getGeneratedKeys();
	        int orderId = -1;
	        
	        if (generatedKeys.next()) {
	            orderId = generatedKeys.getInt(1); // Recupera l'ID generato
	        } else {
	            throw new SQLException("Nessun ID generato dopo l'inserimento dell'ordine.");
	        }
	        
	        for (CartItem item : order.getProdotti()) {
	            if (item.getProduct() instanceof Libro) {
	                String s = "INSERT INTO `acquisto libro` (Libro, Ordine, Quantità, `Prezzo acquisto`, `Prezzo totale`) "
	                           + "VALUES (?,?,?,?,?)";
	                preparedStatementProdotti = connection.prepareStatement(s);
	                
	                preparedStatementProdotti.setInt(1, item.getProduct().getId());
	                preparedStatementProdotti.setInt(2, orderId);
	                preparedStatementProdotti.setInt(3, item.getNumElementi());
	                preparedStatementProdotti.setDouble(4, item.getProduct().getPrezzo());
	                preparedStatementProdotti.setDouble(5, item.getTotalCost());
	                
	                preparedStatementProdotti.executeUpdate();
	                preparedStatementProdotti.close(); // Chiudi il PreparedStatement dopo l'esecuzione
	            }
	            
	            if (item.getProduct() instanceof Gadget) {
	                String s = "INSERT INTO `acquisto gadget` (Gadget, Ordine, Quantità, `Prezzo acquisto`, `Prezzo totale`) "
	                           + "VALUES (?,?,?,?,?)";
	                preparedStatementProdotti = connection.prepareStatement(s);
	                
	                preparedStatementProdotti.setInt(1, item.getProduct().getId());
	                preparedStatementProdotti.setInt(2, orderId);
	                preparedStatementProdotti.setInt(3, item.getNumElementi());
	                preparedStatementProdotti.setDouble(4, item.getProduct().getPrezzo());
	                preparedStatementProdotti.setDouble(5, item.getTotalCost());
	                
	                preparedStatementProdotti.executeUpdate();
	                preparedStatementProdotti.close(); // Chiudi il PreparedStatement dopo l'esecuzione
	            }
	            
	            if (item.getProduct() instanceof Musica) {
	                String s = "INSERT INTO `acquisto musica` (Musica, Ordine, Quantità, `Prezzo acquisto`, `Prezzo totale`) "
	                           + "VALUES (?,?,?,?,?)";
	                preparedStatementProdotti = connection.prepareStatement(s);
	                
	                preparedStatementProdotti.setInt(1, item.getProduct().getId());
	                preparedStatementProdotti.setInt(2, orderId);
	                preparedStatementProdotti.setInt(3, item.getNumElementi());
	                preparedStatementProdotti.setDouble(4, item.getProduct().getPrezzo());
	                preparedStatementProdotti.setDouble(5, item.getTotalCost());
	                
	                preparedStatementProdotti.executeUpdate();
	                preparedStatementProdotti.close(); // Chiudi il PreparedStatement dopo l'esecuzione
	            }
	        }
	        
	    } finally {
	        try {
	            if (generatedKeys != null) {
	                generatedKeys.close();
	            }
	            if (preparedStatement != null) {
	                preparedStatement.close();
	            }
	            if (preparedStatementProdotti != null) {
	                preparedStatementProdotti.close();
	            }
	        } finally {
	            DriverManagerCP.releaseConnection(connection);    
	        }
	    }
	}

	@Override
	public Collection<Ordine> doRetrieveAll(String clienteId) throws SQLException {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    ResultSet resultSet = null;
	    Collection<Ordine> ordini = new ArrayList<Ordine>();

	    String query = "SELECT * FROM " + TABLE_NAME;
        if (clienteId != null && !clienteId.isEmpty()) {
            query += " WHERE Cliente = ?";
        }
        
	    try {
	        connection = DriverManagerCP.getConnection();
	        preparedStatement = connection.prepareStatement(query);
	        
	        if (clienteId != null && !clienteId.isEmpty()) {
	        	preparedStatement.setString(1, clienteId);
	        }
	        
	        resultSet = preparedStatement.executeQuery();
	        
	        while (resultSet.next()) {
	    
	            // Recupera gli altri campi dell'ordine necessari
	            String nomeConsegna = resultSet.getString("Nome consegna");
	            String cognomeConsegna = resultSet.getString("Cognome consegna");
	            double prezzoTotale = resultSet.getDouble("Prezzo totale");
	     
	            String citta = resultSet.getString("Città");
	            String via = resultSet.getString("Via");
	            String cap = resultSet.getString("CAP");
	            
	            // Costruisci un oggetto Ordine
	            Ordine ordine = new Ordine();
	            ordine.setId(resultSet.getInt("ID"));
	            ordine.setNomeConsegna(nomeConsegna);
	            ordine.setCognomeConsegna(cognomeConsegna);
	            ordine.setPrezzoTotale(prezzoTotale);
	            
				Date data = resultSet.getDate("Data consegna");
				GregorianCalendar dataConsegna = new GregorianCalendar();
				dataConsegna.setTime(data);
				
	            ordine.setDataConsegna(dataConsegna);
	            
				data = resultSet.getDate("Data ordine");
				GregorianCalendar dataOrdine = new GregorianCalendar();
				dataOrdine.setTime(data);
				
	            ordine.setDataOrdine(dataOrdine);
	            
	            ordine.setCitta(citta);
	            ordine.setVia(via);
	            ordine.setCAP(cap);
	            
	            // Aggiungi l'ordine alla collezione
	            ordini.add(ordine);
	        }
	        
	    } finally {
	        try {
	            if (resultSet != null) {
	                resultSet.close();
	            }
	            if (preparedStatement != null) {
	                preparedStatement.close();
	            }
	        } finally {
	            DriverManagerCP.releaseConnection(connection);    
	        }
	    }
	    
	    return ordini;
	}
	
}
