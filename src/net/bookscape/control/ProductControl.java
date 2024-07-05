package net.bookscape.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.bookscape.model.FormatoLibro;
import net.bookscape.model.FormatoMusica;
import net.bookscape.model.Gadget;
import net.bookscape.model.Libro;
import net.bookscape.model.Musica;
import net.bookscape.model.Product;
import net.bookscape.model.ProductModelDM;
import net.bookscape.model.TABLE;
import utility.ValidationUtilsProduct;

/**
 * Servlet implementation class ProductControl
 */
@WebServlet("/ProductControl")
public class ProductControl extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    public ProductControl() {
        super();
    }
    
	private static ProductModelDM model;
	
	static {
		model = new ProductModelDM();
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int productId = getProductId(request);
		String action = request.getParameter("action");
		
		try {
			switch (action.toLowerCase()) {
				case "rimuovi":
					removeProduct(request, response, productId);
					response.sendRedirect("admin/dashboard.jsp");
					break;
				case "viewedit":
					viewEditProduct(request, response, productId);
					return;
				case "modifica":
					modifyProduct(request, response, productId);
					break;
				case "viewinsert":
					viewInsertProduct(request, response);
					return;
				case "inserisci":
					insertProduct(request, response, productId);
					break;
				default:
					response.sendRedirect("admin/dashboard.jsp");
					break;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	private int getProductId(HttpServletRequest request) {
		if(request.getParameter("productId") != null) {
			return Integer.parseInt(request.getParameter("productId"));
		}
		return 0;
	}
	
	private void removeProduct(HttpServletRequest request, HttpServletResponse response, int productId) throws Exception {
		if(model.doDelete(productId)) {
			forward(request, response, "UserControl", "Prodotto eliminato correttamente!", false);
			return;
		} else {
			forward(request, response, "UserControl", "Errore nell'eliminazione del prodotto!", true);
			return;
		}
	}
	
	private void viewEditProduct(HttpServletRequest request, HttpServletResponse response, int productId) throws Exception {
		Product prodotto = model.doRetrieveByKeyGeneral(productId);
		request.setAttribute("prodotto", prodotto);
		request.setAttribute("action", "edit");
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/editProduct.jsp");
		dispatcher.forward(request, response);
		return;
	}
	
	private void modifyProduct(HttpServletRequest request, HttpServletResponse response, int productId) throws Exception {
		Product p = null;
		String type = request.getParameter("type");
		
		if(!validateGeneral(request, response)) return;
		
		Libro l = getLibro(request, productId);
		
		switch (type.toLowerCase()) {
			case "libro":
				setLibroSpecificAttributes(request, l);
				p = l;
				break;
			case "musica":
				Musica m = getMusica(request, l);
				p = m;
				break;
			case "gadget":
				Gadget g = getGadget(request, l);
				p = g;
				break;
		}
		
		try {
			if(model.doUpdate(p)) {
				forward(request, response, "UserControl", "Prodotto modificato correttamente", false);
				return;
			}
		} catch(Exception e) {
			forward(request, response, "ProductControl?productId=" + productId + "&action=viewEdit&type=" + request.getParameter("type"), "Errore nella modifica del prodotto!", true);
			return;
		}
	}
	
	private void viewInsertProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String type = request.getParameter("type");
		Product prodotto = null;
		
		switch (type.toLowerCase()) {
			case "libro":
				prodotto = new Libro();
				break;
			case "musica":
				prodotto = new Musica();
				break;
			case "gadget":
				prodotto = new Gadget();
				break;
		}
		
		request.setAttribute("prodotto", prodotto);
		request.setAttribute("action", "insert");
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/editProduct.jsp");
		dispatcher.forward(request, response);
		return;
	}
	
	private void insertProduct(HttpServletRequest request, HttpServletResponse response, int productId) throws Exception{
		String type = request.getParameter("type");
		Product prodotto = null;
	
		if(!validateGeneral(request, response)) return;
		
		Libro l = getLibro(request, productId);
		
		switch (type.toLowerCase()) {
			case "libro":
				setLibroSpecificAttributes(request, l);
				prodotto = l;
				break;
			case "musica":
				Musica m = getMusica(request, l);
				prodotto = m;
				break;
			case "gadget":
				Gadget g = getGadget(request, l);
				prodotto = g;
				break;
		}
		
		try {
			if(model.doSave(prodotto)) {
				forward(request, response, "UserControl", "Prodotto salvato correttamente", false);
				return;
			}
		} catch(Exception e) {
			forward(request, response, "ProductControl?productId=" + productId + "&action=viewInsert&type=" + request.getParameter("type"), "Errore nel caricamento del prodotto!", true);
			return;
		}
	}
	
	private Libro getLibro(HttpServletRequest request, int productId) {
		Libro l = new Libro();
		l.setId(productId);
		l.setNome(request.getParameter("nome"));
		l.setDescrizione(request.getParameter("descrizione"));
		l.setPrezzo(Double.parseDouble(request.getParameter("prezzo")));
		l.setQuantita(Integer.parseInt(request.getParameter("quantity")));
		l.setImgURL(getImgURL(request));
		return l;
	}
	
	private String getImgURL(HttpServletRequest request) {
		if (request.getAttribute("fileName") != null && !request.getAttribute("fileName").equals("")) {
			return (String) request.getAttribute("fileName");
		} else {
			String fullURL = request.getParameter("productImageURL");
			return fullURL.substring(fullURL.lastIndexOf("/") + 1);
		}
	}
	
	private void setLibroSpecificAttributes(HttpServletRequest request, Libro l) {
		l.setGenere(request.getParameter("genere"));
		l.setFormato(FormatoLibro.valueOf(request.getParameter("formato")));
		l.setAnno(Integer.parseInt(request.getParameter("anno")));
		l.setISBN(request.getParameter("ISBN"));
		l.setAutore(request.getParameter("autore"));
		l.setNumeroPagine(Integer.parseInt(request.getParameter("numeroPagine")));
	}
	
	private Musica getMusica(HttpServletRequest request, Libro l) {
		Musica m = new Musica();
		m.setId(l.getId());
		m.setNome(l.getNome());
		m.setDescrizione(l.getDescrizione());
		m.setPrezzo(l.getPrezzo());
		m.setQuantita(l.getQuantita());
		m.setImgURL(l.getImgURL());
		m.setGenere(request.getParameter("genere"));
		m.setFormato(FormatoMusica.valueOf(request.getParameter("formato")));
		m.setArtista(request.getParameter("artista"));
		m.setAnno(Integer.parseInt(request.getParameter("anno")));
		m.setNumeroTracce(Integer.parseInt(request.getParameter("numeroTracce")));
		return m;
	}
	
	private Gadget getGadget(HttpServletRequest request, Libro l) {
		Gadget g = new Gadget();
		g.setId(l.getId());
		g.setNome(l.getNome());
		g.setDescrizione(l.getDescrizione());
		g.setPrezzo(l.getPrezzo());
		g.setQuantita(l.getQuantita());
		g.setImgURL(l.getImgURL());
		g.setMateriale(request.getParameter("materiale"));
		g.setAltezza(Double.parseDouble(request.getParameter("altezza")));
		g.setLunghezza(Double.parseDouble(request.getParameter("lunghezza")));
		g.setLarghezza(Double.parseDouble(request.getParameter("larghezza")));
		return g;
	}
	
	private boolean validateGeneral(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String type = request.getParameter("type");
		String action = request.getParameter("action");
		int productId = getProductId(request);
		
		String error;
		
		switch (type.toLowerCase()) {
		case "libro":
			error = ValidationUtilsProduct.validateLibro(request.getParameter("nome"), request.getParameter("descrizione"),
					request.getParameter("prezzo"), request.getParameter("quantity"), request.getParameter("genere"),
					request.getParameter("formato"), request.getParameter("anno"), request.getParameter("ISBN"),
					request.getParameter("autore"), request.getParameter("numeroPagine"));
	        if (error != null) {
	        	if(action.equalsIgnoreCase("inserisci")) {
	        		Libro l = new Libro();
	        		request.setAttribute("prodotto", l);
	        		request.setAttribute("action", "insert");
	        	} else {
	        		Libro l = (Libro) model.doRetrieveByKey(productId, TABLE.libro);
	        		request.setAttribute("prodotto", l);
	        		request.setAttribute("action", "edit");
	        	}
	            request.setAttribute("errorMessage", error);
	            request.getRequestDispatcher("admin/editProduct.jsp").forward(request, response);
	            return false;
	        }
			break;
		case "musica":
			error = ValidationUtilsProduct.validateMusica(request.getParameter("nome"), request.getParameter("descrizione"),
					request.getParameter("prezzo"), request.getParameter("quantity"), request.getParameter("genere"),
					request.getParameter("formato"), request.getParameter("anno"), request.getParameter("artista"),
					request.getParameter("numeroTracce"));
	        if (error != null) {
	        	if(action.equalsIgnoreCase("inserisci")) {
	        		Musica m = new Musica();
	        		request.setAttribute("prodotto", m);
	        		request.setAttribute("action", "insert");
	        	} else {
	        		Musica m = (Musica) model.doRetrieveByKey(productId, TABLE.musica);
	        		request.setAttribute("prodotto", m);
	        		request.setAttribute("action", "edit");
	        	}
	            request.setAttribute("errorMessage", error);
	            request.getRequestDispatcher("admin/editProduct.jsp").forward(request, response);
	            return false;
	        }
			break;
		case "gadget":
			error = ValidationUtilsProduct.validateGadget(request.getParameter("nome"), request.getParameter("descrizione"),
					request.getParameter("prezzo"), request.getParameter("quantity"), request.getParameter("materiale"),
					request.getParameter("altezza"), request.getParameter("lunghezza"), request.getParameter("larghezza"));
	        if (error != null) {
	        	if(action.equalsIgnoreCase("inserisci")) {
	        		Gadget g = new Gadget();
	        		request.setAttribute("prodotto", g);
	        		request.setAttribute("action", "insert");
	        	} else {
	        		Gadget g = (Gadget) model.doRetrieveByKey(productId, TABLE.gadget);
	        		request.setAttribute("prodotto", g);
	        		request.setAttribute("action", "edit");
	        	}
	            request.setAttribute("errorMessage", error);
	            request.getRequestDispatcher("admin/editProduct.jsp").forward(request, response);
	            return false;
	        }
			break;
		}
		return true;
	}
	
	public void forward(HttpServletRequest request, HttpServletResponse response, String redirect, String message, boolean negative) throws ServletException, IOException {
		if(negative) request.setAttribute("feedback-negative", message);
		else request.setAttribute("feedback", message);
		RequestDispatcher dispatcher = request.getRequestDispatcher(redirect);
		dispatcher.forward(request, response);
	}
}
