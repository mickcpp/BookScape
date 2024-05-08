package net.bookscape.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.GregorianCalendar;
import java.util.LinkedList;

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
			preparedStatement.setString(3, cliente.getPassword());
			preparedStatement.setString(4, cliente.getNome());
			preparedStatement.setString(5, cliente.getCognome());
			preparedStatement.setTimestamp(6, new Timestamp(cliente.getDataNascita().getTimeInMillis()));
			preparedStatement.setString(7, cliente.getCitta());
		   	preparedStatement.setString(8, cliente.getVia());
		   	preparedStatement.setString(9, cliente.getCAP());
		   	preparedStatement.setString(10, cliente.getCarta().getNomeCarta());
		   	preparedStatement.setString(11, cliente.getCarta().getNumeroCarta());
		   	preparedStatement.setTimestamp(12, new Timestamp(cliente.getCarta().getDataScadenza().getTimeInMillis()));
		   	preparedStatement.setInt(13, cliente.getCarta().getCvv());
		   
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
	
		
		String deleteSQL = "DELETE FROM " + TABLE_NAME + " WHERE ID = ?";
		  
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
	public Cliente doRetrieveByKey(int id) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		Cliente cliente = null;
		
		String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE ID = ?";
		
		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, id);
	
			ResultSet rs = preparedStatement.executeQuery();
			
			while (rs.next()) {
				cliente = new Cliente();
				CartaPagamento carta = new CartaPagamento();
					
				//Setto i dati di cliente
				cliente.setEmail(rs.getString("Email"));
				cliente.setUsername(rs.getString("Username"));
				cliente.setPassword(rs.getString("Password"));
				cliente.setNome(rs.getString("Nome"));
				cliente.setCognome(rs.getString("Cognome"));
					
				Timestamp timestamp = rs.getTimestamp("Data scadenza");
				GregorianCalendar dataNascita = new GregorianCalendar();
				dataNascita.setTimeInMillis(timestamp.getTime());
				cliente.setDataNascita(dataNascita);
					
				cliente.setCitta(rs.getString("Città"));
				cliente.setVia(rs.getString("Via"));
				cliente.setCAP(rs.getString("CAP"));
					
				//setto i dati dell'oggetto di tipo CartaPagamento
				carta.setNomeCarta(rs.getString("Nome carta"));
				carta.setNumeroCarta(rs.getString("Numero carta"));
					
			    timestamp = rs.getTimestamp("Data Scadenza");
				GregorianCalendar scadenza = new GregorianCalendar();
				scadenza.setTimeInMillis(timestamp.getTime());
				carta.setDataScadenza(scadenza);
				
				carta.setCvv(rs.getInt("CVV"));
				
				//setto la carta di cliente
                cliente.setCarta(carta);    
			}
			
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerCP.releaseConnection(connection);
			}
		}
		
		return cliente;
	}

	@Override
	public Collection<Cliente> doRetrieveAll(String order) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		Collection<Cliente> clienti = new LinkedList<Cliente>();
		
		String selectSQL = "SELECT * FROM cliente ";

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}
			
		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Cliente cliente = new Cliente();
				CartaPagamento carta = new CartaPagamento();
					
				//Setto i dati di cliente
				cliente.setEmail(rs.getString("Email"));
				cliente.setUsername(rs.getString("Username"));
				cliente.setPassword(rs.getString("Password"));
				cliente.setNome(rs.getString("Nome"));
				cliente.setCognome(rs.getString("Cognome"));
					
				Timestamp timestamp = rs.getTimestamp("Data scadenza");
				GregorianCalendar dataNascita = new GregorianCalendar();
				dataNascita.setTimeInMillis(timestamp.getTime());
				cliente.setDataNascita(dataNascita);
					
				cliente.setCitta(rs.getString("Città"));
				cliente.setVia(rs.getString("Via"));
				cliente.setCAP(rs.getString("CAP"));
					
				//setto i dati dell'oggetto di tipo CartaPagamento
				carta.setNomeCarta(rs.getString("Nome carta"));
				carta.setNumeroCarta(rs.getString("Numero carta"));
					
			    timestamp = rs.getTimestamp("Data Scadenza");
				GregorianCalendar scadenza = new GregorianCalendar();
				scadenza.setTimeInMillis(timestamp.getTime());
				carta.setDataScadenza(scadenza);
				
				carta.setCvv(rs.getInt("CVV"));
				
				//setto la carta di cliente
                cliente.setCarta(carta); 
                
                //aggiungo il cliente alla lista clienti
                clienti.add(cliente);
			}
			
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerCP.releaseConnection(connection);
			}
		}
		
		return clienti;
	}
	
}
	