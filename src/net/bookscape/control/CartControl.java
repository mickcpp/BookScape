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
import net.bookscape.model.Cart;
import net.bookscape.model.CartItem;
import net.bookscape.model.CartModelDM;

@WebServlet("/CartControl")
public class CartControl extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    private static ProductModelDM productModel;
    private static CartModelDM cartModel;
    
    static {
        productModel = new ProductModelDM();
        cartModel = new CartModelDM();
    }
    
    public CartControl() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = (String) request.getSession().getAttribute("cliente");
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        String redirect = request.getParameter("redirect") == null ? "./" : request.getParameter("redirect");
       
        int productId = request.getParameter("productId") != null ? Integer.parseInt(request.getParameter("productId")) : 0;

        try {
            initializeCart(userId, request);
            cart = (Cart) request.getSession().getAttribute("cart");

            String action = request.getParameter("action");
            String tableName = request.getParameter("type");

            if (action != null) {
            	
                if (action.equalsIgnoreCase("Aggiungi")) {
                	try {
                    	addToCart(request, response, cart, userId, productId, tableName, redirect);
                    	return;
                	} catch(SQLException e) {
                		e.printStackTrace();
                		redirect(request, response, redirect, "Errore nell'aggiunta del prodotto al carrello!", true);
                		return;
                	}
                	
                } else if (action.equalsIgnoreCase("Rimuovi")) {
                	try {
                		removeFromCart(request, response, cart, userId, productId, tableName, redirect);
                		return;
                	} catch(SQLException e) {
                		e.printStackTrace();
                		redirect(request, response, redirect, "Errore nella rimozione del prodotto dal carrello!", true);
                		return;
                	}
                	
                } else if (action.equalsIgnoreCase("Aggiorna")) {
                	try {
                		updateCart(request, response, cart, userId, productId, tableName, redirect);
                		return;
                	} catch(SQLException e) {
                		e.printStackTrace();
                		redirect(request, response, redirect, "Errore nell'aggiornamento del numero di prodotti!", true);
                		return;
                	}
                }
            }
        } catch (SQLException e) {
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

    private void initializeCart(String userId, HttpServletRequest request) throws SQLException {
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if (userId != null && !userId.equals("")) {
            if (cart == null) {
                cart = new Cart();
                cart.setItems(cartModel.doRetrieveAll(null, userId));
                request.getSession().setAttribute("cart", cart);
            }
        }
        if (cart == null) {
            cart = new Cart();
            request.getSession().setAttribute("cart", cart);
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response, Cart cart, String userId, int productId, String tableName, String redirect) throws SQLException, ServletException, IOException {
        CartItem item = new CartItem(productModel.doRetrieveByKey(productId, TABLE.valueOf(tableName)));
        if (cart.isInCart(item)) {
            if (cart.getItem(productId).getNumElementi() < 10) {
                cart.incrementItem(item);
                updateCartInDatabase(cart, userId, productId);
                redirect(request, response, redirect, "Prodotto aggiunto al carrello!", false);
                return;
            } else {
                redirect(request, response, redirect, "Raggiunto limite di prodotti di questo tipo nel carrello!", true);
                return;
            }
        } else {
            cart.addItem(item);
            saveCartInDatabase(cart, userId, productId);
            redirect(request, response, redirect, "Prodotto aggiunto al carrello!", false);
            return;
        }
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response, Cart cart, String userId, int productId, String tableName, String redirect) throws SQLException, ServletException, IOException {
        CartItem item = new CartItem(productModel.doRetrieveByKey(productId, TABLE.valueOf(tableName)));
        boolean itemRemovedFromCart = cart.deleteItem(item);
        boolean itemRemovedFromDatabase = deleteCartItemFromDatabase(userId, productId);

        if (itemRemovedFromCart || itemRemovedFromDatabase) {
            redirect(request, response, redirect, "Prodotto rimosso dal carrello!", false);
            return;
        } else {
        	redirect(request, response, redirect, "Errore nella rimozione del prodotto dal carrello!", true);
        	return;
        }
    }

    private void updateCart(HttpServletRequest request, HttpServletResponse response, Cart cart, String userId, int productId, String tableName, String redirect) throws SQLException, ServletException, IOException {
        CartItem item = new CartItem(productModel.doRetrieveByKey(productId, TABLE.valueOf(tableName)));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        if (quantity > 10) {
        	redirect(request, response, redirect, "Raggiunto limite di prodotti di questo tipo nel carrello!", true);
        	return;
        }

        cart.updateItemNum(item, quantity);
        updateCartInDatabase(cart, userId, productId);
        redirect(request, response, redirect, "Aggiornato numero di prodotti!", false);
        return;
    }

    private void updateCartInDatabase(Cart cart, String userId, int productId) throws SQLException {
        if (userId != null && !userId.equals("")) {
            cartModel.doUpdate(cart.getItem(productId), userId);
        }
    }

    private void saveCartInDatabase(Cart cart, String userId, int productId) throws SQLException {
        if (userId != null && !userId.equals("")) {
            cartModel.doSave(cart.getItem(productId), userId);
        }
    }

    private boolean deleteCartItemFromDatabase(String userId, int productId) throws SQLException {
        if (userId != null && !userId.equals("")) {
            return cartModel.doDelete(productId, userId);
        }
        return false;
    }

    private void redirect(HttpServletRequest request, HttpServletResponse response, String redirect, String message, boolean negative) throws ServletException, IOException {
        if (negative) request.getSession().setAttribute("feedback-negative", message);
        else request.getSession().setAttribute("feedback", message);
        response.sendRedirect(redirect);
    }
}
