package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.bookscape.model.ProductModelDM;
import net.bookscape.model.TABLE;
import net.bookscape.model.Cart;

/**
 * Servlet implementation class ProductDetails
 */
@WebServlet("/CartControl")
public class CartControl extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private static ProductModelDM model;
	
	static {
		model = new ProductModelDM();
	}
	
    public CartControl() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Cart cart = (Cart)request.getSession().getAttribute("cart");
		if(cart == null) {
			cart = new Cart();
			request.getSession().setAttribute("cart", cart);
		}
		
		String action = request.getParameter("action");
		String tableName = request.getParameter("type");
		
		try {
			if (action != null) {
				if (action.equalsIgnoreCase("aggiungi")) {
					int id = Integer.parseInt(request.getParameter("productId"));
					cart.addProduct(model.doRetrieveByKey(id, TABLE.valueOf(tableName)));
				} else if (action.equalsIgnoreCase("rimuovi")) {
					int id = Integer.parseInt(request.getParameter("productId"));
					cart.deleteProduct(model.doRetrieveByKey(id, TABLE.valueOf(tableName)));
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