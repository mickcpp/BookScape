package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
        wishlistModel = new WishlistModelDM();
    }
    
    public WishlistControl() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String userId = (String) request.getSession().getAttribute("cliente");
        Wishlist wishlist = (Wishlist)request.getSession().getAttribute("wishlist");
        String redirect = request.getParameter("redirect");
        int productId = request.getParameter("productId") != null ? Integer.parseInt(request.getParameter("productId")) : 0;

        if (userId == null || userId.equals("")) {
            response.sendRedirect("Login");
            return;
        }

        try {
            if (wishlist == null) {
                wishlist = new Wishlist();
                wishlist.setItems(wishlistModel.doRetrieveAll(null, userId));
                request.getSession().setAttribute("wishlist", wishlist);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        String action = request.getParameter("action");
        String tableName = request.getParameter("type");

        try {
            if (action != null) {
            	
            	if (action.equalsIgnoreCase("Aggiungi")) {
            		try {
            			addProductToWishlist(request, response, userId, wishlist, tableName, productId, redirect);
            			return;
                	} catch(SQLException e) {
                		e.printStackTrace();
                		redirect(request, response, redirect, "Errore nell'aggiunta del prodotto alla wishlist!", true);
                		return;
                	}
                } else if (action.equalsIgnoreCase("Rimuovi")) {
                	try {
                		removeProductFromWishlist(request, response, userId, wishlist, tableName, productId, redirect);
                		return;
                	} catch(SQLException e) {
                		e.printStackTrace();
                		redirect(request, response, redirect, "Errore nella rimozione del prodotto dalla wishlist!", true);
                		return;
                	}
                }
            }
        } catch (Exception e) {
            System.out.println("Error:" + e.getMessage());
        }

        if (redirect != null && !redirect.equals("")) {
            response.sendRedirect(redirect);
        } else {
            response.sendRedirect("./");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
    
    private void addProductToWishlist(HttpServletRequest request, HttpServletResponse response, String userId, Wishlist wishlist, String tableName, int productId, String redirect) throws SQLException, IOException, ServletException {
        Product product = productModel.doRetrieveByKey(productId, TABLE.valueOf(tableName));
        if (wishlist.isInWishlist(product)) {
        	redirect(request, response, redirect, "Prodotto già presente nella wishlist!", true);
        	return;
        } else {
            wishlist.addItem(product);
            wishlistModel.doSave(product, userId);
            redirect(request, response, redirect, "Prodotto aggiunto nella wishlist!", false);
            return;
        }
    }
    
    private void removeProductFromWishlist(HttpServletRequest request, HttpServletResponse response, String userId, Wishlist wishlist, String tableName, int productId, String redirect) throws SQLException, IOException, ServletException {
        Product product = productModel.doRetrieveByKey(productId, TABLE.valueOf(tableName));
        wishlist.deleteItem(product);
        boolean check = wishlistModel.doDelete(productId, userId);
        if (check) {
        	redirect(request, response, redirect, "Prodotto rimosso dalla wishlist!", false);
        	return;
        }
    }
    
    private void redirect(HttpServletRequest request, HttpServletResponse response, String redirect, String message, boolean negative) throws ServletException, IOException {
        if (negative) request.getSession().setAttribute("feedback-negative", message);
        else request.getSession().setAttribute("feedback", message);
        response.sendRedirect(redirect);
    }
}