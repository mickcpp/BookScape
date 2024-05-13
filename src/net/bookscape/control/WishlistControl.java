package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.bookscape.model.ProductModelDM;
import net.bookscape.model.TABLE;
import net.bookscape.model.WishlistModelDM;
import net.bookscape.model.Wishlist;
import net.bookscape.model.CartItem;
import net.bookscape.model.CartModelDM;
import net.bookscape.model.Cliente;
import net.bookscape.model.ClienteModelDM;
import net.bookscape.model.Product;

/**
 * Servlet implementation class ProductDetails
 */
@WebServlet("/WishlistControl")
public class WishlistControl extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private static ProductModelDM productModel;
	private static WishlistModelDM wishlistModel;
	private static ClienteModelDM clienteModel;
	
	static {
		productModel = new ProductModelDM();
		wishlistModel =  new WishlistModelDM();
		clienteModel = new ClienteModelDM();
	}
	
    public WishlistControl() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        String userId = (String) request.getSession().getAttribute("cliente");
        Wishlist wishlist = (Wishlist)request.getSession().getAttribute("wishlist");
        Cliente cliente = null;
        
        if(userId != null && !userId.equals("")) {
        	try {
				cliente = clienteModel.doRetrieveByKey(userId);
				if(wishlist == null) {
	        		wishlist = new Wishlist();
	        		wishlist.setItems(wishlistModel.doRetrieveAll(null, cliente.getEmail()));
	        		request.getSession().setAttribute("wishlist", wishlist);
	        	}
			} catch (SQLException e) {
				e.printStackTrace();
			}
        }else {
        	response.sendRedirect("Login");
        	return;
        }    
		
		String action = request.getParameter("action");
		String tableName = request.getParameter("type");
		
		try {
			if (action != null) {
				if (action.equalsIgnoreCase("aggiungi")) {
					int id = Integer.parseInt(request.getParameter("productId"));
					Product product = productModel.doRetrieveByKey(id, TABLE.valueOf(tableName));
					if(wishlist.isInWishlist(product)) {
						System.out.println("Prodotto già presente nella wishlist!");
					} else {
						wishlist.addItem(product);
						wishlistModel.doSave(product, cliente.getEmail());
					}
				} else if (action.equalsIgnoreCase("Rimuovi")) {
					int id = Integer.parseInt(request.getParameter("productId"));
					Product product = productModel.doRetrieveByKey(id, TABLE.valueOf(tableName));
					wishlist.deleteItem(product);
					
					wishlistModel.doDelete(id, cliente.getEmail());
				}
			}	
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
		
		String redirect = (String)request.getParameter("redirect");
		
		if(redirect != null && !redirect.equals("")) {
			response.sendRedirect(redirect);
		}else {
			response.sendRedirect("./");
		}
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}