package net.bookscape.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

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
		   TABLE_NAME = "musica";
	   }
	   
	   if(product instanceof Gadget) {
		   s = "Materiale, Lunghezza, Larghezza, Altezza VALUES (?,?,?,?,?,?,?,?,?)";
		   TABLE_NAME = "gadget";
	   }
	   
	   String insertP = "INSERT INTO " + TABLE_NAME + " "
					  + "(Nome, Descrizone, Prezzo, Quantità, " + s;

	   try {
		   connection = DriverManagerCP.getConnection();
		   preparedStatement = connection.prepareStatement(insertP);
		   
		   preparedStatement.setString(1, product.getNome());
		   preparedStatement.setString(2, product.getDescrizione());
		   preparedStatement.setDouble(3, product.getPrezzo());
		   preparedStatement.setInt(4, product.getQuantita());
		   
		   if(product instanceof Libro) {
			   Libro l = (Libro) product;
			   preparedStatement.setString(5, l.getGenere());
			   preparedStatement.setString(6, l.getFormato().name());
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
			   preparedStatement.setString(6, m.getFormato().name());
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
			TABLE_NAME = "libro";
		}
 
		if(product instanceof Musica) {
			TABLE_NAME = "musica";
		}
		
		if(product instanceof Gadget) {
			TABLE_NAME="gadget";
		}
		
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
	public Product doRetrieveByKey(int ID, TABLE tabella) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		Product product = null;
		
		TABLE_NAME = tabella.name();
		
		String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE ID = ?";
		
		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, ID);
	
			ResultSet rs = preparedStatement.executeQuery();
	
			while (rs.next()) {
				
				if(TABLE_NAME.equals(TABLE.libro.name())) {
					Libro l = new Libro();
					l.setId(rs.getInt("ID"));
					l.setNome(rs.getString("Nome"));
					l.setDescrizione(rs.getString("Descrizione"));
					l.setPrezzo(rs.getDouble("Prezzo"));
					l.setQuantita(rs.getInt("Quantità"));
					l.setGenere(rs.getString("Genere"));
					l.setFormato(FormatoLibro.valueOf(rs.getString("Formato")));
					l.setAnno(rs.getInt("Anno"));
					l.setISBN(rs.getString("ISBN"));
					l.setAutore(rs.getString("Autore"));
					l.setNumeroPagine(rs.getInt("`Numero pagine`"));
					
					product = l;
				}
				
				if(TABLE_NAME.equals(TABLE.gadget.name())) {
					Gadget g = new Gadget();
					g.setId(rs.getInt("ID"));
					g.setNome(rs.getString("Nome"));
					g.setDescrizione(rs.getString("Descrizione"));
					g.setPrezzo(rs.getDouble("Prezzo"));
					g.setQuantita(rs.getInt("Quantità"));
				    g.setMateriale(rs.getString("Materiale"));
					g.setLunghezza(rs.getDouble("Lunghezza"));
					g.setLarghezza(rs.getDouble("Larghezza"));
					g.setAltezza(rs.getDouble("Altezza"));
					
					product = g;
				}
				
				if(TABLE_NAME.equals(TABLE.musica.name())) {
					Musica m = new Musica();
					m.setId(rs.getInt("ID"));
					m.setNome(rs.getString("Nome"));
					m.setDescrizione(rs.getString("Descrizione"));
					m.setPrezzo(rs.getDouble("Prezzo"));
					m.setQuantita(rs.getInt("Quantità"));
				    m.setGenere(rs.getString("Genere"));
					m.setFormato(FormatoMusica.valueOf(rs.getString("Formato")));
					m.setAnno(rs.getInt("Anno"));
					m.setArtista(rs.getString("Artista"));
					m.setNumeroTracce(rs.getInt("`Numero tracce`"));
					
					product = m;
				} 
			}
			
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerCP.releaseConnection(connection);
			}
		}
		
		return product;
	}
	
	public Collection<Libro> doRetrieveAllLibro(String order) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<Libro> listaLibri = new LinkedList<Libro>();

		String selectSQL = "SELECT * FROM libro ";

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Libro libro = new Libro();
				libro.setId(rs.getInt("ID"));
				libro.setNome(rs.getString("Nome"));
				libro.setDescrizione(rs.getString("Descrizione"));
				libro.setPrezzo(rs.getDouble("Prezzo"));
				libro.setQuantita(rs.getInt("Quantità"));
				libro.setGenere(rs.getString("Genere"));
				libro.setFormato(FormatoLibro.valueOf(rs.getString("Formato")));
				libro.setAnno(rs.getInt("Anno"));
				libro.setISBN(rs.getString("ISBN"));
				libro.setAutore(rs.getString("Autore"));
				libro.setNumeroPagine(rs.getInt("`Numero pagine`"));
			}
			
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerCP.releaseConnection(connection);
			}
		}
		
		return listaLibri;
	}


	public Collection<Musica> doRetrieveAllMusica(String order) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<Musica> listaMusica = new LinkedList<Musica>();

		String selectSQL = "SELECT * FROM musica ";

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Musica musica = new Musica();
				musica.setId(rs.getInt("ID"));
				musica.setNome(rs.getString("Nome"));
				musica.setDescrizione(rs.getString("Descrizione"));
				musica.setPrezzo(rs.getDouble("Prezzo"));
				musica.setQuantita(rs.getInt("Quantità"));
				musica.setGenere(rs.getString("Genere"));
				musica.setFormato(FormatoMusica.valueOf(rs.getString("Formato")));
				musica.setAnno(rs.getInt("Anno"));
				musica.setNumeroTracce(rs.getInt("`Numero tracce`"));
				musica.setArtista(rs.getString("Artista"));
			}
			
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerCP.releaseConnection(connection);
			}
		}
		
		return listaMusica;
	}


	public Collection<Gadget> doRetrieveAllGadget(String order) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<Gadget> listaGadget = new LinkedList<Gadget>();

		String selectSQL = "SELECT * FROM gadget ";

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = DriverManagerCP.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Gadget gadget = new Gadget();
				gadget.setId(rs.getInt("ID"));
				gadget.setNome(rs.getString("Nome"));
				gadget.setDescrizione(rs.getString("Descrizione"));
				gadget.setPrezzo(rs.getDouble("Prezzo"));
				gadget.setQuantita(rs.getInt("Quantità"));
				gadget.setMateriale(rs.getString("Materiale"));
				gadget.setLunghezza(rs.getDouble("Formato"));
				gadget.setLarghezza(rs.getDouble("ISBN"));
				gadget.setAltezza(rs.getDouble("Autore"));
			}
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerCP.releaseConnection(connection);
			}
		}
		
		return listaGadget;
	}
	
	public Collection<Product> doRetrieveAll(String order) throws SQLException {
		Collection<Libro> listaLibri = doRetrieveAllLibro(order);
		Collection<Gadget> listaGadget = doRetrieveAllGadget(order);
		Collection<Musica> listaMusica = doRetrieveAllMusica(order);
		
		Collection<Product> prodotti = new LinkedList<>(listaLibri);
		prodotti.addAll(listaGadget);
		prodotti.addAll(listaMusica);
		
		return prodotti;
	}
}