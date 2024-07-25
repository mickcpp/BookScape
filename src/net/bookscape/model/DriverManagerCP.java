package net.bookscape.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

public class DriverManagerCP {
	
	private static List<Connection> freeDbConnections;

	static {
		freeDbConnections = new LinkedList<Connection>();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			System.out.println("DB driver not found:"+ e.getMessage());
		} 
	}
	
	private static synchronized Connection createDBConnection() throws SQLException {
	    Connection newConnection = null;
	    String ip = "localhost";
	    String port = "3306";
	    String db = "bookscape";
	    String username = "root";
	    String password = "password";
	    String truststorePath = "/opt/jdk-21.0.4/lib/security/cacerts";
	    String truststorePassword = "changeit";

	    // Imposta le proprietà di sistema per il truststore
	    System.setProperty("javax.net.ssl.trustStore", truststorePath);
	    System.setProperty("javax.net.ssl.trustStorePassword", truststorePassword);

	    newConnection = DriverManager.getConnection(
	        "jdbc:mysql://" + ip + ":" + port + "/" + db +
	        "?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Europe/Rome&useSSL=true&verifyServerCertificate=true&enabledTLSProtocols=TLSv1.2&requireSSL=true",
	        username, password
	    );

	    newConnection.setAutoCommit(true);

	    // Verifica se SSL è stato utilizzato
	    try (Statement stmt = newConnection.createStatement();
		        ResultSet rs = stmt.executeQuery("SHOW SESSION STATUS LIKE 'Ssl_cipher'")){
	        if (rs.next()) {
	            String sslCipher = rs.getString("Value");
	            if (sslCipher != null && !sslCipher.isEmpty()) {
	                System.out.println("SSL è attivo. Cifrario SSL utilizzato: " + sslCipher);
	            } else {
	                System.out.println("SSL non è attivo.");
	            }
	        }
	    } catch (SQLException e) {
	        System.err.println("Errore durante la verifica dell'SSL: " + e.getMessage());
	    }

	    return newConnection;
	}


	public static synchronized Connection getConnection() throws SQLException {
		Connection connection;

		if (!freeDbConnections.isEmpty()) {
			connection = (Connection) freeDbConnections.get(0);
			freeDbConnections.remove(0);

			try {
				if (connection.isClosed())
					connection = getConnection();
			} catch (SQLException e) {
				connection.close();
				connection = getConnection();
			}
			
		} else {
			connection = createDBConnection();		
		}

		return connection;
	}

	public static synchronized void releaseConnection(Connection connection) throws SQLException {
		if(connection != null) freeDbConnections.add(connection);
	}

}
