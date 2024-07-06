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
import net.bookscape.model.Product;

/**
 * Servlet implementation class ProductDetails
 */
@WebServlet("/WishlistControl")
public class WishlistControl extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private static ProductModelDM productModel;
	private static WishlistModelDM wishlistModel;
	
	static {
		productModel = new ProductModelDM();
		wishlistModel =  new WishlistModelDM();
	}
	
    public WishlistControl() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        String userId = (String) request.getSession().getAttribute("cliente");
        Wishlist wishlist = (Wishlist)request.getSession().getAttribute("wishlist");
		String redirect = (String)request.getParameter("redirect");

        int id = 0;
        
        if(userId != null && !userId.equals("")) {
        	try {
				if(wishlist == null) {
	        		wishlist = new Wishlist();
	        		wishlist.setItems(wishlistModel.doRetrieveAll(null, userId));
	        		request.getSession().setAttribute("wishlist", wishlist);
	        	}
			} catch (SQLException e) {
				e.printStackTrace();
			}
        }else {
        	response.sendRedirect("Login");
        	return;
        }    
		
        if(request.getParameter("productId") != null){
        	id = Integer.parseInt(request.getParameter("productId"));
        }
        
		String action = request.getParameter("action");
		String tableName = request.getParameter("type");
		
		try {
			if (action != null) {
				
				if (action.equalsIgnoreCase("Aggiungi")) {
					Product product = productModel.doRetrieveByKey(id, TABLE.valueOf(tableName));
					if(wishlist.isInWishlist(product)) {
						redirect(request, response, redirect, "Prodotto già presente nella wishlist!", true);
						return;
					} else {
						wishlist.addItem(product);
						wishlistModel.doSave(product, userId);
						
						redirect(request, response, redirect, "Prodotto aggiunto nella wishlist!", false);
						return;
					}
					
				} else if (action.equalsIgnoreCase("Rimuovi")) {
					Product product = productModel.doRetrieveByKey(id, TABLE.valueOf(tableName));
					wishlist.deleteItem(product);
					boolean check = wishlistModel.doDelete(id, userId);
					
					if(check) {
						redirect(request, response, redirect, "Prodotto rimosso dalla wishlist!", false);
						return;
					}
				}
			}	
			
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
				
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
	
	public void redirect(HttpServletRequest request, HttpServletResponse response, String redirect, String message, boolean negative) throws ServletException, IOException {
		if(negative) request.getSession().setAttribute("feedback-negative", message);
		else request.getSession().setAttribute("feedback", message);
		response.sendRedirect(redirect);
	}
}
