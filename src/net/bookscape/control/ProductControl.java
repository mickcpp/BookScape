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
		
		int productId = 0;
		if(request.getParameter("productId") != null) {
			productId = Integer.parseInt(request.getParameter("productId"));
		}
		
		String action = request.getParameter("action");
		
		try {
	
			if(action.equalsIgnoreCase("rimuovi")) {
				model.doDelete(productId);
				
			} else if(action.equalsIgnoreCase("viewEdit")) {
				
				Product prodotto = model.doRetrieveByKeyGeneral(productId);
				request.setAttribute("prodotto", prodotto);
				request.setAttribute("action", "edit");
				RequestDispatcher dispatcher = request.getRequestDispatcher("admin/editProduct.jsp");
				dispatcher.forward(request, response);
				return;
				
			} else if(action.equalsIgnoreCase("modifica")) {
				Product p = null;
				String type = request.getParameter("type");
				
				Libro l = new Libro();
				l.setId(productId);
				l.setNome(request.getParameter("nome"));
				l.setDescrizione(request.getParameter("descrizione"));
				l.setPrezzo(Double.parseDouble(request.getParameter("prezzo")));
				l.setQuantita(Integer.parseInt(request.getParameter("quantity")));
				if(request.getAttribute("fileName") != null && !request.getAttribute("fileName").equals("")) {
					l.setImgURL((String) request.getAttribute("fileName"));
				} else {
					String fullURL = request.getParameter("productImageURL");
					String fileName = fullURL.substring(fullURL.lastIndexOf("/") + 1);
					l.setImgURL(fileName); // Imposta solo il nome del file
				}
				
				if(type.equalsIgnoreCase("libro")) {
					l.setGenere(request.getParameter("genere"));
					l.setFormato(FormatoLibro.valueOf(request.getParameter("formato")));
					l.setAnno(Integer.parseInt(request.getParameter("anno")));
					l.setISBN(request.getParameter("ISBN"));
					l.setAutore(request.getParameter("autore"));
					l.setNumeroPagine(Integer.parseInt(request.getParameter("numeroPagine")));
					p = l;
					
					model.doUpdate(p);
					response.sendRedirect("admin/dashboard.jsp");
					return;
				}
				
				if(type.equalsIgnoreCase("musica")) {
					Musica m = new Musica();
					m.setGenere(request.getParameter("genere"));
					m.setFormato(FormatoMusica.valueOf(request.getParameter("formato")));
					m.setArtista(request.getParameter("artista"));
					m.setAnno(Integer.parseInt(request.getParameter("anno")));
					m.setNumeroTracce(Integer.parseInt(request.getParameter("numeroTracce")));
					p = m;
				}
				
				if(type.equalsIgnoreCase("gadget")) {
					Gadget g = new Gadget();
					g.setMateriale(request.getParameter("materiale"));
					g.setAltezza(Double.parseDouble(request.getParameter("altezza")));
					g.setLunghezza(Double.parseDouble(request.getParameter("lunghezza")));
					g.setLarghezza(Double.parseDouble(request.getParameter("larghezza")));
					p = g;
				}
				
				p.setId(l.getId());
				p.setNome(l.getNome());
				p.setDescrizione(l.getDescrizione());
				p.setPrezzo(l.getPrezzo());
				p.setQuantita(l.getQuantita());
				p.setImgURL(l.getImgURL());
				
				model.doUpdate(p);
				
			} else if(action.equalsIgnoreCase("viewInsert")){
				
				String type = request.getParameter("type");
				Product prodotto = null;
				
				if(type.equals("libro")) {
					Libro l = new Libro();
					prodotto = l;
				}
				
				if(type.equals("musica")) {
					Musica m = new Musica();
					prodotto = m;
				}
				
				if(type.equals("gadget")) {
					Gadget g = new Gadget();
					prodotto = g;
				}
				
				request.setAttribute("prodotto", prodotto);
				request.setAttribute("action", "insert");
				RequestDispatcher dispatcher = request.getRequestDispatcher("admin/editProduct.jsp");
				dispatcher.forward(request, response);
				return;
				
			} else if(action.equalsIgnoreCase("inserisci")) {
				String type = request.getParameter("type");
				
				Product prodotto = null;
				
				Libro l = new Libro();
				l.setId(productId);
				l.setNome(request.getParameter("nome"));
				l.setDescrizione(request.getParameter("descrizione"));
				l.setPrezzo(Double.parseDouble(request.getParameter("prezzo")));
				l.setQuantita(Integer.parseInt(request.getParameter("quantity")));
				l.setImgURL((String) request.getAttribute("fileName"));
				
				if(type.equalsIgnoreCase("libro")) {
					l.setGenere(request.getParameter("genere"));
					l.setFormato(FormatoLibro.valueOf(request.getParameter("formato")));
					l.setAnno(Integer.parseInt(request.getParameter("anno")));
					l.setISBN(request.getParameter("ISBN"));
					l.setAutore(request.getParameter("autore"));
					l.setNumeroPagine(Integer.parseInt(request.getParameter("numeroPagine")));
					prodotto = l;
					
					model.doSave(prodotto);
					response.sendRedirect("admin/dashboard.jsp");
					return;
				}
				
				if(type.equalsIgnoreCase("musica")) {
					Musica m = new Musica();
					m.setGenere(request.getParameter("genere"));
					m.setFormato(FormatoMusica.valueOf(request.getParameter("formato")));
					m.setArtista(request.getParameter("artista"));
					m.setAnno(Integer.parseInt(request.getParameter("anno")));
					m.setNumeroTracce(Integer.parseInt(request.getParameter("numeroTracce")));
					prodotto = m;
				}
				
				if(type.equalsIgnoreCase("gadget")) {
					Gadget g = new Gadget();
					g.setMateriale(request.getParameter("materiale"));
					g.setAltezza(Double.parseDouble(request.getParameter("altezza")));
					g.setLunghezza(Double.parseDouble(request.getParameter("lunghezza")));
					g.setLarghezza(Double.parseDouble(request.getParameter("larghezza")));
					prodotto = g;
				}
				
				prodotto.setId(l.getId());
				prodotto.setNome(l.getNome());
				prodotto.setDescrizione(l.getDescrizione());
				prodotto.setPrezzo(l.getPrezzo());
				prodotto.setQuantita(l.getQuantita());
				prodotto.setImgURL(l.getImgURL());
				
				model.doSave(prodotto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		response.sendRedirect("admin/dashboard.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
