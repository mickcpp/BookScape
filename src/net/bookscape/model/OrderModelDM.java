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
	        
	        preparedStatement.close();
	        
	        String s = "INSERT INTO datiFatturazione (Ordine, Nome, Cognome, Città, Via, CAP, `Nome carta`, `Numero carta`, `Data scadenza`, CVV) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?)";
	        preparedStatement = connection.prepareStatement(s);
	        
	        Cliente cliente = new ClienteModelDM().doRetrieveByKey(order.getCliente());
	        
	        preparedStatement.setInt(1, orderId);
	        preparedStatement.setString(2, cliente.getNome());
	        preparedStatement.setString(3, cliente.getCognome());
	        preparedStatement.setString(4, cliente.getCitta());
	        preparedStatement.setString(5, cliente.getVia());
	        preparedStatement.setString(6, cliente.getCAP());
	        preparedStatement.setString(7, cliente.getCarta().getNomeCarta());
	        preparedStatement.setString(8, cliente.getCarta().getNumeroCarta());
	        preparedStatement.setTimestamp(9, new Timestamp(cliente.getCarta().getDataScadenza().getTimeInMillis()));
	        preparedStatement.setInt(10, cliente.getCarta().getCvv());
	        
	        preparedStatement.executeUpdate();
	        
	        for (CartItem item : order.getProdotti()) {
	            if (item.getProduct() instanceof Libro) {
	                s = "INSERT INTO `acquisto libro` (Libro, Ordine, Quantità, `Prezzo acquisto`, `Prezzo totale`) "
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
	                s = "INSERT INTO `acquisto gadget` (Gadget, Ordine, Quantità, `Prezzo acquisto`, `Prezzo totale`) "
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
	                s = "INSERT INTO `acquisto musica` (Musica, Ordine, Quantità, `Prezzo acquisto`, `Prezzo totale`) "
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
	public Collection<Ordine> doRetrieveAll(String clienteId, boolean completo) throws SQLException {
		
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
	            ordine.setCliente(resultSet.getString("Cliente"));
	            
	            if(completo) {
	            	Collection<CartItem> items = doRetrieveProductsByOrder(ordine.getId());
		            ordine.setProdotti(items);
	            }
	            
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

	public Collection<CartItem> doRetrieveProductsByOrder(int orderId) throws SQLException {
		
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    ResultSet resultSet = null;
	    Collection<CartItem> prodotti = new ArrayList<CartItem>();

	    String queryLibri = "SELECT Ordine, Quantità, `Prezzo acquisto`, libro "
	            + "FROM `Acquisto libro` WHERE Ordine = ?";
	    String queryGadget = "SELECT Ordine, Quantità, `Prezzo acquisto`, gadget "
	            + "FROM `Acquisto gadget` WHERE Ordine = ?";
	    String queryMusica = "SELECT Ordine, Quantità, `Prezzo acquisto`, musica "
	            + "FROM `Acquisto musica` WHERE Ordine = ?";

	    ProductModelDM productModel = new ProductModelDM();
	    
	    try {
	        connection = DriverManagerCP.getConnection();
	        
	        // Process books
	        preparedStatement = connection.prepareStatement(queryLibri);
	        preparedStatement.setInt(1, orderId);
	        resultSet = preparedStatement.executeQuery();
	        while (resultSet.next()) {
	        	Libro libro = new Libro();
	        	libro = (Libro) productModel.doRetrieveByKey(resultSet.getInt("libro"), TABLE.libro);
	        	
	        	CartItem item = new CartItem();
	        	item.setProduct(libro);
	        	item.setNumElementi(resultSet.getInt("Quantità"));
	        	item.getProduct().setPrezzo(resultSet.getDouble("Prezzo acquisto"));
	    
	            prodotti.add(item);
	        }
	        resultSet.close();
	        preparedStatement.close();

	        // Process gadgets
	        preparedStatement = connection.prepareStatement(queryGadget);
	        preparedStatement.setInt(1, orderId);
	        resultSet = preparedStatement.executeQuery();
	        while (resultSet.next()) {
	        	Gadget gadget = new Gadget();
	        	gadget = (Gadget) productModel.doRetrieveByKey(resultSet.getInt("gadget"), TABLE.gadget);
	        	
	        	CartItem item = new CartItem();
	        	item.setProduct(gadget);
	        	item.setNumElementi(resultSet.getInt("Quantità"));
	        	item.getProduct().setPrezzo(resultSet.getDouble("Prezzo acquisto"));
	    
	            prodotti.add(item);
	        }
	        resultSet.close();
	        preparedStatement.close();

	        // Process music
	        preparedStatement = connection.prepareStatement(queryMusica);
	        preparedStatement.setInt(1, orderId);
	        resultSet = preparedStatement.executeQuery();
	        while (resultSet.next()) {
	           	Musica musica = new Musica();
	           	musica = (Musica) productModel.doRetrieveByKey(resultSet.getInt("musica"), TABLE.musica);
	        	
	        	CartItem item = new CartItem();
	        	item.setProduct(musica);
	        	item.setNumElementi(resultSet.getInt("Quantità"));
	        	item.getProduct().setPrezzo(resultSet.getDouble("Prezzo acquisto"));
	    
	            prodotti.add(item);
	        }
	        resultSet.close();
	        preparedStatement.close();

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

	    return prodotti;
	}

}
