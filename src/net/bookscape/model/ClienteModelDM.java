package net.bookscape.model;

import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.LinkedList;
import utility.UtilsModel;

public class ClienteModelDM implements ClienteModel<Cliente>{

	private static String TABLE_NAME = "cliente";

	@Override
	public void doSave(Cliente cliente) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		   
		String insertP = "INSERT INTO " + TABLE_NAME + " "
					  + "(Email, Username, Password, Nome, Cognome, `Data Nascita`, Città,"
					  + " Via, CAP, `Nome carta`, `Numero carta`, `Data scadenza`, CVV)"
					  + " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(insertP);
		  
			preparedStatement.setString(1, cliente.getEmail());
			preparedStatement.setString(2, cliente.getUsername());
			preparedStatement.setString(3, toHash(cliente.getPassword()));
			preparedStatement.setString(4, cliente.getNome());
			preparedStatement.setString(5, cliente.getCognome());
			preparedStatement.setTimestamp(6, new Timestamp(cliente.getDataNascita().getTimeInMillis()));
			preparedStatement.setString(7, cliente.getCitta());
		   	preparedStatement.setString(8, cliente.getVia());
		   	preparedStatement.setString(9, cliente.getCAP());
		   	
		   	if(cliente.getCarta() != null) {
			   	preparedStatement.setString(10, cliente.getCarta().getNomeCarta());
			   	preparedStatement.setString(11, cliente.getCarta().getNumeroCarta());
			   	preparedStatement.setTimestamp(12, new Timestamp(cliente.getCarta().getDataScadenza().getTimeInMillis()));
			   	preparedStatement.setInt(13, cliente.getCarta().getCvv());
		   	}else {
		   		preparedStatement.setString(10, null);
			   	preparedStatement.setString(11, null);
			   	preparedStatement.setTimestamp(12, null);
			   	preparedStatement.setNull(13, java.sql.Types.INTEGER);
		   	}
		   	
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
	public boolean doDelete(String email) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		int result = 0;
	
		
		String deleteSQL = "DELETE FROM " + TABLE_NAME + " WHERE Email = ?";
		  
		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setString(1, email);

			result = preparedStatement.executeUpdate();
			connection.commit();
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
	public Cliente doRetrieveByKey(String id) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;
		String selectSQL = null;
		Cliente cliente = null;
		
		if(id.contains("@")) {
			selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE Email = ?";
		}else {
			selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE Username = ?";
		}
	
		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, id);
	
			rs = preparedStatement.executeQuery();
			
			while (rs.next()) {
				cliente = new Cliente();
				CartaPagamento carta = new CartaPagamento();
					
				//Setto i dati di cliente
				cliente.setEmail(rs.getString("Email"));
				cliente.setUsername(rs.getString("Username"));
				cliente.setPassword(rs.getString("Password"));
				cliente.setNome(rs.getString("Nome"));
				cliente.setCognome(rs.getString("Cognome"));
					
				Date data = rs.getDate("Data nascita");
				GregorianCalendar dataNascita = new GregorianCalendar();
				dataNascita.setTime(data);
				
				cliente.setDataNascita(dataNascita);
					
				cliente.setCitta(rs.getString("Città"));
				cliente.setVia(rs.getString("Via"));
				cliente.setCAP(rs.getString("CAP"));
					
				//setto i dati dell'oggetto di tipo CartaPagamento
				carta.setNomeCarta(rs.getString("Nome carta"));
				carta.setNumeroCarta(rs.getString("Numero carta"));
			
				GregorianCalendar dataScadenza;
				data = rs.getDate("Data scadenza");
				if(data != null) {
					dataScadenza = new GregorianCalendar();
					dataScadenza.setTime(data);
				}else {
					dataScadenza = null;
				}
				
				carta.setDataScadenza(dataScadenza);
				
				carta.setCvv(rs.getInt("CVV"));

				//setto la carta di cliente
                cliente.setCarta(carta);    
			}
			
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
				if (rs != null)
	    			rs.close();
			} finally {
				DriverManagerCP.releaseConnection(connection);
			}
		}
		
		return cliente;
	}

	@Override
	public synchronized Collection<Cliente> doRetrieveAll(String order) throws SQLException {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    ResultSet rs = null;

	    Collection<Cliente> clienti = new LinkedList<>();
	    String selectSQL = "SELECT * FROM cliente";

	    try {
	        connection = DriverManagerCP.getConnection();

			if (order != null && !order.equals("")) {
		        if (UtilsModel.validateColumn(connection, preparedStatement, rs, selectSQL, order))
		            selectSQL += " ORDER BY " + order;
		        else
		            throw new SQLException("Colonna di ordinamento non valida: " + order);
			}

	        preparedStatement = connection.prepareStatement(selectSQL);
	        rs = preparedStatement.executeQuery();

	        while (rs.next()) {
	            Cliente cliente = new Cliente();
	            CartaPagamento carta = new CartaPagamento();

	            // Setto i dati di cliente
	            cliente.setEmail(rs.getString("Email"));
	            cliente.setUsername(rs.getString("Username"));
	            cliente.setPassword(rs.getString("Password"));
	            cliente.setNome(rs.getString("Nome"));
	            cliente.setCognome(rs.getString("Cognome"));

	            Date data = rs.getDate("Data nascita");
	            GregorianCalendar dataNascita = new GregorianCalendar();
	            dataNascita.setTime(data);

	            cliente.setDataNascita(dataNascita);

	            cliente.setCitta(rs.getString("Città"));
	            cliente.setVia(rs.getString("Via"));
	            cliente.setCAP(rs.getString("CAP"));

	            // Setto i dati dell'oggetto di tipo CartaPagamento
	            carta.setNomeCarta(rs.getString("Nome carta"));
	            carta.setNumeroCarta(rs.getString("Numero carta"));

	            GregorianCalendar dataScadenza;
	            data = rs.getDate("Data scadenza");
	            if (data != null) {
	                dataScadenza = new GregorianCalendar();
	                dataScadenza.setTime(data);
	            } else {
	                dataScadenza = null;
	            }

	            carta.setDataScadenza(dataScadenza);
	            carta.setCvv(rs.getInt("CVV"));

	            // Setto la carta di cliente
	            cliente.setCarta(carta);

	            // Aggiungo il cliente alla lista clienti
	            clienti.add(cliente);
	        }
	    } finally {
	    	try {
	    		if (preparedStatement != null)  
	    			preparedStatement.close();
	    		if (rs != null)
	    			rs.close();
	    	} finally {
	            DriverManagerCP.releaseConnection(connection);
	    	}
	    }

	    return clienti;
	}


	@Override
	public boolean isAdmin(String id) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;
		String selectSQL = null;
		
		selectSQL = "SELECT COUNT(*) FROM amministratore WHERE Email = ?";
		
		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, id);

			rs = preparedStatement.executeQuery();
			
			if(rs.next()) {
				int count = rs.getInt(1); // Ottieni il valore della prima colonna
				return count > 0; // Se count è maggiore di 0, ritorna true, altrimenti false
			} else {
				return false;
			}
			
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
				if (rs != null)
	    			rs.close();
			} finally {
				DriverManagerCP.releaseConnection(connection);
			}
		}
	}
	
	public boolean changeRole(String id, String role) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		String selectSQL = null;
		int result = 0;
	
		if(role.equals("admin")) {
			selectSQL = "INSERT INTO amministratore (Email) VALUES (?)";
		} else if(role.equals("cliente")){
			selectSQL = "DELETE FROM amministratore WHERE Email = ?";
		}
		
		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, id);

			result = preparedStatement.executeUpdate();
				
			return result != 0 ? true : false;
			
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerCP.releaseConnection(connection);
			}
		}
	}

	public Collection<String> doRetrieveAllAdmin() throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;
		
		Collection<String> listaAdmin = new LinkedList<String>();
		
		String selectSQL = "SELECT * FROM amministratore ";
			
		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			rs = preparedStatement.executeQuery();

			while (rs.next()) {
				String adminEmail = rs.getString("Email");
                listaAdmin.add(adminEmail);
			}
			
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
				if (rs != null)
	    			rs.close();
			} finally {
				DriverManagerCP.releaseConnection(connection);
			}
		}
		
		return listaAdmin;
	}
	
	@Override
	public void doUpdate(Cliente cliente) throws SQLException {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    
	    String updateSQL = "UPDATE " + TABLE_NAME + " SET "
	                     + "Username = ?, Password = ?, Nome = ?, Cognome = ?, `Data Nascita` = ?, "
	                     + "Città = ?, Via = ?, CAP = ?, `Nome carta` = ?, `Numero carta` = ?, `Data scadenza` = ?, CVV = ? "
	                     + "WHERE Email = ?";
	    
	    try {
	        connection = DriverManagerCP.getConnection();
	        preparedStatement = connection.prepareStatement(updateSQL);
	        
	        preparedStatement.setString(1, cliente.getUsername());
	        preparedStatement.setString(2, cliente.getPassword());
	        preparedStatement.setString(3, cliente.getNome());
	        preparedStatement.setString(4, cliente.getCognome());
	        preparedStatement.setTimestamp(5, new Timestamp(cliente.getDataNascita().getTimeInMillis()));
	        preparedStatement.setString(6, cliente.getCitta());
	        preparedStatement.setString(7, cliente.getVia());
	        preparedStatement.setString(8, cliente.getCAP());
	        
	        if(cliente.getCarta() != null && cliente.getCarta().getNomeCarta() != null && cliente.getCarta().getNumeroCarta() != null && cliente.getCarta().getDataScadenza() != null && cliente.getCarta().getCvv() != null) {
	            preparedStatement.setString(9, cliente.getCarta().getNomeCarta());
	            preparedStatement.setString(10, cliente.getCarta().getNumeroCarta());
	            preparedStatement.setTimestamp(11, new Timestamp(cliente.getCarta().getDataScadenza().getTimeInMillis()));
	            preparedStatement.setInt(12, cliente.getCarta().getCvv());
	        } else {
	            preparedStatement.setString(9, null);
	            preparedStatement.setString(10, null);
	            preparedStatement.setTimestamp(11, null);
	            preparedStatement.setNull(12, java.sql.Types.INTEGER);
	        }
	        
	        preparedStatement.setString(13, cliente.getEmail());
	        
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

	public String toHash(String pass){
		
		String hashString = null;
		try{
			java.security.MessageDigest digest = java.security.MessageDigest.getInstance("SHA-512");
		    byte[] hash = digest.digest(pass.getBytes(StandardCharsets.UTF_8));
		    hashString = "";
		    for(int i=0; i<hash.length ; i++){
		        hashString += Integer.toHexString(
		                (hash[i] & 0xFF) | 0x100)
		                .toLowerCase().substring(1,3);
		    }
		} catch (java.security.NoSuchAlgorithmException e){
		    System.out.println(e);
		}

		return hashString;
	}
		
}
	