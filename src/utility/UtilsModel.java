package utility;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public interface UtilsModel {
    
	public static boolean validateColumn(Connection connection, PreparedStatement preparedStatement, ResultSet rs, String selectSQL, String order) throws SQLException {
	    preparedStatement = connection.prepareStatement(selectSQL + " LIMIT 1");
	    preparedStatement.setString(1, ""); //
	    rs = preparedStatement.executeQuery();
	    ResultSetMetaData metaData = rs.getMetaData();
	    
	    // Verifica se l'ordine di ordinamento è un nome di colonna valido
	    for (int i = 1; i <= metaData.getColumnCount(); i++) {
	        if (order.equalsIgnoreCase(metaData.getColumnName(i))) {
	            return true;
	        }
	    }
	    
	    return false;
	}
}
