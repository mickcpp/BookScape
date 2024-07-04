package net.bookscape.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.Calendar;
import java.util.LinkedList;

public class RecensioneModelDM implements RecensioneModel<Recensione>{
	
	public synchronized void doSave(Recensione recensione, TABLE table) throws SQLException {
		   
		   Connection connection = null;
		   PreparedStatement preparedStatement = null;
		   String tabella = "recensione" + table.name();
		   
		   String insertR = "INSERT INTO " + tabella + " "
						  + "(Cliente, " + table.name() + ", Descrizione, Valutazione) VALUES (?,?,?,?)";

		   try {
			   connection = DriverManagerCP.getConnection();
			   preparedStatement = connection.prepareStatement(insertR);
			   
			   preparedStatement.setString(1, recensione.getCliente());
			   preparedStatement.setInt(2, recensione.getProdotto());
			   preparedStatement.setString(3, recensione.getRecensione());
			   preparedStatement.setInt(4, recensione.getValutazione());
			   
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
	public boolean doDelete(String cliente, int prodotto, TABLE table) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		String tabella = "recensione" + table.name();
		int result = 0;	
		
		String deleteSQL = "DELETE FROM " + tabella + " WHERE Cliente = ?  AND " + table.name()+ " = ?";
		  
		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setString(1, cliente);
			preparedStatement.setInt(2, prodotto);

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
	public Collection<Recensione> doRetrieveAll(int prodotto, TABLE table) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;
		String tabella = "recensione" + table.name();
		
		Collection<Recensione> listaRecensioni = new LinkedList<Recensione>();
	
		String selectSQL = "SELECT * FROM " + tabella +  " WHERE " + table.name()+ "= ?";
	
		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, prodotto);
			
			rs = preparedStatement.executeQuery();
	
			while (rs.next()) {
				Recensione r = new Recensione();
				r.setCliente(rs.getString("Cliente"));
				r.setProdotto(rs.getInt(table.name()));
				r.setRecensione(rs.getString("Descrizione"));
				r.setValutazione(rs.getInt("Valutazione"));
				
                Timestamp timestamp = rs.getTimestamp("Data");
                
                if (timestamp != null) {
                	Calendar calendar = Calendar.getInstance();
                    calendar.setTimeInMillis(timestamp.getTime());
                    r.setData(calendar);
                } else {
                    r.setData(null);
                }
                
				listaRecensioni.add(r);
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
		
		return listaRecensioni;
	}

	@Override
	public void doUpdate(Recensione product, TABLE table) throws SQLException {
		
	}
}